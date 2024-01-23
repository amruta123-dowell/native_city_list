package com.example.city_list

import androidx.annotation.NonNull
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    private val channel = "com.example.city_list"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            if (call.method == "getDataFromNative") {
                // Perform platform-specific operations and obtain the result
                val data = getDataFromNative()

                // Send the result back to Flutter
                result.success(data)
            } else {
                result.notImplemented()
            }
        }

    }


    // Set up the MethodChannel with the same name as defined in Dart


    private fun getDataFromNative(): List<Map<String, Any?>> {


        val jsonData = """
        [
               {
        "id": "1",
        "name": "Mumbai",
        "state": "Maharashtra"
    },
    {
        "id": "2",
        "name": "Delhi",
        "state": "Delhi"
    },
    {
        "id": "3",
        "name": "Bengaluru",
        "state": "Karnataka"
    },
    {
        "id": "4",
        "name": "Ahmedabad",
        "state": "Gujarat"
    },
    {
        "id": "5",
        "name": "Hyderabad",
        "state": "Telangana"
    },
    {
        "id": "6",
        "name": "Chennai",
        "state": "Tamil Nadu"
    },
    {
        "id": "7",
        "name": "Kolkata",
        "state": "West Bengal"
    },
    {
        "id": "8",
        "name": "Pune",
        "state": "Maharashtra"
    },
    {
        "id": "9",
        "name": "Jaipur",
        "state": "Rajasthan"
    },
    {
        "id": "10",
        "name": "Surat",
        "state": "Gujarat"
    },
    {
        "id": "11",
        "name": "Lucknow",
        "state": "Uttar Pradesh"
    },
    {
        "id": "12",
        "name": "Kanpur",
        "state": "Uttar Pradesh"
    },
    {
        "id": "13",
        "name": "Nagpur",
        "state": "Maharashtra"
    },
    {
        "id": "14",
        "name": "Patna",
        "state": "Bihar"
    },
    {
        "id": "15",
        "name": "Indore",
        "state": "Madhya Pradesh"
    },
    {
        "id": "16",
        "name": "Thane",
        "state": "Maharashtra"
    },
    {
        "id": "17",
        "name": "Bhopal",
        "state": "Madhya Pradesh"
    },
    {
        "id": "18",
        "name": "Visakhapatnam",
        "state": "Andhra Pradesh"
    }
         ]
    """.trimIndent()


        val cities: List<CityModel>  = Gson().fromJson(jsonData, object : TypeToken<List<CityModel>>() {}.type)
        // Convert CityModel list to List<Map<String, Any?>>
        val cityMaps: List<Map<String, Any?>> = cities.map { city ->
            mapOf(
                "id" to city.id,
                "name" to city.name,
                "state" to city.state
            )
        }

        println("cityMaps -----> $cityMaps")
        return cityMaps


    }


}
