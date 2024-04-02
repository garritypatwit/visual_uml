import 'dart:io';
import 'model.dart' as model;  

            // Diagram length
void export(model.Diagram diagram) {
  File file = File("p.puml");
  file.writeAsStringSync('@startuml\n');

  //write participants names
  for (var lifeline in diagram.lifelines) {
    file.writeAsStringSync('participant ${lifeline.title}\n');
  }
  file.writeAsStringSync('\n');  

// for diagram length/how many connections
  for (var i = 0; i < diagram.connections.length; i++) {

    // lifeline source
    String name = diagram.connections[i].src.title; 

    // lifeline destination
    String connectionOutName = diagram.connections[i].dest.title; 

    // connection text to destination
    String connectionOutText = diagram.connections[i].title; 

    //connection text to source
    String connectionInText = '';  

    // arrow style
    String arrowStyle = ''; 

    // write lifeline source name | 'Alice', arrow style and lifeline dest name | ' -> Bob'
    try {
      file.writeAsStringSync('$name $arrowStyle $connectionOutName');
      // tests to see if theres a name for the connection text and writes | ': Authentication Request'
      try {
        file.writeAsStringSync(': $connectionOutText\n');
      } catch (e) {
        continue;
      }

      //tests (writes lifeline dest name | 'Bob') and (write arrow style and lifeline source | ' <-- Alice')
      try {
        file.writeAsStringSync('$connectionOutName $arrowStyle $name');
        // tests to write connection text and write | ': Authentication Response'
        try {
          file.writeAsStringSync(': $connectionOutText\n');  
        } catch (e) {
          continue;
        }
      } catch (e) {
        continue;
      }
    } catch (e) {
      continue;
    }
  }

  // writes enduml
  file.writeAsStringSync('@enduml\n');
}
