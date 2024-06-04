import 'package:country_code_picker/country_code_picker.dart';

class AuthEvents {}

class LoginEvent extends AuthEvents {
  String email;
  String password;
  LoginEvent({required this.email, required this.password});
}

class ResetPasswordEvent extends AuthEvents {
  String email;
  ResetPasswordEvent({required this.email});
}

class SignUpEvent extends AuthEvents {
  String nameController;
  String emailController;
  String phoneController;
  String addressController;
  String passwordController;
  SignUpEvent(
      {required this.nameController,
      required this.emailController,
      required this.phoneController,
      required this.addressController,
      required this.passwordController});
}

class ShowPasswordEvent extends AuthEvents {}

class HidePasswordEvent extends AuthEvents {}

class CountryCodeEvent extends AuthEvents {
  CountryCode countryCode;
  CountryCodeEvent({required this.countryCode});
}
