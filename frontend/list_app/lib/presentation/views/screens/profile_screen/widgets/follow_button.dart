import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_providers/is_following_provider.dart';
import '../../../../common_providers/repository_providers.dart';
import '../../../custom_widgets/custom_button.dart';

class FollowButton extends ConsumerWidget {
  final String id;
  const FollowButton({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
        text: 'Follow',
        width: 150,
        height: 45,
        fontSize: 20,
        func: () async {
          await ref.read(userRepositoryProvider).follow(id);
          ref.invalidate(isFollowingProvider(id));
        }
    );
  }
}
