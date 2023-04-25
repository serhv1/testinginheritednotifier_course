import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (
          context,
        ) {
          return Column(
            children: [
              Slider(
                value: SliderInheritedNotifier.of(context),
                onChanged: (value) {
                  sliderData.value = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 200,
                      color: Colors.yellow,
                    ),
                  ),
                  Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                    child: Container(
                      height: 200,
                      color: Colors.blue,
                    ),
                  ),
                ].expandEqually().toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}

final sliderData = SliderData();

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    if (newValue != _value) {
      _value = newValue;
      notifyListeners();
    }
  }
}

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  const SliderInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child,
  }) : super(
          child: child,
          notifier: sliderData,
          key: key,
        );

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
          ?.notifier
          ?.value ??
      0.0;
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map(
        (w) => Expanded(
          child: w,
        ),
      );
}
