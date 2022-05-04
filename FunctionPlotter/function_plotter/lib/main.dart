import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:function_plotter/graph.dart';

void main() {
  runApp(const MyApp());

  //used to create custom windows
  doWhenWindowReady(() {
    const initialSize = Size(1000, 650);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'Function Evaluator';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: FuncPlotter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FuncPlotter extends StatefulWidget {
  const FuncPlotter({Key? key}) : super(key: key);

  @override
  State<FuncPlotter> createState() => _FuncPlotterState();
}

//defualt expression of 0 from 0.0 to 1.0
var exp = '0';
var xstart = 0.0;
var xend = 1.0;

class _FuncPlotterState extends State<FuncPlotter> {
  @override
  Widget build(BuildContext context) {
    //controller for text field to enter the expression
    //and controllers for the start and end points
    var txControllerExp = TextEditingController();
    var txControllerXstart = TextEditingController();
    var txControllerXend = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 112, 148, 167),
            Color.fromARGB(255, 106, 147, 168),
            Color.fromARGB(255, 57, 161, 212),
          ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 112, 148, 167),
                            Color.fromARGB(255, 106, 147, 168),
                            Color.fromARGB(255, 57, 161, 212),
                          ]),
                        ),
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            'Function Evaluator',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  WindowButtons(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Graph(start: xstart, end: xend, exp: exp),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth * 0.9,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Enter an expression to evaluate',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("f(x) = ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                              Expanded(
                                child: TextField(
                                  controller: txControllerExp,
                                  onSubmitted: (x) {
                                    var input = txControllerExp.text;
                                    input = input.replaceAll(' ', '');
                                    input = input.replaceAll('X', 'x');
                                    if (!isExpression(input)) {
                                      var dialoge = AlertDialog(
                                        title: const Text('Invalid Expression'),
                                        content: const Text(
                                            'Please enter a valid expression'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => dialoge);

                                      return;
                                    }
                                    exp = input;
                                    txControllerExp.text = input;
                                  },
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Enter an expression (ex: 3*x^2, note that 3x^2 is not valid)',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 196, 184, 184),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 38, 161, 228),
                                      Color.fromARGB(255, 57, 212, 191),
                                    ],
                                  ),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    //evaluate the expression
                                    var input = txControllerExp.text;
                                    input = input.replaceAll(' ', '');
                                    input = input.replaceAll('X', 'x');
                                    if (!isExpression(input)) {
                                      var dialoge = AlertDialog(
                                        title: const Text('Invalid Expression'),
                                        content: const Text(
                                            'Please enter a valid expression'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => dialoge);

                                      return;
                                    }
                                    exp = input;
                                    txControllerExp.text = input;
                                    if (txControllerXstart.text.isEmpty) {
                                      xstart = -10;
                                    } else {
                                      if (isNumeric(txControllerXstart.text)) {
                                        xstart = double.parse(
                                            txControllerXstart.text);
                                      } else {
                                        var dialoge = AlertDialog(
                                          title: const Text('Invalid Input'),
                                          content: const Text(
                                              'Please enter a valid number'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) => dialoge);
                                        return;
                                      }
                                    }
                                    if (txControllerXend.text.isEmpty) {
                                      xend = 10;
                                    } else {
                                      if (isNumeric(txControllerXend.text)) {
                                        xend =
                                            double.parse(txControllerXend.text);
                                      } else {
                                        var dialoge = AlertDialog(
                                          title: const Text('Invalid Input'),
                                          content: const Text(
                                              'Please enter a valid number'),
                                          actions: [
                                            TextButton(
                                              child: const Text('OK'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (context) => dialoge);
                                        return;
                                      }
                                    }
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: const Text(
                                    'Plot',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("start value for x = ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                              Expanded(
                                child: TextField(
                                  onSubmitted: (x) {
                                    var input = txControllerXstart.text;
                                    input = input.replaceAll(' ', '');
                                    if (!isNumeric(input)) {
                                      var dialoge = AlertDialog(
                                        title: const Text('Invalid Number'),
                                        content: const Text(
                                            'Please enter a valid Number'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => dialoge);

                                      return;
                                    }
                                    xstart = double.parse(input);
                                    txControllerXstart.text = input;
                                  },
                                  controller: txControllerXstart,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: ' -10',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 196, 184, 184),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("End value for x = ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )),
                              Expanded(
                                child: TextField(
                                  onSubmitted: (x) {
                                    var input = txControllerXend.text;
                                    input = input.replaceAll(' ', '');
                                    if (!isNumeric(input)) {
                                      var dialoge = AlertDialog(
                                        title: const Text('Invalid Number'),
                                        content: const Text(
                                            'Please enter a valid Number'),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (context) => dialoge);

                                      return;
                                    }
                                    xend = double.parse(input);
                                    txControllerXend.text = input;
                                  },
                                  controller: txControllerXend,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: '10',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 196, 184, 184),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  WindowButtons({Key? key}) : super(key: key);

  final windowColors = WindowButtonColors(
    iconNormal: Colors.black,
    mouseOver: const Color.fromARGB(255, 53, 126, 187),
    iconMouseOver: Colors.red.shade800,
    normal: const Color.fromARGB(255, 57, 161, 212),
    iconMouseDown: Colors.red.shade800,
    mouseDown: const Color.fromARGB(255, 73, 134, 165),
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: windowColors, animate: true),
        MaximizeWindowButton(colors: windowColors, animate: true),
        CloseWindowButton(colors: windowColors, animate: true),
      ],
    );
  }
}

bool isExpression(String input) {
  //makes sure input only contains numbers, operators, and x  and is not empty
  if (input.isEmpty) {
    return false;
  }
  String prevChar = '';
  for (var i = 0; i < input.length; i++) {
    if (input[i] != 'x' &&
        input[i] != '^' &&
        input[i] != '+' &&
        input[i] != '-' &&
        input[i] != '*' &&
        input[i] != '/' &&
        input[i] != '.' &&
        !isNumeric(input[i])) {
      return false;
    }
    //makes sure that there are no two consecutive operators
    if (prevChar == '+' ||
        prevChar == '-' ||
        prevChar == '*' ||
        prevChar == '/' ||
        prevChar == '.' ||
        prevChar == '^') {
      if (input[i] == '+' ||
          input[i] == '-' ||
          input[i] == '*' ||
          input[i] == '/' ||
          input[i] == '.' ||
          input[i] == '^') {
        return false;
      }
    }
    if (input[i] == 'x') {
      if (prevChar == 'x' || isNumeric(prevChar)) {
        return false;
      }
    }
    prevChar = input[i];
  }

  //make sure that no number has two decimal points
  for (var i = 0; i < input.length; i++) {
    if (input[i] == '.') {
      if (i == 0 || i == input.length - 1) {
        return false;
      }
      if (input[i - 1] == '.' || input[i + 1] == '.') {
        return false;
      }
    }
  }

  return true;
}

bool isNumeric(String str) {
  return double.tryParse(str) != null;
}
