import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/weather_controller.dart';

class HoursPage extends StatefulWidget {
  const HoursPage({super.key});

  @override
  State<HoursPage> createState() => _HoursPageState();
}

class _HoursPageState extends State<HoursPage> {

 final WeatherController _weatherController = Get.put(WeatherController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return SizedBox(
            height: 120.h,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _weatherController.hourly.length,
                itemBuilder: (context,index){
                  int unixTimestamp = _weatherController.hourly[index].dt;
                  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
                  String formattedTime = DateFormat('h:mm a').format(dateTime); // Format time as HH:mm

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                    decoration: BoxDecoration(
                        color: formattedTime == DateFormat('h:mm a').format(DateTime.now())? Colors.blue[300] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: Column(
                      children: [
                        Text(formattedTime,
                          style: TextStyle(fontSize: 14.sp,color: Colors.black),),
                        SizedBox(height: 8.h,),
                        Image.asset(
                          (_weatherController.hourly[index].weather[0].description == 'broken clouds'
                              && _weatherController.hourly[index].weather[0].icon == '04d' ) ? 'assets/weather/04d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '04n')? 'assets/weather/04n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'clear sky'
                              && _weatherController.hourly[index].weather[0].icon  == '01d')? 'assets/weather/01d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '01n')? 'assets/weather/01n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'few clouds'
                              && _weatherController.hourly[index].weather[0].icon == '02d')? 'assets/weather/02d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '02n')? 'assets/weather/02n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'heavy intensity rain'
                              && _weatherController.hourly[index].weather[0].icon == '03d')? 'assets/weather/03d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '03d')? 'assets/weather/03d.png':

                          (_weatherController.hourly[index].weather[0].description == 'moderate rain'
                              && _weatherController.hourly[index].weather[0].icon == '10d')? 'assets/weather/10d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '10n')? 'assets/weather/10n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'overcast clouds'
                              && _weatherController.hourly[index].weather[0].icon == '04d')? 'assets/weather/04d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '04n')? 'assets/weather/04n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'scattered clouds'
                              && _weatherController.hourly[index].weather[0].icon == '03d' ) ? 'assets/weather/03d.png' :
                          (_weatherController.hourly[index].weather[0].icon == '03n')? 'assets/weather/03n.png':

                          (_weatherController.hourly[index].weather[0].description  == 'light rain'
                              &&  _weatherController.hourly[index].weather[0].icon == '03d')?'assets/weather/03d.png' :'assets/weather/03n.png',

                          height: 30.h,width: 40.w,),
                        SizedBox(height: 10.h,),
                        Text(_weatherController.hourly[index].weather[0].description!,
                          style: TextStyle(fontSize: 9.sp,color: Colors.black,overflow: TextOverflow.ellipsis),),
                        SizedBox(height: 10.h,),
                        Text("${_weatherController.hourly[index].temp.toString()}˚C",
                          style: TextStyle(fontSize: 14.sp,color: Colors.black),)
                      ],
                    ),
                  );

                }),

          );
      }
    );
    }
 //  selectImage(int index){
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

    //   Container(
    //   child:  Column(
    //     children: [
    //       Text("Comfort Level",style: TextStyle(color: Colors.black,fontSize: 16.sp),),
    //        SizedBox(height: 8.h,),
    //        Center(
    //          child: SleekCircularSlider(
    //            min: 0,
    //            max: 100,
    //            initialValue: double.parse(_weatherController.humidity.value),
    //            appearance: CircularSliderAppearance(
    //              animationEnabled: true,size: 140,
    //              infoProperties: InfoProperties(
    //                bottomLabelText: "Humidity"
    //              )
    //            ),
    //
    //          ),
    //        )
    //
    //     ],
    //   ),
    // );
  }
