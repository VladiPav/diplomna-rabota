import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../following_provider.dart';
import '../util/custom_search_delegate.dart';

class SearchField extends ConsumerWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Find user...',
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        filled: false,
        contentPadding: const EdgeInsets.only(left: 20),
      ),
      onChanged: (value) {
        ref
            .read(searchFieldControllerProvider.notifier)
            .update((state) => value);

      },
    );
  }
}
