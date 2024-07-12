import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_text_field.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/profile/presentation/pages/edit_profile/edit_profile_page_cubit.dart';
import 'package:instituto_o_caminho/features/profile/presentation/pages/edit_profile/edit_profile_page_view.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    implements EditProfilePageView {
  late EditProfilePageCubit controller;

  @override
  void initState() {
    controller = EditProfilePageCubit(view: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<EditProfilePageCubit, EditProfilePageState>(
        builder: (_, state) {
          if (state.isLoading) return const SizedBox.shrink();

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              backgroundColor: backgroundColor,
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text(
                  'Editar perfil',
                  style: TextStyle(
                    color: constLight,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 16),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: state.isUseLocalImage
                      ? NetworkImage(state.image!)
                      : NetworkImage(state.image!),
                ),
                const SizedBox(height: 16),
                AppInputTextField(
                  title: 'Nome',
                  hint: 'Digite seu nome',
                  onChanged: controller.setName,
                  initialValue: state.name,
                ),
                const SizedBox(height: 16),
                AppInputTextField(
                  title: 'Telefone',
                  hint: 'Telefone com DDD',
                  onChanged: controller.setPhone,
                  initialValue: state.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                ),
                PrimaryButton(
                  title: 'Atualizar',
                  onPressed: controller.updateProfile,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initError() {
    // TODO: implement initError
  }
}
