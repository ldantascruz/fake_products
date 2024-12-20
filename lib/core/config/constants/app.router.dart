import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../feature/_feature.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: HomeRoutesEnum.home.fullPath,
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    ...HomeRouter.routes,
  ],
);
