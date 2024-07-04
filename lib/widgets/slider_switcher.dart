import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_app/const.dart';
import 'package:slide_switcher/slide_switcher.dart';

class SliderSwitcher extends StatelessWidget {
  const SliderSwitcher({
    super.key,
    this.index = 0,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideSwitcher(
        initialIndex: index,
        onSelect: (index) {
          index == 0 ? context.go("/") : context.go("/stats");
        },
        containerHeight: 40,
        containerWight: 380,
        slidersColors: const [mandarin],
        containerColor: grey3,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.book,
                  color: index == 1 ? grey1 : Colors.white,
                ),
              ),
              SizedBox(
                width: 380 / 2 - 40,
                child: Text(
                  'Дневник настроения',
                  style: TextStyle(
                    color: index == 1 ? grey1 : Colors.white,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Icon(
                  Icons.bar_chart,
                  color: index == 0 ? grey1 : Colors.white,
                ),
              ),
              SizedBox(
                width: 380 / 2 - 90,
                child: Text(
                  'Статистика',
                  style: TextStyle(
                    color: index == 0 ? grey1 : Colors.white,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.fade,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
