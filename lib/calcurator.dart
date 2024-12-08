import 'package:flutter/material.dart';

import 'widget/calcurator_button.dart';
import 'widget/currrency_card.dart';

class CalcuratorHomePage extends StatefulWidget {
  const CalcuratorHomePage({super.key});

  @override
  _CalcuratorHomePageState createState() => _CalcuratorHomePageState();
}

class _CalcuratorHomePageState extends State<CalcuratorHomePage> {
  String output = "0"; //화면에 표시될 계산 결과 값
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  //버튼이 눌렸을 때 호출되는 함수
  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      //모든 값을 초기화 합니다.
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      //연산자를 선택하고 첫 번째 숫자를 저장합니다.
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      //소수점이 이미 포함되어 있으면 추가하지 않습니다.
      if (output.contains(".")) {
        return;
      } else {
        _output += buttonText; // 소수점
      }
    } else if (buttonText == "=") {
      //두 번째 숫자를 저장하고 계산을 합니다.
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      } else if (operand == "-") {
        _output = (num1 - num2).toString();
      } else if (operand == "x") {
        _output = (num1 * num2).toString();
      } else if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      //계산이 끝난 후 초기화
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      // 숫자를 입력할 때마다 현재 출력 값에 추가 합니다.
      _output += buttonText;
    }
    //UI를 업데이트하고 계산 결과를 표시합니다.
    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  @override // auto complete 됨.
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'SEX',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '섹스',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                // 계산 결과를 표시할 화면 삽입
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 12.0),
                  child: Text(
                    output,
                    style: const TextStyle(
                        fontSize: 44.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const CurrencyCard(
                  name: 'Dollar',
                  code: 'USD',
                  amount: '428',
                  icon: Icons.attach_money_outlined,
                  isInverted: false,
                  offset: -40,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CalcuratorButton("C", buttonPressed),
                        CalcuratorButton("()", buttonPressed),
                        CalcuratorButton("%", buttonPressed),
                        CalcuratorButton("/", buttonPressed),
                      ],
                    ),
                    Row(
                      children: [
                        CalcuratorButton("7", buttonPressed),
                        CalcuratorButton("8", buttonPressed),
                        CalcuratorButton("9", buttonPressed),
                        CalcuratorButton("x", buttonPressed),
                      ],
                    ),
                    Row(
                      children: [
                        CalcuratorButton("4", buttonPressed),
                        CalcuratorButton("5", buttonPressed),
                        CalcuratorButton("6", buttonPressed),
                        CalcuratorButton("-", buttonPressed),
                      ],
                    ),
                    Row(
                      children: [
                        CalcuratorButton("1", buttonPressed),
                        CalcuratorButton("2", buttonPressed),
                        CalcuratorButton("3", buttonPressed),
                        CalcuratorButton("+", buttonPressed),
                      ],
                    ),
                    Row(
                      children: [
                        CalcuratorButton("0", buttonPressed),
                        CalcuratorButton("00", buttonPressed),
                        CalcuratorButton(".", buttonPressed),
                        CalcuratorButton("=", buttonPressed),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
