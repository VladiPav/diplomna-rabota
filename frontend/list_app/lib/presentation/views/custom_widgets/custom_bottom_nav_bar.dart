import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/themes.dart';

final navbarIndexProvider = StateProvider<int>((ref) => 0);

class CustomNavBar extends ConsumerWidget {
  const CustomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/followIcon.svg',
              width: 10,
              height: 20,
              color: Colors.white,
            ),
            label: 'Following',
            backgroundColor: primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lists',
            backgroundColor: primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: primaryColor,
          ),

        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: ref.watch(navbarIndexProvider),
        selectedItemColor: Colors.white,
        onTap: (index) {
          ref.read(navbarIndexProvider.notifier).update((state) => index);
        },
      );
}
