import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/screens/all_news_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:news_app/widgets/card/news_card_row.dart';
import 'package:news_app/widgets/tile/category_tile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // image slider index
  int activeSliderIndex = 0;

  List<CategoryModel> categories = [];
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];
  bool isLoading = true; // news loading

  @override
  void initState() {
    categories = getCategories();
    getSliders();
    getNews();
    super.initState();
  }

  // get the news heading for image sliders
  void getSliders() async {
    SliderData slider = SliderData();
    await slider.getSliders();
    sliders = slider.sliders;
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

  // check internet connectivity
  void checkInternetConnection() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Row(
          children: [
            Text(
              "Quick",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "News App",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // news categories below appbar
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTitle(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(
                                    categoryTitle:
                                        categories[index].categoryName!,
                                  ),
                                ),
                              );
                            },
                            image: categories[index].imageUrl.toString(),
                            categoryName:
                                categories[index].categoryName.toString(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Breaking News",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade300,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AllNewsScreen(
                                  news: "Breaking",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // image slider
                    CarouselSlider.builder(
                      itemCount: 5,
                      options: CarouselOptions(
                        height: 200,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeSliderIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIndex) {
                        String? imageURL = sliders[index].urlToImage;
                        String? name = sliders[index].title;

                        return buildImage(
                          imageURL!,
                          index,
                          name!,
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    // dot indicators
                    Center(
                      child: buildDotIndicator(),
                    ),
                    const SizedBox(height: 20),
                    // title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Most Trending",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w600,
                            color: Colors.purple.shade300,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AllNewsScreen(
                                  news: "Trending",
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return NewsCardRow(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                    imageUrl: articles[index].urlToImage!,
                                    title: articles[index].title!,
                                    description: articles[index].description!,
                                  ),
                                ),
                              );
                            },
                            imageUrl: articles[index].urlToImage!,
                            title: articles[index].title!,
                            description: articles[index].description!,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildImage(String imageUrl, int index, String name) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 250,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDotIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeSliderIndex,
      count: 5,
      effect: WormEffect(
        dotWidth: 12,
        dotHeight: 6,
        dotColor: Colors.grey.shade400,
        activeDotColor: Colors.blue,
      ),
    );
  }
}
