import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_header_title.dart';
import 'package:instituto_o_caminho/components/app_text_field.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/cancel_activity/cancel_activity_cubit.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/cancel_activity/cancel_activity_state.dart';

class CancelActivityPage extends StatefulWidget {
  const CancelActivityPage({super.key});

  @override
  State<CancelActivityPage> createState() => _CancelActivityPageState();
}

class _CancelActivityPageState extends State<CancelActivityPage> {
  late CancelActivityCubit controller;

  @override
  void initState() {
    controller = CancelActivityCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: BlocProvider.value(
        value: controller,
        child: BlocBuilder<CancelActivityCubit, CancelActivityState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const AppHeaderTitle(
                    title: 'Cancelar atividade',
                    description:
                        'Preencha as informações abaixo para cancelar uma atividade',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: sectionColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          color: modalBackground,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: sectionColor,
                              items: controller.state.activities.map((p) {
                                return DropdownMenuItem(
                                  value: p,
                                  child: Text(p.title),
                                );
                              }).toList(),
                              hint: const Text(
                                'Selecione',
                                style: TextStyle(
                                  color: constLight,
                                ),
                              ),
                              value: state.selectActivity,
                              style: const TextStyle(
                                color: constLight,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setActivity(value);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppInputTextField(
                          title: 'Motivo',
                          maxLines: 4,
                          hint: 'Opcional',
                          onChanged: controller.setReason,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    title: 'Confirmar',
                    onPressed: controller.sendForm,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
