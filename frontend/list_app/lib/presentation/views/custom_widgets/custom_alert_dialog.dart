import 'package:flutter/material.dart';
import 'package:list_app/presentation/views/custom_widgets/unfocus_detector.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.content,
    required this.color,
    Key? key,
    this.title,
    this.actions,

  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final List<Widget>? actions;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return UnfocusDetector(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        actions: actions,
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        backgroundColor: color,
        title: title,
        content: content,
        actionsPadding: EdgeInsets.only(bottom: 10),
      ),
    );
  }
}
