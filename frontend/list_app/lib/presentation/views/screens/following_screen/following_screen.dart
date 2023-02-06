import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../themes/themes.dart';
import '../../custom_widgets/custom_text_field.dart';

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
    return Scaffold(
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
                  child: ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        // return the header
                        return Row(
                          children: [
                            Expanded(
                                child: TextButton(
                              onPressed: () => {},
                              child: Text('Following'),
                            )),
                            Expanded(
                                child: TextButton(
                              onPressed: () => {},
                              child: Text('Followers'),
                            ))
                          ],
                        );
                      }
                      index -= 1;
                      // return row
                      var row = data[index];
                      return row;
                    },
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
