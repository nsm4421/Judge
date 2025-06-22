import 'package:auto_route/auto_route.dart';
import 'package:judge/domain/usecases/export.dart';
import 'router_config.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthUseCase _useCase;

  AuthGuard(this._useCase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuth = _useCase.currentUser != null;
    if (isAuth) {
      resolver.next(true);
    } else {
      router.replace(SignInRoute());
    }
  }
}
