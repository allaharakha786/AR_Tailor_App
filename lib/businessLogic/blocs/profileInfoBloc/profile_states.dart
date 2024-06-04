import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:previous/helper/enums/status_enums.dart';

class ProfileInfoStates {
  StatusEnums states;
  bool isLoading;
  String errorMessage;
  // String email;
  // String address;
  // int phone;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> profileImage;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList;
  ProfileInfoStates(
      {this.states = StatusEnums.INITIAL_STATE,
      this.dataList = const [],
      this.profileImage = const [],
      this.isLoading = false,
      this.errorMessage = ''});
  ProfileInfoStates copyWith(
      {StatusEnums? states,
      String? errorMessage,
      bool? isLoading,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? dataList,
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? profileImage}) {
    return ProfileInfoStates(
        states: states ?? this.states,
        dataList: dataList ?? this.dataList,
        profileImage: profileImage ?? this.profileImage,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  List<Object>? get props =>
      [states, dataList, profileImage, isLoading, errorMessage];
}
