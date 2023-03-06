import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'presentation/themes/themes.dart';
import 'presentation/util/route_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();

  runApp(
    const ProviderScope(child: ListApp()),
  );
}

class ListApp extends StatelessWidget {
  const ListApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'List App',
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      useInheritedMediaQuery: true,
      initialRoute: Routes.accessValidator,
      onGenerateRoute: AppRouter.generateRoute,
      theme: getThemeData(),
    );
}
