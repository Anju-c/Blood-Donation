// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:bloodapp/utilis/helpers/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    
  }
}
