import 'dart:io';


class Connection {

  // lifeline source
  String name = '';

  // lifeline destination
  String connectionOutName = '';

  // connection text to destination
  String connectionOutText = '';

  //connection text to source
  String connectionInText = '';

  // arrow style
  String arrowStyle = '';
}


            // Diagram length
void export(List<Connection> connections){
  File file = File("p.puml");
  // start uml
  file.writeAsStringSync('@startuml\n');


// for diagram length/how many connections
  for (var i= 0; i < connections.length; i++) {

    //write participants names
    /*
    for(var i=0; i < lifeline names; i++) {
      file.writeAsStringSync('participant ${lifeline name[i]}');
    }
    file.writeAsStringSync('\n');
    */

    // write lifeline source name | 'Alice'
    file.writeAsStringSync(connections[i].name);

    // writes arrow style and lifeline dest name | ' -> Bob'
    file.writeAsStringSync(' ${connections[i].arrowStyle} ${connections[i].connectionOutName}');

    // tests to see if theres a name for the connection text and writes | ': Authentication Request'
    try {
      file.writeAsStringSync(': ${connections[i].connectionOutText}\n');
    } catch(e) {
      continue;
    }

    // tests for a lifeline destination and text and writes
    try {
      // writes lifeline dest name | 'Bob'
      file.writeAsStringSync(connections[i].name);
      // write arrow style and lifeline source | ' <-- Alice'
      file.writeAsStringSync(' ${connections[i].arrowStyle} ${connections[i].connectionOutName}');
      
      // tests to write connection text and write | ': Authentication Response'
      try {
        file.writeAsStringSync(': ${connections[i].connectionOutText}\n');
      } catch(e) {
        continue;
      }

    } catch(e) {
      continue;
    }
    // 
  }

  // writes enduml
  file.writeAsStringSync('@enduml\n');
}