import 'package:auto_route/auto_route.dart';
import 'package:tasks_app/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: TasksRoute.page),
      ];
}
