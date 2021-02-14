import 'package:flutter/material.dart';

const firstColor = Color(0xFF282C30);
const secondColor = Color(0xFF404347);
const thirdColor = Color(0xFF646669);
const fourthColor = Color(0xFFFF9F0A);

enum OperasiMatematika {
  PEMBAGIAN,
  PERKALIAN,
  PENGURANGAN,
  PENJUMLAHAN,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Simple Calculator',
      theme: ThemeData(
        primaryColor: firstColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double numberA;
  double numberB;
  var strNumberResult = '0';
  AnimationController controller;
  Animation<double> animation;
  OperasiMatematika operasiMatematika;
  var isButtonOperationActive = false;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );
    controller.forward(from: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Simple Calculator'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildWidgetNumberResult(),
            _buildWidgetNumberEditor(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetNumberResult() {
    return Expanded(
      child: Container(
        color: firstColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeTransition(
              opacity: animation,
              child: Text(
                strNumberResult,
                style: Theme.of(context).textTheme.headline3.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetNumberEditor() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Column(
          children: [
            _buildWidgetButtonRow1(),
            _buildWidgetButtonRow2(),
            _buildWidgetButtonRow3(),
            _buildWidgetButtonRow4(),
            _buildWidgetButtonRow5(),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetButtonRow5() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWidgetButtonCalculator(
            '0',
            thirdColor,
            () {
              _updateStrNumberResult('0');
            },
            flex: 3,
          ),
          _buildWidgetButtonCalculator(
            '=',
            fourthColor,
            () {
              if (numberA != null) {
                numberB = double.parse(strNumberResult.replaceAll(',', ''));
                switch (operasiMatematika) {
                  case OperasiMatematika.PEMBAGIAN:
                    isButtonOperationActive = true;
                    double hasilPembagian = numberA / numberB;
                    numberA = null;
                    numberB = null;
                    strNumberResult = _formatNumber(hasilPembagian.toString());
                    operasiMatematika = null;
                    setState(() {});
                    break;
                  case OperasiMatematika.PERKALIAN:
                    isButtonOperationActive = true;
                    double hasilPerkalian = numberA * numberB;
                    numberA = null;
                    numberB = null;
                    strNumberResult = _formatNumber(hasilPerkalian.toString());
                    operasiMatematika = null;
                    setState(() {});
                    break;
                  case OperasiMatematika.PENGURANGAN:
                    isButtonOperationActive = true;
                    double hasilPengurangan = numberA - numberB;
                    numberA = null;
                    numberB = null;
                    strNumberResult = _formatNumber(hasilPengurangan.toString());
                    operasiMatematika = null;
                    setState(() {});
                    break;
                  case OperasiMatematika.PENJUMLAHAN:
                    isButtonOperationActive = true;
                    double hasilPenjumlahan = numberA + numberB;
                    numberA = null;
                    numberB = null;
                    strNumberResult = _formatNumber(hasilPenjumlahan.toString());
                    operasiMatematika = null;
                    setState(() {});
                    break;
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonRow4() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWidgetButtonCalculator(
            '1',
            thirdColor,
            () {
              _updateStrNumberResult('1');
            },
          ),
          _buildWidgetButtonCalculator(
            '2',
            thirdColor,
            () {
              _updateStrNumberResult('2');
            },
          ),
          _buildWidgetButtonCalculator(
            '3',
            thirdColor,
            () {
              _updateStrNumberResult('3');
            },
          ),
          _buildWidgetButtonCalculator(
            '+',
            operasiMatematika == OperasiMatematika.PENJUMLAHAN ? Colors.white : fourthColor,
            () {
              _lakukanPerhitungan(OperasiMatematika.PENJUMLAHAN);
            },
            textColor: operasiMatematika == OperasiMatematika.PENJUMLAHAN ? fourthColor : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonRow3() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWidgetButtonCalculator(
            '4',
            thirdColor,
            () {
              _updateStrNumberResult('4');
            },
          ),
          _buildWidgetButtonCalculator(
            '5',
            thirdColor,
            () {
              _updateStrNumberResult('5');
            },
          ),
          _buildWidgetButtonCalculator(
            '6',
            thirdColor,
            () {
              _updateStrNumberResult('6');
            },
          ),
          _buildWidgetButtonCalculator(
            '-',
            operasiMatematika == OperasiMatematika.PENGURANGAN ? Colors.white : fourthColor,
            () {
              _lakukanPerhitungan(OperasiMatematika.PENGURANGAN);
            },
            textColor: operasiMatematika == OperasiMatematika.PENGURANGAN ? fourthColor : Colors.white,
          ),
        ],
      ),
    );
  }

  void _lakukanPerhitungan(OperasiMatematika operasiMatematikaNew) {
    var number = double.parse(strNumberResult.replaceAll(',', ''));
    if (operasiMatematika != null && !isButtonOperationActive) {
      isButtonOperationActive = true;
      if (numberA == null) {
        numberA = number;
      } else if (numberB == null) {
        numberB = number;
      }
      if (numberA != null && numberB != null) {
        switch (operasiMatematika) {
          case OperasiMatematika.PEMBAGIAN:
            double hasilPembagian = numberA / numberB;
            numberA = hasilPembagian;
            numberB = null;
            strNumberResult = _formatNumber(hasilPembagian.toString());
            break;
          case OperasiMatematika.PERKALIAN:
            double hasilPerkalian = numberA * numberB;
            numberA = hasilPerkalian;
            numberB = null;
            strNumberResult = _formatNumber(hasilPerkalian.toString());
            break;
          case OperasiMatematika.PENGURANGAN:
            double hasilPengurangan = numberA - numberB;
            numberA = hasilPengurangan;
            numberB = null;
            strNumberResult = _formatNumber(hasilPengurangan.toString());
            break;
          case OperasiMatematika.PENJUMLAHAN:
            double hasilPenjumlahan = numberA + numberB;
            numberA = hasilPenjumlahan;
            numberB = null;
            strNumberResult = _formatNumber(hasilPenjumlahan.toString());
            break;
        }
      }
    } else {
      isButtonOperationActive = true;
      numberA = number;
    }
    operasiMatematika = operasiMatematikaNew;
    controller.forward(from: 0);
    setState(() {});
  }

  Widget _buildWidgetButtonRow2() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWidgetButtonCalculator(
            '7',
            thirdColor,
            () {
              _updateStrNumberResult('7');
            },
          ),
          _buildWidgetButtonCalculator(
            '8',
            thirdColor,
            () {
              _updateStrNumberResult('8');
            },
          ),
          _buildWidgetButtonCalculator(
            '9',
            thirdColor,
            () {
              _updateStrNumberResult('9');
            },
          ),
          _buildWidgetButtonCalculator(
            'x',
            operasiMatematika == OperasiMatematika.PERKALIAN ? Colors.white : fourthColor,
            () {
              _lakukanPerhitungan(OperasiMatematika.PERKALIAN);
            },
            textColor: operasiMatematika == OperasiMatematika.PERKALIAN ? fourthColor : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetButtonRow1() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildWidgetButtonCalculator(
            'AC',
            secondColor,
            () {
              setState(() {
                strNumberResult = '0';
                operasiMatematika = null;
                numberA = null;
                numberB = null;
                controller.forward(from: 0);
              });
            },
            flex: 2,
          ),
          _buildWidgetButtonCalculator(
            '+/-',
            secondColor,
            () {
              setState(() {
                var numberResult = double.parse(strNumberResult.replaceAll(',', ''));
                if (numberResult != 0) {
                  if (strNumberResult.startsWith('-')) {
                    strNumberResult = strNumberResult.replaceFirst('-', '');
                  } else {
                    strNumberResult = '-$strNumberResult';
                  }
                }
              });
            },
          ),
          _buildWidgetButtonCalculator(
            '/',
            operasiMatematika == OperasiMatematika.PEMBAGIAN ? Colors.white : fourthColor,
            () {
              _lakukanPerhitungan(OperasiMatematika.PEMBAGIAN);
            },
            textColor: operasiMatematika == OperasiMatematika.PEMBAGIAN ? fourthColor : Colors.white,
          ),
        ],
      ),
    );
  }

  void _updateStrNumberResult(String strNumber) {
    setState(() {
      if (isButtonOperationActive) {
        strNumberResult = strNumber;
        isButtonOperationActive = false;
      } else if (strNumberResult.length == 1 && strNumberResult[0] == '0') {
        if (strNumber == '0') {
          return;
        }
        strNumberResult = strNumber;
      } else {
        strNumberResult += strNumber;
      }
      strNumberResult = _formatNumber(strNumberResult);
    });
  }

  String _formatNumber(String strNumber) {
    strNumber = strNumber.replaceAll(',', '');
    double numberDouble = double.parse(strNumber);
    num number;
    if (isInteger(numberDouble)) {
      number = numberDouble.toInt();
    } else {
      number = numberDouble;
    }
    strNumber = number.toString();
    var len = strNumber.length;
    var size = 3;
    var chunks = <String>[];
    for (var index = len; index > 0; index -= size) {
      var start = index - size >= 0 ? index - size : 0;
      chunks.add(strNumber.substring(start, index));
    }
    chunks = chunks.reversed.toList();
    var result = chunks.join(',');
    return result;
  }

  bool isInteger(num value) {
    return value % 1 == 0;
  }

  Widget _buildWidgetButtonCalculator(
    String label,
    Color backgroundColor,
    Function onTap, {
    int flex = 1,
    Color textColor = Colors.white,
  }) {
    return Expanded(
      flex: flex,
      child: RaisedButton(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: textColor,
              ),
        ),
        onPressed: onTap,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.5,
            color: firstColor,
          ),
        ),
      ),
    );
  }
}
