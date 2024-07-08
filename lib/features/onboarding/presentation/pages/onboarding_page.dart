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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const Text(
              'Tranformando vidas através do assistencialismo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: constLight,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            PrimaryButton(
              title: 'Login',
              onPressed: () {
                context.push(AppRoutesList.login.fullPath);
              },
            ),
            const SizedBox(height: 16),
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
