

import 'package:abc_tech_app/controller/assists_controller.dart';
import 'package:get/instance_manager.dart';

class HomeBind extends Bindings { 
  
  @override
  void dependencies() {
    Get.lazyPut<AssistsController>(() => AssistsController());
  }


}