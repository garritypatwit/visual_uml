class Diagram {
  Diagram({
    List<Lifeline>? lifelines,
    List<Connection>? connections,
  })  : lifelines = lifelines ?? [],
        connections = connections ?? [];

  List<Lifeline> lifelines;
  List<Connection> connections;
}

class Lifeline {
  Lifeline({
    required this.title,
  });

  String title;
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
}
