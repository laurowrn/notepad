import 'dart:convert';
import 'dart:io';
import 'package:notepad/src/model/NoteModel.dart';
import 'package:path_provider/path_provider.dart';

class FileRepository {

  Future<File> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }


  void saveToFile(List<NoteModel> notes) async {
    File archive = await getFilePath();
    var listToSend = notes.map((map) {
      return map.toJson();
    }
    ).toList();
    archive.writeAsString(json.encode(listToSend));
  }

  Future<List<NoteModel>> getFromFile() async {
    try {
      final archive = await getFilePath();
      String dataJson = await archive.readAsString();
      List listTemp = json.decode(dataJson);
      List<NoteModel> listToGet = listTemp.map<NoteModel>((map) {
        return NoteModel.fromJson(map);
      }
      ).toList();
      return listToGet;
    } catch (e) {
      throw(e);
    }
  }

}