import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../themes/themes.dart';
import './following_provider.dart';
import 'util/custom_search_delegate.dart';
import 'widgets/search_field.dart';

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
    final following = ref.watch(followingProvider);

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: primaryColor, width: 3),
                ),
                child: IconButton(
                  icon: const Icon(Icons.search_rounded),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
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
                            text: 'Following',
                          ),
                          Tab(
                            text: 'Followers',
                          ),
                        ],
                        overlayColor: MaterialStateProperty.all<Color>(
                          Colors.transparent,
                        ),
                        indicatorColor: primaryColor,
                        labelColor: primaryColor,
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            following.when(
                              data: (following) => ListView.builder(
                                shrinkWrap: true,
                                itemCount: following.length ?? 0,
                                itemBuilder: (context, index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(),
                                    Text(following[index].username),
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
    );
  }
}
