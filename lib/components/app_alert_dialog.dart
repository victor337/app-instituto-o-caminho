import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

enum ModalAlertType { success, error, alert }

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.canPopScope,
    required this.type,
    required this.title,
    required this.description,
    required this.actions,
  });

  final bool canPopScope;
  final ModalAlertType type;
  final String title;
  final String description;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    Icon getIcon() {
      switch (type) {
        case ModalAlertType.success:
          return const Icon(
            Icons.check_circle,
            color: constLight,
            size: 32,
          );
        case ModalAlertType.error:
        case ModalAlertType.alert:
          return const Icon(
            Icons.error,
            color: constLight,
            size: 32,
          );
      }
    }

    return PopScope(
      canPop: canPopScope,
      child: AlertDialog(
        surfaceTintColor: backgroundColor,
        backgroundColor: backgroundColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            getIcon(),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                color: constLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 250,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: constLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...actions,
          ],
        ),
      ),
    );
  }
}
