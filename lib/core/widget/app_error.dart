import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppError extends StatelessWidget {
  const AppError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.nearby_error,
          color: Theme.of(context).primaryColor,
          size: 50,
        ),
        Gap(10),
        Text("Customer data not found"),
      ],
    );
  }
}
