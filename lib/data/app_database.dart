import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../models/tarea.dart';

part 'app_database.g.dart';

//Tabla tareas usa la clase Tarea del modelo como fila.
@UseRowClass(Tarea)
class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text().withLength(min: 1, max: 100)();
  BoolColumn get completada => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tareas])
class AppDatabase extends _$AppDatabase {
  //En pruebas se pasa una base en memoria
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _abrirConexion());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _abrirConexion() {
    return driftDatabase(
      name: 'gestor_tareas',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  // una lista nueva cada vez que cambia la tabla.
  Stream<List<Tarea>> observarTareas() {
    return (select(tareas)
          ..orderBy([(t) => OrderingTerm.desc(t.id)]))
        .watch();
  }

  /// INSERT devuelve el id generado
  Future<int> crearTarea(String titulo) {
    return into(tareas).insert(TareasCompanion.insert(titulo: titulo));
  }

  // UPDATE devuelve cuántas filas cambiaron y cero si el id no existe
  Future<int> actualizarTitulo(int id, String titulo) {
    return (update(tareas)..where((t) => t.id.equals(id)))
        .write(TareasCompanion(titulo: Value(titulo)));
  }

  // UPDATE estado
  Future<int> cambiarEstado(int id, bool completada) {
    return (update(tareas)..where((t) => t.id.equals(id)))
        .write(TareasCompanion(completada: Value(completada)));
  }

  // DELETE regresa cuantas filas se borraron
  Future<int> eliminarTarea(int id) {
    return (delete(tareas)..where((t) => t.id.equals(id))).go();
  }
}