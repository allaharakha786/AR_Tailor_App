import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:previous/businessLogic/blocs/homeScreenBloc/home_screen_events.dart';
import 'package:previous/businessLogic/blocs/homeScreenBloc/home_screen_states.dart';
import 'package:previous/helper/enums/status_enums.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvents, HomeScreenStates> {
  HomeScreenBloc()
      : super(HomeScreenStates(states: StatusEnums.INITIAL_STATE)) {
    on<GetDressDataEvent>(getDressMethod);
    on<GetSliderImagesEvent>(getSliderImagesMethod);
  }

  getDressMethod(
      GetDressDataEvent event, Emitter<HomeScreenStates> emit) async {
    emit(state.copyWith(states: StatusEnums.LOADING_STATE));
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('cloths').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
      emit(state.copyWith(
          states: StatusEnums.DRESS_LOADED_STATE, dataList: docs));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE));
    }
  }

  getSliderImagesMethod(
      GetSliderImagesEvent event, Emitter<HomeScreenStates> emit) async {
    emit(state.copyWith(states: StatusEnums.LOADING_STATE));
    try {
      var snapshot =
          await FirebaseFirestore.instance.collection('sliderImages').get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
      emit(state.copyWith(
          states: StatusEnums.SLIDER_IMAGES_LOADED_STATE,
          sliderDataList: docs));
    } catch (e) {
      emit(state.copyWith(states: StatusEnums.ERROR_STATE));
    }
  }
}
