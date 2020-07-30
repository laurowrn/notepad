import 'package:notepad/src/provider/ListProvider.dart';
import 'package:provider/provider.dart';

class WritingPageBloc{
  void validatePage(String title, String body, int index, context){
    if(index != -1){
      title = Provider.of<ListProvider>(context, listen: false).notes[index].title;
      body = Provider.of<ListProvider>(context, listen: false).notes[index].body;
    }
  }
}