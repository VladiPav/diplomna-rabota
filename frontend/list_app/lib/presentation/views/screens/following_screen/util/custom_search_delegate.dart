import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../data/api/api_service.dart';
import '../../../../../data/repositories/user_repository.dart';
import '../../../../../models/user_model.dart';
import '../../../../themes/themes.dart';
import '../../../../util/route_manager.dart';
import '../../profile_screen/profile_screen.dart';
import '../../profile_screen/widgets/profile_widget.dart';
import 'debouncer.dart';

class CustomSearchDelegate extends SearchDelegate {
  final _debouncer = Debouncer(milliseconds: 500);
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
          return suggestions?.length == 0 || suggestions == null
              ? Center(child: Text('No matching results'))
              : ListView.builder(
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = suggestions[index];
                    return ListTile(
                      leading: Image.network(suggestion.profileImagePath ?? 'https://media.tenor.com/TwCxxAZeZDcAAAAC/bolen-lud.gif'),
                      title: Text(suggestion.username),
                      onTap: () {
                        query = suggestion.username;
                        user = suggestion;
                        showResults(context);
                      },
                    );
                  });
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
