import 'package:flutter/cupertino.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class AppHeaderTitle extends StatelessWidget {
  const AppHeaderTitle({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: constLight,
            fontSize: 20,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: greyText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
