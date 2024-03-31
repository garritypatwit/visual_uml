import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';
import 'controller.dart';

class DiagramView extends StatefulWidget {
  final DiagramController controller;

  const DiagramView({
    super.key,
    required this.controller,
  });

  @override
  State<DiagramView> createState() => _DiagramViewState();
}

class _DiagramViewState extends State<DiagramView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ReorderableListView.builder(
          itemCount: widget.controller.lifelineCount(),
          itemBuilder: (BuildContext context, int index) {
            final lifeline = widget.controller.getLifeline(index);
            return Container();
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              
            });
          }
        ),
      ]
    );
  }
}