import 'stream-info-parser.dart';
import 'package:xml/xml.dart';

class DashManifestParser {
  XmlDocument _root;

  DashManifestParser(this._root);

  List<StreamInfoParser> getStreamInfo() {
    var streamInfosXml = _root.descendants
        .where((x) => x is XmlElement && x.name.local == 'Representation')
        .toList();

    // List that we will full
    List<StreamInfoParser> builtList = [];

    streamInfosXml.forEach((x) {
      builtList.add(StreamInfoParser(x));
    });

    return builtList;
  }

  static DashManifestParser initialize(String raw) {
    var root = XmlDocument.parse(raw);
    return DashManifestParser(root);
  }
}
