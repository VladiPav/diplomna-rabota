import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../data/api/api_service.dart';
import '../../../../../data/models/user_model.dart';
import '../../../../themes/themes.dart';
import '../../profile_screen/widgets/profile_widget.dart';

class UserSearchDelegate extends SearchDelegate {
  late User user;
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => ProfileWidget(user: user);

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder(
        future: ApiService().searchUser(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<User>? suggestions = snapshot.data;
            print('RESULT:\n$suggestions');
            return suggestions?.length == 0 || suggestions == null
                ? Center(child: Text('No matching results'))
                : ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestions[index];
                      return ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              suggestion.profileImagePath ??
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
                            ),
                          ),
                        ),
                        title: Text(suggestion.username),
                        onTap: () {
                          query = suggestion.username;
                          user = suggestion;
                          showResults(context);
                        },
                      );
                    },
                  );
          } else {
            return Center(
              child: SpinKitWave(
                color: primaryColor,
              ),
            );
          }
        },
      );
}
