import 'package:flutter/material.dart'; 

class ResultScreen extends StatefulWidget {
  final String result; 
  const ResultScreen(this.result, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: const Text('Result'), 
      ), 
      body: Padding( 
        padding: const EdgeInsets.all(24), 
        child: SelectableText(widget.result, 
          showCursor: true, 
          cursorColor: Theme.of(context).colorScheme.secondary, 
          cursorWidth: 5, 
          scrollPhysics: const ClampingScrollPhysics(), 
          onTap: (){}, 
        )), 
    ); 

  }
}