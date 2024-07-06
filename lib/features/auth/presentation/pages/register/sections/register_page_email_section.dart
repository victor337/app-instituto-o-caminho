import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_cubit.dart';

class RegisterPageEmailSection extends StatefulWidget {
  const RegisterPageEmailSection({super.key});

  @override
  State<RegisterPageEmailSection> createState() =>
      _RegisterPageEmailSectionState();
}

class _RegisterPageEmailSectionState extends State<RegisterPageEmailSection> {
  final FocusNode emailFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(emailFocus));
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Email',
          description: 'Estamos quase lá! Vamos precisar agora de um email',
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
