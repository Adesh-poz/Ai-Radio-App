import 'dart:convert';
import 'package:flutter/foundation.dart';

class MyRadioList {
  final List<MyRadio> radios;
  MyRadioList({
    required this.radios,
  });

  MyRadioList copyWith({
    required List<MyRadio> radios,
  }) {
    return MyRadioList(
      radios: radios,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return MyRadioList(
      radios: List<MyRadio>.from(map['radios']?.map((x) => MyRadio.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) =>
      MyRadioList.fromMap(json.decode(source));

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MyRadioList && listEquals(o.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String color;
  final String desc;
  final String url;
  final String category;
  final String icon;
  final String image;
  final String lang;
  MyRadio({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.color,
    required this.desc,
    required this.url,
    required this.category,
    required this.icon,
    required this.image,
    required this.lang,
  });

  MyRadio copyWith({
    required int id,
    required int order,
    required String name,
    required String tagline,
    required String color,
    required String desc,
    required String url,
    required String category,
    required String icon,
    required String image,
    required String lang,
  }) {
    return MyRadio(
      id: id,
      order: order,
      name: name,
      tagline: tagline,
      color: color,
      desc: desc,
      url: url,
      category: category,
      icon: icon,
      image: image,
      lang: lang,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'color': color,
      'desc': desc,
      'url': url,
      'category': category,
      'icon': icon,
      'image': image,
      'lang': lang,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return MyRadio(
      id: map['id'],
      order: map['order'],
      name: map['name'],
      tagline: map['tagline'],
      color: map['color'],
      desc: map['desc'],
      url: map['url'],
      category: map['category'],
      icon: map['icon'],
      image: map['image'],
      lang: map['lang'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) =>
      MyRadio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MyRadio(id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MyRadio &&
        o.id == id &&
        o.order == order &&
        o.name == name &&
        o.tagline == tagline &&
        o.color == color &&
        o.desc == desc &&
        o.url == url &&
        o.category == category &&
        o.icon == icon &&
        o.image == image &&
        o.lang == lang;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    order.hashCode ^
    name.hashCode ^
    tagline.hashCode ^
    color.hashCode ^
    desc.hashCode ^
    url.hashCode ^
    category.hashCode ^
    icon.hashCode ^
    image.hashCode ^
    lang.hashCode;
  }
}

// import 'dart:convert';
//
// class MyRadioList{
//   final List<MyRadio> radios;
//
// //<editor-fold desc="Data Methods">
//   const MyRadioList({
//     required this.radios,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is MyRadioList &&
//           runtimeType == other.runtimeType &&
//           radios == other.radios);
//
//   @override
//   int get hashCode => radios.hashCode;
//
//   String toJson() => json.encode(toMap());
//
//   factory MyRadioList.fromJson(String source) => MyRadioList.fromMap(json.decode(source));
//
//   @override
//   String toString() {
//     return 'MyRadioList{ radios: $radios,}';
//   }
//
//   MyRadioList copyWith({
//     List<MyRadio>? radios,
//   }) {
//     return MyRadioList(
//       radios: radios ?? this.radios,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'radios': radios,
//     };
//   }
//
//   factory MyRadioList.fromMap(Map<String, dynamic> map) {
//     return MyRadioList(
//       radios: map['radios'] as List<MyRadio>,
//     );
//   }
//
// //</editor-fold>
// }
//
// class MyRadio{
//   final int id;
//   final int order;
//   final String name;
//   final String tagline;
//   final String color;
//   final String desc;
//   final String url;
//   final String category;
//   final String icon;
//   final String image;
//   final String lang;
//
// //<editor-fold desc="Data Methods">
//   const MyRadio({
//     required this.id,
//     required this.order,
//     required this.name,
//     required this.tagline,
//     required this.color,
//     required this.desc,
//     required this.url,
//     required this.category,
//     required this.icon,
//     required this.image,
//     required this.lang,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is MyRadio &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           order == other.order &&
//           name == other.name &&
//           tagline == other.tagline &&
//           color == other.color &&
//           desc == other.desc &&
//           url == other.url &&
//           category == other.category &&
//           icon == other.icon &&
//           image == other.image &&
//           lang == other.lang);
//
//   @override
//   int get hashCode =>
//       id.hashCode ^
//       order.hashCode ^
//       name.hashCode ^
//       tagline.hashCode ^
//       color.hashCode ^
//       desc.hashCode ^
//       url.hashCode ^
//       category.hashCode ^
//       icon.hashCode ^
//       image.hashCode ^
//       lang.hashCode;
//
//   @override
//   String toString() {
//     return 'MyRadio{ id: $id, order: $order, name: $name, tagline: $tagline, color: $color, desc: $desc, url: $url, category: $category, icon: $icon, image: $image, lang: $lang,}';
//   }
//
//   MyRadio copyWith({
//     int? id,
//     int? order,
//     String? name,
//     String? tagline,
//     String? color,
//     String? desc,
//     String? url,
//     String? category,
//     String? icon,
//     String? image,
//     String? lang,
//   }) {
//     return MyRadio(
//       id: id ?? this.id,
//       order: order ?? this.order,
//       name: name ?? this.name,
//       tagline: tagline ?? this.tagline,
//       color: color ?? this.color,
//       desc: desc ?? this.desc,
//       url: url ?? this.url,
//       category: category ?? this.category,
//       icon: icon ?? this.icon,
//       image: image ?? this.image,
//       lang: lang ?? this.lang,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': this.id,
//       'order': this.order,
//       'name': this.name,
//       'tagline': this.tagline,
//       'color': this.color,
//       'desc': this.desc,
//       'url': this.url,
//       'category': this.category,
//       'icon': this.icon,
//       'image': this.image,
//       'lang': this.lang,
//     };
//   }
//
//   factory MyRadio.fromMap(Map<String, dynamic> map) {
//     return MyRadio(
//       id: map['id'] as int,
//       order: map['order'] as int,
//       name: map['name'] as String,
//       tagline: map['tagline'] as String,
//       color: map['color'] as String,
//       desc: map['desc'] as String,
//       url: map['url'] as String,
//       category: map['category'] as String,
//       icon: map['icon'] as String,
//       image: map['image'] as String,
//       lang: map['lang'] as String,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory MyRadio.fromJson(String source) => MyRadio.fromMap(json.decode(source));
//
// //</editor-fold>
// }