import 'dart:io';

num add(num a, num b) => a + b;
num subtract(num a, num b) => a - b;
num multiply(num a, num b) => a * b;
num divide(num a, num b) {
  if (b == 0) {
    print('Error: Division by zero');
    return double.nan;
  }
  return a / b;
}

num calculate(num a, num b, String operator) {
  switch (operator) {
    case '+':
      return add(a, b);
    case '-':
      return subtract(a, b);
    case '*':
      return multiply(a, b);
    case '/':
      return divide(a, b);
    default:
      print('Invalid operator');
      return double.nan;
  }
}

void main() {
  print('Enter the first number:');
  num num1 = num.parse(stdin.readLineSync()!);

  print('Enter the operator (+, -, *, /):');
  String operator = stdin.readLineSync()!;

  print('Enter the second number:');
  num num2 = num.parse(stdin.readLineSync()!);

  num result = calculate(num1, num2, operator);
  if (!result.isNaN) {
    print('Result: $result');
  }
}
