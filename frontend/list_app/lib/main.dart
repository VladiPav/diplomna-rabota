import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/firebase_options.dart';
import 'package:list_app/presentation/themes/themes.dart';

import 'presentation/views/util/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      useInheritedMediaQuery: true,
      initialRoute: Routes.login,
      onGenerateRoute: AppRouter.generateRoute,
      theme: getThemeData(),
    );
  }
}
