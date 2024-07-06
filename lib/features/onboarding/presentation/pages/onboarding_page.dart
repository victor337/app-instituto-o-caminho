import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/core/extensions/context_extension.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PrimaryButton(
              title: 'Cadastrar',
              onPressed: () {
                context.push(AppRoutesList.register.fullPath);
              },
            ),
          ],
        ),
      ),
    );
  }
}
