import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // 최상위 앱 MyApp 을 실생

class MyApp extends StatelessWidget { //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '폼 검증 데모',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() {
    return _BmiMainState();
  }
}

class _BmiMainState extends State<BmiMain> {

  final _formKey = GlobalKey<FormState>(); // 글로벌 키를 생성 -> 폼 안에서 검증 할 때 필
  final _heightController = TextEditingController(); // 상태변화에 관하여 사용 하고 싶을 때 설정 -> SetState()안에서 사용 되는게 일반적.
  final _weightController = TextEditingController();

  @override
  void dispose() { // 메모리에서 헤재되도록 하는 것
    _heightController.dispose();
    _weightController.dispose();
    super.dispose(); // 상속 받은 dispose를 사용 할 것이며, 수정을 할 수도 있다.
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form( // 입력 받은 창들을 한번에 정리하는 것. 이 안에 있는 검증을 마쳐야 다음 단계로 넘어갈 수 있음.
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '키',
              ),
                controller: _heightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                if (value.trim().isEmpty) {
                  return '키를 입력하세요';
                }
                return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '몸무게',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                              double.parse(_heightController.text.trim()),
                              double.parse(_weightController.text.trim()))),
                      );
                    }
                  },
                  child: Text('결과'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;


  BmiResult(this.height, this.weight);

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100));
    print('bmi : $bmi');

    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _calcBmi(bmi),
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            _buildIcon(bmi),
          ],
        ),
      ),
    );
  }
  String _calcBmi(double bmi) {
    var result = '저체중';
    if (bmi >= 35) {
      result = '고도비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  Widget _buildIcon(double bmi) {
    if (bmi >= 23) {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    } else {
     return  Icon(
       Icons.sentiment_dissatisfied,
       color: Colors.orange,
       size: 100,
     );
    }
  }
}
