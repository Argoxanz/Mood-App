import 'package:flutter_bloc/flutter_bloc.dart';

class SliderCubit extends Cubit<double> {
  SliderCubit() : super(0.5);

  void update(double value) {
    emit(value);
  }
}
