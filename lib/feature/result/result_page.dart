import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({this.matchId, super.key});

  final String? matchId;
  static const routeName = '/result';

  @override
  ConsumerState<ResultPage> createState() => ResultPageState();
}

class ResultPageState extends ConsumerState<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Result Page'),
      ),
    );
  }
}
