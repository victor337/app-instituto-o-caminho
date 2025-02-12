import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_alert_dialog.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/components/secondary_button.dart';
import 'package:instituto_o_caminho/core/extensions/context_extension.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_cubit.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_view.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/sections/register_page_email_section.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/sections/register_page_name_section.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/sections/register_page_pass_section.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/sections/register_page_phone_section.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    implements RegisterPageView {
  late RegisterPageCubit controller;
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    controller = RegisterPageCubit(
      pageController: pageController,
      view: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        controller.backPressed();
      },
      child: BlocProvider.value(
        value: controller,
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: InkWell(
              customBorder: const CircleBorder(),
              onTap: controller.floatButtonPressed,
              child: BlocBuilder<RegisterPageCubit, RegisterPageState>(
                builder: (_, state) {
                  return AnimatedOpacity(
                    opacity: state.currentFormIsValid ? 1 : 0,
                    duration: const Duration(
                      milliseconds: 100,
                    ),
                    child: state.currentFormIsValid
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.arrow_right,
                              color: backgroundColor,
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
            ),
            backgroundColor: backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: controller.backPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: backgroundColor,
            ),
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                RegisterPageNameSection(),
                RegisterPagePhoneSection(),
                RegisterPageEmailSection(),
                RegisterPagePassSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void popPage() {
    Navigator.of(context).pop();
  }

  @override
  void errorToRegister(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          canPopScope: true,
          type: ModalAlertType.error,
          title: 'Ops, tivemos um problema',
          description: message,
          actions: [
            PrimaryButton(
              title: 'Tentar novamente',
              onPressed: () {
                controller.register();
              },
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              title: 'Fechar',
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void successToRegister() {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          canPopScope: false,
          type: ModalAlertType.success,
          title: 'Conta criada',
          description: 'Vamos entrar na sua conta agora?',
          actions: [
            PrimaryButton(
              title: 'Ir para login',
              onPressed: () {
                context.pop();
                context.replace(AppRoutesList.login.fullPath);
              },
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              title: 'Fechar',
              onPressed: () {
                context.pop();
                context.replace(AppRoutesList.onboarding);
              },
            ),
          ],
        );
      },
    );
  }
}
