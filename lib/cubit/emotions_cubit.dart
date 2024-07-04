import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_app/const.dart';

List<int> emotionsValues = List.filled(emotions.length, 0);
int lastSelEmotion = -1;

class EmotionsCubit extends Cubit<List<int>> {
  EmotionsCubit() : super(emotionsValues);

  void select(int sel) {
    emotionsValues = List.filled(emotions.length, 0);
    emotionsValues[sel] = 1;
    lastSelEmotion = sel;
    emit(emotionsValues);
  }
}
