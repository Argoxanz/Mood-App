import 'package:flutter_bloc/flutter_bloc.dart';

class NotesCubit extends Cubit<String> {
  NotesCubit() : super("");

  void change(String text) {
    emit(text);
  }
}
