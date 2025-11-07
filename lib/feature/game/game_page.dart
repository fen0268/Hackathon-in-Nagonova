import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  static const routeName = '/game';

  @override
  ConsumerState<GamePage> createState() => GamePageState();
}

class GamePageState extends ConsumerState<GamePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Game Page'),
      ),
    );
  }
}
