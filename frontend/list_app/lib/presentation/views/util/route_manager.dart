import 'package:flutter/material.dart';
import '../screens/access_validation/access_validation_screen.dart';
import '../screens/login_screen/login.dart';
import '../screens/profile_screen/profileScreen.dart';
import '../screens/register_screen/register.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class Routes {
  static const String accessValidator = 'accessValidator';
  static const String login = 'login';
  static const String register = 'register';
  static const String profile = 'profile';
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
      default:
        throw const FormatException('Route not found!');
    }
  }
}