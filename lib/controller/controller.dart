import 'package:get/state_manager.dart';

import '../services/services.dart';

enum AppControllerStatus {
  initial,
  loading,
  loaded,
  error
}

class AppController extends GetxController {
  final RxList<dynamic> _products = [].obs;
  List<dynamic> get products => _products;

  final Rx<AppControllerStatus> _status = AppControllerStatus.initial.obs;
  AppControllerStatus get status => _status.value;

  @override
  void onInit() async {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      _status.value = AppControllerStatus.loading;
      _products.value = await RemoteServer().getProducts();
      _status.value = AppControllerStatus.loaded;
    } catch (e) {
      _status.value = AppControllerStatus.error;
    }
  }

  Future<void> refetchProducts() async {
    _status.value = AppControllerStatus.initial;
    _products.clear();
    await fetchProducts();
  }
}
