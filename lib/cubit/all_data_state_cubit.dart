import 'package:flutter_bloc/flutter_bloc.dart';

int a = 0;
List<int> list = [0, 0, 0];

class AllDataStateCubit extends Cubit<int> {
  AllDataStateCubit() : super(a);

  void updateBasicEmotions() {
    if (list[0] == 0) {
      list[0] = 1;
      emit(state + 1);
    } else {
      emit(state);
    }
  }

  void updateDetailedEmotions() {
    if (list[1] == 0) {
      list[1] = 1;
      emit(state + 1);
    } else {
      emit(state);
    }
  }

  void updateNotes() {
    if (list[2] == 0) {
      list[2] = 1;
      emit(state + 1);
    } else {
      emit(state);
    }
  }
}
