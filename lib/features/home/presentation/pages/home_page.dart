import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/di/injection.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/activities/presentation/widgets/activities_list/activities_list_section.dart';
import 'package:instituto_o_caminho/features/auth/domain/repositories/auth_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = getIt();

    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: const Drawer(),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(color: constLight),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Olá, ${authRepository.currentUser!.name.split(' ')[0]}!',
              style: const TextStyle(
                color: constLight,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 16),
            CircleAvatar(),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            Text(
              'Nossas atividades',
              style: TextStyle(
                color: constLight,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            ActivitiesListSection(),
            SizedBox(height: 32),
            Text(
              'Suas aulas',
              style: TextStyle(
                color: constLight,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Você não se cadastrou em nenhuma aula',
              style: TextStyle(
                color: constLight,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
