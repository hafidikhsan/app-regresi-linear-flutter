import 'package:flutter/material.dart';
import 'result_data_screen.dart';
import 'cant_access_screen.dart';

class InputDataScreen extends StatefulWidget {
  const InputDataScreen({Key? key}) : super(key: key);

  @override
  State<InputDataScreen> createState() => _InputDataScreenState();
}

class _InputDataScreenState extends State<InputDataScreen> {
  // Inisialization number of input
  int _jumlah = 3;

  // Variable List to accomodate the input
  List<num> valueOfInput = [];
  List<num> valueOfX = [];
  List<num> valueOfY = [];
  List<num> valueOfX2 = [];
  List<num> valueOfY2 = [];
  List<num> valueOfXY = [];
  List<Map> ValueOfAll = [];

  // Global Key for Form
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  // Widget to generate number of input
  Widget _buildInputGenerate() {
    return SizedBox(
      height: 80,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: 'Jumlah Data',
        ),
        validator: (String? value) {
          if (isNumeric(value!) == false) {
            return 'Masukan angka integer';
          } else {
            return null;
          }
        },
        onSaved: (value) => setState(() {
          _jumlah = int.parse(value!);
          //Clear The Value
          valueOfInput.clear();
          valueOfX.clear();
          valueOfY.clear();
          valueOfX2.clear();
          valueOfY2.clear();
          valueOfXY.clear();
          ValueOfAll.clear();
        }),
      ),
    );
  }

  // Widget for input value of X and Y
  Widget _buildInputXY(String s) {
    return Column(
      children: List<Widget>.generate(_jumlah, (int index) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '$s${index + 1}',
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => setState(() {
                    valueOfInput.add(double.parse(value!));
                  }),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukan angka';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Function for check input must integer
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  // Function to process the input
  void _process() {
    for (var i = 0; i < valueOfX.length; i++) {
      valueOfX2.add(valueOfX[i] * valueOfX[i]);
    }
    for (var i = 0; i < valueOfY.length; i++) {
      valueOfY2.add(valueOfY[i] * valueOfY[i]);
    }
    for (var i = 0; i < valueOfX.length; i++) {
      valueOfXY.add(valueOfX[i] * valueOfY[i]);
    }

    var sumx = valueOfX.reduce((a, b) => a + b);
    var sumy = valueOfY.reduce((a, b) => a + b);
    var sumx2 = valueOfX2.reduce((a, b) => a + b);
    var sumy2 = valueOfY2.reduce((a, b) => a + b);
    var sumxy = valueOfXY.reduce((a, b) => a + b);

    for (var i = 0; i < valueOfX.length; i++) {
      var NamaVariable = new Map();
      NamaVariable['no'] = i + 1;
      NamaVariable['x'] = valueOfX[i];
      NamaVariable['y'] = valueOfY[i];
      NamaVariable['x2'] = valueOfX2[i];
      NamaVariable['y2'] = valueOfY2[i];
      NamaVariable['xy'] = valueOfXY[i];
      ValueOfAll.add(NamaVariable);
    }

    var NamaVariable = new Map();
    NamaVariable['no'] = 'Total';
    NamaVariable['x'] = sumx;
    NamaVariable['y'] = sumy;
    NamaVariable['x2'] = sumx2;
    NamaVariable['y2'] = sumy2;
    NamaVariable['xy'] = sumxy;
    ValueOfAll.add(NamaVariable);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 42, 66, 131),
            Color.fromARGB(255, 30, 47, 92)
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            elevation: 0,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Center(
                  child: Text(
                    'Regresi Linear',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 800 && constraints.maxHeight > 400) {
                  return _buildWideInput(screenSize);
                } else if (constraints.maxWidth <= 800 &&
                    constraints.maxHeight > 400) {
                  return _buildNormalInput(screenSize);
                } else {
                  return CantAccessScreen(
                    mode: true,
                  );
                }
              },
            ),
          )),
    );
  }

  // Mobile User
  Widget _buildNormalInput(Size screenSize) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          color: Colors.white,
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 800),
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    _buildTitle("Masukkan jumlah data"),
                    _buildGenerator(),
                    _buildTitle("Masukkan nilai X dan Y"),
                    _buildXY(),
                    _buildInputValueXY(),
                    _buildButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Web User
  Widget _buildWideInput(Size screenSize) {
    return Container(
        padding: const EdgeInsets.only(top: 30),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.white,
                constraints:
                    const BoxConstraints(maxWidth: 1000, maxHeight: 800),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: screenSize.width * 0.3,
                      constraints:
                          const BoxConstraints(minWidth: 350, maxWidth: 450),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _buildTitle("Masukkan jumlah data"),
                          _buildGenerator(),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width * 0.3,
                      constraints:
                          const BoxConstraints(minWidth: 350, maxWidth: 450),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView(children: <Widget>[
                              _buildTitle("Masukkan nilai X dan Y"),
                              _buildXY(),
                              _buildInputValueXY(),
                            ]),
                          ),
                          _buildButton(),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  // Widget for input button
  Widget _buildGenerator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Form(
        key: _formKey1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 130,
              child: _buildInputGenerate(),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: GestureDetector(
                onTap: () {
                  if (_formKey1.currentState!.validate()) {
                    _formKey1.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Jumlah input berhasil diganti'),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 120,
                  height: 40,
                  color: const Color.fromARGB(255, 20, 158, 154),
                  child: const Center(
                      child: Text(
                    "Generate",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Title
  Widget _buildTitle(String s) {
    return Center(
      child: Text(
        s,
        style: const TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Widget to show X and Y
  Widget _buildXY() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          SizedBox(
            width: 70,
            child: Center(
                child: Text(
              "X",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
          ),
          SizedBox(
            width: 70,
            child: Center(
                child: Text(
              "Y",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )),
          ),
        ],
      ),
    );
  }

  // Widget for show text input
  Widget _buildInputValueXY() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: 70,
          child: Form(
            key: _formKey2,
            child: _buildInputXY("X"),
          ),
        ),
        SizedBox(
          width: 70,
          child: Form(
            key: _formKey3,
            child: _buildInputXY("Y"),
          ),
        ),
      ],
    );
  }

  // Widget for Calculate Regresion
  Widget _buildButton() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: GestureDetector(
          onTap: () {
            if (_formKey2.currentState!.validate() &&
                _formKey3.currentState!.validate()) {
              valueOfInput.clear();
              valueOfX.clear();
              valueOfY.clear();
              valueOfY2.clear();
              valueOfX2.clear();
              valueOfXY.clear();
              ValueOfAll.clear();
              _formKey2.currentState!.save();
              _formKey3.currentState!.save();
              for (var i = 0; i < valueOfInput.length; i++) {
                if (i < (valueOfInput.length / 2)) {
                  valueOfX.add(valueOfInput[i]);
                } else {
                  valueOfY.add(valueOfInput[i]);
                }
              }
              _process();
              // Go to next page with parameter
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResultDataScreen(
                  hasil: ValueOfAll,
                );
              }));
            }
          },
          child: Container(
            height: 50,
            color: const Color.fromARGB(255, 20, 158, 154),
            child: const Center(
                child: Text(
              "Hitung",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
          ),
        ),
      ),
    );
  }
}
