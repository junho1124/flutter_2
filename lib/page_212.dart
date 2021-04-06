import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_appds/image_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '카카오 T',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        centerTitle: true,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(label: '홈', icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: '이용 서비스', icon: Icon(Icons.assessment)),
          BottomNavigationBarItem(
              label: '내정보', icon: Icon(Icons.account_circle))
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final dummyItems = [
    'https://newsimg.sedaily.com/2021/03/02/22JNI0BLJ4_1.jpg',
    'https://pbs.twimg.com/media/ELbI9xNUwAEA6ZA.jpg',
    'https://i.ytimg.com/vi/V343XU9mIU8/maxresdefault.jpg',
    'https://file.mk.co.kr/meet/neds/2019/09/image_readtop_2019_733188_15686182793901764.png'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _biuildTop(),
        _biuildMiddle(),
        _biuildBottom(),
      ],
    );
  }

  Widget _biuildTop() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageText('https://img.icons8.com/ios/452/taxi.png', '택시'),
            ImageText('https://img.icons8.com/ios/452/bus.png', '버스'),
            ImageText('https://i.pinimg.com/originals/23/ef/33/23ef33c7af0907557d07c6c9d10385e8.png', '기차'),
            ImageText('https://img.icons8.com/ios/452/taxi.png', '비행기'),
          ],
        ),
        SizedBox(
          height: 20,
        ), // 공백의 박스 하나를 삽입하여 크기를 지정하는 위젯.
        Row(
          // Column 들을 Row 로 감싼다.
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ImageText('https://img.icons8.com/ios/452/taxi.png', '택시'),
            ImageText('https://img.icons8.com/ios/452/taxi.png', '택시'),
            ImageText('https://img.icons8.com/ios/452/taxi.png', '택시'),
            SizedBox(
              width: 80,
              height: 80,
            ),
          ],
        ),
      ],
    );
  }

  Widget _biuildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0, //s 높이 400
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ),
      items: dummyItems.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }

  Widget _biuildBottom() {
    final items = List.generate(10, (i) {
      return ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[이벤트] 이것은 공지사항입니다.'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(), // 이 리스트의 스크롤을 금지
      shrinkWrap: true, // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정 해야 함
      children: items,
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("클릭 되었습니다."),
          content: new Text("화면을 닫아 주셔도 됩니다."),
          actions: <Widget>[
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '이용서비스',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '내 정보',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
