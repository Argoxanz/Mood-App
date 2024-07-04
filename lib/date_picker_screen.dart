import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:mood_app/const.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    List<DateTime?> singleDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
    final config = CalendarDatePicker2Config(
      calendarViewMode: CalendarDatePicker2Mode.scroll,
      selectedDayHighlightColor: mandarin,
      weekdayLabels: ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 0,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: customBlack,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: customBlack,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      centerAlignModePicker: true,
      useAbbrLabelForMonthModePicker: true,
      firstDate: DateTime(DateTime.now().year - 2, DateTime.now().month - 1,
          DateTime.now().day - 5),
      lastDate: DateTime(DateTime.now().year + 3, DateTime.now().month + 2,
          DateTime.now().day + 10),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 3)))
          .isNegative,
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "Сегодня",
            style: TextStyle(color: grey1, fontSize: 20),
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: 900,
          child: CalendarDatePicker2(
            config: config.copyWith(
              scrollViewController: scrollController,
              dayMaxWidth: 32,
              controlsHeight: 40,
              hideScrollViewTopHeader: true,
            ),
            value: singleDatePickerValueWithDefaultValue,
            onValueChanged: (dates) =>
                setState(() => singleDatePickerValueWithDefaultValue = dates),
          ),
        ),
      ),
    );
  }
}
