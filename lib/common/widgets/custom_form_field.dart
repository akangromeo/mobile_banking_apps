import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/constants/app_constants.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

class CustomFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool isPasswordField;
  final double radius;
  final bool isEnabled;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Color? iconColor;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconPressed;
  final int? minLines;
  final int? maxLines;

  const CustomFormField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
    this.obscureText = false,
    this.isPasswordField = false,
    this.isEnabled = true,
    //icon text field
    this.suffixIcon,
    this.prefixIcon,
    this.iconColor = AppColors.darkGray,
    //keyboard type
    this.keyboardType = TextInputType.text,
    this.validator,
    //Radius
    this.radius = AppDesignConstants.kDefaultRadius,
    this.onSuffixIconPressed,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  State<CustomFormField> createState() => _CustomFormField();
}

class _CustomFormField extends State<CustomFormField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.isPasswordField ? true : widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDesignConstants.kDefaultMargin,
      ),
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.isEnabled,
        keyboardType: widget.keyboardType,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        validator: widget.validator,
        obscureText: widget.isPasswordField ? _isObscure : widget.obscureText,
        style: appTheme.textTheme.bodyLarge?.copyWith(
          color: AppColors.textBlack,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: appTheme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ),
          hintText: widget.hintText,
          hintStyle: appTheme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: AppColors.grey,
          contentPadding: const EdgeInsets.all(
            AppDesignConstants.kDefaultPadding,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: widget.iconColor,
                )
              : null,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: widget.iconColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                    if (widget.onSuffixIconPressed != null) {
                      widget.onSuffixIconPressed!();
                    }
                  },
                )
              : (widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(
                        widget.suffixIcon,
                        color: widget.iconColor,
                      ),
                      onPressed: widget.onSuffixIconPressed,
                    )
                  : null),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(
              color: AppColors.grey,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(
              color: AppColors.grey,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: const BorderSide(
              color: AppColors.blueSecondary,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
