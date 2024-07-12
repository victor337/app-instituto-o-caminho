import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instituto_o_caminho/components/app_menu/app_menu_cubit.dart';
import 'package:instituto_o_caminho/components/app_menu/components/app_menu_item.dart';
import 'package:instituto_o_caminho/core/extensions/context_extension.dart';
import 'package:instituto_o_caminho/core/routes/app_routes_list.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';
import 'package:instituto_o_caminho/features/home/presentation/pages/home_page_cubit.dart';

class AppMenu extends StatefulWidget {
  const AppMenu({super.key});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  late AppMenuCubit controller;

  @override
  void initState() {
    controller = AppMenuCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 75,
              ),
              const Text(
                'Instituto o caminho',
                style: TextStyle(
                  color: constLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            height: 1,
            width: double.maxFinite,
            color: modalBackground,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 16),
              CircleAvatar(
                maxRadius: 18,
                foregroundImage: NetworkImage(
                  controller.user.image,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Olá, ${controller.user.name}!',
                style: const TextStyle(
                  color: constLight,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            width: double.maxFinite,
            color: modalBackground,
          ),
          AppMenuItem(
            title: 'Home',
            iconData: Icons.home,
            onPressed: () {
              context.pop();
            },
          ),
          AppMenuItem(
            title: 'Perfil',
            iconData: Icons.person,
            onPressed: () {
              context.push(AppRoutesList.profile.fullPath);
            },
          ),
          if (controller.user.isAdmin) ...[
            AppMenuItem(
              title: 'Cadastrar atividade',
              iconData: Icons.star,
              onPressed: () {},
            ),
            AppMenuItem(
              title: 'Cadastrar professor',
              iconData: Icons.book,
              onPressed: () {},
            ),
            AppMenuItem(
              title: 'Cancelar aula',
              iconData: Icons.book,
              onPressed: () {},
            ),
          ],
          AppMenuItem(
            title: 'Sobre',
            iconData: Icons.list_alt_outlined,
            onPressed: () {},
          ),
          AppMenuItem(
            title: 'Ajudar',
            iconData: Icons.monetization_on_outlined,
            onPressed: () {},
          ),
          AppMenuItem(
            title: 'Sair',
            iconData: Icons.exit_to_app_rounded,
            onPressed: () {
              controller.exitToApp();
              context.pushReplacement(AppRoutesList.onboarding);
            },
          ),
        ],
      ),
    );
  }
}
