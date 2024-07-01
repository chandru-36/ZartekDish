// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

List<ItemModel> itemModelFromJson(String str) => List<ItemModel>.from(json.decode(str).map((x) => ItemModel.fromJson(x)));

String itemModelToJson(List<ItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemModel {
    final String? restaurantId;
    final List<TableMenuList>? tableMenuList;

    ItemModel({
        this.restaurantId,
        this.tableMenuList,
    });

    factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        restaurantId: json["restaurant_id"],
        tableMenuList: json["table_menu_list"] == null ? [] : List<TableMenuList>.from(json["table_menu_list"]!.map((x) => TableMenuList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "table_menu_list": tableMenuList == null ? [] : List<dynamic>.from(tableMenuList!.map((x) => x.toJson())),
    };
}

class TableMenuList {
    final String? menuCategory;
    final String? menuCategoryId;
    final List<CategoryDish>? categoryDishes;

    TableMenuList({
        this.menuCategory,
        this.menuCategoryId,
        this.categoryDishes,
    });

    factory TableMenuList.fromJson(Map<String, dynamic> json) => TableMenuList(
        menuCategory: json["menu_category"],
        menuCategoryId: json["menu_category_id"],
        categoryDishes: json["category_dishes"] == null ? [] : List<CategoryDish>.from(json["category_dishes"]!.map((x) => CategoryDish.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "menu_category": menuCategory,
        "menu_category_id": menuCategoryId,
        "category_dishes": categoryDishes == null ? [] : List<dynamic>.from(categoryDishes!.map((x) => x.toJson())),
    };
}

class CategoryDish {
    final String? dishId;
    final String? dishName;
    final String? dishImage;
    final String? dishDescription;
    final String? nexturl;
    final num? dishType;
    final num? dishCalories;
    final num? dishPrice;
    final List<AddonCat>? addonCat;
    int? count;

    CategoryDish({
        this.dishId,
        this.dishName,
        this.dishImage,
        this.dishDescription,
        this.nexturl,
        this.dishType,
        this.dishCalories,
        this.dishPrice,
        this.addonCat,
        this.count,
    });

    factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"],
        dishName: json["dish_name"],
        dishImage: json["dish_image"],
        dishDescription: json["dish_description"],
        nexturl: json["nexturl"],
        dishType: json["dish_Type"],
        dishCalories: json["dish_calories"],
        dishPrice: json["dish_price"],
        addonCat: json["addonCat"] == null ? [] : List<AddonCat>.from(json["addonCat"]!.map((x) => AddonCat.fromJson(x))),
        count: json["count"] ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "dish_id": dishId,
        "dish_name": dishName,
        "dish_image": dishImage,
        "dish_description": dishDescription,
        "nexturl": nexturl,
        "dish_Type": dishType,
        "dish_calories": dishCalories,
        "dish_price": dishPrice,
        "addonCat": addonCat == null ? [] : List<dynamic>.from(addonCat!.map((x) => x.toJson())),
         "count": count,
    };
}

class AddonCat {
    final String? addonCategory;

    AddonCat({
        this.addonCategory,
    });

    factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
        addonCategory: json["addon_category"],
    );

    Map<String, dynamic> toJson() => {
        "addon_category": addonCategory,
    };
}
