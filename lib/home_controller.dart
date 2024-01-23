import 'package:city_list/city_model.dart';
import 'package:city_list/ui/city_list_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const methodPlatform = MethodChannel("com.example.city_list");
  final eventPlatform = const EventChannel("com.example.city_list/events");
  List<CityModel> cities = [];
  CityModel? selectedCity;
  List<String> nativeMethods = [
    "Method Channel",
    "Event Channel",
    "Platform Channel"
  ];

  ///call different channel based on index
  void onClickDifChannel(int index) {
    index == 1 ? callEventChannel() : callMethodChannel();
    Get.to(() => CityListScreen());
  }

  callMethodChannel() async {
    List<Object?> details =
        await methodPlatform.invokeMethod("getDataFromNative");
    addDataIntoList(details);
    print("call method channel");
    selectedCity = cities.first;
    update();
  }

  callEventChannel() async {
    eventPlatform.receiveBroadcastStream().listen((event) {
      var details = event;
      addDataIntoList(details);
      print("call event channel");
      selectedCity = cities.first;
      update();
    });
  }

  ///To change the city based on selected
  void onSelectCity(String city) {
    selectedCity = cities.firstWhereOrNull((element) => element.name == city);
    update();
  }

  ///covert data into List<Map<String, dynamic>>
  void addDataIntoList(List<Object?> details) {
    cities.clear();
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

    update();
  }
}
