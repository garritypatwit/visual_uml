import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const VisualUML());
}

class BackendBloc extends Cubit<String> {
  BackendBloc() : super('');

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/data'));
    if (response.statusCode == 200) {
      emit(response.body);
    } else {
      emit('Failed to fetch data');
    }
  }
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
      home: const MyHomePage(title: 'Visual UML'),
    );
  }
}

class Component extends StatelessWidget {
  const Component({super.key});

  @override
  Widget build(BuildContext context) {
    return const Draggable(
      data: "test",
      feedback: SizedBox(height: 100, width: 100, child: DecoratedBox(decoration: BoxDecoration(color: Colors.purple) , child: Center(child: Text('test')))),
      child: SizedBox(height: 100, child: DecoratedBox(decoration: BoxDecoration(color: Colors.purple) , child: Center(child: Text('test')))),
    );
  }
}

class Sequence extends StatelessWidget {
  const Sequence({super.key, required this.parent});

  final Diagram parent;

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable(
      feedback: const SizedBox(
        width: 90,
        height: 90,
        child: DecoratedBox(decoration: BoxDecoration(color: Colors.green)),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            color: Colors.blueGrey.shade400,
          ),
          DragTarget <Widget>(
            builder: (
              BuildContext context,
              List<dynamic> accepted,
              List<dynamic> rejected,
            ) {
              return Container(
                width: 20,
                color: Colors.blueGrey,
              );
            },
            onAcceptWithDetails: (details) {
              
            },
          ),
        ],
      ),
    );
  }
} 

class Diagram extends StatefulWidget {
  const Diagram({super.key});

  @override
  State<Diagram> createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {
  final List<Widget> a = [];
  final ScrollController _controller = ScrollController();


  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Scrollbar(
          thumbVisibility: true,
          controller: _controller,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return a[index%2];
            },
          ),
        );
      },
      onAcceptWithDetails: (details) {
        setState(() {
          print(details);
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> b = [Component()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: b.length,
              itemBuilder: (context, index) {
                return b[index];
              },
            ),
          ),
          const Expanded(
            flex: 4,
            child: Diagram(),
          ),
        ],
      ),
    );
  }
}

