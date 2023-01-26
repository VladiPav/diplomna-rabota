
import 'package:flutter/material.dart';

class UnfocusDetector extends StatelessWidget {
  const UnfocusDetector({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
    child: child,
    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
  );
}