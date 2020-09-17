import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Easing animation with gradient style progress bar
class GradientIndeterminateProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  GradientIndeterminateProgressbar({Key key}) : super(key: key);

  @override
  _GradientIndeterminateProgressbarState createState() =>
      _GradientIndeterminateProgressbarState();
}

class _GradientIndeterminateProgressbarState
    extends State<GradientIndeterminateProgressbar>
    with TickerProviderStateMixin {
  Animation<double> firstAnimation;
  AnimationController firstAnimationController;
  Animation<double> secondAnimation;
  AnimationController secondAnimationController;
  double animationValue = 0;
  bool isFirstAnimationCompleted = false;
  @override
  void initState() {
    super.initState();
    firstAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    firstAnimation =
        CurvedAnimation(parent: firstAnimationController, curve: Curves.easeIn)
          ..addListener(() {
            setState(() {
              if (!isFirstAnimationCompleted) {
                animationValue = firstAnimation.value * 360;
              }
            });
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              isFirstAnimationCompleted = true;
              secondAnimationController.forward();
              firstAnimationController.reset();
            }
          });
    firstAnimationController.forward();

    /// Easing animation
    secondAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    secondAnimation = CurvedAnimation(
        parent: secondAnimationController, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {
          if (isFirstAnimationCompleted) {
            animationValue = secondAnimation.value * 360;
          }
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          isFirstAnimationCompleted = false;
          firstAnimationController.forward();
          secondAnimationController.reset();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(
        showLabels: false,
        showTicks: false,
        startAngle: animationValue,
        endAngle: animationValue + 350,
        radiusFactor: 0.5,
        axisLineStyle: AxisLineStyle(
          thickness: 0.2,
          cornerStyle: CornerStyle.bothCurve,
          gradient: const SweepGradient(
              colors: <Color>[Color(0xFFFFFFFF), Color(0xFF00A8B5)],
              stops: <double>[0.25, 1.0]),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    secondAnimationController.dispose();
    super.dispose();
  }
}
