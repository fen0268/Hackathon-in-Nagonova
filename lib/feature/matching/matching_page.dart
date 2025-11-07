import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchingPage extends ConsumerStatefulWidget {
  const MatchingPage({super.key});

  static const routeName = '/matching';

  @override
  ConsumerState<MatchingPage> createState() => MatchingPageState();
}

class MatchingPageState extends ConsumerState<MatchingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Matching Page'),
      ),
    );
  }
}
