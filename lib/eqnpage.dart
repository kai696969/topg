import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

void main() {
  runApp(eqnpage());
}

const equations =
[
  [
    'Fresnels Equation ', r'V(z)=V_o^+e^-j\beta z -  V_o^- e^+j\beta z '
  ],

  [
    'Fresnels Equation ', r'I(z)=\frac{V_o^+e^-j\beta z -  V_o^- e^+j\beta z}{Z_o} '
  ],

  [
    r'Fresnels Equation', r'\beta=\frac{2\pi}{\lambda} '
  ],

  [
    'Fresnels Equation ', r'\Gamma_L= \frac{Z_L-Z_o}{Z_L+Z_o}= \frac{V_o^+}{V_o^-}'
  ],

  [
    'Fresnels Equation ', r'\Gamma(z)=\Gamma_L e^+2j\beta z '
  ],

  [
    'Fresnels Equation ', r' Z_in (-l) =\frac{Z_L+ jZ_otan(\beta l)}{Z_o- jZ_Ltan(\beta l)} Z_o '
  ],

];

class eqnpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
          appBar: AppBar(
            title:  Text("Formulas"),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 1, 1),
            child:
            Container(
              color: Colors.white,
              constraints: BoxConstraints(maxWidth: 1000),
              child: ListView(
                children: equations
                    .map((entry) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(5, 1, 1, 1),
                          child: SelectableMath.tex(
                            entry[0],
                            textStyle: TextStyle(fontSize: 25 ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
                    .toList(),
              ),
            ),
          )
      );
}
