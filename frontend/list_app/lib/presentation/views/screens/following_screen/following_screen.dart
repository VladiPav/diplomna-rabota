import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../themes/themes.dart';
import './following_provider.dart';
import 'util/custom_search_delegate.dart';

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
                    delegate: CustomSearchDelegate(),
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
                                print('ACTUAL FOLLOWING:\n$following');
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: following.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(following[
                                                      index]
                                                  .profileImagePath ??
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                        ),
                                        Text(following[index].username),
                                      ],
                                    ),
                                  ),
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
                            followers.when(
                              data: (followers) {
                                print('ACTUAL FOLLOWERS:\n$following');
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: followers.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(followers[
                                                      index]
                                                  .profileImagePath ??
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
                                        ),
                                        Text(followers[index].username),
                                      ],
                                    ),
                                  ),
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
