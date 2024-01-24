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
    "Platform Event"
  ];

  String? state;
  int? selectedIndex = 0;

  ///call different channel based on index
  void onClickDifChannel(int index) {
    selectedIndex = index;
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

  onSelectCity(String city) async {
    if (selectedIndex == 1) {
      onSelectedCityFromEvent(city);
      return;
    }

    //getSelectedData from method channel
    var state = await methodPlatform
        .invokeMethod("getDataFromNative", {"cityName": city});
    Map<String, dynamic> convertMap =
        Map<String, dynamic>.from(state.cast<String, dynamic>());
    getSelectedData(convertMap);
    update();
  }

//getSelectedData from event channel
  onSelectedCityFromEvent(String city) async {
    eventPlatform.receiveBroadcastStream({"param1": city}).listen((event) {
      Map<String, dynamic> convertMap =
          Map<String, dynamic>.from(event.cast<String, dynamic>());
      getSelectedData(convertMap);

      update();
    });
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

  ///selected city
  getSelectedData(Map<String, dynamic> selectedMapData) {
    selectedCity = selectedCity = CityModel(
        name: selectedMapData["name"],
        id: selectedMapData["id"],
        state: selectedMapData["state"]);
  }
}
