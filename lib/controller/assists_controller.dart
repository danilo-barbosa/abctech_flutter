

import 'package:abc_tech_app/service/assist_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../model/assist.dart';

class AssistsController extends GetxController with StateMixin<List<Assist>> {

  late AssistService _assistService;
  List<Assist> allAssists = [];
  List<Assist> selectedAssists = [];

  @override
  void onInit(){
    super.onInit();
    _assistService = Get.find<AssistService>();
    getAsssistList();
  }

  @override
  void onReady() {
    super.onReady();
    selectedAssists = Get.arguments;
  }

  void finishSelectAssist () {
    Get.back();
  }

  void getAsssistList() {
    _assistService
      .getAssists()
      .then((value) { 
        allAssists.addAll(value);
        change(value, status: RxStatus.success());
      }).onError((error, stackTrace) {
          change([], status: RxStatus.error(error.toString()));
      });
  }

  void selectAssist(int index) {
      Assist assist = allAssists[index];
      int indexFound = 
        selectedAssists.indexWhere((element) => element.id == assist.id);
      if (indexFound == -1) {
        selectedAssists.add(assist);
      } else {
        selectedAssists.removeAt(indexFound);
      }
      change(allAssists, status: RxStatus.success());
  }

  bool isSelected(int index) {
    Assist assist = allAssists[index];
    int indexFound = 
        selectedAssists.indexWhere((element) => element.id == assist.id);
      if (indexFound == -1) {
        return false;
      }
      return true;
  }

}