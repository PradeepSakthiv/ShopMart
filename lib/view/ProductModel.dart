import 'package:flutter/material.dart';

import 'const.dart';

class ProductModel {
  final String name;
  final double price;
  final String desc;
  final Color color;
  final String brand;
  final String imgPath;

  ProductModel({
    required this.name,
    required this.price,
    required this.desc,
    required this.color,
    required this.brand,
    required this.imgPath,
  });

  static List<ProductModel> list = [
    ProductModel(
      name: "Apple AirPods Pro",
      desc:
          "Familiar but always fresh, the iconic Air Jordan 1 is remastered for "
              "today's sneakerhead culture. This Retro High OG version goes all "
              "in with full-grain leather, comfortable cushioning and classic "
              "design details.",
      price: 10000,
      color: AppColors.redColor,
      brand: "Apple",
      imgPath: "airpod.png",
    ),
    ProductModel(
      name: "Nike Air Jordan",
      desc:
      "Familiar but always fresh, the iconic Air Jordan 1 is remastered for "
          "today's sneakerhead culture. This Retro High OG version goes all "
          "in with full-grain leather, comfortable cushioning and classic "
          "design details.",
      price: 3000,
      color: AppColors.blueColor,
      brand: "Nike",
      imgPath: "addidas.png",
    ),
    ProductModel(
      name: "Mi SunGlass",
      desc:
          "Familiar but always fresh, the iconic Air Jordan 1 is remastered "
              "for today's sneakerhead culture. This Retro High OG version "
              "goes all in with full-grain leather, comfortable cushioning "
              "and classic design details.",
      price: 1600,
      color: AppColors.yellowColor,
      brand: "Converse",
      imgPath: "rolex.png",
    ),
    ProductModel(
      name: "Apple AirPods Pro",
      desc:
      "Familiar but always fresh, the iconic Air Jordan 1 is remastered for "
          "today's sneakerhead culture. This Retro High OG version goes all "
          "in with full-grain leather, comfortable cushioning and classic "
          "design details.",
      price: 10000,
      color: AppColors.redColor,
      brand: "Apple",
      imgPath: "airpod.png",
    ),

  ];

  static List<String> typeList = [
    "Bag", "T-Shirt","Jacket","V-Shirt",
    "Jewel","Bangle", "Ring", "Bangles",
    "Hard Disk","SSD", "Ring", "Bangles",
    "Hard Disk","SSD", "Ring", "Bangles",
    "Hard Disk","SSD", "Ring", "Bangles",
  ];
}
