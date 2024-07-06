import 'package:flutter/material.dart';

class FormBasePage extends StatelessWidget {
  const FormBasePage({
    required this.title,
    required this.description,
    required this.forms,
    super.key,
  });

  final String title;
  final String description;
  final List<Widget> forms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Calibri',
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 100),
              ...forms,
            ],
          ),
        ],
      ),
    );
  }
}
