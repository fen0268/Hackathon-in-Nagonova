import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  ConsumerState<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Auth Page'),
      ),
    );
  }
}
