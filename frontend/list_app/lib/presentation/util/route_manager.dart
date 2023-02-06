import 'package:flutter/material.dart';

import '../views/screens/access_validation/access_validation_screen.dart';
import '../views/screens/following_screen/following_screen.dart';
import '../views/screens/login_screen/login_screen.dart';
import '../views/screens/profile_screen/profile_screen.dart';
import '../views/screens/register_screen/register_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class Routes {
  static const String accessValidator = 'accessValidator';
  static const String login = 'login';
  static const String register = 'register';
  static const String profile = 'profile';
  static const String following = 'following';
}


class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.accessValidator:
        return MaterialPageRoute(
          builder: (_) => const AccessValidator(),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.following:
        return MaterialPageRoute(
          builder: (_) => const FollowingScreen(),
        );
      default:
        throw const FormatException('Route not found!');
    }
  }
}