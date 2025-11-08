import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

/// Firebase Storage画像アップロードサービス
class StorageService {
  StorageService(this._storage);

  final FirebaseStorage _storage;

  /// 画像をリサイズして圧縮
  /// 640x480 JPEG、品質80%
  Future<Uint8List> _processImage(File imageFile) async {
    try {
      // 画像ファイルを読み込み
      final imageBytes = await imageFile.readAsBytes();
      final originalImage = img.decodeImage(imageBytes);

      if (originalImage == null) {
        throw Exception('Failed to decode image');
      }

      // 640x480にリサイズ（アスペクト比を保持しながら）
      final resized = img.copyResize(
        originalImage,
        width: 640,
        height: 480,
      );

      // JPEG形式で品質80%に圧縮
      final compressed = img.encodeJpg(resized, quality: 80);

      return Uint8List.fromList(compressed);
    } catch (e) {
      throw Exception('Failed to process image: $e');
    }
  }

  /// マッチ用の画像をアップロード
  ///
  /// パス: matches/{matchId}/player{playerNumber}.jpg
  /// タイムアウト: 10秒
  Future<String> uploadMatchImage({
    required String matchId,
    required int playerNumber,
    required File imageFile,
  }) async {
    try {
      // 画像を処理（リサイズ・圧縮）
      final processedImage = await _processImage(imageFile);

      // ストレージパスを生成
      final path = 'matches/$matchId/player$playerNumber.jpg';
      final ref = _storage.ref().child(path);

      // メタデータ設定
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {
          'matchId': matchId,
          'playerNumber': playerNumber.toString(),
          'uploadedAt': DateTime.now().toIso8601String(),
        },
      );

      // アップロード（10秒タイムアウト）
      final uploadTask = ref.putData(processedImage, metadata);

      // タイムアウト設定
      final snapshot = await uploadTask.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          // タイムアウト時はアップロードをキャンセル
          uploadTask.cancel();
          throw TimeoutException('Upload timeout: 10 seconds exceeded');
        },
      );

      // ダウンロードURLを取得
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } on FirebaseException catch (e) {
      throw StorageException('Firebase Storage error: ${e.message}', e.code);
    } on TimeoutException {
      throw StorageException('Upload timeout', 'timeout');
    } catch (e) {
      throw StorageException('Upload failed: $e', 'unknown');
    }
  }

  /// 画像をダウンロード（デバッグ用）
  Future<Uint8List?> downloadImage(String path) async {
    try {
      final ref = _storage.ref().child(path);
      final data = await ref.getData();
      return data;
    } on FirebaseException catch (e) {
      throw StorageException('Download failed: ${e.message}', e.code);
    }
  }

  /// 画像を削除（将来の機能拡張用）
  Future<void> deleteImage(String path) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.delete();
    } on FirebaseException catch (e) {
      throw StorageException('Delete failed: ${e.message}', e.code);
    }
  }

  /// マッチの全画像を削除（将来の機能拡張用）
  Future<void> deleteMatchImages(String matchId) async {
    try {
      final ref = _storage.ref().child('matches/$matchId');
      final result = await ref.listAll();

      // 全てのファイルを削除
      await Future.wait(
        result.items.map((item) => item.delete()),
      );
    } on FirebaseException catch (e) {
      throw StorageException(
        'Delete match images failed: ${e.message}',
        e.code,
      );
    }
  }
}

/// カスタムStorage例外クラス
class StorageException implements Exception {
  StorageException(this.message, this.code);

  final String message;
  final String code;

  @override
  String toString() => 'StorageException($code): $message';
}

/// タイムアウト例外クラス
class TimeoutException implements Exception {
  TimeoutException(this.message);

  final String message;

  @override
  String toString() => 'TimeoutException: $message';
}

@riverpod
StorageService storageService(Ref ref) {
  return StorageService(FirebaseStorage.instance);
}
