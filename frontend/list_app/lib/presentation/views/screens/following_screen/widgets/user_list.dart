import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../following_provider.dart';

class UserList extends ConsumerWidget {
  const UserList({
    required this.usersList,
    Key? key,
  }) : super(key: key);
  final List<User> usersList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      color: primaryColor,
      strokeWidth: 3,
      onRefresh: () async {
        await ref.refresh(followingProvider);
        await ref.refresh(followersProvider);
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: usersList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                usersList[index].profileImagePath ??
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
              ),
            ),
            title: Text(usersList[index].username),
            onTap: () {
              Navigator.pushNamed(context, Routes.profile,
                  arguments: usersList[index]);
            },
          ),
        ),
      ),
    );
  }
}
