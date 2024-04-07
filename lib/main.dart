import 'package:flutter/material.dart';
import 'package:visual_uml/controller.dart';
import 'package:visual_uml/view.dart';


void main() {
  runApp(const VisualUML());
}

class VisualUML extends StatelessWidget {
  const VisualUML({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual UML',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  
  final DiagramController controller = DiagramController();

  @override
  Widget build(BuildContext context) {
    return MainView();
  }
}
