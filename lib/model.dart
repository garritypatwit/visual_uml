import 'package:flutter/services.dart';

class Diagram {
  Diagram({
     List<Lifeline>? lifelines ,
     List<Connection>? connections,
  }) : lifelines = lifelines ?? [],
       connections =  connections ?? [];

  List<Lifeline> lifelines;
  List<Connection> connections;

  void addLifeline(String title, int index) {
    lifelines.insert(index, Lifeline(title: title, index: index));
    return;
  }

  void removeLifeline(int index) {
    lifelines.removeAt(index); 
    return;
  }

  Lifeline getLifeline(index) {
    return lifelines.elementAt(index);
  }

  void addConnection(int index, Lifeline src, Lifeline dest){
    connections.insert(index, Connection(src: src, dest: dest));
    return;
  }

  void removeConnection(int index) {
    connections.removeAt(index); 
    return;
  }


}

class Lifeline {
  Lifeline({
    required this.title,
    required this.index,
  });
  String title;
  int index;

  String getTitle(){
    return title;
  }

  int getIndex(){
    return index;
  }
}

class Connection { 
  Connection({
    required this.src,
    required this.dest,
    this.title = '',

  });
  String title;
  Lifeline src;
  Lifeline dest;

   String getTitle(){
    return title;
  }

  int getSrcIndex(){
    return src.getIndex();
  }

  int getDestIndex(){
    return dest.getIndex();
  }

}