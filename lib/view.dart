import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';
import 'controller.dart';

class MainView extends StatefulWidget {
  final DiagramController controller = DiagramController();

  MainView({
    super.key,
  });
  
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Visual UML'),
      ),
      body: DiagramView(controller: widget.controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<void>(
            context: context,
            builder: (context) {
              var nameController = TextEditingController();
              var formKey = GlobalKey<FormState>();
              return AlertDialog(
                scrollable: true,
                title: const Text("New Lifeline"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter a name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Name',
                            icon: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var name = nameController.text;
                        setState(() {
                          widget.controller.addLifeline(name);
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
          scrollDirection: Axis.horizontal,
          itemCount: widget.controller.lifelineCount(),
          itemBuilder: (BuildContext context, int index) {
            final lifeline = widget.controller.getLifeline(index);
            return Card(
              key: ValueKey<int>(lifeline.hashCode),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: SizedBox(
                  width: 80,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 60,
                      child: Card(
                        color: Colors.grey.shade200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Center(child: Text(lifeline.toMap()['title'])),
                        )
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              widget.controller.reorderLifelines(oldIndex, newIndex);
            });
          }
        ),
        Container(
          padding: const EdgeInsets.only(top: 70.0, bottom: 40.0),
          child: ReorderableListView.builder(
            itemCount: widget.controller.connectionCount() + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < widget.controller.connectionCount()) {
                final connection = widget.controller.getConnection(index);
                return Card(
                  key: ValueKey<int>(connection.hashCode),
                  child: Text(connection.toMap()['title']),
                );
              }
              return SizedBox(
                key: const ValueKey<int>(0),
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.controller.lifelineCount(),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 80,
                      child: Card(
                        child: Text('$index'),
                      ),
                    );
                  }
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                widget.controller.reorderConnections(oldIndex, newIndex);
              });
            },
          ),
        ),
      ]
    );
  }
}

class LifelineView extends StatefulWidget {
  const LifelineView({
    super.key,
  });

  @override
  State<LifelineView> createState() => _LifelineViewState();
}

class _LifelineViewState extends State<LifelineView> {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}