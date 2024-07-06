import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/form_base_page.dart';
import 'package:instituto_o_caminho/features/auth/presentation/pages/register/register_page_cubit.dart';

class RegisterPageNameSection extends StatefulWidget {
  const RegisterPageNameSection({super.key});

  @override
  State<RegisterPageNameSection> createState() =>
      _RegisterPageNameSectionState();
}

class _RegisterPageNameSectionState extends State<RegisterPageNameSection> {
  final FocusNode nameFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => FocusScope.of(context).requestFocus(nameFocus));
  }

  @override
  Widget build(BuildContext context) {
    final RegisterPageCubit controller = BlocProvider.of(context);

    return BlocBuilder<RegisterPageCubit, RegisterPageState>(
      builder: (_, state) {
        return FormBasePage(
          title: 'Nome',
          description:
              'Primeiro, preencha seu nome para sabermos como te chamar',
          forms: [
            TextFormField(
              focusNode: nameFocus,
              initialValue: state.name,
              onChanged: controller.setName,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Digite aqui',
                hintStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 24,
                ),
              ),
              textCapitalization: TextCapitalization.words,
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
