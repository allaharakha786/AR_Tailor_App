// ignore: file_names
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget Dropdown(defultvalue, itemslist, onchanged) {
  return DropdownButton(
      dropdownColor: Colors.black87,
      borderRadius: BorderRadius.circular(6),
      value: defultvalue,
      items: itemslist,
      onChanged: onchanged);
}
