part of 'exchange.dart';

class JsonData extends Data {
  dynamic jsondata = [];
  String contentJson = '';
  String contenttoSave = '';

  @override
  void load(jsonfile) {
    try {
      if (jsonfile.contains('.json'))
        jsonfile = File(jsonfile).readAsStringSync();
      contenttoSave = jsonfile;
      data = jsonfile;
    } catch (e) {
      throw InvalidFormat();
    }
  }

  @override
  List<String> get fields => jsondata[0].keys.toList();

  @override
  set data(String data) {
    jsondata = jsonDecode(data);
    contentJson = jsondata.toString();
  }

  @override
  String get data {
    if (!hasData) return '';
    final strValues = [];
    for (int i = 0; i < jsondata.length; i++) {
      strValues.add(jsondata[i]);
      //strValues += '\n';
    }
    return strValues.toString();
  }

  @override
  bool get hasData => jsondata.isNotEmpty;

  @override
  void save(String fileName) {
    final outFile = File(fileName);
    outFile.createSync(recursive: true);
    outFile.writeAsStringSync(contenttoSave);
    print('Status: Saved successfully');
  }

  @override
  void clear() {
    jsondata = "";
  }
}
