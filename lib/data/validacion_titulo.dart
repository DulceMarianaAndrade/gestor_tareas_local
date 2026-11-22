//Devuelve mensaje de error si el título no es válido o null si es válido.
String? validarTitulo(String? titulo) {
  final limpio = (titulo ?? '').trim();
  if (limpio.isEmpty) {
    return 'El título no puede estar vacío';
  }
  if (limpio.length > 100) {
    return 'El título no puede pasar de 100 caracteres';
  }
  return null;
}