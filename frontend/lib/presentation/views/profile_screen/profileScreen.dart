import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/themes/themes.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../custom_widgets/custom_button.dart';
import '../util/route_manager.dart';

var indexProvider = StateProvider<int>((ref) => 0);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(indexProvider),
        children: [
          Text("Home"),
          Text("Collections"),
          Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xfffcdddd),
                      Color(0xfffacbcb),
                      Color(0xfff8aeae),
                      Color(0xfff48181),
                      Color(0xfff16161),
                      Color(0xffed3939),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                    AssetImage('assets/images/profilePicture.jpeg'),
                    radius: 100,
                  ),
                  CustomButton(
                    width: 155,
                    height: 50,
                    fontSize: 24,
                    text: "back",
                    borderRadius: 100,
                    func: () =>
                    {Navigator.pushReplacementNamed(context, Routes.login)},
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: ref.read(indexProvider),
        onTap: (index) => {ref.read(indexProvider.notifier).state = index},
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.done),
            selectedColor: accentColor,
            unselectedColor: primaryColor,
            title: Text("Following"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.list),
            selectedColor: accentColor,
            unselectedColor: primaryColor,
            title: Text("Collections"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.account_circle),
            selectedColor: accentColor,
            unselectedColor: primaryColor,
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}