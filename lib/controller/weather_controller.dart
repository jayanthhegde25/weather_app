import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../models/weather/weather_model.dart';

class WeatherController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  RxDouble temp = 0.0.obs;
  RxString type = ''.obs;
  RxString windSpeed = ''.obs;
  RxString clouds = ''.obs;
  RxString humidity = ''.obs;
  RxList<Current> hourly = <Current>[].obs;
  RxList<Daily> daily = <Daily>[].obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      isLoading.value = false;
      update();
    });
  }

   Future<void> getWeatherData(lat,lon) async {
     String url = 'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=c8ea03ecaeb49c15d166adb882a333c2&units=metric';
     log(url);
     try {
     var response = await http.get(Uri.parse(url));
     if (response.statusCode == 200) {
       Weather data = Weather.fromJson(json.decode(response.body));
       temp.value = data.current.temp;
       type.value = data.current.weather[0].description.toString();
       windSpeed.value = data.current.windSpeed.toString();
       clouds.value = data.current.clouds.toString();
       humidity.value = data.current.humidity.toString();
       hourly.value = data.hourly;
       daily.value = data.daily;

       update();
     }
   }
   catch(e){
       log(" catch -${e.toString()}");
     }

  }
}
