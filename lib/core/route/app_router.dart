import 'package:expense/screens/analytic_page.dart';
import 'package:expense/screens/changelog_page.dart';
import 'package:expense/screens/home_page.dart';
import 'package:expense/screens/root_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/analytic',
              builder: (context, state) => const AnalyticPage(),
            ),
            // GoRoute(
            //   path: '/add',
            //   builder: (context, state) => const AddPage(),
            // ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              // routes: [
              //   GoRoute(
              //     path: 'add',
              //     builder: (context, state) => const AddPage(),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/logs',
              builder: (context, state) => const ChangeLogPage(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) => RootPage(
        navigationShell: navigationShell,
      ),
    ),
  ],
);
