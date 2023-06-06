part of 'exchange.dart';

class XmlData extends Data {
  Map<String, dynamic> mapcontentTag = {};
  List<String> field = [];
  dynamic content = [];
  String contentXml = '';

  @override
  void load(xmlfile) {
    try {
      final document = File(xmlfile).readAsStringSync();
      contentXml = document;
      data = document;
    } catch (e) {
      throw InvalidFormat();
    }
  }

  @override
  set data(String data) {
    final xmldata = XmlDocument.parse(data);
    final xmlFile = xmldata.rootElement.childElements;
    for (XmlElement tagContent in xmlFile) {
      content.add(tagContent.attributes.toString());
    }
    ;
    xmlFile.first.attributes
        .forEach((eachField) => {field.add(eachField.name.toString())});
  }

  @override
  String get data => contentXml;

  @override
  List<String> get fields => field;

  @override
  bool get hasData => content.isNotEmpty;

  @override
  void clear() {
    content = "";
  }

  @override
  void save(String fileName) {
    final outFile = File(fileName);
    outFile.writeAsStringSync(contentXml);
    print('Status: Saved successfully');
  }
}
