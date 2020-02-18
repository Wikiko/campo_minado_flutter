import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/campo.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  @override
  _CampoMinadoAppState createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool _venceu;
  Tabuleiro _tabuleiro;

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      var qtdeColunas = 15;
      var tamanhoCampo = largura / qtdeColunas;
      var qtdeLinhas = (altura / tamanhoCampo).floor();
      _tabuleiro =
          Tabuleiro(linhas: qtdeLinhas, colunas: qtdeColunas, qtdeBombas: 50);
    }
    return _tabuleiro;
  }

  _reinciar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      try {
        campo.abrir();
        if (_tabuleiro.resolvido) {
          _venceu = true;
        }
      } on ExplosaoException {
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo campo) {
    if (_venceu != null) {
      return;
    }
    setState(() {
      campo.alternarMarcacao();
      if (_tabuleiro.resolvido) {
        _venceu = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reinciar,
        ),
        body: Container(
            color: Colors.grey,
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return TabuleiroWidget(
                  tabuleiro: _getTabuleiro(
                      constraints.maxWidth, constraints.maxHeight),
                  onAbrir: _abrir,
                  onAlternarMarcacao: _alternarMarcacao,
                );
              },
            )),
      ),
    );
  }
}
