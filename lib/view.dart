import 'package:flutter/material.dart';
import 'package:widget_arrows/widget_arrows.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';
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
  final LinkedScrollControllerGroup _controllers = LinkedScrollControllerGroup();

  @override
  Widget build(BuildContext context) {
    return ArrowContainer(
      child: ReorderableListView.builder(
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
                  child: Column(
                    children: [
                      LifelineEditView(
                        lifelineController: LifelineController(lifeline: lifeline),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ListenableBuilder(
                            listenable: widget.controller,
                            builder: (BuildContext context, Widget? child) {
                              return ConnectionView(
                                controller: widget.controller,
                                lifelineIndex: index,
                                scrollController: _controllers.addAndGet()
                              );
                            }
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}

class ConnectionView extends StatefulWidget {
  const ConnectionView({
    super.key,
    required this.controller,
    required this.lifelineIndex,
    required this.scrollController
  });

  final DiagramController controller;
  final int lifelineIndex;
  final ScrollController scrollController;

  @override
  State<ConnectionView> createState() => _ConnectionViewState();
}

class _ConnectionViewState extends State<ConnectionView> {
  @override
  Widget build(BuildContext context) {
    int lifelineHash = widget.controller.getLifeline(widget.lifelineIndex).hashCode;
    return Scrollbar(
      key: ValueKey<String>('S${widget.scrollController.hashCode}'),
      controller: widget.scrollController,
      child: ListView.builder(
        key: ValueKey<String>('L${widget.scrollController.hashCode}'),
        controller: widget.scrollController,
        itemCount: widget.controller.connectionCount() + 1,
        itemBuilder: (BuildContext context, int index) {
          List<Widget> result = [
            SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: DragTarget<int>(
                  builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return Draggable<int>(
                      data: widget.lifelineIndex,
                      axis: Axis.horizontal,
                      feedback: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(size: 15,Icons.add),
                      ),
                      childWhenDragging: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(size: 15,Icons.add),
                      ),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Icon(size: 15,Icons.add),
                      ),
                    );
                  },
                  onWillAcceptWithDetails: (DragTargetDetails<int> details) {
                    return widget.lifelineIndex != details.data;
                  },
                  onAcceptWithDetails: (DragTargetDetails<int> details) {
                    setState(() {
                      widget.controller.insertConnection(index, details.data, widget.lifelineIndex);
                    });
                  }, 
                ),
              ),
            ),
          ];

          if (index < widget.controller.connectionCount()) {
            var connection = widget.controller.getConnection(index).toMap();
            if (lifelineHash == connection['srcHash'] || lifelineHash == connection['destHash']) {
              result.add(
                ArrowElement(
                  id: '$lifelineHash$index',
                  targetId: lifelineHash == connection['srcHash'] ? '${connection['destHash']}$index' : null,
                  sourceAnchor: Alignment.center,
                  targetAnchor: Alignment.center,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            else {
              result.add(
                const SizedBox(
                  width: 40,
                  height: 40,
                ),
              );
            }
          }

          return Column(
            children: result,
          );
        },
      ),
    );
  }
}

class LifelineEditView extends StatefulWidget {
  const LifelineEditView ({
    super.key,
    this.child,
    required this.lifelineController,
  });

  final Widget? child;
  final LifelineController lifelineController;

  @override
  State<LifelineEditView> createState() => _LifelineEditViewState();
}

class _LifelineEditViewState extends State<LifelineEditView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryTap: () async {
        await showDialog<void>(
          context: context,
          builder: (context) {
            var nameController = TextEditingController();
            var formKey = GlobalKey<FormState>();
            return AlertDialog(
              scrollable: true,
              title: Text(widget.lifelineController.getTitle()),
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
                            return 'Enter new name';
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
                        widget.lifelineController.renameLifeline(name);
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
      child: SizedBox(
        height: 60,
        child: Card(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(child: Text(widget.lifelineController.getTitle())),
          )
        ),
      ),
    );
  }
}
