import 'package:flutter/material.dart';

//①Form用の構造体を用意
class FormData {
  //typeの初期値
  String type = "en";
  String word = "";
}

class InputForm extends StatefulWidget {
  InputForm();

  @override
  MyInputFormState createState() => MyInputFormState();
}

class MyInputFormState extends State<InputForm> {
  FormData data = FormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ワード登録'),
        //②保存用のボタンを設定
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //本来保存処理が入るはずだが今はまだ画面を閉じる機能だけ
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        //③Formを設定
        child: Form(
          //④Formは複数ウィジェットの組み合わせなのでListViewを利用
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              //⑤英和用Radioボタン
              RadioListTile(
                value: "en",
                //data構造体を利用して和英と状態を共有
                groupValue: data.type,
                //ラジオボタン横に表示されるテキスト
                title: Text("英和"),
                onChanged: (String value) {
                  //変更時のイベント挙動
                  setState(
                    () {
                      //構造体のtypeの値をvalue(en)に設定
                      data.type = value;
                    },
                  );
                },
              ),
              //⑥和英用Radioボタン
              RadioListTile(
                value: "ja",
                groupValue: data.type,
                title: Text("和英"),
                onChanged: (String value) {
                  setState(
                    () {
                      data.type = value;
                    },
                  );
                },
              ),

//////////////////////////////////////////////
              //⑦ワード入力用テキストフィールド
              TextFormField(
                //テキストフィールドのデコレーション
                decoration: InputDecoration(
                  icon: Icon(Icons.library_books),
                  hintText: 'ワード',
                  labelText: 'word',
                ),
                //保存時のイベント挙動
                onSaved: (String value) {
                  setState(
                    () {
                      data.word = value;
                    },
                  );
                },
                //バリデーション時の挙動
                validator: (value) {
                  if (value.isEmpty) {
                    return 'ワードは必須入力項目です';
                  }
                  //バリデーションクリアのときはreturn nullしないとワーニング
                  return null;
                },
                initialValue: data.word,
              ),
//////////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
