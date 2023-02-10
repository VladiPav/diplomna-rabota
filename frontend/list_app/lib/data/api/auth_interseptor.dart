import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['authorization'] =
        'Bearer ${await FirebaseAuth.instance.currentUser?.getIdToken(true)}';

    return handler.next(options);
  }
}
