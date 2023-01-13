import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Segmented indeterminate progress bar
class SegmentedIndeterminateProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SegmentedIndeterminateProgressbar({Key key}) : super(key: key);

  @override
  _SegmentedIndeterminateProgressbarState createState() =>
      _SegmentedIndeterminateProgressbarState();
}

class _SegmentedIndeterminateProgressbarState
    extends State<SegmentedIndeterminateProgressbar>
    with TickerProviderStateMixin {
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
      // Create primary radial axis
      RadialAxis(
        minimum: 0,
        interval: 1,
        maximum: 360,
        showLabels: false,
        showTicks: false,
        startAngle: 270,
        endAngle: 270,
        radiusFactor: 0.6,
        axisLineStyle: AxisLineStyle(
          thickness: 0.05,
          color: const Color.fromARGB(40, 0, 169, 181),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
        pointers: <GaugePointer>[
          RangePointer(
            value: animationValue,
            width: 0.05,
            sizeUnit: GaugeSizeUnit.factor,
          )
        ],
      ),
      // Create secondary radial axis for segmented line
      RadialAxis(
        minimum: 0,
        interval: 1,
        maximum: 20,
        showLabels: false,
        showTicks: true,
        showAxisLine: false,
        tickOffset: -0.05,
        offsetUnit: GaugeSizeUnit.factor,
        minorTicksPerInterval: 0,
        startAngle: 270,
        endAngle: 270,
        radiusFactor: 0.6,
        majorTickStyle: MajorTickStyle(
            length: 0.1,
            thickness: 5,
            lengthUnit: GaugeSizeUnit.factor,
            color: Colors.white),
      )
    ]);
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    super.dispose();
  }
}
