import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../themes/themes.dart';
import '../../../util/route_manager.dart';
import './following_provider.dart';
import 'widgets/user_list.dart';
import 'widgets/user_search_delegate.dart';

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
              child: OutlinedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                    Text(
                      'Search user...',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  side: MaterialStateProperty.all(
                    BorderSide(
                      width: 3,
                      color: primaryColor,
                    ),
                  ),
                ),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: UserSearchDelegate(),
                  );
                },
              ),
              // child: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(30),
              //     border: Border.all(color: primaryColor, width: 3),
              //   ),
              //   child: IconButton(
              //     icon: const Icon(Icons.search_rounded),
              //     onPressed: () {
              //       showSearch(
              //         context: context,
              //         delegate: CustomSearchDelegate(),
              //       );
              //     },
              //   ),
              // ),
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
                                data: (following) {
                                  return following.length != 0
                                      ? UserList(usersList: following)
                                      : RefreshIndicator(
                                          child: Center(
                                            child: Text(
                                              'You have no followed users',
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          onRefresh: () async {
                                            ref.invalidate(followersProvider);
                                          },
                                        );
                                },
                                error: (error, stacktrace) =>
                                    Text('Error: $error'),
                                loading: () => Center(
                                    child: SpinKitWave(color: primaryColor))),
                            followers.when(
                              data: (followers) {
                                return followers.length != 0
                                    ? UserList(usersList: followers)
                                    : RefreshIndicator(
                                        child: Center(
                                          child: Text(
                                            'You have no followers',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        onRefresh: () async {
                                          ref.invalidate(followersProvider);
                                        },
                                      );
                              },
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
