import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/auth_page.dart';
import '../feature/auth/service/auth_provider.dart';
import '../feature/game/game_page.dart';
import '../feature/home/home_page.dart';
import '../feature/matching/matching_page.dart';
import '../feature/ranking/ranking_page.dart';
import '../feature/result/result_page.dart';

final Provider<GoRouter> routerProvider = Provider((ref) {
  // 認証状態を監視
  final isAuthenticated = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AuthPage.routeName,
    redirect: (context, state) {
      final isAuthPage = state.matchedLocation == AuthPage.routeName;

      // 未認証の場合
      if (!isAuthenticated) {
        // 認証ページ以外にアクセスしようとしたら認証ページへリダイレクト
        return isAuthPage ? null : AuthPage.routeName;
      }

      // 認証済みの場合
      // 認証ページにいる場合はホームページへリダイレクト
      if (isAuthPage) {
        return HomePage.routeName;
      }

      return null; // リダイレクトなし
    },
    routes: [
      GoRoute(
        path: AuthPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AuthPage());
        },
      ),
      GoRoute(
        path: HomePage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        path: MatchingPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: MatchingPage());
        },
      ),
      GoRoute(
        path: GamePage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: GamePage());
        },
      ),
      GoRoute(
        path: ResultPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: ResultPage());
        },
      ),
      GoRoute(
        path: RankingPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: RankingPage());
        },
      ),
    ],
  );
});
