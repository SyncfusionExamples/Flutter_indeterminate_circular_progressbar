import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Easing animated progress bar
class EasingIndeterminateProgressbar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  EasingIndeterminateProgressbar({Key key}) : super(key: key);

  @override
  _EasingIndeterminateProgressbarState createState() =>
      _EasingIndeterminateProgressbarState();
}

class _EasingIndeterminateProgressbarState
    extends State<EasingIndeterminateProgressbar>
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
        startAngle: 0,
        endAngle: 360,
        radiusFactor: 0.5,
        axisLineStyle: AxisLineStyle(
          thickness: 0.12,
          color: const Color.fromARGB(30, 0, 169, 181),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
      ),
      RadialAxis(
        showLabels: false,
        showTicks: false,
        startAngle: animationValue,
        endAngle: animationValue + 120,
        radiusFactor: 0.5,
        axisLineStyle: AxisLineStyle(
          thickness: 0.12,
          cornerStyle: CornerStyle.bothCurve,
          color: const Color.fromARGB(255, 0, 169, 181),
          thicknessUnit: GaugeSizeUnit.factor,
        ),
      )
    ]);
  }

  @override
  void dispose() {
    firstAnimationController.dispose();
    secondAnimationController.dispose();
    super.dispose();
  }
}
