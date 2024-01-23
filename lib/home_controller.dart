import 'package:city_list/city_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/utils.dart';

class HomeController extends GetxController {
  static const platform = MethodChannel("com.example.city_list");
  List<CityModel> cities = [];
  CityModel? selectedCity;
  @override
  void onInit() {
    _getCities();
    super.onInit();
  }

  Future<void> _getCities() async {
    List<Object?> details = await platform.invokeMethod("getDataFromNative");
    for (var obj in details) {
      if (obj is Map<String, dynamic>) {
      } else if (obj is Map<Object?, Object?>) {
        Map<String, dynamic> convertedMap =
            Map<String, dynamic>.from(obj.cast<String, dynamic>());
        cities.add(CityModel(
            id: convertedMap["id"],
            name: convertedMap["name"],
            state: convertedMap["state"]));
      }
    }
    selectedCity = cities.first;
    update();
  }

  void onSelectCity(String city) {
    selectedCity = cities.firstWhereOrNull((element) => element.name == city);
    update();
  }
}
