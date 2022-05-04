import 'package:eval_ex/expression.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  var exp = Expression('2+2');

  //in this test group, the expression evaluator is tested to verify that the operators work as inteded
  //this is particularly helpful because Dart doesnt have a defualt Power operator
  //instead it requires the use of the pow() function, however this confirms that the evaluator works with the ^ operator
  group('no variable operations', () {
    test('+: should return 4 ', () {
      exp = Expression('2+2');
      expect(exp.eval().toString(), '4');
    });

    test('-: should return 0 ', () {
      exp = Expression('2-2');
      expect(exp.eval().toString(), '0');
    });

    test('*: should return 4 ', () {
      exp = Expression('2*2');
      expect(exp.eval().toString(), '4');
    });

    test('/: should return 1 ', () {
      exp = Expression('2/2');
      expect(exp.eval().toString(), '1');
    });

    test('^: should return 8 ', () {
      exp = Expression('2^3');
      expect(exp.eval().toString(), '8');
    });
    //ce: complex expression
    test('ce: should return 14', () {
      exp = Expression('2+2*2 + 2^3');
      expect(exp.eval().toString(), '14');
    });
  });

  //this test group validates the evaluator's capability of handling variables
  group('Varibale operations', () {
    exp = Expression('a ^ b + c');
    // Variables may contain alphanumeric characters

    test('+: should return 4', () {
      exp = Expression('x + 2');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '4');
    });

    test('-: should return 0 ', () {
      exp = Expression('x-2');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '0');
    });

    test('*: should return 4 ', () {
      exp = Expression('x*2');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '4');
    });

    test('/: should return 1 ', () {
      exp = Expression('x/2');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '1');
    });

    test('^: should return 8 ', () {
      exp = Expression('x^3');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '8');
    });
    //ce: complex expression
    test('ce: should return 14', () {
      exp = Expression('x+x*x + x^3');
      exp.setStringVariable('x', '2');
      expect(exp.eval().toString(), '14');
    });
  });
}
