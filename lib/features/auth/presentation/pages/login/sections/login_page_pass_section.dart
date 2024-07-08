import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/login/login_page_cubit.dart';

class LoginPagePassSection extends StatefulWidget {
  const LoginPagePassSection({super.key});

  @override
  State<LoginPagePassSection> createState() => _LoginPagePassSectionState();
}

class _LoginPagePassSectionState extends State<LoginPagePassSection> {
  final FocusNode passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(passFocus));
  }

  @override
  Widget build(BuildContext context) {
    final LoginPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<LoginPageCubit, LoginPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Senha',
          description: 'Digite sua senha definida no cadastro',
          forms: [
            TextFormField(
              focusNode: passFocus,
              initialValue: state.pass,
              onChanged: controller.setPass,
              obscureText: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite aqui',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const Spacer(),
            if (state.passIsValid)
              PrimaryButton(
                onPressed: () {
                  passFocus.unfocus();
                  controller.login();
                },
                title: 'Entrar',
                isLoading: state.isLoading,
              ),
          ],
        );
      },
    );
  }
}
