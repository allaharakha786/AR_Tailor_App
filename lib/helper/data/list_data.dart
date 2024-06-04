import 'package:flutter/material.dart';

import '../constants/gifs_resources.dart';
import '../constants/string_resources.dart';

class ListData {
  static List<String> colorList = [
    'Black',
    'White',
    'Grey',
    'Orange',
    'Yellow',
    'Red',
    'Green',
    'Blue',
    'Purple'
  ];
  static List<String> profileInfoTitlesList = [
    'Name',
    'Mobile',
    'Email',
    'Address'
  ];
  static List<IconData> profileInfoIconsList = [
    Icons.person,
    Icons.phone,
    Icons.email,
    Icons.home
  ];

  static List<String> billingTitleList = [
    'Account Holder Name',
    'Account Number',
    'Payments Amount'
  ];
  static List<String> iconsOfMeasurementList = [
    'assets/icons/chest_icon.png',
    'assets/icons/waist_icon.png',
    'assets/icons/hip_icon.png',
    'assets/icons/inseam_icon.png',
    'assets/icons/thigh_icon.png',
    'assets/icons/arm_icon.png',
    'assets/icons/shoulder_icon.png',
    'assets/icons/neck_icon.png',
    'assets/icons/sleeve_icon.png',
  ];
  static List<String> titlesOfMeasurementList = [
    'Chest Size:',
    'Waist Size:',
    'Hips Size:',
    'Inseam Size:',
    'Thigh Size: ',
    'Arm Size:',
    'Shoulder Size:',
    'Neck Size: ',
    'Steeve Size:'
  ];
  static List iconOfOrderList = [
    Icons.shopping_bag_sharp,
    Icons.format_list_numbered,
    Icons.price_change
  ];
  static List<String> titlesOfOrderList = [
    'Product Name',
    'Quantity',
    'Amount'
  ];

  static List<String> measurementDiscriptionList = [
    StringResources.CHEST_DETAILS,
    StringResources.WAIST_DETAILS,
    StringResources.HIPS_DETAILS,
    StringResources.INSEAM_DETAILS,
    StringResources.THIGH_DETAILS,
    StringResources.ARM_DETAILS,
    StringResources.SHOULDER_DETAILS,
    StringResources.NECK_DETAILS,
    StringResources.SLEEVE_DETAILS
  ];

  static List<String> measurementTitles = [
    StringResources.CHEST,
    StringResources.WAIST,
    StringResources.HIPS,
    StringResources.INSEAM,
    StringResources.THIGH,
    StringResources.ARM,
    StringResources.SHOULDER,
    StringResources.NECK,
    StringResources.SLEEVE
  ];
  static List<String> gifUrlsList = [
    GifsResources.CHEST_GIF,
    GifsResources.WAIST_GIF,
    GifsResources.HIPS_GIF,
    GifsResources.INSEAM_GIF,
    GifsResources.THIGH_GIF,
    GifsResources.ARM_GIF,
    GifsResources.SHOULDER_GIF,
    GifsResources.NECK_GIF,
    GifsResources.SLEEVE_GIF,
  ];
}
