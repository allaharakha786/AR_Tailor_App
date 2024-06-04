class OrderEvents {}

class GetOrdersEvent extends OrderEvents {}

class AddOrderEvent extends OrderEvents {
  List<String> orderData;
  AddOrderEvent({required this.orderData});
}

class UploadScreenshotEvent extends OrderEvents {}

class DropDownEvent extends OrderEvents {
  String defualtValue;
  DropDownEvent({required this.defualtValue});
}

class ClearImagePathEvent extends OrderEvents {}

class UpdateOrderEvent extends OrderEvents {
  var docId;
  List<String> dataList = [];

  UpdateOrderEvent({required this.docId, required this.dataList});
}
