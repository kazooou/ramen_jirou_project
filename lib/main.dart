import 'package:flutter/material.dart';

// 公式版①
//import 'package:firebase_admob/firebase_admob.dart';
// 非公式②
//import 'package:admob_flutter/admob_flutter.dart';
// 非公式③
//import 'package:flutter_native_admob/flutter_native_admob.dart';
// 非公式４
import 'package:flutter_google_ad_manager/flutter_google_ad_manager.dart';

import 'dart:io';
import 'package:share/share.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primarySwatch: Colors.yellow,
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {

  String _men = null;
  String _yasai = null;
  String _seabura = null;
  String _tare = null;
  String _ninniku = null;
  List<String> _mens = new List<String>();
  List<String> _yasais = new List<String>();
  List<String> _seaburas = new List<String>();
  List<String> _tares = new List<String>();
  List<String> _ninnikus = new List<String>();

  String _jumon = "";

  @override
  void initState() {


    _mens.addAll({"なし","少なめ","普通","多め","非常に多め","極めて多め"});
    _yasais.addAll({"なし","少なめ","普通","多め","非常に多め","極めて多め"});
    _seaburas.addAll({"なし","少なめ","普通","多め","非常に多め","極めて多め"});
    _tares.addAll({"なし","少なめ","普通","多め","非常に多め","極めて多め"});
    _ninnikus.addAll({"なし","少なめ","普通","多め","非常に多め","極めて多め"});

    _men = _mens.elementAt(2);
    _yasai = _yasais.elementAt(2);
    _seabura = _seaburas.elementAt(2);
    _tare = _tares.elementAt(2);
    _ninniku = _ninnikus.elementAt(0);


    /* 公式版①
    // firebaseAdmob インスタンスを初期化
    if (Platform.isAndroid) {
      // Androidの場合
      FirebaseAdMob.instance.initialize(appId: "ca-app-pub-4499819044057258~9602224321");
    } else {
      // iOSの場合
      FirebaseAdMob.instance.initialize(appId: "ca-app-pub-4499819044057258~4398019496");
    }
     */

    // バナー広告を表示する
    /* 公式版①
    myBanner..load()..show(
      // topからのオフセットで表示位置を決定
      anchorOffset: 0,
      anchorType: AnchorType.bottom,
    );
*/
    /* 非公式③
    final _nativeAdmob = NativeAdmob();
    if (Platform.isAndroid) {
      // Androidの場合
      _nativeAdmob.initialize(appID: "ca-app-pub-4499819044057258~9602224321");
    } else {
      // iOSの場合
      _nativeAdmob.initialize(appID: "ca-app-pub-4499819044057258~4398019496");
    }

     */



  }

  void _onMenChanges(String value) {
    setState((){
      _men = value;
    });
  }
  void _onYasaiChanges(String value) {
    setState((){
      _yasai = value;
    });
  }
  void _onSeaburaChanges(String value) {
    setState((){
      _seabura = value;
    });
  }
  void _onTareChanges(String value) {
    setState((){
      _tare = value;
    });
  }
  void _onNinnikuChanges(String value) {
    setState((){
      _ninniku = value;
    });
  }

  void _play() {
    setState(() {
      _jumon = _generate();
    });

  }

  String _generate() {


    // 普通の場合
    if ( (_men == "普通") &&
        (_yasai == "普通") &&
        (_seabura == "普通") &&
        (_tare == "普通") &&
        (_ninniku == "普通") ){
      return "ソノママ";
    }

    // 全部MAXの場合
    if ( (_men == "極めて多め") &&
        (_yasai == "極めて多め") &&
        (_seabura == "極めて多め") &&
        (_tare == "極めて多め") &&
        (_ninniku == "極めて多め") ){
      return "チョモランマ";
    }

    String _jumon = "";
    var youso = [_men, _yasai, _seabura, _tare, _ninniku];
    var items = ["メン","ヤサイ","アブラ","カラメ","ニンニク"];
    for (int i = 0; i <= 4; i++) {
      switch (i) {
        case 0:
        case 1:
        case 2:
        case 3:
          if (youso[i] != "普通") {
            _jumon = _jumon + items[i];
          }
          if (youso[i] != youso[i+1]) {
            _jumon = _jumon + henkan(youso[i]);
          }
          break;

        case 4: // ニンニク
          if (youso[i] != "普通") {
            _jumon = _jumon + items[i];
          }
          _jumon = _jumon + henkan(youso[i]);
          break;

      }
    }


    return _jumon;



  }


  String henkan(String value) {
    if (value == "なし") return "ナシ";
    if (value == "少なめ") return "スクナメ";
    if (value == "普通") return "";
    if (value == "多め") return "マシ";
    if (value == "非常に多め") return "マシマシ";
    if (value == "極めて多め") return "チョモランマ";

  }

  void _openModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          // ModalBottomSheet を押した時のイベントを捕まえるために
          // GestureDetector でラップする
          return new GestureDetector(
              onTap: () {
                // ModalBottomSheet を押した時には何もしないようにする
              },
              child: new Container(
                // ModalBottomSheet のどこを押してもラップした GestureDetector が
                // 検知できるように、ラップした Container には色をつけておく
                  color: Colors.white,
//                  padding: const EdgeInsets.all(16.0),
                  child: new Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
//                        leading: Icon(Icons.music_note),
                        title: Text('このアプリを友達に教える'),
                        onTap: () => {
                          Share.share("AppStoreで #ヘイ二郎 を検索 https://apple.co/2kaEKbz"),
                          Navigator.of(context).pop(1),
                        },
                      ),
                      ListTile(
//                        leading: Icon(Icons.videocam),
                        title: Text('注文内容を共有する'),
                        onTap: () => {
                          Share.share("ニンニク入れますか？「" + _jumon + "」 https://apple.co/2kaEKbz"),
                          Navigator.of(context).pop(2),

                        },
                      ),
                    ],
                  )));
        });
  }


  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("ヘイ二郎"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                _openModalBottomSheet();
              },
            )
          ]
      ),
      body:
      SafeArea(
        child:
        SingleChildScrollView(
          child:
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //                     AdmobBanner(
                //                       adUnitId: getBannerAdUnitId(),
                //                       adSize: AdmobBannerSize.LARGE_BANNER,
                //                     ),
                // 非公式③
//                      NativeAdmobBannerView(
//                        adUnitID: getBannerAdUnitId(),
//                        style: BannerStyle.dark, // enum dark or light
//                        showMedia: true, // whether to show media view or not
//                        contentPadding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0), // content padding
//                      ),
                // 非公式４
                DFPBanner(
                  isDevelop: false,
                  adUnitId: getBannerAdUnitId(),
                  adSize: DFPAdSize.SMART_BANNER,
                ),
                Center(
                  child:
                  Text(
                    "ニンニク入れますか？",
                    style: TextStyle(fontSize:  25.0,),
                  ),

                ),
                Text(
                  _jumon,
                  style: TextStyle(fontSize: 34.0),
                ),

                Text(
                    "麺"
                ),
                new DropdownButton(
                  value: _men,
                  isExpanded: true,
                  items: _mens.map((String value){
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        children: <Widget>[
                          new Text("${value}")
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value){_onMenChanges(value);},
                ),
                SizedBox(height: 20),
                Text(
                    "野菜"
                ),
                new DropdownButton(
                  value: _yasai,
                  isExpanded: true,
                  items: _yasais.map((String value){
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        children: <Widget>[
                          new Text("${value}")
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value){_onYasaiChanges(value);},
                ),
                SizedBox(height: 20),
                Text(
                    "背脂"
                ),
                new DropdownButton(
                  value: _seabura,
                  isExpanded: true,
                  items: _seaburas.map((String value){
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        children: <Widget>[
                          new Text("${value}")
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value){_onSeaburaChanges(value);},
                ),
                SizedBox(height: 20),
                Text(
                    "スープのたれ"
                ),
                new DropdownButton(
                  value: _tare,
                  isExpanded: true,
                  items: _tares.map((String value){
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        children: <Widget>[
                          new Text("${value}")
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value){_onTareChanges(value);},
                ),
                SizedBox(height: 20),
                Text(
                    "ニンニク"
                ),
                new DropdownButton(
                  value: _ninniku,
                  isExpanded: true,
                  items: _ninnikus.map((String value){
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        children: <Widget>[
                          new Text("${value}")
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value){_onNinnikuChanges(value);},
                ),
              ]
          ),


        ),
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: _play,
          tooltip: 'Increment',
          child: Icon(Icons.play_arrow)
      ),
    );

  }


}

// 広告ターゲット
/* 公式版①のロジック
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['flutterio', 'beautiful apps'],
  contentUrl: 'https://flutter.io',
  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender: MobileAdGender.male,
  testDevices: <String>[],
);


BannerAd myBanner = BannerAd(
  // テスト用のIDを使用
  // リリース時にはIDを置き換える必要あり
  adUnitId: getAdUnitId() ,
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);



String getAdUnitId() {
  if (Platform.isAndroid) {
    // Androidの場合
    return "ca-app-pub-4499819044057258/2378340425";
  } else {
    // iOSの場合
    return "ca-app-pub-4499819044057258/5874752695";
  }

}
*/

// デバッグモードかどうかを判定する関数
bool isDebug() {
  var isDebug = false;
  assert(isDebug = true);
  if (isDebug) {
    return true;
  } else {
    return false;
  }
}

String getBannerAdUnitId() {
  if (isDebug()) {
    // デバッグ用テスト広告ID
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
  }


  if (Platform.isIOS) {
    return 'ca-app-pub-4499819044057258/5874752695';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-4499819044057258/2378340425';
  }
  return null;
}

