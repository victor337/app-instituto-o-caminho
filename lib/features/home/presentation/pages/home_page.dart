import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_menu/app_menu.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/widgets/activities_list/activities_list_section.dart';
import 'package:instituto_o_caminho/features/history/presentation/components/history_list_section/history_list_section.dart';
import 'package:instituto_o_caminho/features/home/presentation/pages/home_page_cubit.dart';
import 'package:instituto_o_caminho/features/punishments/presentation/components/punishments_section/punishments_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageCubit controller;

  @override
  void initState() {
    controller = HomePageCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: controller,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (_, state) {
          if (state.isLoading) return const SizedBox.shrink();

          return Scaffold(
            backgroundColor: backgroundColor,
            drawer: const AppMenu(),
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: backgroundColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Olá, ${controller.userName}',
                    style: const TextStyle(
                      color: constLight,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshPage();
                },
                color: modalBackground,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: const [
                    SizedBox(height: 24),
                    ActivitiesListSection(),
                    SizedBox(height: 32),
                    HistoryListSection(),
                    SizedBox(height: 32),
                    PunishmentsSection(),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
