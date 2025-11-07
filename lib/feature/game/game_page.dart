import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/feature/game/service/native_camera_service.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  static const routeName = '/game';

  @override
  ConsumerState<GamePage> createState() => GamePageState();
}

class GamePageState extends ConsumerState<GamePage> {
  final NativeCameraService _cameraService = NativeCameraService();

  // ゲーム状態
  GamePhase _currentPhase = GamePhase.ready;
  int _countdown = 5;
  Timer? _countdownTimer;
  Timer? _judgementTimer;
  int _judgementTimeRemaining = 15;
  bool _isPlayerSmiling = false;

  @override
  void initState() {
    super.initState();

    // 笑顔判定結果を監視
    _cameraService.listenToSmileDetection((result) {
      if (mounted) {
        setState(() {
          _isPlayerSmiling = result.isSmiling;
        });

        // 笑顔を検知したら負け
        if (result.isSmiling && _currentPhase == GamePhase.judging) {
          _onPlayerLost();
        }
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _judgementTimer?.cancel();
    _cameraService.dispose();
    super.dispose();
  }

  Future<void> _startGame() async {
    setState(() {
      _currentPhase = GamePhase.countdown;
      _countdown = 5;
    });

    // カウントダウンタイマー開始
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });

      if (_countdown == 0) {
        timer.cancel();
        _onCountdownComplete();
      }
    });

    // ネイティブカメラ起動（カウントダウン付き）
    try {
      await _cameraService.startCameraWithCountdown();
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('カメラの起動に失敗しました: $e')),
        );
      }
    }
  }

  void _onCountdownComplete() {
    setState(() {
      _currentPhase = GamePhase.captured;
    });

    // 3秒待機後に判定開始
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _startJudgement();
      }
    });
  }

  Future<void> _startJudgement() async {
    setState(() {
      _currentPhase = GamePhase.judging;
      _judgementTimeRemaining = 15;
    });

    // 笑顔判定開始
    await _cameraService.startSmileDetection();

    // 判定タイマー（15秒）
    _judgementTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _judgementTimeRemaining--;
      });

      if (_judgementTimeRemaining == 0) {
        timer.cancel();
        _onTimeUp();
      }
    });
  }

  void _onPlayerLost() {
    _judgementTimer?.cancel();
    _cameraService.stopSmileDetection();

    setState(() {
      _currentPhase = GamePhase.result;
    });

    _showResultDialog(won: false);
  }

  void _onTimeUp() {
    _cameraService.stopSmileDetection();

    setState(() {
      _currentPhase = GamePhase.result;
    });

    _showResultDialog(won: true);
  }

  void _showResultDialog({required bool won}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(won ? '勝利！' : '敗北...'),
        content: Text(won
          ? 'おめでとうございます！笑わずに勝ちました！'
          : '笑顔を検出しました。残念...'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // ゲーム画面を閉じる
            },
            child: const Text('ホームに戻る'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // カメラプレビュー（ネイティブ側で表示される）
            Container(
              color: Colors.black,
            ),

            // UI オーバーレイ
            Column(
              children: [
                // ヘッダー
                _buildHeader(),

                const Spacer(),

                // メインコンテンツ
                _buildMainContent(),

                const Spacer(),

                // フッター（ボタン等）
                _buildFooter(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          if (_currentPhase == GamePhase.judging)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '残り時間: $_judgementTimeRemaining秒',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_currentPhase) {
      case GamePhase.ready:
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '準備はいいですか？',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'スタートボタンを押すと\nカウントダウンが始まります',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );

      case GamePhase.countdown:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$_countdown',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '撮影までのカウントダウン',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );

      case GamePhase.captured:
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 80,
              ),
              SizedBox(height: 16),
              Text(
                '撮影完了！',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'まもなくにらめっこ開始...',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );

      case GamePhase.judging:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _isPlayerSmiling ? Colors.red : Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isPlayerSmiling
                      ? Icons.sentiment_very_satisfied
                      : Icons.sentiment_neutral,
                  color: Colors.white,
                  size: 80,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _isPlayerSmiling ? '笑顔を検出中...' : '真顔を保持中',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '笑わないようにしてください！',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );

      case GamePhase.result:
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
    }
  }

  Widget _buildFooter() {
    if (_currentPhase == GamePhase.ready) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: _startGame,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'スタート',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

enum GamePhase {
  ready,      // 準備中
  countdown,  // カウントダウン中
  captured,   // 撮影完了
  judging,    // 判定中
  result,     // 結果表示
}
