import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/auth_page.dart';
import '../feature/auth/nickname_registration_page.dart';
import '../feature/game/game_page.dart';
import '../feature/home/home_page.dart';
import '../feature/matching/matching_page.dart';
import '../feature/ranking/ranking_page.dart';
import '../feature/result/result_page.dart';
import '../feature/settings/settings_page.dart';

final Provider<GoRouter> routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: AuthPage.routeName,
    redirect: (context, state) {
      final isAuthPage = state.matchedLocation == AuthPage.routeName;
      final isNicknamePage =
          state.matchedLocation == NicknameRegistrationPage.routeName;

      // 認証ページとニックネーム登録ページは常にアクセス可能
      if (isAuthPage || isNicknamePage) {
        return null;
      }

      // その他のページは後でガードする（今は通す）
      return null;
    },
    routes: [
      GoRoute(
        path: AuthPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: AuthPage());
        },
      ),
      GoRoute(
        path: NicknameRegistrationPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: NicknameRegistrationPage());
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
        path: '${GamePage.routeName}/:matchId',
        pageBuilder: (context, state) {
          final matchId = state.pathParameters['matchId'] ?? '';
          return MaterialPage(child: GamePage(matchId: matchId));
        },
      ),
      GoRoute(
        path: ResultPage.routeName,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final matchId = extra?['matchId'] as String?;
          return MaterialPage(
            child: ResultPage(matchId: matchId),
          );
        },
      ),
      GoRoute(
        path: RankingPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: RankingPage());
        },
      ),
      GoRoute(
        path: SettingsPage.routeName,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SettingsPage());
        },
      ),
    ],
  );
});
