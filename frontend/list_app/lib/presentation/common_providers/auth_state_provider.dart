
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/common_providers/repository_providers.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
    (ref) => FirebaseAuth.instance,
);

final authStateProvider = StreamProvider<User?>(
    (ref) => ref.watch(authRepositoryProvider).authStateChange,
);

