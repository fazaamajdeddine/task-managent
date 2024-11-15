
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String?)? onChanged;
  final Color borderColor;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.onIconPressed,
    this.prefixIcon,
    this.inputFormatter,
    this.onChanged, required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatter,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        enabledBorder: UnderlineInputBorder(
            borderSide: new BorderSide(
                color: borderColor)),
        suffixIcon: icon != null
            ? IconButton(
                icon: Icon(icon, size: 20.sp),
                onPressed: onIconPressed,
                color: Colors.grey)
            : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtil()
              .setHeight(16),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'SFUIText',
        fontSize: 14.sp,
      ),
      onSaved: (String? newValue) {},
      onChanged: onChanged,
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor; 
  final void Function(String?)? onChanged;

  const CustomPasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    required this.borderColor, this.onChanged, 
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;
  bool _isPasswordEightCharacters = false;
  bool _hasPaswwordOneNumber = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      controller: widget.controller,
      obscureText: _obscureText,
      borderColor: widget.borderColor, // Pass borderColor
      icon: _obscureText ? Icons.visibility : Icons.visibility_off,
      prefixIcon: Icon(
        Icons.lock,
        color: Colors.grey,
        size: 20.sp,
      ),
      onIconPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      onChanged: widget.onChanged,
    );
  }


}


