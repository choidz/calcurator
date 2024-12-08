import 'package:flutter/material.dart';

//CalcuratorButton 클래스는 계산기의 버튼을 정의하는 위젯입니다.

class CalcuratorButton extends StatelessWidget {
  final String buttonText;
  final Function buttonCallback;

  //CalcuratorButton 생성자는 버튼의 텍스트와 콜백 함수를 받아옵니다.
  const CalcuratorButton(this.buttonText, this.buttonCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1.0), // 버튼 사이의 간격을 설정합니다.
        child: SizedBox(
          width: 60, // 버튼의 너비를 설정합니다.
          height: 60, // 버튼의 높이를 설정합니다.
          child: OutlinedButton(
            onPressed: () => buttonCallback(buttonText),
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.blue, // 버튼의 배경색을 설정합니다.
              side: const BorderSide(
                  color: Colors.white, width: 0), // 버튼 테두리 색상과 두께를 설정합니다.
              shape: RoundedRectangleBorder(
                // 버튼 모서리를 둥글게 설정합니다.
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white, // 텍스트 색상 변경
              ),
            ),
          ),
        ),
      ),
    );
  }
}
