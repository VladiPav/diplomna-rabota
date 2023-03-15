import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../data/repositories/user_repository.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../common_providers/common_providers.dart';
import '../../../../common_providers/repository_providers.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../../../custom_widgets/custom_button.dart';
import 'collections_widget.dart';
import 'follow_button.dart';
import 'unfollow_button.dart';

class ProfileWidget extends ConsumerWidget {
  final User user;
  const ProfileWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final isFollowing = ref.watch(isFollowingProvider(user.id));
    final auth = ref.watch(authRepositoryProvider);

    return RefreshIndicator(
      color: primaryColor,
      strokeWidth: 3,
      onRefresh: () async => await ref.refresh(currentUserProvider),
      child: SafeArea(
        child: currentUser.when(
          data: (currentUser) => Center(
            child: ListView(
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
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            foregroundImage: NetworkImage(
                              user.profileImagePath ??
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                            ),
                            radius: 80,
                          ),
                        ),
                        if (currentUser.id == user.id)
                          Column(
                            children: [
                              CustomButton(
                                text: 'Change Photo',
                                width: 130,
                                height: 40,
                                fontSize: 15,
                                func: () async {
                                  XFile? xfile = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                  File? file = File(xfile!.path);
                                  await UserRepository(
                                          api: ref.read(apiProvider))
                                      .uploadProfileImage(file);
                                },
                              ),
                              CustomButton(
                                text: 'Log Out',
                                width: 130,
                                height: 40,
                                fontSize: 15,
                                func: () async {
                                  await auth.signOut().then(
                                        (value) => Navigator.popAndPushNamed(
                                          context,
                                          Routes.login,
                                        ),
                                      );
                                },
                              ),
                            ],
                          )
                        else
                          isFollowing.when(
                            data: (isFollowing) {
                              print('Hello? $isFollowing');
                              return isFollowing
                                  ? UnfollowButton(id: user.id)
                                  : FollowButton(id: user.id);
                            },
                            error: (error, stacktrace) => Text('Error: $error'),
                            loading: () => const Center(
                              child: SpinKitWave(
                                color: primaryColor,
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                          child: Text(
                            user.username,
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: primaryColor,
                  thickness: 3,
                ),
                CollectionsWidget(
                  user: user,
                ),
              ],
            ),
          ),
          error: (error, stacktrace) => Text('Error: $error'),
          loading: () => const Center(
            child: SpinKitWave(
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
