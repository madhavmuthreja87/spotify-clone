import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  // The single real player used by the whole app.
  final AudioPlayer player = AudioPlayer();

  MyAudioHandler() {
    // Pause for calls / other apps, handle headphone unplug, etc.
    AudioSession.instance.then(
      (session) => session.configure(const AudioSessionConfiguration.music()),
    );

    // Keep the notification / lock screen / Now Playing in sync.
    player.playbackEventStream.listen((_) => _broadcast());
    player.playingStream.listen((_) => _broadcast());
  }

  void _broadcast() {
    playbackState.add(
      PlaybackState(
        controls: [player.playing ? MediaControl.pause : MediaControl.play],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        playing: player.playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
      ),
    );
  }

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() async {
    await player.stop();
    return super.stop();
  }
}
