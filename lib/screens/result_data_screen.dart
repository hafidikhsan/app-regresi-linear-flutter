import 'package:flutter/material.dart';
import 'dart:math';
import 'package:graphic/graphic.dart';

class ResultDataScreen extends StatelessWidget {
  // Variable List to show the data
  List<Map> hasil = [];
  List<Map> Graph = [];
  double ValueOfB = 0;
  double ValueOfDeltaY = 0;
  double ValueOfDeltaB = 0;
  double Acuration = 0;

  // Construction
  ResultDataScreen({required this.hasil});

  // Function to process the data
  void _resultOfB() {
    final SumOfData = hasil.length - 1;
    var SumVariable = new Map();
    SumVariable = hasil.last;

    double sumOfX = SumVariable["x"];
    double sumOfY = SumVariable["y"];
    double sumOfX2 = SumVariable["x2"];
    double sumOfY2 = SumVariable["y2"];
    double sumOfXY = SumVariable["xy"];

    double ResultOfB = ((SumOfData * sumOfXY) - (sumOfX * sumOfY)) /
        ((SumOfData * sumOfX2) - (sumOfX * sumOfX));

    ValueOfB = ResultOfB;

    double ResultOfDeltaY = ((1 / (SumOfData - 2)) *
        (sumOfY2 -
            ((sumOfX2 * (sumOfY * sumOfY)) -
                    (2 * sumOfX * sumOfY * sumOfXY) +
                    (SumOfData * (sumOfXY * sumOfXY))) /
                ((SumOfData * sumOfX2) - (sumOfX * sumOfX))));

    ValueOfDeltaY = sqrt(ResultOfDeltaY);

    double ResultOfDeltaB = (ValueOfDeltaY *
        sqrt((SumOfData) / ((SumOfData * sumOfX2) - (sumOfX * sumOfX))));

    ValueOfDeltaB = ResultOfDeltaB;

    double ResultOfAcuration = (1 - (ValueOfDeltaB / ValueOfB)) * 100;

    Acuration = ResultOfAcuration;

    for (var i = 0; i < hasil.length - 1; i++) {
      Graph.add(hasil[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    _resultOfB();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 20, 158, 154),
        ),
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'Hasil',
                style: TextStyle(
                    color: Color.fromARGB(255, 20, 158, 154), fontSize: 24),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  _buildTitle("Tabel Regresi Linear"),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: _createDataTable(),
                    ),
                  ),
                  _buildTitle("Nilai Variabel b"),
                  _buildValue("B = $ValueOfB"),
                  _buildTitle("Nilai Variabel Delta Y"),
                  _buildValue("Delta Y = $ValueOfDeltaY"),
                  _buildTitle("Nilai Variabel Delta B"),
                  _buildValue("Delta B = $ValueOfDeltaB"),
                  _buildTitle("Pelaporan (B +- Delta B)"),
                  _buildValue("($ValueOfB +- $ValueOfDeltaB)"),
                  _buildTitle("Tingkat Ketelitian"),
                  _buildValue("TK = $Acuration %"),
                  _buildTitle("Grafik"),
                  Container(
                    constraints:
                        const BoxConstraints(maxHeight: 300, maxWidth: 600),
                    child: Chart(
                      // Show Graph
                      data: Graph,
                      variables: {
                        'x': Variable(
                          accessor: (Map map) => map['x'] as num,
                        ),
                        'y': Variable(
                          accessor: (Map map) => map['y'] as num,
                        ),
                      },
                      elements: [
                        LineElement(shape: ShapeAttr(value: BasicLineShape()))
                      ],
                      axes: [
                        Defaults.horizontalAxis,
                        Defaults.verticalAxis,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for title
  Widget _buildTitle(String s) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Container(
        width: 240,
        height: 40,
        color: const Color.fromARGB(255, 20, 158, 154),
        child: Center(
          child: Text(
            s,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  // Widget for show the result
  Widget _buildValue(String s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        s,
        style: const TextStyle(
            color: Color.fromARGB(255, 20, 158, 154), fontSize: 18),
      ),
    );
  }

  // Create Table
  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
    );
  }

  // Show the title label
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('No')),
      DataColumn(label: Text('X')),
      DataColumn(label: Text('X2')),
      DataColumn(label: Text('Y')),
      DataColumn(label: Text('Y2')),
      DataColumn(label: Text('XY')),
    ];
  }

  // Show the value
  List<DataRow> _createRows() {
    return hasil
        .map((result) => DataRow(cells: [
              DataCell(Text(result['no'].toString())),
              DataCell(Text(result['x'].toString())),
              DataCell(Text(result['x2'].toString())),
              DataCell(Text(result['y'].toString())),
              DataCell(Text(result['y2'].toString())),
              DataCell(Text(result['xy'].toString())),
            ]))
        .toList();
  }
}
