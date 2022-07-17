import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/weather_forecast/weather_forecast_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'Networkk.dart';

class weather_forecast extends StatefulWidget {
  const weather_forecast({Key? key}) : super(key: key);

  @override
  State<weather_forecast> createState() => _weather_forecastState();
}

class _weather_forecastState extends State<weather_forecast> {
  late Future<WeatherForecast> weatherObject;
  String cityName = "cairo";

  @override
  void initState() {
    super.initState();
    weatherObject = Networkk().getWeatherForecast(cityName);

    weatherObject.then((value) {
      print(value.list[1].wind.speed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          textfieldview(),
          midview(weatherObject, context),
          bottomview(weatherObject, context)
        ],
      ),
    );
  }

  //methods used

  Widget textfieldview() {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Enter city name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(8)),
        onSubmitted: (v) {
          setState(() {
            cityName = v;
            weatherObject = new Networkk().getWeatherForecast(cityName);
          });
        },
      ),
    );
  }

  Widget midview(Future<WeatherForecast> w, BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: weatherObject,
        builder: (context, AsyncSnapshot<WeatherForecast> snapshot) {
          if (snapshot.hasData) {
            var date = snapshot.data?.list[0].dt;
            var listt = snapshot.data?.list;

            //start of mid view

            return Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${snapshot.data?.city.name}, " +
                          "${snapshot.data?.city.country}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      "${getformatteddate(new DateTime.fromMillisecondsSinceEpoch(date! * 1000))}",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    getIcon(listt?[0].weather[0].main, 180),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${listt?[0].main.temp}°C",
                            style: TextStyle(
                                fontSize: 33, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "    ${listt?[0].weather[0].description.toUpperCase()}",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${listt?[0].wind.speed} m/h"),
                                Icon(Icons.air, color: Colors.blue)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${listt?[0].main.humidity}%"),
                                Icon(
                                  FontAwesomeIcons.droplet,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${listt?[0].main.feelsLike}°C"),
                                Icon(FontAwesomeIcons.temperatureHigh,
                                    color: Colors.blue)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );

            //end of midview

          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget bottomview(Future<WeatherForecast> w, BuildContext context) {
    var i = -1;
    return Container(
        child: FutureBuilder(
            future: w,
            builder: (context, AsyncSnapshot<WeatherForecast> snapshot) {
              if (snapshot.hasData) {
                var date = snapshot.data?.list[8].dt;
                var listt = snapshot.data?.list;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "5-DAY WEATHER FORECAST",
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Container(
                        height: 170,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 8,
                                ),
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              i++;
                              if(i>3)i=0;
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.7,
                                  height: 160,
                                  child: forecastcard(snapshot, index-i,i),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                        Color(0xff0096FF),
                                        Colors.white
                                      ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight)),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
  }

  String getformatteddate(DateTime date) {
    return new DateFormat("EEEE, MMM d, y").format(date);
  }

  Widget getIcon(String? d, double? size) {
    switch (d) {
      case "Clear":
        {
          return Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(Icons.sunny, size: size, color: Colors.yellow),
          );
        }
        break;
      case "Clouds":
        {
          return Container(
              margin: EdgeInsets.only(right: 20),
              child:
                  Icon(FontAwesomeIcons.cloud, size: size, color: Colors.grey));
        }
        break;
      case "Rain":
        {
          return Container(
              margin: EdgeInsets.only(right: 20),
              child: Icon(FontAwesomeIcons.cloudRain,
                  size: size, color: Colors.blue));
        }
        break;
      case "Snow":
        {
          return Icon(FontAwesomeIcons.snowflake,
              size: size, color: Colors.white38);
        }
        break;
      default:
        {
          return Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(Icons.sunny, size: size, color: Colors.yellow),
          );
        }
        break;
    }
  }

  Widget forecastcard(AsyncSnapshot<WeatherForecast> snapshot, int index, int i) {
    i++;
    var listt = snapshot.data?.list;
    var d = listt?[index+8*(i)].dt;
    var day = "";
    var fulldate = getformatteddate(new DateTime.fromMillisecondsSinceEpoch(d! * 1000));
    day = fulldate.split(",")[0];
    print(listt?[index+8*(i)].main.tempMax);
    print(listt?[index+8*(i)].main.tempMin);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(day),

        )),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: getIcon(listt?[index].weather[0].main,40),
                ),
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        Text("${listt?[index+8*i].main.temp}°C"),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(FontAwesomeIcons.temperatureHigh,
                            color: Colors.blue, size: 17,),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0,left: 18),
                    child: Row(
                      children: [
                        Text("${listt?[index+8*i].main.humidity}%"),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            FontAwesomeIcons.droplet,
                            color: Colors.blue,size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text("${listt?[index+8*i].weather[0].description}",style: TextStyle(
                      fontSize: 12
                    ),),
                  ),
                ],
              ),
            )
          ],

        )

      ],
    );
  }



}
