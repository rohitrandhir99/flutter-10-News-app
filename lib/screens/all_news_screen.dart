import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/widgets/tile/categories_tile.dart';

class AllNewsScreen extends StatefulWidget {
  const AllNewsScreen({
    super.key,
    required this.news,
  });

  final String news;

  @override
  State<AllNewsScreen> createState() => _AllNewsScreenState();
}

class _AllNewsScreenState extends State<AllNewsScreen> {
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    getSliders();
    getNews();
    super.initState();
  }

  // get the news heading for image sliders
  void getSliders() async {
    SliderData slider = SliderData();
    await slider.getSliders();
    sliders = slider.sliders;

    setState(() {
      isLoading = false;
    });
  }

  // get the news
  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.news} News",
          style: TextStyle(
            color:
                widget.news == "Breaking" ? Colors.red : Colors.purple.shade300,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
          ),
        ),
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue.shade500,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.news == "Breaking"
                        ? sliders.length
                        : articles.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                imageUrl: widget.news == "Breaking"
                                    ? sliders[index].urlToImage!
                                    : articles[index].urlToImage!,
                                title: widget.news == "Breaking"
                                    ? sliders[index].title!
                                    : articles[index].title!,
                                description: widget.news == "Breaking"
                                    ? sliders[index].description!
                                    : articles[index].description!,
                              ),
                            ),
                          );
                        },
                        imageUrl: widget.news == "Breaking"
                            ? sliders[index].urlToImage!
                            : articles[index].urlToImage!,
                        title: widget.news == "Breaking"
                            ? sliders[index].title!
                            : articles[index].title!,
                        description: widget.news == "Breaking"
                            ? sliders[index].description!
                            : articles[index].description!,
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
