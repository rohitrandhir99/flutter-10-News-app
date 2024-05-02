import 'package:flutter/material.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/services/show_category_news.dart';
import 'package:news_app/widgets/tile/categories_tile.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.categoryTitle,
  });

  final String categoryTitle;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isLoading = true;

  ShowCategoryNews showCategoryNews = ShowCategoryNews();

  List<ShowCategoryModel> categories = [];

  void getNewsCategory() async {
    await showCategoryNews.getCategories(widget.categoryTitle);
    categories = showCategoryNews.categories;

    // stop loading
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNewsCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.categoryTitle,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
            color: Colors.blue,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoriesTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailScreen(
                          imageUrl: categories[index].urlToImage!,
                          title: categories[index].title!,
                          description: categories[index].description!,
                        ),
                      ),
                    );
                  },
                  imageUrl: categories[index].urlToImage!,
                  title: categories[index].title!,
                  description: categories[index].description!,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
