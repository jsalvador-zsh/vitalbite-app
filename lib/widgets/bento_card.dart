import 'package:flutter/material.dart';

class BentoCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const BentoCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                imagePath,
                height: 250,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
