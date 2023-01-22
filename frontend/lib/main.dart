import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/views/login_screen/login.dart';
import 'package:frontend/presentation/views/profile_screen/profileScreen.dart';
import 'package:frontend/presentation/views/util/route_manager.dart';
// import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp();

  runApp(
    const ProviderScope(child: ListApp()),
  );
}

class ListApp extends StatelessWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List App',
      // home: LoginScreen(),
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      useInheritedMediaQuery: true,
      initialRoute: Routes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
