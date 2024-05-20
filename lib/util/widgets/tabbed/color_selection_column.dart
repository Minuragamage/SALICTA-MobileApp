import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/constants.dart';

class ColorSelectionColumn extends StatelessWidget {
  final List<Color> colorsList;

  ColorSelectionColumn({super.key, required this.colorsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          for (int i = 0; i < colorsList.length; i++)
            GestureDetector(
              onTap: () {
                // _controller.colorIndex.value = i;
              },
              child: AnimatedContainer(
                height: 34,
                width: 34,
                duration: const Duration(milliseconds: 400),
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: colorsList[i],
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5,
                    color: (true) ? kTinGrey : kSnowFlakeWhite,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
