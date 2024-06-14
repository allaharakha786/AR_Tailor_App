import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:previous/businessLogic/blocs/ordersBloc/order_events.dart';

import '../../../helper/enums/status_enums.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'order_states.dart';

class OrderBloc extends Bloc<OrderEvents, OrderStates> {
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
  CollectionReference<Map<String, dynamic>> firestoreInstance =
      FirebaseFirestore.instance.collection('orders');
  String imagePath = '';
  OrderBloc()
      : super(
            OrderStates(states: StatusEnums.INITIAL_STATE, isLoading: false)) {
    on<GetOrdersEvent>(getOrdermethod);
    on<AddOrderEvent>(addOrderMethod);
    on<UpdateOrderEvent>(updateOrderMethod);
    on<UploadScreenshotEvent>(uploadScreenshotMethod);
    on<DropDownEvent>(dropdownMethod);
    on<ClearImagePathEvent>(clearImageUrl);
  }

  dropdownMethod(DropDownEvent event, Emitter<OrderStates> emit) {
    emit(state.copyWith(
        defualtValue: event.defualtValue, states: StatusEnums.INITIAL_STATE));
  }

  updateOrderMethod(UpdateOrderEvent event, Emitter<OrderStates> emit) async {
    emit(state.copyWith(states: StatusEnums.INITIAL_STATE, isLoading: true));
    try {
      await firestoreInstance.doc(event.docId).update({
        'chestSize': event.dataList[0],
        'waistSize': event.dataList[1],
        'hipsSize': event.dataList[2],
        'inseamSize': event.dataList[3],
        'thighSize': event.dataList[4],
        'armSize': event.dataList[5],
        'shoulderSize': event.dataList[6],
        'neckSize': event.dataList[7],
        'sleeveSize': event.dataList[8]
      });
      emit(state.copyWith(
          states: StatusEnums.ORDER_UPDATED_STATE, isLoading: false));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          isLoading: false,
          errorMessage: e.message));
    }
  }

  addOrderMethod(AddOrderEvent event, Emitter<OrderStates> emit) async {
    var time = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(time);
    final formattedTime = DateFormat('HH:mm:ss').format(time);
    emit(state.copyWith(isLoading: true, states: StatusEnums.INITIAL_STATE));
    try {
      QuerySnapshot<Map<String, dynamic>> firestoreCollection =
          await FirebaseFirestore.instance
              .collection('users')
              .where('userId', isEqualTo: firebaseAuthInstance.currentUser!.uid)
              .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> snapshot =
          firestoreCollection.docs;

      await firestoreInstance.doc().set({
        'userName': snapshot[0]['name'],
        'email': snapshot[0]['email'],
        'address': snapshot[0]['address'],
        'phone': snapshot[0]['phone'],
        'userId': firebaseAuthInstance.currentUser!.uid,
        'chestSize': event.orderData[0],
        'waistSize': event.orderData[1],
        'hipsSize': event.orderData[2],
        'inseamSize': event.orderData[3],
        'thighSize': event.orderData[4],
        'armSize': event.orderData[5],
        'shoulderSize': event.orderData[6],
        'neckSize': event.orderData[7],
        'sleeveSize': event.orderData[8],
        'orderDate': formattedDate,
        'orderTime': formattedTime,
        'price': event.orderData[9],
        'title': event.orderData[10],
        'paymentMethod': event.orderData[11],
        'transactionId': event.orderData[12],
        'status': 'pending',
        'paymentStatus': event.orderData[14],
        'screenshot':
            event.orderData[13].isNotEmpty ? event.orderData[13] : 'noImage',
        'imageTitle': event.orderData[15].isNotEmpty ? event.orderData[15] : ''
      });
      emit(state.copyWith(
          states: StatusEnums.ORDERS_ADDED_STATE, isLoading: false));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE,
          isLoading: false,
          errorMessage: e.message));
    }
  }

  getOrdermethod(GetOrdersEvent event, Emitter<OrderStates> emit) async {
    emit(state.copyWith(states: StatusEnums.LOADING_STATE));

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestoreInstance
          .where('userId', isEqualTo: firebaseAuthInstance.currentUser?.uid)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;
      emit(state.copyWith(
          states: StatusEnums.ORDERS_LOADED_STATE, dataList: docs));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          states: StatusEnums.ERROR_STATE, errorMessage: e.message));
    }
  }

  clearImageUrl(ClearImagePathEvent event, Emitter<OrderStates> emit) {
    emit(state.copyWith(states: StatusEnums.INITIAL_STATE, imagePath: ''));
  }

  uploadScreenshotMethod(
      UploadScreenshotEvent event, Emitter<OrderStates> emit) async {
    var status = await Permission.storage.status;

    if (status.isGranted) {
      FilePickerResult? pickedFile =
          await FilePicker.platform.pickFiles(type: FileType.media);
      if (pickedFile != null) {
        PlatformFile path = pickedFile.files.single;
        String imageTitle = path.path!.toLowerCase().split('/').last;
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$imageTitle');
        UploadTask uploadTask = ref.putFile(File(path.path!));
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        imagePath = await snapshot.ref.getDownloadURL();

        emit(state.copyWith(imagePath: imagePath, imageTitle: imageTitle));
      }
    } else {
      await Permission.storage.request();
    }
  }
}
