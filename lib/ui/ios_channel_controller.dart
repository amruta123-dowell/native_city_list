import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../city_model.dart';

class IOSChannelController extends GetxController {
  List<String> iosChannelTypes = [
    "Method Channel",
    "Event Channel",
    "PlatformView"
  ];
  MethodChannel methodChannelPlatform =
      const MethodChannel("cityList method channel");
  List<CityModel> cities = [];
  CityModel? selectedCityDetails;
  @override
  void onInit() {
    callMethodChannelFromIOS();
    super.onInit();
  }

  callMethodChannelFromIOS() async {
    try {
      var cityData =
          await methodChannelPlatform.invokeMethod('recieveCityData');
      // Process the received data (List of Maps)

      for (var obj in cityData) {
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
      print(cities);

      // Handle the cities list
    } on PlatformException catch (e) {
      // Handle error
      print('Error: ${e.message}');
    }
  }

  void getSelectedCityData(String selectedCity) async {
    var selectedCityData = await methodChannelPlatform.invokeMethod(
        'recieveCityData', selectedCity);
    print(selectedCityDetails);
    selectedCityDetails = CityModel(
        name: selectedCityData["name"],
        id: selectedCityData["id"],
        state: selectedCityData["state"]);
    update();
  }
}
