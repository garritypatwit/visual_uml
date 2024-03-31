import 'model.dart';

class DiagramController {
  Diagram diagram = Diagram();

  void addLifeline(String title) {
    diagram.lifelines.add(Lifeline(title: title));
  }

  void insertLifeline(int index, String title) {
    diagram.lifelines.insert(index, Lifeline(title: title));
  }

  void removeLifeline(int index) {
    diagram.lifelines.removeAt(index);
  }

  int lifelineCount() {
    return diagram.lifelines.length;
  }

  Lifeline getLifeline(int index) {
    return diagram.lifelines[index];
  }

  void addConnection(int srcIndex, int destIndex) {
    diagram.connections.add(Connection(src: diagram.lifelines[srcIndex], dest: diagram.lifelines[destIndex]));
  }

  void insertConnection(int index, int srcIndex, int destIndex) {
    diagram.connections.insert(index, Connection(src: diagram.lifelines[srcIndex], dest: diagram.lifelines[destIndex]));
  }

  void removeConnection(int index) {
    diagram.connections.removeAt(index);
  }

  int connectionCount() {
    return diagram.connections.length;
  }

  Connection getConnection(int index) {
    return diagram.connections[index];
  }
}
