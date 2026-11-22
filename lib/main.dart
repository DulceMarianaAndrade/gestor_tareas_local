import 'package:flutter/material.dart';

import 'data/app_database.dart';
import 'screens/tareas_page.dart';

void main() {
  runApp(const GestorTareasApp());
}

/// Punto de entrada. Abre la base de datos una vez y la cierra al salir.
class GestorTareasApp extends StatefulWidget {
  const GestorTareasApp({super.key, this.database});

  /// Solo para pruebas: permite inyectar una base en memoria.
  final AppDatabase? database;

  @override
  State<GestorTareasApp> createState() => _GestorTareasAppState();
}

class _GestorTareasAppState extends State<GestorTareasApp> {
  late final AppDatabase _db = widget.database ?? AppDatabase();

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de tareas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: TareasPage(database: _db),
    );
  }
}