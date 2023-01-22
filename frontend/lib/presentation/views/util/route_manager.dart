import 'package:flutter/material.dart';
import 'package:frontend/presentation/views/profile_screen/profileScreen.dart';

import '../login_screen/login.dart';
import '../register_screen/register.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class Routes {
  static const String login = 'login';
  static const String register = 'register';
  static const String profile = 'profile';
}


class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
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