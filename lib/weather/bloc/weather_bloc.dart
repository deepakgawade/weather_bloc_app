
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(getWeather);
    on<ResetWeather>(reset);
  }

  void getWeather(WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final weatherData = await weatherRepository.getWeather(city: event.city);

      emit(WeatherLoaded(weather: weatherData));
    } catch (e) {
      emit(WeatherNotloaded());
    }
  }
  void reset(WeatherEvent event, Emitter<WeatherState> emit){
emit(WeatherInitial());
  }
}
