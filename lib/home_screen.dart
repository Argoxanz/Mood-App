import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_app/const.dart';
import 'package:mood_app/cubit/Slider_cubit.dart';
import 'package:mood_app/cubit/all_data_state_cubit.dart';
import 'package:mood_app/cubit/emotions_cubit.dart';
import 'package:mood_app/cubit/detailed_emotions_cubit.dart';
import 'package:mood_app/cubit/notes_cubit.dart';

import 'package:go_router/go_router.dart';
import 'package:mood_app/widgets/slider_switcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final emotionsCubit = EmotionsCubit();
    final detailedEmotionsCubit = DetailedEmotionsCubit();
    final stressCubit = SliderCubit();
    final selfEsteemCubit = SliderCubit();
    final notesCubit = NotesCubit();
    final gatheredState = AllDataStateCubit();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                context.push('/datepicker');
              },
              child: const Icon(
                Icons.calendar_month,
                size: 30,
                color: grey2,
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "${now.day} ${months[now.month - 1]} ${now.hour.toString().padLeft(2, "0")}:${now.minute.toString().padLeft(2, "0")}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: grey2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SliderSwitcher(),
              const SizedBox(height: 30),
              const TextLabelHome(text: 'Что чувствуешь?'),
              const SizedBox(height: 20),
              BasicEmotionPicker(
                emotionsCubit: emotionsCubit,
                allDataStateCubit: gatheredState,
              ),
              const SizedBox(height: 20),
              DetailedEmotionPicker(
                  emotionsCubit: emotionsCubit,
                  detailedEmotionsCubit: detailedEmotionsCubit,
                  allDataStateCubit: gatheredState),
              const SizedBox(height: 20),
              const TextLabelHome(text: 'Уровень стресса'),
              const SizedBox(height: 20),
              BlocBuilder(
                bloc: detailedEmotionsCubit,
                builder: (context, state) {
                  return Column(
                    children: [
                      MoodSlider(stressCubit: stressCubit),
                      const SizedBox(height: 20),
                      const TextLabelHome(text: 'Самооценка'),
                      const SizedBox(height: 20),
                      MoodSlider(
                        stressCubit: selfEsteemCubit,
                        smallIndication: 'Неуверенность',
                        bigIndication: 'Уверенность',
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              const TextLabelHome(text: 'Заметки'),
              const SizedBox(height: 20),
              MoodNotes(
                  notesCubit: notesCubit, allDataStateCubit: gatheredState),
              const SizedBox(height: 20),
              MoodButton(gatheredState: gatheredState),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  const MoodButton({
    super.key,
    required this.gatheredState,
  });

  final AllDataStateCubit gatheredState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: gatheredState,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (gatheredState.state == 3) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Успешно!'),
                  content: const Text('Ваша заметка сохранена!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Container(
              height: 45,
              width: MediaQuery.sizeOf(context).width - 20 * 2,
              decoration: BoxDecoration(
                  color: gatheredState.state > 2 ? mandarin : grey3,
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: const Center(
                child: Text(
                  'Сохранить',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
        );
      },
    );
  }
}

class MoodNotes extends StatelessWidget {
  const MoodNotes({
    super.key,
    required this.notesCubit,
    required this.allDataStateCubit,
  });

  final NotesCubit notesCubit;
  final AllDataStateCubit allDataStateCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          onChanged: (value) {
            notesCubit.change(value);

            if (notesCubit.state.length > 3) {
              allDataStateCubit.updateNotes();
            }
          },
        ),
      ),
    );
  }
}

class MoodSlider extends StatelessWidget {
  const MoodSlider({
    super.key,
    required this.stressCubit,
    this.smallIndication = 'Низкий',
    this.bigIndication = 'Высокий',
  });

  final String smallIndication;
  final String bigIndication;
  final SliderCubit stressCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int z = 0; z < 6; z++)
                    Container(
                      width: 2,
                      height: 8,
                      decoration: BoxDecoration(
                          color: grey2, borderRadius: BorderRadius.circular(1)),
                    ),
                ]),
          ),
          BlocBuilder(
            bloc: stressCubit,
            builder: (context, state) {
              return Slider(
                secondaryActiveColor: Colors.white,
                divisions: 10,
                thumbColor: lastDetSelEmotion > -1 ? mandarin : grey3,
                activeColor: lastDetSelEmotion > -1 ? mandarin : grey3,
                inactiveColor: grey3,
                value: stressCubit.state,
                onChanged: (value) {
                  stressCubit.update(value);
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  smallIndication,
                  style: const TextStyle(color: grey1, fontSize: 13),
                ),
                Text(
                  bigIndication,
                  style: const TextStyle(color: grey1, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class DetailedEmotionPicker extends StatelessWidget {
  const DetailedEmotionPicker({
    super.key,
    required this.emotionsCubit,
    required this.detailedEmotionsCubit,
    required this.allDataStateCubit,
  });

  final EmotionsCubit emotionsCubit;
  final DetailedEmotionsCubit detailedEmotionsCubit;
  final AllDataStateCubit allDataStateCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: emotionsCubit,
      builder: (context, state) {
        return lastSelEmotion > -1
            ? Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  children: detailedEmotions[lastSelEmotion].map((item) {
                    int index = detailedEmotions[lastSelEmotion]
                        .asMap()
                        .keys
                        .firstWhere((k) =>
                            detailedEmotions[lastSelEmotion].asMap()[k] ==
                            item);
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 5, right: 12),
                      child: GestureDetector(
                        onTap: () {
                          detailedEmotionsCubit.select(index);
                          allDataStateCubit.updateDetailedEmotions();
                        },
                        child: BlocBuilder(
                          bloc: detailedEmotionsCubit,
                          builder: (context, state) {
                            return Container(
                              decoration: BoxDecoration(
                                color: lastDetSelEmotion == index
                                    ? mandarin
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: lastDetSelEmotion == index
                                              ? Colors.white
                                              : customBlack,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class BasicEmotionPicker extends StatelessWidget {
  const BasicEmotionPicker({
    super.key,
    required this.emotionsCubit,
    required this.allDataStateCubit,
  });

  final EmotionsCubit emotionsCubit;
  final AllDataStateCubit allDataStateCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: emotionsCubit,
      builder: (context, state) {
        return SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: emotions.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                emotionsCubit.select(index);
                allDataStateCubit.updateBasicEmotions();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  height: 118,
                  width: 95,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: emotionsCubit.state[index] == 1
                        ? Border.all(color: mandarin)
                        : null,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/$index.png"),
                      Text(
                        emotions[index],
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TextLabelHome extends StatelessWidget {
  const TextLabelHome({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w900, color: customBlack),
      ),
    );
  }
}
