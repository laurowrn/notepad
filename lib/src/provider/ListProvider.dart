import 'package:flutter/material.dart';
import 'package:notepad/src/model/NoteModel.dart';
import 'package:notepad/src/repository/DatabaseRepository.dart';

class ListProvider extends ChangeNotifier{
  List<NoteModel> notes = List<NoteModel>();
  DatabaseRepository databaseRepository = DatabaseRepository();

  void addNote(String title, String body, {int id})async{
    if(id == null){
      databaseRepository.saveNote(NoteModel(title: title, body: body));
    }
    else{
      databaseRepository.saveNote(NoteModel(title: title, body: body, id: id));
    }
    notes = await databaseRepository.recoverNotes();
    notifyListeners();
  }

  void updateNote(NoteModel note)async{
    databaseRepository.updateNote(note);
    notes = await databaseRepository.recoverNotes();
    notifyListeners();
  }

  void removeNote(int index)async{
    databaseRepository.removeNote(index);
    notes = await databaseRepository.recoverNotes();
    notifyListeners();
  }

  void getStartNotes()async{
    notes = await databaseRepository.recoverNotes();
    notifyListeners();
  }

  Future<NoteModel> getNote(int id)async{
    return await databaseRepository.getNote(id);
  }


}