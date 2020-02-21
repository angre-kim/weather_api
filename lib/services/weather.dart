import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '83b6363fa422a666a28b75dea9ebc7a6';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async{
    //입력한 도시명으로 API 가져오기
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    try {
      await location.getCurrentLocation().timeout(Duration(seconds: 5));

      NetworkHelper networkHelper = NetworkHelper(
          '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      var weatherData = null;
      return weatherData;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '🍦 먹기 좋은 날씨';
    } else if (temp > 20) {
      return '선선해요 👕';
    } else if (temp < 10) {
      return '추워요 🧣와 🧤를 준비하세요';
    } else {
      return '진짜 추워요. 꼭 🧥을 챙기세요';
    }
  }
}
