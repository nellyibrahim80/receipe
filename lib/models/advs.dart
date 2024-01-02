class Advs {

  String? image;
  String? title;

  Advs();

  Advs.fromJson(Map<String, dynamic> data){
    title = data["title"];
    image = data["image"];
  }

  Map<String, dynamic> toJson() {
    return { "image": image, "title": title};
  }
}