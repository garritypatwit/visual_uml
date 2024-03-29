import 'package:flutter/material.dart';
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
    return Container();
  }
}