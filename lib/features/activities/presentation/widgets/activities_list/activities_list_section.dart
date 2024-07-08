import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/widgets/activities_list/activities_list_cubit.dart';
import 'package:instituto_o_caminho/features/activities/presentation/widgets/activity_widget.dart';

class ActivitiesListSection extends StatefulWidget {
  const ActivitiesListSection({super.key});

  @override
  State<ActivitiesListSection> createState() => _ActivitiesListSectionState();
}

class _ActivitiesListSectionState extends State<ActivitiesListSection> {
  late ActivitiesListCubit controller;

  @override
  void initState() {
    controller = ActivitiesListCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<ActivitiesListCubit, ActivitiesListState>(
        builder: (context, state) {
          if (state is ActivitiesListLoading) {
            return Container();
          } else if (state is ActivitiesListError) {
            return const Text(
              'Houve um erro',
              style: TextStyle(
                color: constLight,
              ),
            );
          } else if (state is ActivitiesListDone) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
              ),
              shrinkWrap: true,
              itemCount: state.activities.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) {
                return ActivityWidget(activity: state.activities[i]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
