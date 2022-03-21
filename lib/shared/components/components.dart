import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget defaultTextField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onSubmit,
        Function? onChange,
        Function? onTap,
        bool isPassword = false,
        required FormFieldValidator validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        Function? suffixPressed,
        bool isClickable = true,
        bool isReadOnly = false, //Clickable and not editable
        double borderRadius = 16.0}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      readOnly: isReadOnly,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      onTap: () {
        onTap!();
      },
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

Widget defaultButton({
  double width = 100,
  double height = 50,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 16.0,
  required Function function,
  required String text,
  TextStyle? style,
//  required TextStyle style,
}) =>
    SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(
                color: background,
                width: width,
              ),
            ),
          ),
        ),
      ),
    );

Widget defaultTextButton(
        {required Function function,
        required String text,
        fontSizeColor = Colors.white,
        textFontSize = 16.0,
        isBold = false,
        textAlign = TextAlign.center}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
              color: fontSizeColor,
              fontSize: textFontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          textAlign: textAlign,
        ),
      ),
    );

Widget defaultDivider({
  double paddingStart = 20.0,
  double paddingEnd = 20.0,
}) =>
    Padding(
      padding: EdgeInsetsDirectional.only(start: paddingStart, end: paddingEnd),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget loadingShimmer({
  required double width,
  required double height,
}) =>
    Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: const Color(0xfff9e9b8),
      enabled: true,
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/logo.png', height: height),
      ),
    );
