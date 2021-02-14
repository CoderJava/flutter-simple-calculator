import 'package:flutter/material.dart';

const firstColor = Color(0xFF282C30);
const secondColor = Color(0xFF404347);
const thirdColor = Color(0xFF646669);
const fourthColor = Color(0xFFFF9F0A);

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
  final listOperations = <int>[];

  String strNumberResult = '0';
  AnimationController controller;
  Animation<double> animation;

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
            flex: 2,
          ),
          _buildWidgetButtonCalculator(
            '.',
            thirdColor,
            () {
              _updateStrNumberResult('.');
            },
          ),
          _buildWidgetButtonCalculator(
            '=',
            fourthColor,
            () {
              // TODO: buat fitur tombol sama dengan
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
            fourthColor,
            () {
              // TODO: buat fitur operasi penjumlahan
            },
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
            fourthColor,
            () {
              // TODO: buat fitur operasi pengurangan
            },
          ),
        ],
      ),
    );
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
            fourthColor,
            () {
              // TODO: buat fitur operasi perkalian
            },
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
            fourthColor,
            () {
              // TODO: buat fitur operasi pembagian
            },
          ),
        ],
      ),
    );
  }

  void _updateStrNumberResult(String strNumber) {
    setState(() {
      if (strNumberResult.length == 1 && strNumberResult[0] == '0') {
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
    bool isNegative = strNumber.startsWith('-');
    if (isNegative) {
      strNumber = strNumber.replaceFirst('-', '');
    }
    var len = strNumber.length;
    var size = 3;
    var chunks = <String>[];
    for (var index = len; index > 0; index -= size) {
      var start = index - size >= 0 ? index - size : 0;
      chunks.add(strNumber.substring(start, index));
    }
    chunks = chunks.reversed.toList();
    var result = chunks.join(',');
    if (isNegative) {
      result = '-$result';
    }
    return result;
  }

  Widget _buildWidgetButtonCalculator(String label, Color backgroundColor, Function onTap, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: RaisedButton(
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Colors.white,
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
