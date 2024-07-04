import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_app/const.dart';
import 'package:mood_app/cubit/emotions_cubit.dart';

List<int> detailedEmotionsValues = List.filled(
    detailedEmotions[lastSelEmotion > -1 ? lastSelEmotion : 0].length, 0);
int lastDetSelEmotion = -1;

class DetailedEmotionsCubit extends Cubit<List<int>> {
  DetailedEmotionsCubit() : super(detailedEmotionsValues);

  void select(int sel) {
    detailedEmotionsValues =
        List.filled(detailedEmotions[lastSelEmotion].length, 0);
    detailedEmotionsValues[sel] = 1;
    lastDetSelEmotion = sel;
    emit(detailedEmotionsValues);
  }
}
