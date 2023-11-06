import 'package:bloc_pattern/weather/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final cityController = TextEditingController();
  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Weather"),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        builder: (context, state) {
          if (state is WeatherInitial) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: cityController,
                    decoration:
                        const InputDecoration(contentPadding: EdgeInsets.only(left: 20),alignLabelWithHint: true,labelText: "Enter city name",border:OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(10)) )),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      weatherBloc.add(FetchWeather(myCity: cityController.text));
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            );
          } else if (state is WeatherLoading) {
            return const Center(child:  CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(state.data.location),
                  Text(state.data.condition.name),
                  Text(state.data.temperature.toString()),
                  ElevatedButton(
                    onPressed: () {
                      weatherBloc.add(const ResetWeather(myCity: ''));
                    },
                    child: const Text("Reset"),
                  )
                ],
              ),
            );
          }
          return Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Something went wrong!!"),
              ElevatedButton(
                onPressed: () {
                  weatherBloc.add(const ResetWeather(myCity: ''));
                },
                child: const Text("Reset"),
              )
            ],
          ));
        },
      ),
    );
  }
}
