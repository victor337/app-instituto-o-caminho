import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_text_field.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/add_activity/add_activity_page_cubit.dart';

class AddActivityPage extends StatefulWidget {
  const AddActivityPage({super.key});

  @override
  State<AddActivityPage> createState() => _AddActivityPageState();
}

class _AddActivityPageState extends State<AddActivityPage> {
  late AddActivityPageCubit controller;

  @override
  void initState() {
    controller = AddActivityPageCubit();
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
        child: BlocBuilder<AddActivityPageCubit, AddActivityPageState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Cadastrar atividade',
                    style: TextStyle(
                      color: constLight,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    'Preencha as informações abaixo para cadastrar uma atividade',
                    style: TextStyle(
                      color: greyText,
                      fontSize: 14,
                    ),
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
                        AppInputTextField(
                          title: 'Nome da atividade',
                          hint: 'Digite aqui',
                          onChanged: controller.setTitle,
                        ),
                        const SizedBox(height: 24),
                        AppInputTextField(
                          title: 'Descrição',
                          maxLines: 4,
                          hint: 'Sobre o que é essa atividade',
                          onChanged: controller.setDescription,
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Professor',
                          style: TextStyle(
                            color: constLight,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          color: modalBackground,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: sectionColor,
                              items: controller.proffessorsOptions.map((p) {
                                return DropdownMenuItem(
                                  child: Text(p.name),
                                );
                              }).toList(),
                              value: state.professor,
                              style: TextStyle(
                                color: constLight,
                              ),
                              onChanged: (value) {
                                if (value != null) {
                                  controller.setProfessor(value);
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Ocorre toda',
                          style: TextStyle(
                            color: constLight,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 24,
                          runSpacing: 10,
                          children: [
                            for (final day in controller.days)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: constLight),
                                    borderRadius: BorderRadius.circular(8),
                                    color: sectionColor,
                                  ),
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      color: constLight,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Wrap(
                          spacing: 17,
                          runSpacing: 10,
                          children: [
                            for (final hour in controller.hours)
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: constLight),
                                    borderRadius: BorderRadius.circular(8),
                                    color: sectionColor,
                                  ),
                                  child: Text(
                                    hour,
                                    style: const TextStyle(
                                      color: constLight,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}