import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:previous/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_events.dart';
import 'package:previous/businessLogic/blocs/bottomNavigationBloc/bottom_navigation_states.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvents, BottomNavigationStates> {
  BottomNavigationBloc() : super(BottomNavigationStates(currentIndex: 0)) {
    on<CurrentIndexEvent>(currentIndexMethod);
  }
  currentIndexMethod(
      CurrentIndexEvent event, Emitter<BottomNavigationStates> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }
}
