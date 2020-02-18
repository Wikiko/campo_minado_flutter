import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir Campo COM Explosão', () {
      var c = Campo(linha: 0, coluna: 0);
      c.minar();

      expect(c.abrir, throwsException);
    });

    test('Abrir Campo SEM Explosão', () {
      var c = Campo(linha: 0, coluna: 0);
      c.abrir();
      expect(c.aberto, isTrue);
    });

    test('Adicionar NÃO Vizinho', () {
      var c1 = Campo(linha: 0, coluna: 0);
      var c2 = Campo(linha: 1, coluna: 3);

      c1.adicionarVizinho(c2);
      expect(c1.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar Vizinho', () {
      var c1 = Campo(linha: 3, coluna: 3);
      var c2 = Campo(linha: 3, coluna: 4);
      var c3 = Campo(linha: 2, coluna: 2);
      var c4 = Campo(linha: 4, coluna: 4);

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);
      
      expect(c1.vizinhos.length, 3);
    });

    test('Minas na Vizinhança', () {
      var c1 = Campo(linha: 3, coluna: 3);

      var c2 = Campo(linha: 3, coluna: 4);
      c2.minar();

      var c3 = Campo(linha: 2, coluna: 2);

      var c4 = Campo(linha: 4, coluna: 4);
      c4.minar();

      c1.adicionarVizinho(c2);
      c1.adicionarVizinho(c3);
      c1.adicionarVizinho(c4);

      expect(c1.qtdeMinasNaVizinhanca, 2);
    });
  });
}
