import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stage/models/product.dart';
import 'package:flutter_stage/utilities/constants.dart';
import 'package:http/http.dart' as http;

class ApiInstance {
  Future<List<dynamic>> getAllProducts() async {
    List allProducts = [];

    try {
      http.Response response =
          await http.get(Uri.parse(baseUrl + "products"), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
      }).then((response) async {
        allProducts = json
            .decode(response.body)
            .map((data) => ProductModel.fromJson(data))
            .toList();

        return response;
      });
    } catch (err) {
      print(err);
      return allProducts;
    }

    return allProducts;
  }

  Future<List<dynamic>> getPromo() async {
    List all = await getAllProducts();

    all.removeWhere(
        (element) => element.promotion.toString().toLowerCase() != "promo");

    all.shuffle();
    return all;
  }

  Future<List<dynamic>> getPcPortable() async {
    List all = await getAllProducts();

    all.removeWhere((element) =>
        element.categorie.toString().toLowerCase() != 'pc portable');
    all.shuffle();
    return all;
  }

  Future<List<dynamic>> getPcGamer() async {
    List all = await getAllProducts();
    List list = [];
    for (var i = 0; i < all.length; i++) {
      if ((all[i].categorie.toString().toLowerCase()) == 'pc gamer' ||
          (all[i].categorie.toString().toLowerCase()) ==
              'ordinateur portable gamer') {
        list.add(all[i]);
      }
    }
    list.shuffle();
    return list;
  }

  Future<List<dynamic>> getMac() async {
    List all = await getAllProducts();
    List list = [];
    for (var i = 0; i < all.length; i++) {
      if ((all[i].categorie.toString().toLowerCase()) == 'mac' ||
          (all[i].categorie.toString().toLowerCase()) == "apple macbook") {
        list.add(all[i]);
      }
    }
    list.shuffle();
    return list;
  }

  Future<List<dynamic>> getPcPro() async {
    List all = await getAllProducts();
    List list = [];
    for (var i = 0; i < all.length; i++) {
      if ((all[i].categorie.toString().toLowerCase()) == 'pc portable pro' ||
          (all[i].categorie.toString().toLowerCase()) == 'pc portable pro ') {
        list.add(all[i]);
      }
    }
    list.shuffle();
    return list;
  }

  Future<dynamic>? getData(String tag) {
    if (tag == "pc portable") {
      return getPcPortable();
    } else if (tag == 'pc gamer') {
      return getPcGamer();
    } else if (tag == 'apple macbook') {
      return getMac();
    } else if (tag == 'pc portable pro') {
      return getPcPro();
    }
  }

  Future<List<dynamic>> search(String key) async {
    List allProducts = [];

    try {
      http.Response response = await http
          .get(Uri.parse(baseUrl + "products/search/" + key), headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
      }).then((response) async {
        allProducts = json
            .decode(response.body)
            .map((data) => ProductModel.fromJson(data))
            .toList();

        return response;
      });
    } catch (err) {
      print(err);
      return allProducts;
    }

    return allProducts;
  }
}
