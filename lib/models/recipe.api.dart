import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:receipe_app/models/recipe.dart';

//var options = {
//  method: 'GET',
// url: 'https://yummly2.p.rapidapi.com/feeds/list',
//  params: {limit: '18', start: '0'},
//  headers: {
//    'x-rapidapi-host': 'yummly2.p.rapidapi.com',
//    'x-rapidapi-key': '0907284862msh6a1d4dfbb2ce5a1p114e25jsn74a86cb9c610'
//  }
//};

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "0907284862msh6a1d4dfbb2ce5a1p114e25jsn74a86cb9c610",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(_temp);
  }
}
