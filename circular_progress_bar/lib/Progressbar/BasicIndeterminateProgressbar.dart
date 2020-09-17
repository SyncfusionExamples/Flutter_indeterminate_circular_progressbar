import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Basic style progress bar
class BasicIndeterminateProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BasicIndeterminateProgressbar({Key key}) : super(key: key);

  @override
  _BasicIndeterminateProgressbarState createState() =>
      _BasicIndeterminateProgressbarState();
}

class _BasicIndeterminateProgressbarState
    extends State<BasicIndeterminateProgressbar> with TickerProviderStateMixin {
  Animation<double> linearAnimation;
  AnimationController linearAnimationController;
  double animationValue = 0;

  @override
  void initState() {
    super.initState();

    /// Linear animation
    linearAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    linearAnimation =
        CurvedAnimation(parent: linearAnimationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {
              animationValue = linearAnimation.value * 360;
            });
          });
    linearAnimationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 360,
        showAxisLine: false,
        showLabels: false,
        showTicks: false,
        startAngle: animationValue,
        endAngle: animationValue + 330,
        radiusFactor: 0.55,
        pointers: <GaugePointer>[
          RangePointer(
            value: 330,
            width: 0.25,
            cornerStyle: CornerStyle.bothCurve,
            sizeUnit: GaugeSizeUnit.factor,
          )
        ],
      )
    ]);
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    super.dispose();
  }
}
