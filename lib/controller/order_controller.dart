
import 'dart:developer';

import 'package:abc_tech_app/model/order_location.dart';
import 'package:abc_tech_app/service/geolocation_service.dart';
import 'package:abc_tech_app/service/order_service.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:get/get.dart';
import '../model/assist.dart';
import '../model/order.dart';

enum OrderState {creating, started, finished}

class OrderController extends GetxController with StateMixin {
  final GeolocatorServiceInterface _geolocationService;
  final OrderServiceInterface _orderService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;
  final screenState = OrderState.creating.obs;
  final Order _order = Order(operatorId: 0,assists: [],start: null, end: null);


  OrderController(this._geolocationService,this._orderService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  @override
  void onReady() {
    super.onReady();
    change(null, status: RxStatus.success());
  }

  getLocation () {
    _geolocationService
    .getPosition()
    .then((value) => log(value.toJson().toString()));
  }

  List<int> _assistToList() {
    return selectedAssists.map((element) => element.id).toList();
  }

  finishStartOrder() {
    switch (screenState.value) {
      case OrderState.creating:
        if (!_validateForm()) break;
        _geolocationService.getPosition().then((value){
          setOrder(value);
        });
        screenState.value = OrderState.started;
        break;
      case OrderState.started:
        change(null,status: RxStatus.loading());
        _geolocationService.getPosition().then((value){
          _order.end = OrderLocation(
            latitude: value.latitude, 
            longitude: value.longitude, 
            dateTime: DateTime.now());
          _createOrder();
        });
        break;
      default:
    }
  }

  void setOrder(Position value) {
    OrderLocation start = OrderLocation(
      latitude: value.latitude, 
      longitude: value.longitude, 
      dateTime: DateTime.now());
    _order.operatorId = int.parse(operatorIdController.text);
    _order.assists = _assistToList();
    _order.start = start;
    _order.end = null;
  }

  bool _validateForm () {
    var errorMessage = "";
    if (operatorIdController.text.isEmpty)  {
      errorMessage = "Service provider code is empty";
    }
    if (selectedAssists.value.isEmpty)  {
      errorMessage = "Please choose at least one assistance.";
    }
    if (errorMessage.isNotEmpty) {
      Get.snackbar("Error", errorMessage);
      return false;    
    }
    
    return true;
    
  }

  void _createOrder() {
    screenState.value = OrderState.finished;
    _orderService.createOrder(_order).then((value) {
      if (value) {
        Get.snackbar("Success", "Order was successfully submitted.");
        _clearForm();
      }
    }).catchError((error){
        Get.snackbar("Error", error.toString());
        _clearForm();
    });
  }

  void _clearForm () {
    screenState.value = OrderState.creating;
    selectedAssists.clear();
    operatorIdController.text = "";
    change(null, status:  RxStatus.success());
  }

  selectAssits(){
    Get.toNamed("/assists", arguments: selectedAssists);
  }


}

