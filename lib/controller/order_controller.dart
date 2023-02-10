
import 'dart:developer';

import 'package:abc_tech_app/service/geolocation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../model/assist.dart';

class OrderController extends GetxController {
  final GeolocationService _geolocationService;
  final formKey = GlobalKey<FormState>();
  final operatorIdController = TextEditingController();
  final selectedAssists = <Assist>[].obs;


  OrderController(this._geolocationService);

  @override
  void onInit() {
    super.onInit();
    _geolocationService.start();
  }

  getLocation () {
    _geolocationService
    .getPosition()
    .then((value) => log(value.toJson().toString()));
  }

  finishStartOrder() {
    log("Test");
  }

  selectAssits(){
    Get.toNamed("/assists", arguments: selectedAssists);
  }


}

