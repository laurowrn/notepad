class NoteModel{
  String title;
  String body;
  NoteModel({this.title, this.body});

  factory NoteModel.fromJson(Map json){
    return NoteModel(
        title: json["title"],
        body: json["body"],
    );
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["title"] = this.title;
    data["body"] = this.body;
    return data;
  }

}