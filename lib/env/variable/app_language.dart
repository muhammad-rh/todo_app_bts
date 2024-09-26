import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppLanguage extends Equatable {
  final Locale locale;
  final String name;

  const AppLanguage({required this.locale, required this.name});

  static const AppLanguage en =
      AppLanguage(locale: Locale("en"), name: "English");
  static const AppLanguage id =
      AppLanguage(locale: Locale("id"), name: "Indonesia");

  static const List<AppLanguage> values = [en, id];

  @override
  List<Object?> get props => [locale, name];
}
