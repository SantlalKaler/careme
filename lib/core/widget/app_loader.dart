import 'package:flutter/material.dart';

import '../../app/theme/colors.dart';

class AppLoader extends StatelessWidget {
  final bool showBackground;
  final Color progressColor;
  const AppLoader({
    super.key,
    this.showBackground = true,
    this.progressColor = AppColors.primaryLight,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: showBackground
          ? Colors.grey.withValues(alpha: 0.1)
          : null,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: progressColor, strokeWidth: 2),
      ),
    );
  }
}
