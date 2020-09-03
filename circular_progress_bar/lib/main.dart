import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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

class _IndeterminateState extends State<IndeterminatePage>
    with TickerProviderStateMixin {
  double _pointerValue = 0;
  double _startAngle = 0;
  double _endAngle = 0;
  double _animationRepeatCount = 0;
  bool _needsPointerUpdate = false;

  Animation<double> linearAnimation;
  AnimationController linearAnimationController;
  Animation<double> animation;
  AnimationController controller;
  Animation<double> easeAnimation;
  AnimationController easeAnimationController;

  static final Tween<double> _lowToHighValueTween =
      Tween<double>(begin: 0, end: 360);

  static final Tween<double> _highToLowValueTween =
      Tween<double>(begin: 360, end: 0);

  @override
  void initState() {
    super.initState();

    /// Linear animation
    linearAnimationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);

    linearAnimation = CurvedAnimation(
        parent: linearAnimationController,
        curve: const Interval(0, 1, curve: Curves.linear))
      ..addListener(() {
        setState(() {});
      });
    linearAnimationController.repeat();

    /// Easing animation
    easeAnimationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    easeAnimation = Tween<double>(begin: 0, end: 360).animate(CurvedAnimation(
        parent: easeAnimationController,
        curve: const Interval(0, 1, curve: Curves.ease))
      ..addListener(() {
        setState(() {});
      }));
    easeAnimationController.repeat();

    /// Rotate axisline bar at 4 times and progressed the pointer.
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 360).animate(controller)
      ..addListener(() {
        setState(() {
          if (!_needsPointerUpdate) {
            _startAngle = animation.value;
            _endAngle = _startAngle + 270;
          }
          if (animation.value > 350) {
            _animationRepeatCount++;
          }
          if (_animationRepeatCount > 4) {
            _pointerValue++;
            _startAngle = 270;
            _endAngle = 270;
            _needsPointerUpdate = true;
          }
          if (_pointerValue > 100) {
            controller.stop();
          }
        });
      });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Flutter circular progress bar')),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          getBasicIndeterminateStyleProgress(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            getEaseAnimationStyle(),
            getDownloadStyleProgressbar(),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            getEaseAnimationStyleWithGradient(),
            getSettingStyleProgressbar(),
          ]),
          getSegmentedProgressStyle()
        ]));
  }

  Widget getBasicIndeterminateStyleProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 150,
            width: 150,
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 360,
                showAxisLine: false,
                showLabels: false,
                showTicks: false,
                startAngle: _lowToHighValueTween.evaluate(linearAnimation),
                endAngle: _lowToHighValueTween.evaluate(linearAnimation) + 330,
                radiusFactor: 0.6,
                pointers: <GaugePointer>[
                  RangePointer(
                    value: 330,
                    width: 0.25,
                    cornerStyle: CornerStyle.bothCurve,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ])),
        Container(
            height: 150,
            width: 150,
            child: SfRadialGauge(axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: _lowToHighValueTween.evaluate(linearAnimation),
                endAngle: _lowToHighValueTween.evaluate(linearAnimation) + 359,
                showAxisLine: false,
                radiusFactor: 0.65,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.05,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFd9f8fa), Color(0xFF00A8B5)],
                        stops: <double>[0.25, 1.0]),
                    value: 100,
                    width: 1,
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ])),
      ],
    );
  }

  Widget getEaseAnimationStyle() {
    return Container(
        height: 150,
        width: 150,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 0,
            endAngle: 360,
            radiusFactor: 0.5,
            axisLineStyle: AxisLineStyle(
              thickness: 0.12,
              color: const Color.fromARGB(30, 0, 169, 181),
              cornerStyle: CornerStyle.bothCurve,
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          ),
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: easeAnimation.value,
            endAngle: easeAnimation.value + 120,
            radiusFactor: 0.5,
            axisLineStyle: AxisLineStyle(
              thickness: 0.12,
              cornerStyle: CornerStyle.bothCurve,
              color: const Color.fromARGB(255, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          )
        ]));
  }

  Widget getDownloadStyleProgressbar() {
    return Container(
        height: 150,
        width: 150,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 100,
            interval: 1,
            showLabels: false,
            showTicks: false,
            startAngle: _startAngle,
            endAngle: _endAngle,
            radiusFactor: 0.4,
            axisLineStyle: AxisLineStyle(
              thickness: 0.15,
              color: const Color.fromARGB(75, 0, 169, 181),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
            pointers: <GaugePointer>[
              RangePointer(
                  value: _pointerValue,
                  width: 0.15,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: false,
                  animationDuration: 500,
                  animationType: AnimationType.easeOutBack)
            ],
          )
        ]));
  }

  Widget getEaseAnimationStyleWithGradient() {
    return Container(
        height: 150,
        width: 150,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: easeAnimation.value,
            endAngle: easeAnimation.value + 350,
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
        ]));
  }

  Widget getSettingStyleProgressbar() {
    return Container(
        height: 200,
        width: 200,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            interval: 1,
            maximum: 10,
            showLabels: false,
            showTicks: true,
            showAxisLine: true,
            showLastLabel: false,
            ticksPosition: ElementsPosition.outside,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 0,
            startAngle: _highToLowValueTween.evaluate(linearAnimation),
            centerX: 0.36,
            centerY: 0.36,
            isInversed: false,
            endAngle: _highToLowValueTween.evaluate(linearAnimation) + 359.9,
            radiusFactor: 0.35,
            majorTickStyle: MajorTickStyle(
              length: 0.2,
              thickness: 8,
              color: const Color(0xFF00A8B5),
              lengthUnit: GaugeSizeUnit.factor,
            ),
            axisLineStyle: AxisLineStyle(
              thickness: 0.3,
              color: const Color(0xFF00A8B5),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          ),
          RadialAxis(
            minimum: 0,
            interval: 1,
            maximum: 10,
            centerX: 0.6,
            centerY: 0.6,
            showLabels: false,
            showTicks: true,
            showAxisLine: true,
            showLastLabel: false,
            ticksPosition: ElementsPosition.outside,
            offsetUnit: GaugeSizeUnit.factor,
            minorTicksPerInterval: 0,
            startAngle: _lowToHighValueTween.evaluate(linearAnimation),
            endAngle: _lowToHighValueTween.evaluate(linearAnimation) + 359.9,
            radiusFactor: 0.35,
            majorTickStyle: MajorTickStyle(
              length: 0.2,
              thickness: 8,
              color: const Color(0xFF69e7f0),
              lengthUnit: GaugeSizeUnit.factor,
            ),
            axisLineStyle: AxisLineStyle(
              thickness: 0.3,
              color: const Color(0xFF69e7f0),
              thicknessUnit: GaugeSizeUnit.factor,
            ),
          ),
        ]));
  }

  Widget getSegmentedProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            height: 150,
            width: 150,
            child: SfRadialGauge(axes: <RadialAxis>[
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
                startAngle: _lowToHighValueTween.evaluate(linearAnimation),
                endAngle: _lowToHighValueTween.evaluate(linearAnimation) + 180,
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
            ])),
        Container(
          height: 150,
          width: 150,
          child: SfRadialGauge(axes: <RadialAxis>[
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
                  value: _lowToHighValueTween.evaluate(linearAnimation),
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
          ]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    linearAnimationController.dispose();
    easeAnimationController.dispose();
    controller.dispose();
    super.dispose();
  }
}
