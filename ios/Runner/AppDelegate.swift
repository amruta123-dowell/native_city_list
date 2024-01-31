import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
let jsonString = """
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
    }]
"""
    var cities: [CityModel] = []
    let methodChannelName: String = "cityList method channel"
    let eventChannelName:String = "cityList event channel"

    //decode the jsondata
    private func decodeCities(){
        if let jsonData = jsonString.data(using: .utf8){
            do{
                let cityList = try JSONDecoder().decode([CityModel].self, from: jsonData)
                self.cities = cityList
                print("decoded cityList --------> \(cityList)")
            }catch{
                print("Error decoding JSON -------------> \(error)")
            }
        }
    }
    override  init() {
        super.init()
        decodeCities()
    }
    
  
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
        //method channel
        let methodChannel = FlutterMethodChannel(name: methodChannelName,
                                                 binaryMessenger: controller.binaryMessenger)
        let eventChannel = FlutterEventChannel(name: eventChannelName, binaryMessenger: controller.binaryMessenger)
        prepareMethodHandler(methodChannel: methodChannel)
//        eventChannel.setStreamHandler(StreamHandler())
        GeneratedPluginRegistrant.register(with: self)
//        GeneratedPluginRegistrant.register(withRegistry:self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
    }
    //calling method channel event
    private func prepareMethodHandler(methodChannel: FlutterMethodChannel) {
               methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                        if call.method == "recieveCityData" {
                            let selectedCity = call.arguments as? String
                            self.receiveCities(result: result, selectedCity: selectedCity)
            }
            else {
                result(FlutterMethodNotImplemented)
                return
            }
            
        })
    }
    
//    class StreamHandler:NSObject, FlutterStreamHandler{
//        func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
//            receiveCities(
//
//        }
//    }
 

    private func receiveCities(result: FlutterResult, selectedCity: String?) {
         
          // Convert CityModel objects to dictionaries
          let cityDictionaries: [[String: Any]] = cities.map { city in
                 return [
                     "id": city.id,
                     "name": city.name,
                     "state": city.state
                 ]
             }
            if let selectedCityDetails = cityDictionaries.first(where: { $0["name"] as? String == selectedCity }) {
                // Send details of the selected city
                result(selectedCityDetails)
            
            
        }else{
            result(cityDictionaries)
        }
            
      }
    
    
}
