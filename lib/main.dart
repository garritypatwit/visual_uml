import 'package:flutter/material.dart';
import 'package:visual_uml/controller.dart';
import 'package:visual_uml/view.dart';


void main() {
  runApp(VisualUML());
}

class VisualUML extends StatelessWidget {
  VisualUML({super.key});

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
  final DiagramController controller = DiagramController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Visual UML'),
      ),
      body: DiagramView(controller: controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {controller.addLifeline("title");},
        child: const Icon(Icons.add),
      ),
    );
  }
}
