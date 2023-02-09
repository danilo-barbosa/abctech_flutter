

import 'package:abc_tech_app/service/assist_service.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../model/assist.dart';

class AssistsController extends GetxController with StateMixin<List<Assist>> {

  late AssistService _assistService;

  @override
  void onInit(){
    super.onInit();
    _assistService = Get.find<AssistService>();
  }

  void getAsssistList() {
    _assistService
      .getAssists()
      .then((value) => change(value, status: RxStatus.success()))
      .onError((error, stackTrace) => 
          change([], status: RxStatus.error(error.toString())));

  }

}