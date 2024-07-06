import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_cubit.dart';

class RegisterPagePassSection extends StatefulWidget {
  const RegisterPagePassSection({super.key});

  @override
  State<RegisterPagePassSection> createState() =>
      _RegisterPagePassSectionState();
}

class _RegisterPagePassSectionState extends State<RegisterPagePassSection> {
  final FocusNode passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(passFocus));
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Senha',
          description:
              'Agora pra finalizar, define sua senha com no minímo 6 digitos',
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
                  controller.register();
                },
                title: 'Cadastrar',
                isLoading: state.isLoading,
              ),
          ],
        );
      },
    );
  }
}
