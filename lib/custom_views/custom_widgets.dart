import 'package:flutter/material.dart';
import 'dart:ui' as ui show TextHeightBehavior;

class MyTextError extends StatelessWidget {
  const MyTextError(
    this.text,
    this.iconData,
    this.iconColor, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  }) : textSpan = null;
  final Color? iconColor;
  final String text;
  final IconData iconData;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;
  final InlineSpan? textSpan;
  final Color? selectionColor;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(
        iconData,
        color: iconColor,
        size: 15,
      ),
      const SizedBox(
        width: 4,
      ),
      Text(text,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaler: textScaler,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor)
    ]);
  }
}

class MyFormData extends StatelessWidget {
  const MyFormData(this.text,
      {this.formKey,
      this.obscureText,
      super.key,
      this.autoValidate,
      this.errorMessage,
      this.textInputAction,
      this.onFieldSubmitted,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.validator});

  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final bool? obscureText;
  final String text;
  final GlobalKey<FormFieldState>? formKey;
  final AutovalidateMode? autoValidate;
  final String? errorMessage;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 124,
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          key: formKey,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          autovalidateMode: autoValidate ?? AutovalidateMode.disabled,
          validator: (value) {
            if (validator != null) {
              return validator!(value);
            }
            return null;
          },
          decoration: InputDecoration(
            error: null,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor: Colors.white,
            filled: true,
            border: const OutlineInputBorder(),
            labelText: '',
          ),
          onChanged: onChanged,
        ),
        if (errorMessage != null)
          Align(
              alignment: Alignment.centerLeft,
              child: MyTextError(
                errorMessage!,
                Icons.error,
                Colors.red,
                style: const TextStyle(color: Colors.white),
              ))
      ]),
    );
  }
}
