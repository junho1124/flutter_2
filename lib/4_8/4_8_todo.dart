import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class Todo {
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}

//시작 클래스
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[];

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  var _todoController = TextEditingController();

  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleTodo(todo),
      title: Text(todo.title,
          style: todo.isDone
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontStyle: FontStyle.italic,
                )
              : null),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(doc),
      ),
    );
  }

  void _addTodo(Todo todo) {
    // 콜백 callback 방식
    // 웹에서는 Promise 방식
    // 콜백 지옥에 빠질 수 있다.
    CollectionReference query = FirebaseFirestore.instance.collection('todo');
    query.add({
      'title': todo.title,
      'isDone': todo.isDone,
    }).then((DocumentReference value) {
      setState(() {
        _todoController.text = '';
      });
    }).catchError((error){
      //다이얼로그 띄우기
    });
  }


  // 할일 삭제 메서드
  void _deleteTodo(DocumentSnapshot todo) {
    CollectionReference query = FirebaseFirestore.instance.collection('todo');
    query.doc(todo.id)
        .delete()
        .then((value) => print('성공'))
        .catchError((error) => print('실패'));
  }

  //할 일 완료/미완료 메서드
  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text('문자가 없습니다.'),
          content: new Text("내용을 입력 해 주세요."),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }



  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('todo');

    return Scaffold(
      appBar: AppBar(
        title: Text('남은 할 일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoController,
                  ),
                ),
                ElevatedButton(
                    child: Text('추가'),
                    onPressed: () {
                      if (_todoController.text != '') {
                        _addTodo(Todo(_todoController.text));
                      } else return _showMaterialDialog();
                    }
                    )
              ],

            ),
            StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data.docs;
                return Expanded(
                  child: ListView(
                    children: documents.map((doc) => _buildItemWidget(doc)).toList(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
