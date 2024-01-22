class Recipes {
  String? title;
  String? image;
  String? MealType;
  int? calories;

  int? serving;
  int? prepare;
  String? Description;
  Recipes.fromJson(Map<String, dynamic> data) {
    title = data["title"];
    image = data["image"];
    MealType = data["MealType"];
    calories = data["calories"];
    prepare = data["prepare"];
    serving = data["serving"];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "MealType": MealType,
      "calories": calories,
      "prepare": prepare,
      "serving": serving
    };
  }
}
