class Recipes {
  String? id;
  String? title;
  String? image;
  String? MealType;
  int? calories;
  int? serving;
  int? prepare;
  String? Description;
  List<String>? ingredient;
  List<String>? favourite_users_ids;

  Recipes.fromJson(Map<String, dynamic> data,[String? docId]) {
    id=docId;
    title = data["title"];
    image = data["image"];
    MealType = data["MealType"];
    calories = data["calories"];
    prepare = data["prepare"];
    serving = data["serving"];
    ingredient = data['ingredients'] != null
        ? List<String>.from(data['ingredient'].map((e) => e.toString()))
        : null;
    favourite_users_ids = data['favourite_users_ids'] != null
        ? List<String>.from(
        data['favourite_users_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "MealType": MealType,
      "calories": calories,
      "prepare": prepare,
      "serving": serving,
      "ingredient": ingredient,
      "favourite_users_ids": favourite_users_ids
    };
  }
}
