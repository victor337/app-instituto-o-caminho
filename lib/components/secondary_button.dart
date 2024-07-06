import 'package:flutter/material.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  final String title;
  final Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: constLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: constLight,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  color: constLight,
                ),
              ),
      ),
    );
  }
}
