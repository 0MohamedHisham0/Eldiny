import 'dart:convert';

import 'package:adealy/models/surah/surah.dart';

class SurahsList {
  final List<Surah>? surahs;

  SurahsList({
    this.surahs,
  });

  factory SurahsList.fromJSON(Map<String, dynamic> json) {
    Iterable surahlist = json['data']['surahs'];
    List<Surah> surahsList = surahlist.map((i) => Surah.fromJSON(i)).toList();

    return SurahsList(surahs: surahsList);
  }

  SurahsList copyWith({
    List<Surah>? surahs,
  }) {
    return SurahsList(
      surahs: surahs ?? this.surahs,
    );
  }

  SurahsList merge(SurahsList model) {
    return SurahsList(
      surahs: model.surahs ?? surahs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'surahs': surahs?.map((x) => x.toMap()).toList(),
    };
  }

  factory SurahsList.fromMap(Map<String, dynamic> map) {
    return SurahsList(
      surahs: List<Surah>.from(map['surahs']?.map((x) => Surah?.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SurahsList.fromJson(String source) =>
      SurahsList.fromMap(json.decode(source));

  @override
  String toString() => 'SurahsList(surahs: $surahs)';
}
