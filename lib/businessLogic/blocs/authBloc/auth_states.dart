import '../../../helper/enums/status_enums.dart';

class AuthStates {
  StatusEnums states;
  bool isLoading;
  String errorMessage;
  bool showPassword;
  String countryCode;
  AuthStates(
      {this.states = StatusEnums.INITIAL_STATE,
      this.isLoading = false,
      this.errorMessage = '',
      this.showPassword = false,
      this.countryCode = ''});
  AuthStates copyWith(
      {StatusEnums? states,
      bool? isLoading,
      String? errorMessage,
      bool? showPassword,
      String? countryCode}) {
    return AuthStates(
        states: states ?? this.states,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        showPassword: showPassword ?? this.showPassword,
        countryCode: countryCode ?? this.countryCode);
  }

  List<Object> get props =>
      [states, isLoading, errorMessage, showPassword, countryCode];
}
