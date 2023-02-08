import 'package:get/get_connect.dart';

import '../constants.dart';

abstract class AssistProviderInterface {

  Future<Response> getAssist();

}


class AssistProvider extends GetConnect implements AssistProviderInterface {
  
  @override
  Future<Response> getAssist() => get("${Constants.url}/assists");


}