import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../custom_widgets/custom_button.dart';
import '../../util/route_manager.dart';

var indexProvider = StateProvider<int>((ref) => 0);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
          body: SafeArea(
            child: Stack(
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomButton(
                        width: 155,
                        height: 50,
                        fontSize: 24,
                        text: "back",
                        borderRadius: 100,
                        func: () =>
                        {Navigator.pushReplacementNamed(context, Routes.login)},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
