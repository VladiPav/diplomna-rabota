import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../models/user_model.dart';
import '../../../../common_providers/current_user_provider.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../../../custom_widgets/custom_alert_dialog.dart';
import '../../../custom_widgets/custom_button.dart';
import '../profile_providers.dart';

class ProfileWidget extends ConsumerWidget {
  final User user;
  const ProfileWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.read(currentUserProvider);
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: accentColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 80,
                      ),
                    ),
                    currentUser.when(
                      data: (currentUser) =>
                          currentUser.id == user.id ? Text('Yes') : Text('No'),
                      error: (error, stacktrace) => Text('Error: $error'),
                      loading: () => Center(
                        child: SpinKitWave(
                          color: primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              color: primaryColor,
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }
}
