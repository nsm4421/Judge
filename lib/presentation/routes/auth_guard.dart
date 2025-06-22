import 'package:auto_route/auto_route.dart';
import 'package:judge/domain/entities/export.dart';
import 'router_config.dart';

class AuthGuard extends AutoRouteGuard {
  final Stream<AppUser?> _userStream;

  AuthGuard(this._userStream);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    _userStream.listen((user) {
      if (user != null) {
        resolver.next(true);
      } else {
        router.replace(const SignInRoute());
      }
    });
  }
}
