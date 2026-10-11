import "package:frame/pages/login_page.dart";
import "package:go_router/go_router.dart";
import 'package:flutter/material.dart';
import "package:frame/pages/search_screen.dart";
import "package:frame/pages/results_page.dart";
import "package:frame/pages/video_player.dart";
import "package:supabase_flutter/supabase_flutter.dart";

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final loggedIn = Supabase.instance.client.auth.currentSession != null;
    if (loggedIn && state.matchedLocation == '/sign') return '/';
    return null;
  },
  routes: [
    GoRoute(
      path: '/sign',
      name: "sign",
      builder: (context, state) {
        return Title(
          color: Color(0xff7ee7c6),
          title: "Frame - log in",
          child: LoginPage(),
        );
      },
    ),
    GoRoute(
      path: "/",
      name: "home",
      builder: (context, state) => Title(
        color: const Color(0xFF7EE7C6),
        title: 'Frame - Search',
        child: SearchScreen(),
      ),
    ),

    GoRoute(
      path: "/results",
      name: "results",
      builder: (context, state) {
        final pageParameter = int.tryParse(
          state.uri.queryParameters["page"] ?? "1",
        );

        final queryParameter = state.uri.queryParameters["q"] ?? "";

        final initialPage = ((pageParameter ?? 1) - 1)
            .clamp(0, 1 << 30)
            .toInt();

        return Title(
          color: const Color(0xFF7EE7C6),
          child: ResultsPage(
            initialPage: initialPage,
            searchWord: queryParameter,
          ),
        );
      },
    ),

    GoRoute(
      path: "/watch",
      name: "watch",
      builder: (context, state) {
        final id = state.uri.queryParameters["id"]!;

        return VideoPlayer(videoId: id);
      },
    ),
  ],
);
