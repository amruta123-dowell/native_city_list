import 'package:city_list/ui/button_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class CityListScreen extends GetView<HomeController> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select a city",
                style: Theme.of(context)
                    .primaryTextTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 20)),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  ?.copyWith(fontSize: 20),
            ),
            ButtonTileWidget(
              text: controller.selectedCity?.state ?? '',
            )
          ],
        );
      }),
    );
  }
}
