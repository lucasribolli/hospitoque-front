import 'package:flutter/material.dart';

class HospitoqueTextField extends StatelessWidget {
  final String hintText;
  final bool autofocus;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final Widget? suffixIcon;
  final bool enabled;
  final TextInputType? type;
  final int? maxLines;
  final FocusNode? focusNode;

  const HospitoqueTextField({
    Key? key,
    required this.hintText,
    required this.autofocus,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.inputAction,
    this.suffixIcon,
    this.enabled = true,
    this.type = TextInputType.text,
    this.maxLines = 1,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      autofocus: autofocus,
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
        counterText: '',
        enabledBorder: _getDefaultBorder(context),
        focusedBorder: _getDefaultBorder(context),
        disabledBorder: _getDefaultBorder(context),
        suffixIcon: suffixIcon,
      ),
      textInputAction: inputAction,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      onSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted!(value);
        }
      },
      keyboardType: type,
    );
  }

  _getDefaultBorder(BuildContext context) => OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).highlightColor,
        ),
      );
}
