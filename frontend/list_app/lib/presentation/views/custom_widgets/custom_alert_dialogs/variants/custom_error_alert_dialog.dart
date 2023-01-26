import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:list_app/presentation/views/custom_widgets/custom_alert_dialogs/custom_alert_dialog.dart';

class ErrorAlertDialog extends ConsumerWidget {
  const ErrorAlertDialog({
    required this.errorMessage,
    Key? key,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAlertDialog(
        title: const Center(
          child: Text(
            "Error!",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        content: Text(
          errorMessage,
          style: const TextStyle(fontSize: 12),
        ),
        color: Colors.white,
    );
  }
}
