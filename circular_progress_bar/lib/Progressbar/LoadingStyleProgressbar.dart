import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Loading indicator style progress bar
class LoadingStyleSegmentedProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  LoadingStyleSegmentedProgressbar({Key key}) : super(key: key);

  @override
  _LoadingStyleSegmentedProgressbarState createState() =>
      _LoadingStyleSegmentedProgressbarState();
}

class _LoadingStyleSegmentedProgressbarState
    extends State<LoadingStyleSegmentedProgressbar>
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
        showLabels: false,
        showTicks: false,
        startAngle: 270,
        endAngle: 270,
        radiusFactor: 0.25,
        showAxisLine: true,
        showFirstLabel: false,
        axisLineStyle: AxisLineStyle(
          thickness: 0.5,
          color: const Color(0x3000A8B5),
          thicknessUnit: GaugeSizeUnit.factor,
          dashArray: <double>[2, 2],
        ),
      ),
      // Create secondary radial axis for showing progress
      RadialAxis(
        showLabels: false,
        showTicks: false,
        startAngle: animationValue,
        endAngle: animationValue + 180,
        radiusFactor: 0.25,
        showAxisLine: true,
        showFirstLabel: false,
        axisLineStyle: AxisLineStyle(
          thickness: 0.5,
          gradient: const SweepGradient(
              colors: <Color>[Color(0xFFFFFFFF), Color(0xFF00A8B5)],
              stops: <double>[0.25, 0.75]),
          thicknessUnit: GaugeSizeUnit.factor,
          dashArray: <double>[2, 2],
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    super.dispose();
  }
}
