import 'dart:math';
import 'package:flutter/material.dart';
import 'cant_access_screen.dart';

class CalculationScreen extends StatefulWidget {
  String Methode;
  CalculationScreen({Key? key, required this.Methode}) : super(key: key);

  @override
  State<CalculationScreen> createState() =>
      _CalculationScreenState(Methode: Methode);
}

class _CalculationScreenState extends State<CalculationScreen> {
  //Construt class
  final String Methode;
  _CalculationScreenState({required this.Methode});

  // Inisialization varibel
  String hasil = "";
  String dropdownValue1 = 'Persegi';
  String dropdownValue2 = 'Kubus';
  double Value1 = 0;
  double Value2 = 0;
  double Value3 = 0;
  double Summary = 0;
  double InputRequest = 0;
  bool Calculate = false;
  List<String> Value = [];
  List<String> ValueWide = [
    'Persegi',
    'Segitiga',
    'Persegi Panjang',
    'Lingkaran',
    'Trapesium',
    'Jajar Genjang'
  ];
  List<String> ValueVolum = [
    'Kubus',
    'Balok',
    'Bola',
    'Tabung',
    'Kerucut',
  ];

  // State for show the result
  void _Calculate() {
    setState(() {
      Calculate = false;
    });
  }

  // Globalkey for Form
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

  // Controller the text input
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();

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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Center(
                  child: Text(
                    Methode,
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
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildTitle("Menghitung $Methode"),
                    _buildDropDown(screenSize),
                    Row(
                      children: <Widget>[
                        Expanded(child: _buildButton("Hapus", 1)),
                        Expanded(child: _buildButton("Hitung", 2))
                      ],
                    ),
                    _buildTitle("Masukkan Input"),
                    _buildCalculate(screenSize),
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
                        children: <Widget>[
                          _buildTitle("Menghitung $Methode"),
                          _buildDropDown(screenSize),
                          Row(
                            children: <Widget>[
                              Expanded(child: _buildButton("Hapus", 1)),
                              Expanded(child: _buildButton("Hitung", 2))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: screenSize.width * 0.3,
                      constraints:
                          const BoxConstraints(minWidth: 350, maxWidth: 450),
                      child: Column(
                        children: [
                          _buildTitle("Masukkan Input"),
                          _buildCalculate(screenSize),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  // Widget for Title
  Widget _buildTitle(String s) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Text(
          s,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  // Widget for Dropdown
  Widget _buildDropDown(Size screenSize) {
    return SizedBox(
      width: screenSize.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: DropdownButton<String>(
          value: (Methode == "Volume") ? dropdownValue2 : dropdownValue1,
          isExpanded: true,
          style: const TextStyle(
              color: Color.fromARGB(255, 20, 158, 154),
              fontSize: 18,
              fontFamily: "ClashDisplay"),
          underline: Container(
            height: 2,
            color: const Color.fromARGB(255, 20, 158, 154),
          ),
          elevation: 8,
          onChanged: (String? newValue) {
            setState(() {
              (Methode == "Volume")
                  ? dropdownValue2 = newValue!
                  : dropdownValue1 = newValue!;
            });
            _Calculate();
            _controller1.clear();
            _controller2.clear();
            _controller3.clear();
          },
          items: (Methode == "Volume")
              ? ValueVolum.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()
              : ValueWide.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
        ),
      ),
    );
  }

  // Widget for input Form base on dropdown
  Widget _buildCalculate(Size screenSize) {
    String ValueOfA = "Panjang";
    String ValueOfB = "Lebar";
    String ValueOfC = "Tinggi";

    if (Methode == 'Volume') {
      if (dropdownValue2 == 'Kerucut') {
        InputRequest = 2;
        ValueOfA = "Jari-Jari";
        ValueOfB = "Tinggi";
        ValueOfC = "";
      } else if (dropdownValue2 == 'Kubus') {
        InputRequest = 1;
        ValueOfA = "Sisi";
        ValueOfC = "";
        ValueOfB = "";
      } else if (dropdownValue2 == 'Balok') {
        InputRequest = 3;
      } else if (dropdownValue2 == 'Bola') {
        InputRequest = 1;
        ValueOfA = "Jari-Jari";
        ValueOfB = "";
        ValueOfC = "";
      } else if (dropdownValue2 == 'Tabung') {
        InputRequest = 2;
        ValueOfA = "Jari-Jari";
        ValueOfB = "Tinggi";
        ValueOfC = "";
      }
    } else if (Methode == 'Luas') {
      if (dropdownValue1 == 'Segitiga') {
        InputRequest = 2;
        ValueOfA = "Alas";
        ValueOfB = "Tinggi";
        ValueOfC = "";
      } else if (dropdownValue1 == 'Persegi') {
        InputRequest = 1;
        ValueOfA = "Sisi";
        ValueOfC = "";
        ValueOfB = "";
      } else if (dropdownValue1 == 'Persegi Panjang') {
        InputRequest = 2;
        ValueOfC = "";
      } else if (dropdownValue1 == 'Lingkaran') {
        InputRequest = 1;
        ValueOfA = "Jari-Jari";
        ValueOfB = "";
        ValueOfC = "";
      } else if (dropdownValue1 == 'Trapesium') {
        InputRequest = 3;
        ValueOfA = "Sisi A";
        ValueOfB = "Sisi B";
        ValueOfC = "Tinggi";
      } else if (dropdownValue1 == 'Jajar Genjang') {
        InputRequest = 2;
        ValueOfA = "Alas";
        ValueOfB = "Tinggi";
        ValueOfC = "";
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: screenSize.width * 0.8,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: _buildSubTitle(ValueOfA)),
                Expanded(
                    child: Form(
                  key: _formKey1,
                  child: _buildInputValue(ValueOfA, 1),
                ))
              ],
            ),
          ),
          (ValueOfB == "")
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: _buildSubTitle(ValueOfB)),
                      Expanded(
                          child: Form(
                        key: _formKey2,
                        child: _buildInputValue(ValueOfB, 2),
                      ))
                    ],
                  ),
                ),
          (ValueOfC == "")
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: _buildSubTitle(ValueOfC)),
                      Expanded(
                          child: Form(
                        key: _formKey3,
                        child: _buildInputValue(ValueOfC, 3),
                      ))
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: _buildTitle("Hasil"),
          ),
          (Calculate == true)
              ? (Methode == 'Volume')
                  ? _buildTheValue("Volume $dropdownValue2 adalah $Summary")
                  : _buildTheValue("Luas $dropdownValue1 adalah $Summary")
              : Container()
        ],
      ),
    );
  }

  // Widget for Subtitle
  Widget _buildSubTitle(String s) {
    return Text(s, style: const TextStyle(fontSize: 18));
  }

  // Widget for the final value
  Widget _buildTheValue(String s) {
    if (Calculate) {
      return Text(
        s,
        style: const TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      );
    } else {
      return Container();
    }
  }

  // Check the value must double
  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  // Widget for Text Field of value
  Widget _buildInputValue(String s, int key) {
    return SizedBox(
        height: 40,
        child: TextFormField(
          controller: (key == 1)
              ? _controller1
              : (key == 2)
                  ? _controller2
                  : _controller3,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: s,
          ),
          style: const TextStyle(
              color: Color.fromARGB(255, 20, 158, 154),
              fontSize: 18,
              fontFamily: "ClashDisplay"),
          validator: (String? value) {
            if (isNumeric(value!) == false) {
              return 'Masukan angka';
            } else {
              return null;
            }
          },
          onSaved: (value) => setState(() {
            if (key == 1) {
              Value1 = double.parse(value!);
            } else if (key == 2) {
              Value2 = double.parse(value!);
            } else if (key == 3) {
              Value3 = double.parse(value!);
            }
          }),
        ));
  }

  // Widget for Button
  Widget _buildButton(String s, int i) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: GestureDetector(
          onTap: () {
            if (i == 1) {
              _controller1.clear();
              _controller2.clear();
              _controller3.clear();
              _Calculate();
            } else if (i == 2) {
              Value1 = 0;
              Value2 = 0;
              Value3 = 0;
              if (InputRequest == 1) {
                if (_formKey1.currentState!.validate()) {
                  _formKey1.currentState!.save();
                  _calculate();
                  Calculate = true;
                }
              } else if (InputRequest == 2) {
                if (_formKey1.currentState!.validate() &&
                    _formKey2.currentState!.validate()) {
                  _formKey2.currentState!.save();
                  _formKey1.currentState!.save();
                  _calculate();
                  Calculate = true;
                }
              } else if (InputRequest == 3) {
                if (_formKey1.currentState!.validate() &&
                    _formKey2.currentState!.validate() &&
                    _formKey3.currentState!.validate()) {
                  _formKey2.currentState!.save();
                  _formKey3.currentState!.save();
                  _formKey1.currentState!.save();
                  _calculate();
                  Calculate = true;
                }
              }
            }
          },
          child: Container(
            height: 50,
            color: (i == 2)
                ? const Color.fromARGB(255, 20, 158, 154)
                : const Color.fromARGB(255, 116, 116, 116),
            child: Center(
                child: Text(
              s,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
          ),
        ),
      ),
    );
  }

  // Calculation Process
  void _calculate() {
    if (Methode == 'Volume') {
      if (dropdownValue2 == 'Kerucut') {
        Summary = (1 / 3) * pi * Value1 * Value1 * Value2;
      } else if (dropdownValue2 == 'Tabung') {
        Summary = pi * Value1 * Value1 * Value2;
      } else if (dropdownValue2 == 'Kubus') {
        Summary = (Value1 * Value1 * Value1);
      } else if (dropdownValue2 == 'Bola') {
        Summary = (4 / 3) * pi * Value1 * Value1;
      } else if (dropdownValue2 == 'Balok') {
        Summary = (Value1 * Value2 * Value3);
      }
    } else if (Methode == 'Luas') {
      if (dropdownValue1 == 'Jajar Genjang' ||
          dropdownValue1 == 'Persegi Panjang') {
        Summary = Value1 * Value2;
      } else if (dropdownValue1 == 'Segitiga') {
        Summary = (Value1 * Value2) / 2;
      } else if (dropdownValue1 == 'Persegi') {
        Summary = (Value1 * Value1);
      } else if (dropdownValue1 == 'Lingkaran') {
        Summary = pi * Value1 * Value1;
      } else if (dropdownValue1 == 'Trapesium') {
        Summary = ((Value1 + Value2) * Value3) / 2;
      }
    }
  }
}
