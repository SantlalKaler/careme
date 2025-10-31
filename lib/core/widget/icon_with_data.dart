import 'package:careme/app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IconWithData extends StatelessWidget {
  final IconData icon;
  final String data;
  final Color? iconColor;
  const IconWithData({
    super.key,
    required this.icon,
    required this.data,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? AppColors.contentTertiaryLight,
        ),
        Gap(10),
        Expanded(child: Text(data)),
      ],
    );
  }
}
