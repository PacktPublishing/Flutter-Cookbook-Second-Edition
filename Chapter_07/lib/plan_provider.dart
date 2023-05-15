import 'package:flutter/material.dart';
import 'controllers/plan_controller.dart';

class PlanProvider extends InheritedWidget {

  final controller = PlanController();

  PlanProvider({super.key, required super.child});

  static PlanController of(BuildContext context) {
    PlanProvider? provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!.controller;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  
}
