part of 'weather_bloc.dart';


enum WeatherStatus{initial, loading, error, sucess}

 class WeatherState extends Equatable {
  const WeatherState();



  
  @override
  List<Object> get props => [];




}


class WeatherInitial extends WeatherState{}
class WeatherLoaded extends WeatherState{

  final Weather weather;

  const WeatherLoaded({required this.weather});
  Weather get data=>weather;

  @override
  List<Object> get props => [weather];

}
class WeatherLoading extends WeatherState{}
class WeatherNotloaded extends WeatherState{}





