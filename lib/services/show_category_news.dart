import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  final apiKey = dotenv.env['API_KEY'];

  Future<void> getCategories(String category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$apiKey";

    final response = await http.get(Uri.parse(url));

    final jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (article) {
          if (article['urlToImage'] != null && article['description'] != null) {
            ShowCategoryModel categoryModel = ShowCategoryModel(
                title: article['title'],
                author: article['author'],
                description: article['description'],
                url: article['url'],
                urlToImage: article['urlToImage'],
                content: article['content']);

            categories.add(categoryModel);
          }
        },
      );
    }
  }
}
