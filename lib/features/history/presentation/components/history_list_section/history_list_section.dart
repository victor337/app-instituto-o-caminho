import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/core/extensions/datetime_extension.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/history/presentation/components/history_list_section/history_list_section_cubit.dart';

class HistoryListSection extends StatefulWidget {
  const HistoryListSection({super.key});

  @override
  State<HistoryListSection> createState() => _HistoryListSectionState();
}

class _HistoryListSectionState extends State<HistoryListSection> {
  late HistoryListSectionCubit controller;

  @override
  void initState() {
    controller = HistoryListSectionCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<HistoryListSectionCubit, HistoryListSectionState>(
        builder: (_, state) {
          if (state is HistoryListSectionLoading) {
            return const SizedBox.shrink();
          } else if (state is HistoryListSectionError) {
            return const Text(
              'Houve um erro',
              style: TextStyle(color: constLight, fontSize: 16),
            );
          } else if (state is HistoryListSectionDone) {
            if (state.history.isEmpty) {
              return const Text(
                'Você não possui histórico por enquanto',
                style: TextStyle(color: constLight, fontSize: 16),
              );
            }

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: sectionColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Histórico de presença',
                    style: TextStyle(
                      color: constLight,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 12);
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, i) {
                      final item = state.history[i];

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
                              color: Colors.black,
                              spreadRadius: 0.1,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${item.date.ddMMyyyy()} - ',
                              style: const TextStyle(
                                color: constLight,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${item.date.ddMMyyyy()} - ',
                              style: const TextStyle(
                                color: constLight,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              item.activityTitle,
                              style: const TextStyle(
                                color: constLight,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            if (item.wasPresent)
                              const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 24,
                              )
                            else
                              const Icon(
                                Icons.highlight_remove_outlined,
                                color: Colors.red,
                                size: 24,
                              )
                          ],
                        ),
                      );
                    },
                    itemCount: state.history.length,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
