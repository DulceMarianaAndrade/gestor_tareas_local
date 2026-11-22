import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';
import 'package:gestor_tareas_local/main.dart';

void main() {
  setUp(() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  });

  testWidgets('La app abre la pantalla de tareas', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(GestorTareasApp(database: db));
    await tester.pump();
    expect(find.text('Gestor de tareas'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(Duration.zero);
    await db.close();
  });
}