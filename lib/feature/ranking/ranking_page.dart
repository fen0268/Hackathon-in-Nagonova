import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  static const routeName = '/ranking';

  @override
  ConsumerState<RankingPage> createState() => RankingPageState();
}

class RankingPageState extends ConsumerState<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Ranking Page'),
      ),
    );
  }
}
