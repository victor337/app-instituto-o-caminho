import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/user/presentation/components/user_rating/user_rating_section_cubit.dart';

class UserRatingSection extends StatefulWidget {
  const UserRatingSection({super.key});

  @override
  State<UserRatingSection> createState() => _UserRatingSectionState();
}

class _UserRatingSectionState extends State<UserRatingSection> {
  late UserRatingSectionCubit controller;

  @override
  void initState() {
    controller = UserRatingSectionCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<UserRatingSectionCubit, UserRatingSectionState>(
          builder: (_, state) {
        if (state is UserRatingSectionLoading) {
          return const SizedBox.shrink();
        } else if (state is UserRatingSectionError) {
          return const SizedBox.shrink();
        } else if (state is UserRatingSectionDone) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Suas estatísticas',
                style: TextStyle(
                  color: constLight,
                  fontSize: 24,
                ),
              ),
              const Text(
                'Esses são seus números nas nossas atividades',
                style: TextStyle(
                  color: greyText,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: sectionColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: modalBackground,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.userRating!.punishments.length} advertências',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    Column(
                      children: [
                        const Icon(
                          Icons.playlist_remove,
                          color: modalBackground,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.userRating!.history.where((e) => !e.wasPresent).length} faltas',
                          style: const TextStyle(
                            color: constLight,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
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
