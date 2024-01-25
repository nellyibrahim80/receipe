class Ingredient {
  String? id;
  String? name;
  String? img_url;
  List<String>? user_ids=[];

  Ingredient.fromJson(Map<String, dynamic> data, [String? dbId]){
    id = dbId;
    name = data["name"];
    img_url = data["img_url"];
    user_ids = data["user_ids"] != null
        ? List<String>.from(data['user_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String,dynamic> toJson(){
    return {"name": name, "img_url": img_url, "user_ids": user_ids};

  }
}

