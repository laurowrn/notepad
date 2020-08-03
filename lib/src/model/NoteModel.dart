class NoteModel{
  String title;
  String body;
  int id;
  NoteModel({this.title, this.body, this.id});

  factory NoteModel.fromMap(Map json){
    return NoteModel(
        title: json["title"],
        body: json["body"],
        id: json["id"]
    );
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> map = Map<String, dynamic>();
    map["title"] = this.title;
    map["body"] = this.body;

    if( this.id != null ){
      map["id"] = this.id;
    }

    return map;
  }

}