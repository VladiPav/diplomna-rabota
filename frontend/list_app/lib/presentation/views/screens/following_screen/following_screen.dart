import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../themes/themes.dart';
import './following_provider.dart';

final data = [
  Row(
    children: [
      CircleAvatar(),
      Padding(padding: EdgeInsets.all(8)),
      Text('Username of person'),
    ],
  ),
  Row(
    children: [
      CircleAvatar(),
      Padding(padding: EdgeInsets.all(8)),
      Text('Username of person'),
    ],
  ),
  Container(
    color: Colors.red,
    child: Row(
      children: [
        CircleAvatar(),
        Padding(padding: EdgeInsets.all(8)),
        Text('Username of person'),
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  )
];

class FollowingScreen extends ConsumerWidget {
  const FollowingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followers = ref.watch(followersProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: primaryColor, width: 3),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Find user...',
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                      contentPadding: const EdgeInsets.only(left: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: accentColor,
                    ),
                    child: Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(
                              child: Container(
                                child: Text(
                                  'Followers',
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Followers',
                              ),
                            ),
                          ],
                          overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          indicatorColor: primaryColor,
                          dividerColor: accentColor,
                          labelColor: primaryColor,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              followers.when(
                                data: (followers) => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: followers.length ?? 0,
                                  itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(),
                                      Text(followers[index].username),
                                    ],
                                  ),
                                ),
                                error: (error, stacktrace) =>
                                    Text('Error: $error'),
                                loading: () => Center(
                                  child: SpinKitWave(
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              ListView.builder(
                                itemCount: data.length ?? 0,
                                itemBuilder: (context, index) {
                                  final data2 = [
                                    Text('a'),
                                    Text('b'),
                                    Text('c'),
                                    Text('d')
                                  ];
                                  return data2[index];
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
