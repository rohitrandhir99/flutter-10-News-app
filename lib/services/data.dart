import 'package:news_app/models/category_model.dart';

List<CategoryModel> getCategories() {
  CategoryModel categoryModel = CategoryModel();
  // category list
  List<CategoryModel> category = [];

  // business
  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = "assets/images/business.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  // entertainment
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = "assets/images/entertainment.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  // entertainment
  categoryModel.categoryName = "General";
  categoryModel.imageUrl = "assets/images/general.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  // health
  categoryModel.categoryName = "Health";
  categoryModel.imageUrl = "assets/images/health.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  // science & technology
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "assets/images/science.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  // sports
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = "assets/images/sports.jpg";
  category.add(categoryModel);
  categoryModel = CategoryModel();

  return category;
}
