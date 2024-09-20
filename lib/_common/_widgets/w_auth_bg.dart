import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../../_services/theme_services/m_theme_model.dart';
import '../constants/app_assets.dart';

class AuthBgWidget extends StatefulWidget {
  final ThemeModel theme;
  const AuthBgWidget({super.key,required this.theme});

  @override
  State<AuthBgWidget> createState() => _AuthBgWidgetState();
}

class _AuthBgWidgetState extends State<AuthBgWidget> with SingleTickerProviderStateMixin{

  ValueNotifier<double> animatedValue = ValueNotifier(0);
  late AnimationController animationController;
  bool xLoading = false;
  // late Stream<AccelerometerEvent> accStream;
  // final _sensitivity = 15;

  @override
  void initState() {
    super.initState();
    initLoad();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> initLoad() async{
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 10000))..repeat();
    animationController.addListener(() {
      animatedValue.value = animationController.value;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox.expand(
        child: Stack(
          children: [
            baseWidget(),
            animatedLogo(),
            glassWidget(),
          ],
        ),
      ),
    );
  }

  Widget baseWidget(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            widget.theme.background1,
            widget.theme.background1,

          ]
        )
      ),
    );
  }

  Widget animatedLogo(){
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Transform.translate(
          offset: Offset(
            - (Get.width * 0.3),
              (Get.height * 0.6)
          ),
          child: ValueListenableBuilder(
            valueListenable: animatedValue,
            builder: (context, aV, child) {
              return Transform.rotate(
                angle: (360*aV) * (pi/180),
                alignment: Alignment.center,
                origin: const Offset(0.5, 0.5),
                child: Image.asset(
                  AppAssets.logoIcon,
                  width: Get.width*(120/100),
                  height: Get.width*(120/100),
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget glassWidget(){
    return GlassContainer(
      height: double.infinity,
      width: double.infinity,
      opacity: 0.1,
      blur: 20,
      color: widget.theme.background1.withOpacity(0.85),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          widget.theme.background1,
          widget.theme.background1.withOpacity(0.9),
        ],
      ),
      border: Border.all(color: Colors.transparent),
      shadowStrength: 50,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(0),
      shadowColor: Colors.black.withOpacity(0.24),
    );
  }



}
