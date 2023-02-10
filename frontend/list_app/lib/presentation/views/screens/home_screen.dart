import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/themes.dart';
import 'following_screen/following_screen.dart';
import 'profile_screen/profile_screen.dart';

final navbarIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      body: IndexedStack(
        index: ref.watch(navbarIndexProvider),
        children: [
          FollowingScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Search',
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
            iconSize: 35,
            selectedFontSize: 15,
            onTap: (index) {
              ref.read(navbarIndexProvider.notifier).update((state) => index);
            },
          ),
        ),
      ),
    );
}
