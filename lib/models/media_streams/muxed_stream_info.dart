import '../../internal/itag_helper.dart';
import 'audio_encoding.dart';
import 'media_stream_info.dart';
import 'video_encoding.dart';
import 'video_quality.dart';

class MuxedStreamInfo extends MediaStreamInfo {
  /// Audio encoding of the associated stream.
  late AudioEncoding audioEncoding;

  /// Video encoding of the associated stream.
  late VideoEncoding videoEncoding;

  /// Video quality of the associated stream.
  late VideoQuality videoQuality;

  /// Video quality label of the associated stream.
  late String videoQualityLabel;

  MuxedStreamInfo(int iTag, String url, int size) : super(iTag, url, size) {
    audioEncoding = ItagHelper.getAudioEncoding(iTag);
    videoEncoding = ItagHelper.getVideoEncoding(iTag);
    videoQuality = ItagHelper.getVideoQuality(iTag);
    videoQualityLabel = videoQuality.toString() + 'p';
  }
}
