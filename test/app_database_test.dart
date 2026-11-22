import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('crear y consultar una tarea', () async {
    final id = await db.crearTarea('Estudiar Drift');
    final tareas = await db.observarTareas().first;

    expect(tareas, hasLength(1));
    expect(tareas.first.id, id);
    expect(tareas.first.titulo, 'Estudiar Drift');
    expect(tareas.first.completada, isFalse);
  });

  test('actualizar título y cambiar estado', () async {
    final id = await db.crearTarea('Original');

    await db.actualizarTitulo(id, 'Modificado');
    await db.cambiarEstado(id, true);

    final tarea = (await db.observarTareas().first).single;
    expect(tarea.titulo, 'Modificado');
    expect(tarea.completada, isTrue);
  });

  test('eliminar borra solo la tarea indicada', () async {
    final id1 = await db.crearTarea('Una');
    await db.crearTarea('Otra');

    final borradas = await db.eliminarTarea(id1);
    final tareas = await db.observarTareas().first;

    expect(borradas, 1);
    expect(tareas.map((t) => t.titulo), ['Otra']);
  });
}