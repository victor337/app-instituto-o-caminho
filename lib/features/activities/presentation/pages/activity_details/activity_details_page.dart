import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_alert_dialog.dart';
import 'package:instituto_o_caminho/components/photo_view.dart';
import 'package:instituto_o_caminho/components/primary_button.dart';
import 'package:instituto_o_caminho/components/secondary_button.dart';
import 'package:instituto_o_caminho/core/extensions/context_extension.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/activity_details/activity_details_page_cubit.dart';
import 'package:instituto_o_caminho/features/activities/presentation/pages/activity_details/activity_details_page_view.dart';

class ActivityDetailsPage extends StatefulWidget {
  const ActivityDetailsPage({required this.activityId, super.key});

  final String activityId;

  @override
  State<ActivityDetailsPage> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetailsPage>
    implements ActivityDetailsPageView {
  late ActivityDetailsPageCubit controller;

  @override
  void initState() {
    controller = ActivityDetailsPageCubit(
      activityId: widget.activityId,
      view: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
        ),
        body: BlocBuilder<ActivityDetailsPageCubit, ActivityDetailsPageState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Container();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      state.activity!.title,
                      style: const TextStyle(
                        color: constLight,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Sobre',
                      style: const TextStyle(
                        color: constLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      state.activity!.description,
                      style: const TextStyle(
                        color: constLight,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Detalhes',
                      style: const TextStyle(
                        color: constLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Professor: ',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          state.professor!.name,
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Data: ',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          state.activity!.date,
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Endereço: ',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          state.activity!.address,
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Duração: ',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          state.activity!.duration,
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    const Text(
                      'Fotos: ',
                      style: TextStyle(
                        color: constLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.activity!.images.length,
                        shrinkWrap: true,
                        separatorBuilder: (ctx, i) {
                          return const SizedBox(width: 10);
                        },
                        itemBuilder: (_, i) {
                          final image = state.activity!.images[i];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhotoView(image: image),
                                ),
                              );
                            },
                            child: Image.network(
                              image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    PrimaryButton(
                      title: state.buttonTitle,
                      onPressed: controller.buttonPressed,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initError() {
    showDialog(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          canPopScope: false,
          type: ModalAlertType.error,
          title: 'Ops, tivemos um problema',
          description:
              'Houve um erro ao buscar os dados da atividade, tente novamente mais tarde.',
          actions: [
            PrimaryButton(
              title: 'Tentar novamente',
              onPressed: () {
                context.pop();
                controller.init();
              },
            ),
            const SizedBox(height: 16),
            SecondaryButton(
              title: 'Fechar',
              onPressed: () {
                context.pop();
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
