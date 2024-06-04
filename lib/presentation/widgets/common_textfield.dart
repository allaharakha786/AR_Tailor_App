import 'package:flutter/material.dart';
import 'package:previous/helper/constants/colors_resources.dart';
import 'package:previous/helper/constants/dimentions_resources.dart';

import '../../helper/utills/text_styles.dart';

// ignore: must_be_immutable
class CommonTextField extends StatelessWidget {
  TextEditingController? controller;
  Widget? prefixIcon;
  String? hintText;
  bool? isBorder;
  bool? isSuffix;
  Widget? suffixIcon;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  void Function()? onTap;
  String? Function(String?)? validator;

  CommonTextField(
      {super.key,
      this.suffixIcon,
      this.obscureText,
      this.controller,
      this.hintText,
      this.prefixIcon,
      this.validator,
      this.isBorder,
      this.onTap,
      this.isSuffix,
      this.keyboardType,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      controller: controller,
      style: CustomTextStyles.contentTextStyle(ColorsResources.WHITE_70),
      decoration: InputDecoration(
          filled: isBorder ?? false,
          fillColor: ColorsResources.WHITE_12,
          enabledBorder: isBorder ?? false
              ? OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(DimensionsResource.RADIUS_SMALL),
                  borderSide: BorderSide(color: ColorsResources.WHITE_COLOR))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorsResources.WHITE_70)),
          border: isBorder ?? false
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(DimensionsResource.RADIUS_DEFAULT)))
              : null,
          focusedBorder: isBorder ?? false
              ? OutlineInputBorder(
                  borderSide: BorderSide(color: ColorsResources.WHITE_COLOR),
                  borderRadius:
                      BorderRadius.circular(DimensionsResource.RADIUS_DEFAULT))
              : null,
          prefixIcon: prefixIcon,
          suffixIcon: isSuffix ?? false
              ? GestureDetector(onTap: onTap, child: suffixIcon)
              : null,
          prefixIconColor: ColorsResources.WHITE_70,
          labelText: hintText,
          labelStyle:
              CustomTextStyles.contentTextStyle(ColorsResources.WHITE_70)),
    );
  }
}
