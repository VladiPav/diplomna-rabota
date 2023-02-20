import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_providers/common_providers.dart';
import '../../../../common_providers/repository_providers.dart';
import '../../../custom_widgets/custom_button.dart';

class UnfollowButton extends ConsumerWidget {
  final String id;
  const UnfollowButton({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
        text: 'Unfollow',
        width: 150,
        height: 45,
        fontSize: 20,
        func: () async {
          await ref.read(userRepositoryProvider).unfollow(id);
          ref.invalidate(isFollowingProvider(id));
        }
    );;
  }
}
