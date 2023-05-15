import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;
  const PlanScreen({super.key, required this.plan});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late ScrollController scrollController;
  Plan get plan => widget.plan;

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        final controller = PlanProvider.of(context);
        controller.savePlan(plan);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Master Plan')),
        body: Column(children: [
          Expanded(child: _buildList()),
          SafeArea(child: Text(plan.completenessMessage))
        ]),
        floatingActionButton: _buildAddTaskButton(),
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final controller = PlanProvider.of(context);
        controller.createNewTask(plan);
        setState(() {});
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return Dismissible(
      key: ValueKey(task),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        final controller = PlanProvider.of(context);
        controller.deleteTask(plan, task);
        setState(() {});
      },
      child: ListTile(
          leading: Checkbox(
              value: task.complete,
              onChanged: (selected) {
                setState(() {
                  task.complete = selected ?? false;
                });
              }),
          title: TextFormField(
            initialValue: task.description,
            onFieldSubmitted: (text) {
              setState(() {
                task.description = text;
              });
            },
          )),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
