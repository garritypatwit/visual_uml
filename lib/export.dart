import 'dart:io';

class Connection {
  String name = '';
  String connectionOutName = '';
  String connectionOutText = '';
  String connectionInText = '';
  String arrowStyle = '';
}

void export(List<Connection> connections){
  File file = File("p.puml");
  file.writeAsStringSync('@startuml\n');



  for (var i= 0; i < connections.length; i++) {
    file.writeAsStringSync(connections[i].name);
    file.writeAsStringSync(' ${connections[i].arrowStyle} ${connections[i].connectionOutName}');
    try {
      file.writeAsStringSync(': ${connections[i].connectionOutText}\n');
    } catch(e) {
      continue;
    }
    try {
      file.writeAsStringSync(connections[i].name);
      file.writeAsStringSync(' ${connections[i].arrowStyle} ${connections[i].connectionOutName}');
    } catch(e) {
      continue;
    }
    try {
      file.writeAsStringSync(': ${connections[i].connectionOutText}\n');
    } catch(e) {
      continue;
    }
  }
  file.writeAsStringSync('@enduml\n');
}