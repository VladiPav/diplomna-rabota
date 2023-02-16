import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../data/repositories/user_repository.dart';
import '../../../../../models/user_model.dart';
import '../../../../common_providers/api_service_provider.dart';
import '../../../../common_providers/current_user_provider.dart';
import '../../../../common_providers/is_following_provider.dart';
import '../../../../themes/themes.dart';
import '../../../custom_widgets/custom_button.dart';
import 'collections.dart';
import 'follow_button.dart';
import 'unfollow_button.dart';

class ProfileWidget extends ConsumerWidget {
  final User user;
  const ProfileWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final isFollowing = ref.watch(isFollowingProvider(user.id));
    return SafeArea(
      child: currentUser.when(
        data: (currentUser) => Center(
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
                          foregroundImage: NetworkImage(
                            user.profileImagePath ??
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                          ),
                          radius: 80,
                        ),
                      ),
                      if (currentUser.id == user.id) CustomButton(
                              text: 'Change Photo',
                              width: 80,
                              height: 20,
                              fontSize: 12,
                              func: () async {
                                XFile? xfile = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                File? file = File(xfile!.path);
                                await UserRepository(api: ref.read(apiProvider))
                                    .uploadProfileImage(file);
                              },
                            ) else isFollowing.when(
                              data: (isFollowing) {
                                print('Hello? $isFollowing');
                                return isFollowing
                                    ? UnfollowButton(id: user.id)
                                    : FollowButton(id: user.id);
                              },
                              error: (error, stacktrace) =>
                                  Text('Error: $error'),
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
                          style: TextStyle(fontSize: 20),
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
    );
  }
}
