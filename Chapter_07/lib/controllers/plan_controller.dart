import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../plan_provider.dart';
import '../services/plan_services.dart';

class PlanController {
  final services = PlanServices();

  static PlanController of(BuildContext context) {
    PlanProvider? provider =
        context.dependOnInheritedWidgetOfExactType<PlanProvider>();
    return provider!.controller;
  }

  // This public getter cannot be modified by any other object
  List<Plan> get plans => List.unmodifiable(services.getAllPlans());

  void addNewPlan(String name) {
    if (name.isEmpty) {
      return;
    }
    name = _checkForDuplicates(plans.map((plan) => plan.name), name);
    services.createPlan(name);
  }

  void savePlan(Plan plan) {
    services.savePlan(plan);
  }

  void deletePlan(Plan plan) {
    services.delete(plan);
  }

  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount = items.where((item) => item.contains(text)).length;
    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }
    return text;
  }

  void createNewTask(Plan plan, [String description = '']) {
    if (description.isEmpty) {
      description = 'New Task';
    }

    description = _checkForDuplicates(
        plan.tasks.map((task) => task.description), description);

    services.addTask(plan, description);
  }

  void deleteTask(Plan plan, Task task) {
    services.deleteTask(plan, task);
  }
}
