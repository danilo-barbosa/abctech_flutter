

import 'package:abc_tech_app/provider/assist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/assist.dart';

class AssistService extends GetxService {
  late AssistProviderInterface _assistProvider;

  Future<List<Assist>> getAssists() async {
   
   Response response = await _assistProvider.getAssist();
   
   if (response.hasError) {
    //error
    return Future.error(ErrorDescription("Connection Error."));
   }

   try {
      List<Assist> listResult = 
        response.body.map<Assist>((item) => Assist.fromMap(item)).toList();
      return Future.sync(() => listResult);
   } catch (e) {
      e.printInfo();
      return Future.error(ErrorDescription(e.toString()));
   }

  }

  Future<AssistService> init(AssistProviderInterface providerInterface) async {
    _assistProvider = providerInterface;
    return this;
  }

}