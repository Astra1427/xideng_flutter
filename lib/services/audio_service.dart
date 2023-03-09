import 'package:just_audio/just_audio.dart';

class AudioService {
  static final _playUrls = <String, String>{
    'one': 'res/audios/one.mp3',
    'two': 'res/audios/two.mp3',
    'three': 'res/audios/three.mp3',
    'tick': 'res/audios/tick.mp3',
    'bengbengca': 'res/audios/bengbengca.mp3',
    'finish': 'res/audios/finish.mp3',
    'recovery': 'res/audios/recovery.mp3',
    'relax1': 'res/audios/relax1.mp3',
    'relax2': 'res/audios/relax2.mp3',
    'shake': 'res/audios/shake_sound.mp3',
    'start': 'res/audios/start.mp3',
  };

  static final AudioPlayer onePlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['one']!}'))
    ..setVolume(1);
static final AudioPlayer twoPlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['two']!}'))
    ..setVolume(1);
static final AudioPlayer threePlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['three']!}'))
    ..setVolume(1);
static final AudioPlayer startPlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['start']!}'))
    ..setVolume(1);
static final AudioPlayer finishPlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['finish']!}'))
    ..setVolume(1);
static final AudioPlayer backPlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['bengbengca']!}'))
    ..setVolume(1);
static final AudioPlayer tickPlayer = AudioPlayer()
    ..setAudioSource(AudioSource.asset('assets/${_playUrls['tick']!}'))
    ..setVolume(1);

  void initAudioPlayer() {

  }
}
