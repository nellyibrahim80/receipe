class Recipes {
  String? id;
  String? title;
  String? image;
  String? MealType;
  num? calories;
  int? serving;
  int? prepare;
  num? rate;
  String? Description;
  List<String>? ingredient;
  List<String>? favourite_users_ids;
  Map<String,String>? direction;
  bool? is_fresh;

  Recipes.fromJson(Map<String, dynamic> data,[String? docId]) {
    id=docId;
    title = data["title"];
    is_fresh= data["is_fresh"];
    image = data["image"];
    MealType = data["MealType"];
    calories = data["calories"];
    prepare = data["prepare"];
    serving = data["serving"];
    rate = data["rate"];
    ingredient = data['ingredient'] != null
        ? List<String>.from(data['ingredient'].map((e) => e.toString()))
        : null;
    favourite_users_ids = data['favourite_users_ids'] != null
        ? List<String>.from(
        data['favourite_users_ids'].map((e) => e.toString()))
        : null;
    direction = data['direction'] != null
        ? Map<String,String>.from(
        data['direction'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "is_fresh":is_fresh,
      "title": title,
      "image": image,
      "MealType": MealType,
      "calories": calories,
      "prepare": prepare,
      "serving": serving,
      "rate":rate,
      "ingredient": ingredient,
      "favourite_users_ids": favourite_users_ids,
      "direction":direction
    };
  }
}
