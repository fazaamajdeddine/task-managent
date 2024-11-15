
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithText extends StatelessWidget {
  final String text;
  final Size? size;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final bool loading;
final TextStyle? style;
  final bool visible;

  final double? height;
  final double? width;

  final bool isUpperCase;

  const ButtonWithText({
    super.key,
    required this.text,
    this.size,
    this.backgroundColor,
    this.isUpperCase = true,
    this.onPressed,
    this.loading = false,
    this.visible = true,
    this.borderColor,
    this.height,
    this.width, this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: height ,
        width: width,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(
            color: borderColor??Colors.transparent,
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: FittedBox(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style:style,
          ),
        ),
      ),
    );
  }
}