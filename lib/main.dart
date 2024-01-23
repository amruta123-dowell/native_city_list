// In your main.dart or any Flutter file
import 'package:city_list/city_model.dart';
import 'package:city_list/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City List'),
      ),
      body: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Select a city",
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 20),
            ),
            Container(
              color: Colors.blue,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: DropdownButton(
                  underline: Container(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  isExpanded: true,
                  isDense: true,
                  items: controller.cities.map((city) {
                    return DropdownMenuItem(
                        value: city.name, child: Text(city.name));
                  }).toList(),
                  value: controller.selectedCity?.name,
                  onChanged: (value) {
                    controller.onSelectCity(value.toString());
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "State",
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.black, fontSize: 20),
            ),
            Container(
              height: 60,
              alignment: Alignment.center,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              color: Colors.blue,
              child: Text(
                controller.selectedCity?.state ?? '',
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 17, color: Colors.black),
              ),
            )
          ],
        );
      }),
    );
  }
}
