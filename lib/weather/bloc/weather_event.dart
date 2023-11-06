part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent(this.city);
final String city;


  @override
  List<Object> get props => [city];


}

class FetchWeather extends WeatherEvent{
  const FetchWeather( {required this.myCity}):super(myCity);

  final String myCity;



  
}
class ResetWeather extends WeatherEvent{
 const  ResetWeather({required this.myCity}):super(myCity);

  final String myCity;
}




