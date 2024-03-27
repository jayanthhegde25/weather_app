import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/screens/Headrs.dart';
import 'package:weather_app/screens/comport_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherController _weatherController =
      Get.put(WeatherController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return _weatherController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                ))
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: const [HeadrsPage(),
                    // ComportPage()
                  ],
                );
        }),
      ),
    );
  }
}
