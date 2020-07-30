import 'package:flutter/material.dart';
import 'package:notepad/src/provider/ListProvider.dart';
import 'package:notepad/src/view/WritingPage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  void initState() {
    super.initState();
    Provider.of<ListProvider>(context, listen: false).getStartNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(
            Icons.open_in_browser,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () async{
            if(await canLaunch("https://www.youtube.com/watch?v=9Mr-1Tg6IKI")){
              launch("https://www.youtube.com/watch?v=9Mr-1Tg6IKI");
            }
            else{
              print("Erro");
            }
          },
        ),
        centerTitle: true,
        title: Text(
          "Notepad",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Staatliches',
              fontSize: 30
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.note_add,
              color: Colors.black,
              size: 30,
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WritingPage()));
            },
          )
        ],
      ),
      body: Consumer<ListProvider>(
          builder: (context, list, widget){
            return list.notes.isEmpty ?
            Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Para criar notas clique em  ",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 20
                        ),
                      ),
                      Icon(
                          Icons.note_add,
                          color: Colors.black38,
                      )
                    ],
                  ),
                ),
            ) :
            ListView.builder(
                itemCount: list.notes.length,
                itemBuilder: (context, index){
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction){
                      var removedNote = list.notes[index];
                      var lastIndex = index;
                      Provider.of<ListProvider>(this.context, listen: false).removeNote(index);
                      print(lastIndex);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Nota removida"),
                            action: SnackBarAction(
                              label: "Desfazer",
                              onPressed: (){
                                print(lastIndex);

                                Provider.of<ListProvider>(this.context, listen: false).insertNote(removedNote, lastIndex);
                              },
                            ),
                            duration: Duration(seconds: 3),
                          ),
                      );
                    },

                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                      child: Container(
                        height: 90,
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WritingPage(index: index)));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              color: Color.fromRGBO(0, 0, 0, 0.01),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    list.notes[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        fontFamily: "NotoSansSC"
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                              )
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          },
      ),
    );
  }
}
