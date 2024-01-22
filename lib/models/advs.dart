class Advs {
String? id;
  String? image;
  String? title;

  Advs();

  Advs.fromJson(Map<String, dynamic> data, String dbId){
    id=dbId;
    title = data["title"];
    image = data["image"];
  }

  Map<String, dynamic> toJson() {
    return { "image": image, "title": title};
  }
}