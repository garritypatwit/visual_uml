import 'dart:io';
import 'model.dart' as model;  

            // Diagram length
void export(model.Diagram diagram) {
  File file = File("p.puml");
  file.writeAsStringSync('@startuml\n');

  //write participants names
  for (var lifeline in diagram.lifelines) {
    file.writeAsStringSync('participant ${lifeline.title}\n', mode: FileMode.append);
  }
  file.writeAsStringSync('\n', mode: FileMode.append);  

// for diagram length/how many connections
  for (var connection in diagram.connections) {

    // lifeline source
    String name = connection.src.title; 

    // lifeline destination
    String connectionOutName = connection.dest.title; 

    // connection message
    String connectionMessage = connection.title; 

    // arrow style
    String arrowStyle = '->'; 

    // write lifeline source name | 'Alice', arrow style and lifeline dest name | ' -> Bob'
    try {
      file.writeAsStringSync('$name $arrowStyle $connectionOutName', mode: FileMode.append);
      // tests to see if theres a name for the connection text and writes | ': Authentication Request'
      try {
        file.writeAsStringSync(': $connectionMessage\n', mode: FileMode.append);
      } catch (e) {
        continue;
      }

    } catch (e) {
      continue;
    }
  }

  // writes enduml
  file.writeAsStringSync('@enduml\n', mode: FileMode.append);
}
