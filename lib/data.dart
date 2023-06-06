part of 'exchange.dart';

abstract class Data {
  void load(String fileName);

  List<String> get fields;

  bool get hasData;

  void save(String fileName);

  String get data;

  set data(String filename);

  void clear();
}
