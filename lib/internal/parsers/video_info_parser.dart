import 'adaptive_stream_info_parser.dart';
import 'muxed_stream_info_parser.dart';
import 'dart:convert';

class VideoInfoParser {
  final Map<String, String> root;
  final bool isLive;

  VideoInfoParser({required this.root, this.isLive = false});

  String? parseStatus() => root['status'];

  // String parseId() => root["video_id"]; // no longer provided

  int? parseErrorCode() =>
      root['errorcode'] == null ? 0 : int.tryParse(root['errorcode'] ?? "0");

  String? parseErrorReason() => root["reason"];

  String? parsePreviewVideoId() => root['ypc_vid'];

  String? parseDashManifestUrl() =>
      jsonDecode(root['player_response'] ?? "")['streamingData']
          ['dashManifestUrl'];

  String parseHlsPlaylistUrl() =>
      jsonDecode(root['player_response'] ?? "")['streamingData']
          ['hlsManifestUrl'];

  List<MuxedStreamInfoParser> getMuxedStreamInfo() {
    var streamInfosEncoded = root['url_encoded_fmt_stream_map'];

    if (streamInfosEncoded == null) {
      return [];
    }

    // List that we will full
    List<MuxedStreamInfoParser> builtList = [];

    // Extract the streams and return a list
    var streams = streamInfosEncoded.split(',');
    streams.forEach((stream) {
      builtList.add(MuxedStreamInfoParser(Uri.splitQueryString(stream)));
    });

    return builtList;
  }

  List<AdaptiveStreamInfoParser> getAdaptiveStreamInfo() {
    var streamInfosEncoded = root['adaptive_fmts'];

    if (streamInfosEncoded == null) {
      return [];
    }

    // List that we will full
    List<AdaptiveStreamInfoParser> builtList = [];

    // Extract the streams and return a list
    var streams = streamInfosEncoded.split(',');
    streams.forEach((stream) {
      builtList.add(AdaptiveStreamInfoParser(Uri.splitQueryString(stream)));
    });

    return builtList;
  }

  static VideoInfoParser initialize(String raw) {
    var root = Uri.splitQueryString(raw);
    return VideoInfoParser(root: root);
  }
}
