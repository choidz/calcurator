//메모를 작성하거나 수정하는 화면을 구성하는 클래스
import 'package:flutter/material.dart';

import 'widget/record.dart';

class NoteEditPage extends StatefulWidget {
  final Record? note; //기존 메모를 수정할 때 사용, 새 메모일 경우 null

  //생성자에서 Note 객체를 받아옵니다.
  const NoteEditPage({super.key, this.note});

  //상태를 관리하는 State클래스를 생성합니다.
  @override
  _NoteEditPageState createState() => _NoteEditPageState();
}

//NoteEditPage의 상태를 관리하는 _NoteEditPage 클래스
class _NoteEditPageState extends State<NoteEditPage> {
  late TextEditingController _titleController; //제목 입력을 위한 TextEditController
  late TextEditingController _contentController; //내용 입력을 위한 TextEditController

  @override
  void initState() {
    super.initState();
    //초기화 시, 전달된 Note 객체를 사용하여 컨트롤러에 초기값을 설정합니다.
    _titleController = TextEditingController(
      text: widget.note?.record1 ?? '', //메모 제목이 있으면 그 값으로, 없으면 빈 문자열로 초기화 합니다.
    );
    _contentController = TextEditingController(
      text: widget.note?.record2 ?? '', //메모 내용이 있으며 그 값으로, 없으며 빈 문자열로 초기화 합니다.
    );
  }

  @override
  void dispose() {
    //화면이 종료될 때 컨트롤러를 해제합니다.
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //제목을 지정합니다. 메모 수정 시 'Edit Not',새 메모 작성 시 'New note'가 표시됩니다.
        actions: [
          IconButton(
            icon: const Icon(Icons.save), //저장 버튼 아이콘을 표시합니다.
            onPressed: () {
              //저장 버튼이 눌리면 현재 입려된 제목과 내용을 Note 객체로 만들어서 반환합니다.
              final newNote = Record(
                record1: _titleController.text, //입력된 제목을 가져옵니다.
                record2: _contentController.text, //입력된 내용을 가져옵니다.
              );
              Navigator.pop(context, newNote); //현재 화면을 닫고, 작성된 메모를 반환합니다.
            },
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0), // 전체 화면에 여백을 줍니다.
          child: Column(
            children: [
              TextField(
                controller: _titleController, //제목 입력을 위한 TextField
                decoration: const InputDecoration(
                    labelText: 'Record1'), //'Title'레이블을 표시합니다.
              ),
              const SizedBox(height: 16.0), //제목과 내용 입력 사이에 간격을 추가
              TextField(
                controller: _contentController, //내용 입력을 위한 TextField
                decoration: const InputDecoration(labelText: 'Record2'),
                maxLines: 10, //최대 10줄까지 입력할 수 있습니다.
              )
            ],
          )),
    );
  }
}
