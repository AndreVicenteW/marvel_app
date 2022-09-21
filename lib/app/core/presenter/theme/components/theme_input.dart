import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';

class ThemeInput extends StatefulWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? placeholder;
  final bool password;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const ThemeInput({
    required this.controller,
    this.icon,
    this.placeholder,
    this.password = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    Key? key,
  }) : super(key: key);

  @override
  _ThemeInputState createState() => _ThemeInputState();
}

class _ThemeInputState extends State<ThemeInput> {
  bool _isShowingPassword = false;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );

  final normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: ThemeColorHelper.primaryBlackColor.withOpacity(0.1),
        width: 1,
      ));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: ThemeTextStyleHelper.body1.copyWith(
        color: ThemeColorHelper.primaryDarkColor
      ),
      strutStyle: StrutStyle(
        leading: 0.7
      ),
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.password && !_isShowingPassword,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(14),
        fillColor: ThemeColorHelper.primaryGreyColor.withOpacity(0.1),
        filled: true,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon!,
                color: ThemeColorHelper.primaryGreyColor,
              )
            : null,
        suffixIcon: _getSuffixIcon(),
        hintText: widget.placeholder,
        hintStyle: ThemeTextStyleHelper.body1
            .copyWith(color: ThemeColorHelper.primaryGreyColor),
        border: normalBorder,
        enabledBorder: normalBorder,
        focusedBorder: normalBorder.copyWith(
            borderSide: BorderSide(
          color: ThemeColorHelper.primaryBlackColor.withOpacity(0.1),
          width: 2,
        )),
      ),
    );
  }

  Widget? _getSuffixIcon() {
    if (widget.password) {
      return GestureDetector(
          onTap: () {
            setState(() {
              _isShowingPassword = !_isShowingPassword;
            });
          },
          child: Icon(
            _isShowingPassword ? Icons.visibility_off : Icons.visibility,
            color: ThemeColorHelper.primaryGreyColor,
          ));
    }
    return null;
  }
}
