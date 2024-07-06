import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_cubit.dart';

class RegisterPagePhoneSection extends StatefulWidget {
  const RegisterPagePhoneSection({super.key});

  @override
  State<RegisterPagePhoneSection> createState() =>
      _RegisterPagePhoneSectionState();
}

class _RegisterPagePhoneSectionState extends State<RegisterPagePhoneSection> {
  final FocusNode phoneFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(phoneFocus));
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Telefone',
          description: 'Agora precisamos de um celular para te cadastrar',
          forms: [
            TextFormField(
              focusNode: phoneFocus,
              initialValue: state.phone,
              onChanged: controller.setPhone,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite aqui',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
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
