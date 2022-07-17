class WeatherForecast {
  late String cod;
  late num message;
  late num cnt;
  late List<Lista> list;
  late City city;

  WeatherForecast({required this.cod, required this.message, required this.cnt, required this.list, required this.city});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      list = <Lista>[];
      json['list'].forEach((v) {
        list.add(new Lista.fromJson(v));
      });
    }
    city = (json['city'] != null ? new City.fromJson(json['city']) : null)!;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cod'] = this.cod;
  //   data['message'] = this.message;
  //   data['cnt'] = this.cnt;
  //   if (this.list != null) {
  //     data['list'] = this.list.map((v) => v.toJson()).toList();
  //   }
  //   if (this.city != null) {
  //     data['city'] = this.city.toJson();
  //   }
  //   return data;
  // }
}

class Lista {
  late int dt;
  late Main main;
  late List<Weather> weather;
  late Clouds clouds;
  late Wind wind;
  late num visibility;
  late num pop;
  late int sys;
  late String dtTxt;

  Lista(
      {required this.dt,
        required this.main,
        required this.weather,
        required this.clouds,
        required this.wind,
        required this.visibility,
        required this.pop,
        required this.sys,
        required this.dtTxt});

  Lista.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = (json['main'] != null ? new Main.fromJson(json['main']) : null)!;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather.add(new Weather.fromJson(v));
      });
    }
    clouds =
    (json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null)!;
    wind = (json['wind'] != null ? new Wind.fromJson(json['wind']) : null)!;
    visibility = json['visibility'];
    pop = json['pop'];
    // sys = (json['sys'] != null ? new Sys.fromJson(json['sys']) : null)! as int ;
    dtTxt = json['dt_txt'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['dt'] = this.dt;
  //   if (this.main != null) {
  //     data['main'] = this.main.toJson();
  //   }
  //   if (this.weather != null) {
  //     data['weather'] = this.weather.map((v) => v.toJson()).toList();
  //   }
  //   if (this.clouds != null) {
  //     data['clouds'] = this.clouds.toJson();
  //   }
  //   if (this.wind != null) {
  //     data['wind'] = this.wind.toJson();
  //   }
  //   data['visibility'] = this.visibility;
  //   data['pop'] = this.pop;
  //   if (this.sys != null) {
  //     data['sys'] = this.sys.toJson();
  //   }
  //   data['dt_txt'] = this.dtTxt;
  //   return data;
  // }
}

class Main {
  late num temp;
  late num feelsLike;
  late num? tempMin;
  late num? tempMax;
  late num pressure;
  late num seaLevel;
  late num grndLevel;
  late num humidity;
  late num tempKf;

  Main(
      {required this.temp,
        required this.feelsLike,
        required this.tempMin,
        required this.tempMax,
        required this.pressure,
        required this.seaLevel,
        required this.grndLevel,
        required this.humidity,
        required this.tempKf});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
    humidity = json['humidity'];
    tempKf = json['temp_kf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['sea_level'] = this.seaLevel;
    data['grnd_level'] = this.grndLevel;
    data['humidity'] = this.humidity;
    data['temp_kf'] = this.tempKf;
    return data;
  }
}

class Weather {
  late num id;
  late String main;
  late String description;
  late String icon;

  Weather({required this.id, required this.main, required this.description, required this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Clouds {
  late num all;

  Clouds({required this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}

class Wind {
  late num speed;
  late num deg;
  late num gust;

  Wind({required this.speed, required this.deg, required this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    data['gust'] = this.gust;
    return data;
  }
}

// class Sys {
//   late String pod;
//
//   Sys({required this.pod});
//
//   Sys.fromJson(Map<String, dynamic> json) {
//     pod = json['pod'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['pod'] = this.pod;
//     return data;
//   }
// }

class City {
  late num id;
  late String name;
  late Coord coord;
  late String country;
  late num population;
  late num timezone;
  late num sunrise;
  late num sunset;

  City(
      {required this.id,
        required this.name,
        required this.coord,
        required this.country,
        required this.population,
        required this.timezone,
        required this.sunrise,
        required this.sunset});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = (json['coord'] != null ? new Coord.fromJson(json['coord']) : null)!;
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coord != null) {
      data['coord'] = this.coord.toJson();
    }
    data['country'] = this.country;
    data['population'] = this.population;
    data['timezone'] = this.timezone;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    return data;
  }
}

class Coord {
  late num lat;
  late num lon;

  Coord({required this.lat, required this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}