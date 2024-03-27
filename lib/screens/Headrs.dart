import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/screens/dailyPage.dart';

import 'comport_page.dart';

class HeadrsPage extends StatefulWidget {
  const HeadrsPage({super.key});

  @override
  State<HeadrsPage> createState() => _HeadrsPageState();
}

class _HeadrsPageState extends State<HeadrsPage> {
  final WeatherController _weatherController = Get.put(WeatherController());
  String city = "";
  String subCity = '';
  String name = '';
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    getAddress(_weatherController.getLatitude().value, _weatherController.getLongitude().value);

    _weatherController.getWeatherData(_weatherController.getLatitude().value,_weatherController.getLongitude().value);

  }

  getAddress(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    print(placemarks);
    setState(() {
      city = place.locality!;
      subCity = place.subLocality!;
      name = place.name!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                subCity,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              // SizedBox(
              //   height: 4.h,
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$city,",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(DateFormat('dd MMMM yyyy').format(date),
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]))
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    (_weatherController.type.value == 'broken clouds') ?
                    'assets/weather/01n.png' :
                    (_weatherController.type.value == 'clear sky')?
                    'assets/weather/01d.png' :
                    (_weatherController.type.value == 'few clouds')?
                    'assets/weather/02d.png' :
                    (_weatherController.type.value == 'heavy intensity rain')?
                    'assets/weather/03n.png' :
                    (_weatherController.type.value == 'moderate rain')?
                    'assets/weather/04d.png' :
                    (_weatherController.type.value == 'overcast clouds')?
                    'assets/weather/04n.png' : 'assets/weather/10d.png',
                  height: 10.h,width: 10.w,),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 18.w),
                    child: Column(
                      children: [
                        Text("${_weatherController.temp.value.toString()}˚C",style: TextStyle(color: Colors.black,fontSize: 34.sp),),
                        Text(_weatherController.type.value,style: TextStyle(color: Colors.grey,fontSize: 16.sp,),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weathers("${_weatherController.windSpeed.value} Km/h",'assets/icons/windspeed.png'),
                  weathers("${_weatherController.clouds.value} %",'assets/icons/clouds.png'),
                  weathers("${_weatherController.humidity.value} %",'assets/icons/humidity.png'),
                ],
              ),
              SizedBox(height: 22.h,),
              Center(child: Text("Today",style: TextStyle(fontSize: 16.sp,color: Colors.black),)),
              SizedBox(height: 16.h,),
              const HoursPage(),
              SizedBox(height: 24.h,),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                padding: EdgeInsets.only(top:12.h,left: 16.w, ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                ),
                child: Text("Next Week Forecast",style: TextStyle(fontSize: 14.sp,color: Colors.black)),
              ),
              const DailyPage(),


            ],
          );
        }
      ),
    );
  }




  Widget weathers(String info,String path){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200]
            ),
            child: Image.asset(path,height: 35.h,width: 45.w,),
          ),
          SizedBox(height: 6.h,),
          Center(child: Text(info,style: TextStyle(fontSize: 12.sp,color: Colors.black),)),

        ],
      ),
    );
  }

}
