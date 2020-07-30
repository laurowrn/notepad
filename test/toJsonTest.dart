import 'package:flutter_test/flutter_test.dart';
import 'package:notepad/src/model/NoteModel.dart';

void main(){
  test("Test if a object can transform into Json", (){
    NoteModel noteModel = NoteModel(title: "Meu nome", body: "Lauro W.N.");
    expect(NoteModel(title: "Meu nome", body: "Lauro W.N.").toJson(),
        {
          "title": "Meu nome",
          "body": "Lauro W.N."
        }
        );
  });

  test("Test if a json object can transform into a Object", (){
    var json = {"title": "0", "body": "1"};
    String title = NoteModel.fromJson(json).title;
    String body = NoteModel.fromJson(json).body;

    expect(title, "0");
    expect(body, "1");
  });
}