import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/theme/styled_colors.dart';

class AppSnackBar {
  static final loadingSnackBar = SnackBar(
    content: Row(
      children: <Widget>[
        loadingCircularWidget,
        const SizedBox(width: 20.0),
        const Text(
          "Loading...",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    ),
    backgroundColor:  Color(0xff428564),
    duration: const Duration(seconds: 14),
  );

  static SnackBar showErrorSnackBar(String error) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.error_outline_outlined,
            color: Colors.white,
          ),
          const SizedBox(
            height: 32,
            width: 12,
          ),
          Expanded(
            child: Text(
              '$error..',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    );
  }

  static SnackBar showSnackBar(String text,{Color? color}) {
    return SnackBar(
      content: Row(
        children: [
          const SizedBox(
            height: 22,
            width: 12,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      backgroundColor: color??StyledColors.primaryColorDark,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    );
  }
}
