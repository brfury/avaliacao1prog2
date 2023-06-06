part of 'exchange.dart';

class CsvData extends DelimitedData {
  dynamic csvcontent = [];
  List<String> field = [];

  @override
  String get delimiter => ',';

  @override
  List<String> get fields => field;

  @override
  void load(csvfile) {
    try {
      csvfile = File(csvfile).readAsStringSync();
      data = csvfile;
    } catch (e) {
      throw InvalidFormat();
    }
  }

  @override
  String get data {
    if (!hasData) return '';
    String strValues = '';
    for (int i = 0; i < csvcontent.length; i++) {
      strValues +=
          (csvcontent[i].toString().replaceAll('[', '').replaceAll(']', ''));

      strValues += '\n';
    }
    return strValues;
  }

  @override
  set data(String data) {
    csvcontent = const CsvToListConverter().convert(data, eol: '\n');
    final csvList = const CsvToListConverter().convert(data, eol: '\n');
    field = csvList[0].map((e) => e.toString()).toList();
  }

  @override
  void save(String fileName) {
    String csv = const ListToCsvConverter()
        .convert(csvcontent, textDelimiter: '', eol: '\n');
    final outFile = File(fileName);
    outFile.createSync(recursive: true);
    outFile.writeAsStringSync(csv);
    print('Status: Saved successfully');
  }

  @override
  void clear() {
    csvcontent = "";
  }

  @override
  bool get hasData => !csvcontent.isEmpty;
}
