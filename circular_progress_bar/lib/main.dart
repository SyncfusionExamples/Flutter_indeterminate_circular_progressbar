import 'package:flutter/material.dart';
import 'Progressbar/BasicIndeterminateProgressbar.dart';
import 'Progressbar/EasingProgressbar.dart';
import 'Progressbar/FilledTrackProgressbar.dart';
import 'Progressbar/GearStyleProgressbar.dart';
import 'Progressbar/GradientStyleProgressbar.dart';
import 'Progressbar/LoadingStyleProgressbar.dart';
import 'Progressbar/SegmentedIndeterminateProgressbar.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IndeterminatePage(),
    );
  }
}

class IndeterminatePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  IndeterminatePage({Key key}) : super(key: key);

  @override
  _IndeterminateState createState() => _IndeterminateState();
}

class _IndeterminateState extends State<IndeterminatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Flutter circular progress bar')),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              height: 150,
              width: 150,

              /// Basic style progress bar
              child: BasicIndeterminateProgressbar(),
            ),
            Container(
              height: 150,
              width: 150,

              /// Track filled type progress bar
              child: FilledTrackIndeterminateProgressbar(),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
              height: 150,
              width: 150,

              /// Easing animated progress bar
              child: EasingIndeterminateProgressbar(),
            ),
            Container(
              height: 150,
              width: 150,

              /// Easing animation with gradient style progress bar
              child: GradientIndeterminateProgressbar(),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                height: 150,
                width: 150,

                /// Segmented indeterminate progress bar
                child: SegmentedIndeterminateProgressbar()),
            Container(
              height: 200,
              width: 200,

              /// Gear style progress bar
              child: GearStyleProgressbar(),
            ),
          ]),
          Container(
              height: 150,
              width: 150,
              transform: Matrix4.translationValues(0.0, -50.0, 0.0),

              /// Loading indicator style
              child: LoadingStyleSegmentedProgressbar()),
        ]));
  }
}
