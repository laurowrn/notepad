import 'package:flutter/material.dart';
import 'package:notepad/src/model/NoteModel.dart';
import 'package:notepad/src/repository/FileRepository.dart';

class ListProvider extends ChangeNotifier{
  List<NoteModel> notes = [];
  FileRepository fileRepository = FileRepository();

  void addNote(String title, String body){
    notes.add(NoteModel(title: title, body: body));
    fileRepository.saveToFile(notes);
    notifyListeners();
  }

  void insertNote(NoteModel note, int index){
    notes.insert(index, note);
    fileRepository.saveToFile(notes);
    notifyListeners();
  }

  void removeNote(int index){
    notes.removeAt(index);
    fileRepository.saveToFile(notes);
    notifyListeners();
  }

  void getStartNotes()async{
    notes = await fileRepository.getFromFile();
    notifyListeners();
  }


}