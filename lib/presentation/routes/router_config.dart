import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:judge/domain/usecases/export.dart';
import 'package:judge/presentation/pages/export.dart';

import 'auth_guard.dart';

part 'router_config.gr.dart';

@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  final AuthUseCase _useCase;

  AppRouter(this._useCase);

  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: EntryRoute.page, guards: [_authGuard]),
  ];

  @lazySingleton
  AuthGuard get _authGuard => AuthGuard(_useCase.userStream);
}
