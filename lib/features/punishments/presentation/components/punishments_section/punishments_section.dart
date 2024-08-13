import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/empty_list.dart';
import 'package:instituto_o_caminho/core/extensions/datetime_extension.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/punishments/presentation/components/punishments_section/punishments_section_cubit.dart';

class PunishmentsSection extends StatefulWidget {
  const PunishmentsSection({super.key});

  @override
  State<PunishmentsSection> createState() => _PunishmentsSectionState();
}

class _PunishmentsSectionState extends State<PunishmentsSection> {
  late PunishmentsSectionCubit controller;

  @override
  void initState() {
    controller = PunishmentsSectionCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<PunishmentsSectionCubit, PunishmentsSectionState>(
          builder: (_, state) {
        if (state is PunishmentsSectionLoading) {
          return const SizedBox.shrink();
        } else if (state is PunishmentsSectionError) {
          return const SizedBox.shrink();
        } else if (state is PunishmentsSectionDone) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Suas punições',
                style: TextStyle(
                  color: constLight,
                  fontSize: 20,
                ),
              ),
              const Text(
                'Essas são as punições que você já tomou aqui no instituto',
                style: TextStyle(
                  color: greyText,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: sectionColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Builder(
                  builder: (_) {
                    if (state.punishments.isEmpty) {
                      return const EmptyList();
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: 12);
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.punishments.length,
                      itemBuilder: (_, i) {
                        final item = state.punishments[i];

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: modalBackground,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black45,
                                spreadRadius: 0.1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${item.date.ddMMyyyy()} - ',
                                    style: const TextStyle(
                                      color: constLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: constLight,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: constLight,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
