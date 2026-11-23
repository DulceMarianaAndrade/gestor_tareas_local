# Gestor de tareas con SQLite

**Práctica:** Gestor de tareas con SQLite 
**Materia:** Programación de Dispositivos Móviles, 7.º semestre, Universidad Autónoma de Aguascalientes  
**Alumna:** Dulce Mariana Andrade Olvera  
**Grupo:** 7-C  
**ID:** 376905

## Descripción del proyecto
Realicé una aplicación en Flutter para administrar tareas. Permite agregar tareas, verlas, editar su título, marcarlas como completadas o pendientes y eliminarlas.
Para guardar la información utilicé SQLite, por lo que los datos se almacenan directamente en el dispositivo. No se necesita un servidor, MySQL ni conexión a internet. Cada instalación guarda sus propias tareas, por lo que no se comparten entre dispositivos.

## Entornos en los que funciona
| Entorno | Plataforma | Estado |
|---|---|---|
| Web | Chrome | Probada |
| Escritorio | Windows | Probada |
| Móvil | Android (Samsung Galaxy A13) | Probada |
También está preparado para funcionar en iOS, Linux y macOS, aunque estas plataformas no las probé.

## Tecnologías utilizadas
Para trabajar con SQLite utilicé **Drift y drift_flutter**, que permiten manejar la base de datos desde Flutter.
Elegí estas herramientas porque:
- Permiten utilizar el mismo código en web, escritorio y dispositivos móviles.
- Generan el código necesario para trabajar con las tablas de la base de datos.
- Permiten que la lista de tareas se actualice automáticamente cuando se agrega, modifica o elimina algún registro.
- A diferencia de otras opciones como sqflite, Drift también permite trabajar en web y escritorio.

### ¿Por qué utilicé Stream y no Future?
Utilicé Stream porque quería que las tareas se actualizaran automáticamente cada vez que realizara algún cambio.
Por ejemplo, cuando agrego una tarea, no necesito volver a cargar manualmente toda la lista, ya que Stream detecta los cambios y muestra la información actualizada.
Con Future tendría que volver a consultar la información después de cada operación, mientras que con Stream esto se hace automáticamente.

## Base de datos
La aplicación utiliza una tabla llamada `tareas`, que contiene los siguientes campos y cada campo tiene una función:
- **id:** identifica cada tarea y se genera automáticamente.
- **titulo:** guarda el nombre o descripción de la tarea. No puede estar vacío y permite máximo 100 caracteres.
- **completada:** indica si la tarea ya se realizó o sigue pendiente. Se guarda como 0 cuando está pendiente y 1 cuando está completada.
También agregué validaciones para evitar que se registren tareas sin título o que superen los 100 caracteres.

### Operaciones que se pueden realizar
| Operación | Función |
|---|---|
| INSERT | Agregar una nueva tarea. |
| SELECT | Consultar las tareas guardadas. |
| UPDATE | Modificar el título de una tarea. |
| UPDATE | Cambiar una tarea de pendiente a completada o viceversa. |
| DELETE | Eliminar una tarea. |
Cada operación trabaja con el identificador de la tarea para modificar únicamente el registro correspondiente.

## Estructura del proyecto
Los archivos principales tienen las siguientes funciones:
- **main.dart:** inicia la aplicación y abre la base de datos.
- **tarea.dart:** contiene el modelo de las tareas.
- **app_database.dart:** contiene la tabla y las operaciones para agregar, consultar, modificar y eliminar tareas.
- **app_database.g.dart:** es el archivo que se genera automáticamente con Drift.
- **validacion_titulo.dart:** contiene las validaciones para los títulos.
- **tareas_page.dart:** contiene la pantalla donde se muestran y administran las tareas.
- **web:** contiene los archivos necesarios para que SQLite funcione en el navegador.
- **test:** contiene las pruebas automatizadas.

## Cómo ejecutar el proyecto
Primero se descargar el repositorio y se entra a la carpeta:
git clone https://github.com/DulceMarianaAndrade/gestor_tareas_local.git
cd gestor_tareas_local
Después se instalan las dependencias:
flutter pub get
Para ejecutar las pruebas automatizadas:
flutter test

### Ejecutar en cada plataforma
Web (Chrome):
flutter run -d chrome --web-port=8081
El puerto 8081 para cuando volviera cargar se guardaran los datos y en otro puerto no cambiaran el 8080 lo tenía ocupado.

Escritorio (Windows):
flutter run -d windows

Móvil (Android):
Primero se conecta el teléfono mediante USB y se revisan los dispositivos disponibles:
flutter devices
Después se utiliza el identificador del teléfono:
flutter run -d ID_DEL_TELEFONO

- El archivo `app_database.g.dart` ya está incluido en el repositorio. Si se modifica la tabla, se puede volver a generar con `dart run build_runner build`.
- En Windows es recomendable guardar el proyecto en una ruta sin espacios, por ejemplo `C:\proyectos` ya que mi ruta era Dulce Mariana y fallo la primera vez.
- También es necesario activar el Modo desarrollador de Windows para permitir la compilación de algunos complementos.
- En Android se debe activar la Depuración USB y aceptar el permiso cuando se conecte el teléfono.

## Archivos necesarios para SQLite en web
Para que SQLite funcione en el navegador tuve que agregar dos archivos dentro de la carpeta `web`:
- sqlite3.wasm
- drift_worker.js
Los descargué desde los releases de Drift, específicamente de la versión 2.35.4.
Estos archivos son necesarios porque el navegador utiliza WebAssembly para trabajar con SQLite. 

## Pruebas automatizadas
También agregué pruebas automatizadas para comprobar que las funciones principales trabajaran correctamente.
Para ejecutarlas se utiliza:
flutter test

Realicé 7 pruebas en total:

| Archivo | Qué comprueba |
|---|---|
| validacion_titulo_test.dart | Comprueba que no se acepten títulos vacíos, nulos, con espacios o de más de 100 caracteres. |
| app_database_test.dart | Comprueba que se puedan crear, consultar, modificar y eliminar tareas. |
| widget_test.dart | Comprueba que la aplicación abra correctamente la pantalla de tareas. |

## Plataformas probadas
| Entorno | Plataforma | Estado | Detalle |
|---|---|---|---|
| Web | Chrome | Probada | Las pruebas P1 a P6 funcionaron correctamente. |
| Escritorio | Windows | Probada | Windows 11 25H2, Flutter 3.50.1. Las pruebas P1 a P5 funcionaron correctamente. |
| Móvil | Android | Probada | Samsung Galaxy A13 conectado por USB. Las pruebas P1 a P5 funcionaron correctamente. |

## Resultados de las pruebas de la práctica
| ID | Prueba | Chrome | Windows | Android |
|---|---|---|---|---|
| P1 | Agregar 3 tareas, cerrar la aplicación y volver a abrirla. | Correcta | Correcta | Correcta |
| P2 | Marcar una tarea como completada y reiniciar. | Correcta | Correcta | Correcta |
| P3 | Cambiar el título de una tarea y reiniciar. | Correcta | Correcta | Correcta |
| P4 | Eliminar una tarea y reiniciar. | Correcta | Correcta | Correcta |
| P5 | Intentar agregar un título vacío. | Correcta | Correcta | Correcta |
| P6 | Recargar y cerrar o abrir la pestaña utilizando el mismo origen y perfil. | Correcta | No aplica | No aplica |

## Problemas que encontré durante el desarrollo
Durante la realización de la práctica me encontré con algunos problemas que tuve que resolver para poder ejecutar correctamente el proyecto.
- **Falta de espacio en el disco:** algunos comandos como `flutter pub get`, `build_runner` y `flutter test` fallaban porque tenía poco espacio disponible. Liberé espacio, eliminé la carpeta `.dart_tool` y volví a generar los archivos necesarios.
- **Problemas con las rutas:** al ejecutar el proyecto en Windows tuve errores porque la ruta donde estaba guardado contenía espacios. Para solucionarlo moví el proyecto a una carpeta con una ruta más sencilla y sin espacios.
- **Error al ejecutar las pruebas:** apareció un mensaje indicando que todavía había un Timer pendiente después de cerrar la pantalla. Lo solucioné desmontando primero la pantalla y después cerrando la base de datos.
- **Problemas con archivos DLL:** en algunas ocasiones las pruebas no podían eliminar un archivo porque todavía estaba siendo utilizado por procesos de Dart o Flutter. Cerré los procesos que seguían ejecutándose, eliminé la carpeta `build` y volví a ejecutar las pruebas.
- **Modo desarrollador de Windows:** al intentar ejecutar la aplicación en Windows apareció un error relacionado con los enlaces simbólicos. Lo solucioné activando el Modo desarrollador desde la configuración del sistema.
- **Problemas con Visual Studio:** en otra computadora Flutter no reconocía algunos componentes de Visual Studio porque estaba instalada una versión de prueba. Al utilizar una versión estable, los reconoció correctamente.

## Fuentes consultadas
- https://drift.simonbinder.eu/platforms/web/: consulté esta documentación para entender cómo funciona SQLite en el navegador y qué archivos se necesitan para utilizar WebAssembly.
-https://github.com/simolus3/drift/releases: de aquí descargué los archivos `sqlite3.wasm` y `drift_worker.js` correspondientes a la versión 2.35.4.
- Documento de la práctica y repositorio base del profesor: los utilicé para revisar los requisitos y las pruebas que debía realizar la aplicación.

## Uso de IA
Durante el desarrollo utilicé Claude (Anthropic) como apoyo para organizar el proyecto, trabajar con Drift, realizar las pruebas y solucionar algunos errores que fueron apareciendo.
Sin embargo, también comprobé por mi cuenta que la aplicación funcionara correctamente en Chrome, Windows y Android. Ejecuté las pruebas, revisé que los datos permanecieran guardados y probé el proyecto en otra computadora para asegurarme de que se pudiera descargar y ejecutar correctamente.
