import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/validacion_titulo.dart';

void main() {
  group('validarTitulo', () {
    test('rechaza título vacío, nulo o solo espacios', () {
      expect(validarTitulo(''), isNotNull);
      expect(validarTitulo('   '), isNotNull);
      expect(validarTitulo(null), isNotNull);
    });

    test('rechaza títulos de más de 100 caracteres', () {
      expect(validarTitulo('a' * 101), isNotNull);
    });

    test('acepta un título normal y uno de exactamente 100 caracteres', () {
      expect(validarTitulo('Comprar leche'), isNull);
      expect(validarTitulo('a' * 100), isNull);
    });
  });
}