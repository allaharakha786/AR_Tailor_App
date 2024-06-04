import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_events.dart';
import 'package:previous/businessLogic/blocs/authBloc/auth_states.dart';

import '../../../helper/enums/status_enums.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  User? userid = FirebaseAuth.instance.currentUser;
  FirebaseAuth firebaseInstance = FirebaseAuth.instance;
  AuthBloc()
      : super(AuthStates(
            states: StatusEnums.INITIAL_STATE,
            isLoading: false,
            showPassword: true)) {
    on<LoginEvent>(logInMethod);
    on<ShowPasswordEvent>(showPasswordMethod);
    on<SignUpEvent>(signUpMethod);
    on<ResetPasswordEvent>(resetPasswordMethod);
    on<HidePasswordEvent>(hidePasswordMethod);
    on<CountryCodeEvent>(countryCodeMethod);
  }

  resetPasswordMethod(
      ResetPasswordEvent event, Emitter<AuthStates> emit) async {
    emit(state.copyWith(states: StatusEnums.INITIAL_STATE, isLoading: true));
    try {
      await firebaseInstance.sendPasswordResetEmail(email: event.email);
      emit(state.copyWith(
          states: StatusEnums.PASSWORD_RESETTED_STATE, isLoading: false));
    } catch (e) {
      return emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          errorMessage: e.toString(),
          isLoading: false));
    }
  }

  countryCodeMethod(CountryCodeEvent event, Emitter<AuthStates> emit) async {
    emit(state.copyWith(countryCode: event.countryCode.toString()));
    print(event.countryCode.toString());
  }

  logInMethod(LoginEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.INITIAL_STATE, isLoading: true));
      await firebaseInstance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((value) => emit(state.copyWith(
              states: StatusEnums.LOGGED_IN_STATE, isLoading: false)));
    } on FirebaseAuthException catch (e) {
      return emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          isLoading: false,
          errorMessage: e.message));
    }
  }

  showPasswordMethod(ShowPasswordEvent event, Emitter<AuthStates> emit) {
    emit(state.copyWith(showPassword: true, states: StatusEnums.INITIAL_STATE));
  }

  hidePasswordMethod(HidePasswordEvent event, Emitter<AuthStates> emit) {
    emit(
        state.copyWith(showPassword: false, states: StatusEnums.INITIAL_STATE));
  }

  signUpMethod(SignUpEvent event, Emitter<AuthStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.INITIAL_STATE, isLoading: true));
      await firebaseInstance
          .createUserWithEmailAndPassword(
              email: event.emailController, password: event.passwordController)
          .then((value) => FirebaseFirestore.instance
                  .collection('users')
                  .doc(firebaseInstance.currentUser!.uid)
                  .set({
                'name': event.nameController,
                'email': event.emailController,
                'phone': event.phoneController,
                'address': event.addressController,
                'userId': firebaseInstance.currentUser?.uid
              }))
          .then((value) async => await FirebaseFirestore.instance
                  .collection('profileImage')
                  .doc(firebaseInstance.currentUser!.uid)
                  .set({
                'profileImage': '',
                'userId': firebaseInstance.currentUser!.uid
              }))
          .then((value) => firebaseInstance.signOut())
          .then((value) => emit(state.copyWith(
              states: StatusEnums.SINGED_UP_STATE, isLoading: false)));
    } on FirebaseAuthException catch (e) {
      return emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          isLoading: false,
          errorMessage: e.message));
    }
  }
}
