import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;


class News {
  List<ArticleModel> news = [];

  final apiKey = dotenv.env['API_KEY'];

  Future<void> getNews() async {
    // // get current date in YYYY-MM-DD format using intl
    // DateTime now = DateTime.now();
    // // Format the date as YYYY-MM-DD
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    // // print(formattedDate);

    String url =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$apiKey";

    final response = await http.get(Uri.parse(url));

    final jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach(
        (article) {
          if (article['urlToImage'] != null && article['description'] != null) {
            ArticleModel articleModel = ArticleModel(
                title: article['title'],
                author: article['author'],
                description: article['description'],
                url: article['url'],
                urlToImage: article['urlToImage'],
                content: article['content']);

            news.add(articleModel);
          }
        },
      );
    }
  }
}
