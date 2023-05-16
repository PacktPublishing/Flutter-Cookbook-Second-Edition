import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int index;
  const DetailScreen(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text('Detail Screen'),
  ),
  body: Column(children: [
      Expanded(
    flex: 1,
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Hero(
        tag: 'cup$index',
        child: const Icon(Icons.free_breakfast, size: 96,),
     ),
    ),
  ),
  const Spacer(
    flex: 3,
  )

  ]));

  }
}