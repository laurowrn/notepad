import 'package:flutter_test/flutter_test.dart';
import 'package:notepad/src/model/NoteModel.dart';
import 'package:notepad/src/repository/DatabaseRepository.dart';

int main(){
  TestWidgetsFlutterBinding.ensureInitialized();

  DatabaseRepository databaseRepository = DatabaseRepository();
  test("database insertion", ()async{
    int teste = await databaseRepository.saveNote(NoteModel(title: "titulo", body: "body"));
    print(teste);
    //List lista = databaseRepository.recoverNotes();
  });
}