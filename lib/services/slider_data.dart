import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/slider_model.dart';

class SliderData {
  List<SliderModel> sliders = [];

  final apiKey = dotenv.env['API_KEY'];

  Future<void> getSliders() async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";

    final response = await http.get(Uri.parse(url));

    final jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (article) {
          if (article['urlToImage'] != null && article['description'] != null) {
            SliderModel sliderModel = SliderModel(
                title: article['title'],
                author: article['author'],
                description: article['description'],
                url: article['url'],
                urlToImage: article['urlToImage'],
                content: article['content']);

            sliders.add(sliderModel);
          }
        },
      );
    }
  }
}
