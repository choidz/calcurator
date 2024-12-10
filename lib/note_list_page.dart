// @docImport 'package:shared_preferences/shared_preferences.dart'
import 'package:flutter/material.dart'; // Flutter의 기본 위젯을 사용하기 위해 import합니다.

// import 'package:shared_preferences/shared_preferences.dart'; // 로컬 데이터 저장을 위해 import합니다.

import 'note_edit_page.dart'; // NoteEditPage 클래스를 사용하기 위해 import합니다.
import 'widget/record.dart'; // Record 클래스를 사용하기 위해 import합니다.

// 메모 목록 화면을 구성하는 NoteListPage 클래스입니다.
class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  _NoteListPageState createState() =>
      _NoteListPageState(); // 상태를 관리하는 State 클래스 생성합니다.
}

// NoteListPage의 상태를 관리하는 _NoteListPageState 클래스입니다.
class _NoteListPageState extends State<NoteListPage> {
  List<Record> notes = []; // 메모 목록을 저장하는 리스트입니다.

  // @override
  // void initState() {
  //   super.initState();
  //   _loadNotes(); // 앱이 시작될 때 저장된 메모를 불러옵니다.
  // }

  // // SharedPreferences에서 메모 데이터를 불러오는 메서드입니다.
  // void _loadNotes() async {
  //   final prefs =
  //       await SharedPref.getInstance(); // SharedPreferences 인스턴스를 가져옵니다.
  //   final String? notesString = prefs.getString('notes'); // 저장된 메모 데이터를 불러옵니다.
  //   if (notesString != null) {
  //     // 불러온 메모 데이터를 JSON 리스트에서 Record 객체 리스트로 변환합니다.
  //     setState(() {
  //       notes = List<Record>.from(
  //           json.decode(notesString).map((data) => Record.fromJson(data)));
  //     });
  //   }
  // }

  // // 메모 데이터를 SharedPreferences에 저장하는 메서드입니다.
  // void _saveNotes() async {
  //   final prefs =
  //       await SharedPreferences.getInstance(); // SharedPreferences 인스턴스를 가져옵니다.
  //   final String notesString = json.encode(
  //       notes.map((note) => note.toJson()).toList()); // 메모 리스트를 JSON으로 변환합니다.
  //   await prefs.setString('notes', notesString); // 변환된 JSON 데이터를 저장합니다.
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'), // AppBar의 제목을 설정합니다.
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text(
                'No notes available', // 메모가 없을 경우 표시되는 메시지입니다.
                style: TextStyle(fontSize: 18), // 메시지의 스타일을 설정합니다.
              ),
            )
          : ListView.builder(
              itemCount: notes.length, // 메모 개수에 따라 리스트 아이템 수를 결정합니다.
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index].record1), // 메모의 제목을 리스트 아이템에 표시합니다.
                  onTap: () async {
                    final editedNote = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteEditPage(
                            note: notes[index]), // 메모 수정 화면으로 이동합니다.
                      ),
                    );
                    if (editedNote != null) {
                      setState(() {
                        notes[index] = editedNote; // 수정된 메모를 리스트에 반영합니다.
                        // _saveNotes(); // 메모 수정 후 저장합니다.
                      });
                    }
                  },
                  onLongPress: () async {
                    // 메모를 길게 누르면 삭제 확인 대화상자를 표시합니다.
                    bool? shouldDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text('Delete Record'), // 대화상자의 제목을 설정합니다.
                          content: const Text(
                              'Are you sure you want to delete this note?'), // 대화상자의 내용을 설정합니다.
                          actions: [
                            TextButton(
                              child: const Text('Cancel'), // 취소 버튼을 추가합니다.
                              onPressed: () => Navigator.of(context)
                                  .pop(false), // 취소 시 false 반환
                            ),
                            TextButton(
                              child: const Text('Delete'), // 삭제 버튼을 추가합니다.
                              onPressed: () => Navigator.of(context)
                                  .pop(true), // 삭제 확인 시 true 반환
                            ),
                          ],
                        );
                      },
                    );

                    if (shouldDelete == true) {
                      setState(() {
                        notes.removeAt(index); // 메모를 리스트에서 삭제합니다.
                        // _saveNotes(); // 메모 삭제 후 저장합니다.
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Record deleted")), // 메모가 삭제되었음을 알리는 메시지 표시
                      );
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), // 추가 버튼 아이콘을 표시합니다.
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NoteEditPage(), // 새 메모 작성 화면으로 이동합니다.
            ),
          );
          if (newNote != null) {
            setState(() {
              notes.add(newNote); // 새로 작성된 메모를 리스트에 추가합니다.
              // _saveNotes(); // 새 메모 추가 후 저장합니다.
            });
          }
        },
      ),
    );
  }
}
