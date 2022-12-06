import 'package:flutter/material.dart';
import 'dart:math';
import 'package:extended_math/extended_math.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

void main() {
  runApp(calculation());
}

class calculation extends StatefulWidget {
  const calculation({Key? key}) : super(key: key);

  @override
  State<calculation> createState() => _calculationState();
}
class _calculationState extends State<calculation> {
  double Rzl = 0;                                               //  Real ZL
  double Izl = 0;                                                // Imaginary ZL
  double Rzo = 0;                                            // Real Zo
  double Izo = 0;                                             // Imaginary Zo
  double beta = 0;                                          // beta
  double zpos = 0;                                        // z pos
  TextEditingController controller1 = TextEditingController(text: '');
  TextEditingController controller2 = TextEditingController(text: '');
  TextEditingController controller3 = TextEditingController(text: '');
  TextEditingController controller4 = TextEditingController(text: '');
  TextEditingController controller5 = TextEditingController(text: '');
  TextEditingController controller6 = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding:  const EdgeInsets.only(right: 10.0, top: 30.0),
                        child: TextField(
                          controller: controller1,
                          decoration: InputDecoration(
                              labelText: "Real ZL (ohms)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),

                  Expanded(child:
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding:  const EdgeInsets.only(left: 10.0, top: 30.0),
                      child: TextField(
                        controller: controller2,
                        decoration: InputDecoration(
                            labelText: "Imaginary ZL (johms)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  )

                ],
              ),
//Real and Imaginary ZL
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding:  const EdgeInsets.only(right: 10.0,top: 15),
                        child: TextField(
                          controller: controller3,
                          decoration: InputDecoration(
                              labelText: "Real Zo (ohms)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 10.0,top: 15),
                        child: TextField(
                          controller: controller4,
                          decoration: InputDecoration(
                              labelText: "Imaginary Zo (johms)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
//Real and Imaginary Zo
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding:  const EdgeInsets.only(right: 10.0,top: 1),
                        child: TextField(
                          controller: controller5,
                          decoration: InputDecoration(
                              labelText: "Beta(m)  ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Padding(
                        padding:  const EdgeInsets.only(left: 10.0,top: 1),
                        child: TextField(
                          controller: controller6,
                          decoration: InputDecoration(
                              labelText: "Z position(m)",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
//Beta and Z in meter
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            Rzl = double.parse(controller1.text);
                            Izl = double.parse(controller2.text);
                            Rzo = double.parse(controller3.text);
                            Izo = double.parse(controller4.text);
                            final zlvalue = Complex(re: Rzl, im: Izl);
                            final zovalue = Complex(re: Rzo, im: Izo);
                            final rctop = zlvalue - zovalue;
                            final rcbtm = zlvalue + zovalue;
                            final rcvalue = rctop/rcbtm;
                            final rcvalueMod = rcvalue.module;
                            final rcvalueArg = rcvalue.argument;
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => rcRoute(
                                        zlvalue : zlvalue,
                                        zovalue:zovalue,
                                        rctop: rctop,
                                        rcbtm: rcbtm,
                                        rcvalue:rcvalue,
                                        rcvalueMod :  rcvalueMod,
                                        rcvalueArg : rcvalueArg
                                    )
                                )
                            );
                          },
                          child: Text('Reflection Coefficient ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                      ),
                    ),
                  ),
                ],
              ),
// Reflection Coefficient
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 70,
                        child: Padding(
                          padding:  const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                Rzl = double.parse(controller1.text);
                                Izl = double.parse(controller2.text);
                                Rzo = double.parse(controller3.text);
                                Izo = double.parse(controller4.text);
                                beta = double.parse(controller5.text);
                                zpos = double.parse(controller6.text);
                                final zlvalue = Complex(re: Rzl, im: Izl);
                                final zovalue = Complex(re: Rzo, im: Izo);
                                final zinvaluetop= zlvalue + zovalue*tan(beta*zpos)*Complex(re:0, im:1);
                                final zinbtmvalue= zovalue + zlvalue*tan(beta*zpos)*Complex(re:0, im:1);
                                final zinvalue = (zinvaluetop/zinbtmvalue)*zovalue;

                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => zinRoute(
                                          zlvalue : zlvalue,
                                          zovalue:zovalue,
                                          zinvaluetop : zinvaluetop,
                                          zinbtmvalue: zinbtmvalue,
                                          zinvalue: zinvalue,
                                        )
                                    )
                                );
                              },
                              child: Text('Input Impedance ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                          ),
                        )

                    ),
                  ),
                ],
              ),
// Zin1
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 70,
                        child: Padding(
                          padding:  const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                Rzl = double.parse(controller1.text);
                                Izl = double.parse(controller2.text);
                                Rzo = double.parse(controller3.text);
                                Izo = double.parse(controller4.text);
                                beta = double.parse(controller5.text);
                                zpos = double.parse(controller6.text);
                                final zlvalue = Complex(re: Rzl, im: Izl);
                                final zovalue = Complex(re: Rzo, im: Izo);
                                final rctop = zlvalue - zovalue;
                                final rcbtm = zlvalue + zovalue;
                                final rcvalue = rctop/rcbtm;
                                final rcvalueatz = rcvalue* (pow(e, 2*beta*zpos));
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => rcatzRoute(
                                          zlvalue : zlvalue,
                                          zovalue:zovalue,
                                          rctop:rctop,
                                          rcbtm:rcbtm,
                                          rcvalue:rcvalue,
                                          rcvalueatz:rcvalueatz,
                                        )
                                    )
                                );
                              },
                              child: Text('Reflection Coefficient (Z) ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                          ),
                        )

                    ),
                  ),
                ],
              ),
// Reflection Coefficient at Z
            ],
          ),
        ),
      ),
    );
  }
}

class rcRoute extends StatefulWidget {
  final zlvalue;
  final zovalue;
  final rcvalue;
  final rctop;
  final rcbtm;
  final rcvalueMod;
  final rcvalueArg;

  rcRoute({
    this.zlvalue,
    this.zovalue,
    this.rcvalue,
    this.rctop,
    this.rcbtm,
    this.rcvalueMod,
    this.rcvalueArg,
  });
  @override
  _rcRouteState createState() => _rcRouteState(
    this.zlvalue,
    this.zovalue,
    this.rcvalue,
    this.rctop,
    this.rcbtm,
    this.rcvalueMod,
    this.rcvalueArg,
  );
}
class _rcRouteState extends State<rcRoute> {
  final zlvalue;
  final zovalue;
  final rcvalue;
  final rctop;
  final rcbtm;
  final rcvalueMod;
  final rcvalueArg;

  _rcRouteState(
      this.zlvalue,
      this.zovalue,
      this.rcvalue,
      this.rctop,
      this.rcbtm,
      this.rcvalueMod,
      this.rcvalueArg,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: AlertDialog(
        title: Text("Result: \n \n $rcvalue" ,
            textAlign: TextAlign.center,
            style:TextStyle(color: Colors.black , fontSize: 23)),
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20 ),

        actions: [
          TextButton(onPressed: (){
          },
            child : ExpansionTile(
              title: Text("Step By Step Guide " ,
                style:TextStyle(color: Colors.black , fontSize: 20,),
              ),
              children: [
                ListTile(title: Text("Step 1 : \n \n ($zlvalue) - ($zovalue) ", style:TextStyle(color: Colors.blue , fontSize: 22,))) ,
                ListTile(title: Text("Step 2 : \n \n ($zlvalue) + ($zovalue)", style:TextStyle(color: Colors.blue , fontSize: 22,))),
                ListTile(title: Text("Step 3 : \n \n (($zlvalue) - ($zovalue))/(($zlvalue) + ($zovalue)) " , style:TextStyle(color: Colors.blue , fontSize: 22,))),
              ],
            ),
          ),

          TextButton(onPressed: (){
            Navigator.pop(context);
          },child: Text("Back " ,
            style:TextStyle(color: Colors.black , fontSize: 20,),
          ),
          ),


        ],
      ),
    );
  }
}

class zinRoute extends StatefulWidget {
  final zlvalue;
  final zovalue;
  final zinvaluetop;
  final zinbtmvalue;
  final zinvalue;


  zinRoute({
    this.zlvalue,
    this.zovalue,
    this.zinvaluetop,
    this.zinbtmvalue,
    this.zinvalue,
  });
  @override
  _zinRouteState createState() => _zinRouteState(
    this.zlvalue,
    this.zovalue,
    this.zinvaluetop,
    this.zinbtmvalue,
    this.zinvalue,
  );
}
class _zinRouteState extends State<zinRoute> {
  final zlvalue;
  final zovalue;
  final zinvaluetop;
  final zinbtmvalue;
  final zinvalue;


  _zinRouteState(
      this.zlvalue,
      this.zovalue,
      this.zinvaluetop,
      this.zinbtmvalue,
      this.zinvalue,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Result is \n $zinvalue" , style: TextStyle(fontSize: 15)),
      ],
    );
  }
}

class rcatzRoute extends StatefulWidget {
  final zlvalue;
  final zovalue;
  final rctop;
  final rcbtm;
  final rcvalue;
  final rcvalueatz;

  rcatzRoute({
    this.zlvalue,
    this.zovalue,
    this.rctop,
    this.rcbtm,
    this.rcvalue,
    this.rcvalueatz,
  });
  @override
  _rcatzRouteState createState() => _rcatzRouteState(
    this.zlvalue,
    this.zovalue,
    this. rctop,
    this.rcbtm,
    this.rcvalue,
    this.rcvalueatz,
  );
}
class _rcatzRouteState extends State<rcatzRoute> {
  final zlvalue;
  final zovalue;
  final rctop;
  final rcbtm;
  final rcvalue;
  final rcvalueatz;


  _rcatzRouteState(
      this.zlvalue,
      this.zovalue,
      this. rctop,
      this.rcbtm,
      this.rcvalue,
      this.rcvalueatz,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Result is \n $rcvalueatz" , style: TextStyle(fontSize: 15)),
      ],
    );
  }
}




