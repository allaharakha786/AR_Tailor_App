import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_events.dart';
import 'package:previous/businessLogic/blocs/profileInfoBloc/profile_states.dart';
import 'package:previous/helper/enums/status_enums.dart';
import 'dart:io'; // For File object
import 'package:firebase_storage/firebase_storage.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvents, ProfileInfoStates> {
  FirebaseFirestore fireStoreRef = FirebaseFirestore.instance;
  FirebaseAuth firebaseRef = FirebaseAuth.instance;
  ProfileInfoBloc()
      : super(ProfileInfoStates(states: StatusEnums.INITIAL_STATE)) {
    on<GetProfileDetailsEvent>(getProfileDetails);
    on<ProfilePicGetEvent>(profilePicGetMethod);
    on<UpdateProfileInfoEvent>(updateProfileInfoMethod);
    on<UpdateProfileImageEvent>(updateProfileImageMethod);
  }

  updateProfileImageMethod(
      UpdateProfileImageEvent event, Emitter<ProfileInfoStates> emit) async {
    try {
      var status = await Permission.storage.status;

      if (status.isGranted) {
        FilePickerResult? pickedFile =
            await FilePicker.platform.pickFiles(type: FileType.media);

        if (pickedFile != null) {
          emit(state.copyWith(states: StatusEnums.PROFILE_PIC_UPLOADING_STATE));
          emit(state.copyWith(states: StatusEnums.LOADING_STATE));

          String path = pickedFile.files.single.path!;
          String fileName = path.split('/').last;
          final ref = FirebaseStorage.instance.ref().child('images/$fileName');

          final uploadTask = ref.putFile(File(path));
          var snap = await uploadTask.whenComplete(() => null);
          final downloadUrl = await snap.ref.getDownloadURL();

          emit(state.copyWith(states: StatusEnums.LOADING_STATE));
          await FirebaseFirestore.instance
              .collection('profileImage')
              .doc(firebaseRef.currentUser!.uid)
              .update({'profileImage': downloadUrl.toString()});
          emit(state.copyWith(
            states: StatusEnums.PROFILE_IMAGE_UPDATED_STATE,
          ));
        }
      } else {
        await Permission.storage.request();
      }
    } catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE, errorMessage: e.toString()));
    }
  }

  profilePicGetMethod(
      ProfilePicGetEvent event, Emitter<ProfileInfoStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.LOADING_STATE));

      QuerySnapshot<Map<String, dynamic>> snapshot = await fireStoreRef
          .collection('profileImage')
          .where('userId', isEqualTo: firebaseRef.currentUser!.uid)
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = snapshot.docs;
      emit(state.copyWith(
          profileImage: data, states: StatusEnums.PROFILE_PIC_GETTED_STATE));
    } catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE, errorMessage: e.toString()));
    }
  }

  updateProfileInfoMethod(
      UpdateProfileInfoEvent event, Emitter<ProfileInfoStates> emit) async {
    emit(state.copyWith(states: StatusEnums.INITIAL_STATE, isLoading: true));

    try {
      await fireStoreRef
          .collection('users')
          .doc(firebaseRef.currentUser!.uid)
          .update({
        'name': event.profileInfo[0],
        'phone': event.profileInfo[1],
        'address': event.profileInfo[2]
      });

      emit(state.copyWith(
          isLoading: false, states: StatusEnums.PROFILE_INFO_UPDATED_STATE));
    } catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          isLoading: false,
          errorMessage: e.toString()));
    }
  }

  getProfileDetails(
      GetProfileDetailsEvent event, Emitter<ProfileInfoStates> emit) async {
    try {
      emit(state.copyWith(states: StatusEnums.LOADING_STATE));

      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("users")
          .where('userId', isEqualTo: firebaseRef.currentUser?.uid)
          .get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;

      emit(state.copyWith(
          dataList: docs, states: StatusEnums.PROFILE_INFO_LOADED_STATE));
    } catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE, errorMessage: e.toString()));
    }
  }
}
