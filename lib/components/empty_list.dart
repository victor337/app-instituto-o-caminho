import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.check_circle_sharp,
          color: modalBackground,
          size: 64,
        ),
        SizedBox(height: 16),
        Text(
          'Nada por aqui :)',
          style: TextStyle(
            color: constLight,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
