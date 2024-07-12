import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class AppMenuItem extends StatelessWidget {
  const AppMenuItem({
    super.key,
    required this.title,
    required this.iconData,
    required this.onPressed,
  });

  final String title;
  final IconData iconData;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Icon(
                iconData,
                size: 24,
                color: modalBackground,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  color: greyText,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_right_sharp,
                color: modalBackground,
                size: 24,
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}
