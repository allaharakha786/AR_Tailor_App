import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../helper/enums/status_enums.dart';

class HomeScreenStates {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dressDataList;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> sliderDataList;

  StatusEnums states;
  HomeScreenStates(
      {this.dressDataList = const [],
      this.states = StatusEnums.INITIAL_STATE,
      this.sliderDataList = const []});

  HomeScreenStates copyWith(
      {StatusEnums? states,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? sliderDataList,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? dataList}) {
    return HomeScreenStates(
        states: states ?? this.states,
        dressDataList: dataList ?? this.dressDataList,
        sliderDataList: sliderDataList ?? this.sliderDataList);
  }

  List<Object>? get props => [states, dressDataList, sliderDataList];
}
