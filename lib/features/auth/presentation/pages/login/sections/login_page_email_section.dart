import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/login/login_page_cubit.dart';

class LoginPageEmailSection extends StatefulWidget {
  const LoginPageEmailSection({super.key});

  @override
  State<LoginPageEmailSection> createState() => _LoginPageEmailSectionState();
}

class _LoginPageEmailSectionState extends State<LoginPageEmailSection> {
  final FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(emailFocus));
  }

  @override
  Widget build(BuildContext context) {
    final LoginPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<LoginPageCubit, LoginPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Email',
          description: 'Primeiro digite seu e-mail para identifica-lo',
          forms: [
            TextFormField(
              focusNode: emailFocus,
              initialValue: state.email,
              onChanged: controller.setEmail,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite aqui',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        );
      },
    );
  }
}
