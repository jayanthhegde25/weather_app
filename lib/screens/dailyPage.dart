
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/weather_controller.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({super.key});

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  final WeatherController _weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return  Obx(() {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 12.w),
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
            ),
            height: 300.h,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: _weatherController.daily.length,
                itemBuilder: (context,index){
                  int unixTimestamp = _weatherController.daily[index].dt;
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
                  String formattedDay = DateFormat('EEE').format(dateTime);

                  int? riseTimeStamp = _weatherController.daily[index].sunrise;
                  DateTime Risedate = DateTime.fromMillisecondsSinceEpoch(riseTimeStamp * 1000);
                  String Sunrise = DateFormat.jm().format(Risedate);

                  int? setTampSet = _weatherController.daily[index].sunset;
                  DateTime Setdate = DateTime.fromMillisecondsSinceEpoch(setTampSet * 1000);
                  String SunSet = DateFormat.jm().format(Setdate); //

                  return Container(
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.grey.shade300,width: 3))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.shade300),)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formattedDay,style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                                  Image.asset(
                                    (_weatherController.daily[index].weather[0].description == 'broken clouds'
                                        && _weatherController.daily[index].weather[0].icon == '04d' ) ? 'assets/weather/04d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '04n')? 'assets/weather/04n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'clear sky'
                                        && _weatherController.daily[index].weather[0].icon  == '01d')? 'assets/weather/01d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '01n')? 'assets/weather/01n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'few clouds'
                                        && _weatherController.daily[index].weather[0].icon == '02d')? 'assets/weather/02d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '02n')? 'assets/weather/02n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'heavy intensity rain'
                                        && _weatherController.daily[index].weather[0].icon == '03d')? 'assets/weather/03d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '03d')? 'assets/weather/03d.png':

                                    (_weatherController.daily[index].weather[0].description == 'moderate rain'
                                        && _weatherController.daily[index].weather[0].icon == '10d')? 'assets/weather/10d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '10n')? 'assets/weather/10n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'overcast clouds'
                                        && _weatherController.daily[index].weather[0].icon == '04d')? 'assets/weather/04d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '04n')? 'assets/weather/04n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'scattered clouds'
                                        && _weatherController.daily[index].weather[0].icon == '03d' ) ? 'assets/weather/03d.png' :
                                    (_weatherController.daily[index].weather[0].icon == '03n')? 'assets/weather/03n.png':

                                    (_weatherController.daily[index].weather[0].description  == 'light rain'
                                        &&  _weatherController.daily[index].weather[0].icon == '03d')?'assets/weather/03d.png' :'assets/weather/03n.png',
                                    height: 30.h,width: 40.w,),
                                  Text("${_weatherController.daily[index].temp.day.toString()} / ${_weatherController.daily[index].temp.max}˚C",
                                    style: TextStyle(fontSize: 12.sp,color: Colors.black),),
                                ],
                              ),
                              SizedBox(height: 4.h,),
                              Text(_weatherController.daily[index].summary,style: TextStyle(fontSize: 10.sp,color: Colors.black)),

                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 8.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sun rise - $Sunrise",style: TextStyle(fontSize: 10.sp,color: Colors.black)),
                                  Text("Sun set - $SunSet",style: TextStyle(fontSize: 10.sp,color: Colors.black)),
                                  Text("Humidity - ${_weatherController.daily[index].humidity}%",style: TextStyle(fontSize: 10.sp,color: Colors.black)),
                                ],
                              )),
                        ),


                      ],
                    ),
                  );

                }),
          );
      }
    );
  }
  // selectImage(int index){
  //   if(_weatherController.daily[index].weather[0].description == 'broken clouds' ){
  //     if(_weatherController.daily[index].weather[0].icon == '04d'){
  //       Image.asset('assets/weather/04d.png');
  //     }
  //     else{
  //       Image.asset('assets/weather/04n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'clear sky'){
  //     if(_weatherController.daily[index].weather[0].icon == '01d'){
  //       Image.asset('assets/weather/01d.png');
  //     }else{
  //       Image.asset('assets/weather/01n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'few clouds'){
  //     if(_weatherController.daily[index].weather[0].icon == '02d'){
  //       Image.asset('assets/weather/02d.png');
  //     }else{
  //       Image.asset('assets/weather/02n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'heavy intensity rain'){
  //     if(_weatherController.daily[index].weather[0].icon == '03n'){
  //       Image.asset('assets/weather/03n.png');
  //     }else{
  //       Image.asset('assets/weather/03n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description == 'moderate rain'){
  //     if(_weatherController.daily[index].weather[0].icon == '10d'){
  //       Image.asset('assets/weather/10d.png');
  //     }else{
  //       Image.asset('assets/weather/10n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'overcast clouds'){
  //     if(_weatherController.daily[index].weather[0].icon == '04d'){
  //       Image.asset('assets/weather/04d.png');
  //     }else{
  //       Image.asset('assets/weather/04n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'scattered clouds'){
  //     if(_weatherController.daily[index].weather[0].icon == '03d'){
  //       Image.asset('assets/weather/03d.png');
  //     }else{
  //       Image.asset('assets/weather/03n.png');
  //     }
  //   }
  //   else if(_weatherController.daily[index].weather[0].description  == 'light rain'){
  //     if(_weatherController.daily[index].weather[0].icon == '10d'){
  //       Image.asset('assets/weather/10d.png');
  //     }else{
  //       Image.asset('assets/weather/10n.png');
  //     }
  //   }
  // }
}
