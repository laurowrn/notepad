import 'package:flutter/material.dart';
import 'package:notepad/src/bloc/WritingPageBloc.dart';
import 'package:notepad/src/model/NoteModel.dart';
import 'package:notepad/src/provider/ListProvider.dart';
import 'package:provider/provider.dart';

class WritingPage extends StatefulWidget {
  int id;

  WritingPage({this.id = -1});

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerBody = TextEditingController();

  @override
  void initState(){
    if(widget.id != -1){
      Provider.of<ListProvider>(context, listen: false).getNote(widget.id).then(
              (value) {
                _controllerTitle.text = value.title;
                _controllerBody.text = value.body;
              }
      );
    }
    print(_controllerTitle.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: (){
            showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: widget.id == -1 ? Text("Deseja salvar a anotação?") : Text("Deseja salvar as alterações?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Não"),
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("Sim"),
                      onPressed: (){

                        if(widget.id == -1){
                          Provider.of<ListProvider>(context, listen: false).addNote(
                              _controllerTitle.text.isEmpty ? "Sem titulo" : _controllerTitle.text,
                              _controllerBody.text
                          );
                        }
                        else{
                          Provider.of<ListProvider>(context, listen: false).updateNote(
                              NoteModel(title: _controllerTitle.text.isEmpty ? "Sem titulo" :
                                  _controllerTitle.text,
                                  body: _controllerBody.text,
                                  id: widget.id
                              )
                          );
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 40, 20),
          child: TextField(
            controller: _controllerTitle,
            style: TextStyle(
              fontFamily: "NotoSansSC-Regular",
              fontSize: 25,
              color: Colors.black
            ),
            decoration: InputDecoration(
              counterText: "",
              border: InputBorder.none,
              hintText: "Digite o título aqui.",
            ),
            maxLines: 1,
            maxLength: 22,
          ),
        ),
        elevation: 0.1,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextField(
          controller: _controllerBody,
          maxLines: null,
          style: TextStyle(
              fontFamily: "NotoSansSC-Regular",
              fontSize: 20,
              color: Colors.black
          ),
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            counterText: "",
            border: InputBorder.none,
            hintText: "Digite o texto aqui.",
          ),
        ),
      ),
    );
  }
}
