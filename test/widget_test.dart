import 'package:flutter_test/flutter_test.dart';
import 'package:visual_uml/controller.dart';

void main() {
  test('Test lifeline reorder', () {
    DiagramController controller = DiagramController();
    controller.addLifeline('Alice');
    controller.addLifeline('Bob');
    controller.reorderLifelines(0, 2);
    expect(controller.getLifeline(1).toMap()['title'], 'Alice');
  });
}
