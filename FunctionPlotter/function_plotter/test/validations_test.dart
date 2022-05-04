import 'package:flutter_test/flutter_test.dart';
import 'package:function_plotter/main.dart';

void main() {
  group(
    'isNumeric function test',
    (() {
      test('7: should return true', () {
        expect(isNumeric('7'), true);
      });
      test('-7: should return true', () {
        expect(isNumeric('7'), true);
      });
      test('7.5: should return true', () {
        expect(isNumeric('7.5'), true);
      });
      test('-7.5: should return true', () {
        expect(isNumeric('-7.5'), true);
      });

      test('7.5.5: should return false', () {
        expect(isNumeric('7.5.5'), false);
      });
      test('-7.5.5: should return false', () {
        expect(isNumeric('-7.5.5'), false);
      });

      test('x: should return false', () {
        expect(isNumeric('x'), false);
      });
      test('-x: should return false', () {
        expect(isNumeric('-x'), false);
      });

      test('x+2: should return false', () {
        expect(isNumeric('x+2'), false);
      });
    }),
  );

  group('isExpression function test', () {
    test('x: should return true', () {
      expect(isExpression('x'), true);
    });
    test('-x: should return true', () {
      expect(isExpression('-x'), true);
    });
    test('x+2: should return true', () {
      expect(isExpression('x+2'), true);
    });
    test('x+2.5: should return true', () {
      expect(isExpression('x+2.5'), true);
    });
    test('x+2..5: should return false', () {
      expect(isExpression('x+2..5'), false);
    });
    test('x+  2.5: should return false', () {
      expect(isExpression('x+  2.5'), false);
    });
    test('x+  2.5.5: should return false', () {
      expect(isExpression('x+  2.5.5'), false);
    });
    test('x^2: should return true', () {
      expect(isExpression('x^2'), true);
    });
    test('x^2.5: should return true', () {
      expect(isExpression('x^2.5'), true);
    });
    test('x/x: should return true', () {
      expect(isExpression('x/x'), true);
    });
    test('x/x+2: should return true', () {
      expect(isExpression('x/x+2'), true);
    });
    test('y: should return false', () {
      expect(isExpression('y'), false);
    });
    test('y/x+2: should return false', () {
      expect(isExpression('y/x+2'), false);
    });
  });
}
