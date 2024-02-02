import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../city_model.dart';
import 'ios_channels/ios_method_list_screen.dart';

class IOSChannelController extends GetxController {
  List<String> iosChannelTypes = [
    "Method Channel",
    "Event Channel",
    "PlatformView"
  ];
  MethodChannel methodChannelPlatform =
      const MethodChannel("cityList method channel");

  EventChannel eventChannelPlatform =
      const EventChannel("cityList event channel");
  List<CityModel> cities = [];
  CityModel? selectedCityDetails;
  int? selectedButtonIndex = 0;

  void onClickChannelButton(int index) {
    selectedButtonIndex = index;
    cities.clear();
    selectedCityDetails = null;
    index == 0 ? callMethodChannelFromIOS() : callEventChannelFromIos();
    Navigator.push(Get.context!,
        MaterialPageRoute(builder: (context) => IOSMethodScreen()));
  }

  callMethodChannelFromIOS() async {
    try {
      var cityData =
          await methodChannelPlatform.invokeMethod('recieveCityData');

      for (var city in cityData) {
        cities.add(CityModel(
            name: city["name"], id: city["id"], state: city["state"]));
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void getSelectedCityData(String selectedCity) async {
    if (selectedButtonIndex == 1) {
      getSelectedCityDataFromEvent(selectedCity);
      return;
    }
    var selectedCityData = await methodChannelPlatform.invokeMethod(
        'recieveCityData', selectedCity);

    selectedCityDetails = CityModel(
        name: selectedCityData["name"],
        id: selectedCityData["id"],
        state: selectedCityData["state"]);
    update();
  }

  void getSelectedCityDataFromEvent(String selectedCity) {
    try {
      eventChannelPlatform.receiveBroadcastStream(selectedCity).listen((event) {
        selectedCityDetails = CityModel(
            name: event["name"], id: event["id"], state: event["state"]);
        update();
      });
    } catch (error) {
      print(error.toString());
    }
  }

  void callEventChannelFromIos() {
    eventChannelPlatform.receiveBroadcastStream().listen((event) {
      var cityData = event;

      for (var city in cityData) {
        cities.add(CityModel(
            name: city["name"], id: city["id"], state: city["state"]));
      }
      update();
    });
  }
}
