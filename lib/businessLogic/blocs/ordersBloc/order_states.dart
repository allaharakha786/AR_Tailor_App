import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../helper/enums/status_enums.dart';

class OrderStates {
  StatusEnums states;
  bool isLoading;
  String imagePath;
  String errorMessage;
  String defualtValue;
  String imageTitle;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;
  OrderStates(
      {this.imagePath = '',
      this.states = StatusEnums.INITIAL_STATE,
      this.dataList = const [],
      this.isLoading = false,
      this.errorMessage = '',
      this.defualtValue = 'Choose method',
      this.imageTitle = ''});

  OrderStates copyWith(
      {StatusEnums? states,
      String? defualtValue,
      String? errorMessage,
      String? imagePath,
      String? imageTitle,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? dataList,
      bool? isLoading}) {
    return OrderStates(
        defualtValue: defualtValue ?? this.defualtValue,
        imagePath: imagePath ?? this.imagePath,
        states: states ?? this.states,
        imageTitle: imageTitle ?? this.imageTitle,
        dataList: dataList ?? this.dataList,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object>? get props => [
        imagePath,
        states,
        dataList,
        isLoading,
        errorMessage,
        defualtValue,
        imageTitle
      ];
}
