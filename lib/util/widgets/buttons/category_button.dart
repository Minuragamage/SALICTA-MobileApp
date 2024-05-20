import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salicta_mobile/theme/constants.dart';

class CategoryButton extends StatelessWidget {
  final String iconPath;
  final String name;
  final bool isSelected;
  final void Function() onTap;

  const CategoryButton({
    super.key,
    required this.iconPath,
    required this.name,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: (isSelected) ? kOffBlack : lightGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                iconPath,
                fit: BoxFit.none,
                color: (isSelected) ? Colors.white : Colors.black54,
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: (isSelected) ? kOffBlack : kGrey,
                fontWeight: FontWeight.w400 ,
              ),
            ),
          ],
        ),
      ),
    );
  }
}