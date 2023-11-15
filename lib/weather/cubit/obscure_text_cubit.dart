import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextCubit extends Cubit<bool> {

  ObscureTextCubit() : super(false);


  void toggle() => emit(!state);


}
