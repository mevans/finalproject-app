import 'package:app/core/navigation/bloc/navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertService {
  Future<bool> confirmation(
    BuildContext context, {
    @required String text,
    String title,
    String cancelText = "Cancel",
    String confirmText = "Ok",
  }) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: Text(text),
        actions: [
          TextButton(
            child: Text(cancelText),
            onPressed: () => ctx.read<NavigationBloc>().add(
                  NavigationPop(false),
                ),
          ),
          TextButton(
            child: Text(confirmText),
            onPressed: () => ctx.read<NavigationBloc>().add(
                  NavigationPop(true),
                ),
          ),
        ],
      ),
    ).then((r) => r != null && !r);
  }
}
