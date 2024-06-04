class ProfileInfoEvents {}

class GetProfileDetailsEvent extends ProfileInfoEvents {}

class ProfilePicGetEvent extends ProfileInfoEvents {}

class UpdateProfileImageEvent extends ProfileInfoEvents {}

class UpdateProfileInfoEvent extends ProfileInfoEvents {
  List<String> profileInfo;
  UpdateProfileInfoEvent({required this.profileInfo});
}
