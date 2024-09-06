// import 'package:audioplayers/audioplayers.dart';
// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class PlaylistProvider extends ChangeNotifier {
//   //playlist of songs
//   final List<Song> _playList = [
//     Song(
//       songName: 'Calm Down',
//       artistName: 'Rema',
//       albumArtImagePath: 'assets/images/ajk1.jpg',
//       audioPath: 'audio/Rema - Calm Down - (Dj Fego Bootleg _ Remix).mp3',
//     ),

//     //
//     Song(
//       songName: 'Afropiano Party Mix 2023',
//       artistName: 'DJ Unbeetable',
//       albumArtImagePath: 'assets/images/ajk2.jpg',
//       audioPath:
//           'audio/DJ Unbeetable - Afropiano Party Mix 2023 (NetNaija.com).mp3',
//     ),

//     //
//     Song(
//       songName: 'The New Song -  My Life is in Your Hands',
//       artistName: 'The Choir',
//       albumArtImagePath: 'assets/images/ajk3.jpg',
//       audioPath:
//           'audio/The_New_Song_-_My_Life_Is_In_Your_Hands_CeeNaija.com_.mp3',
//     ),
//   ];

//   int? _currentSongIndex;

//   /*
// A U D I O P L A Y E R

//   */

//   //audio player
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   //initially not playing
//   bool _isPlaying = false;

//   //play the song
//   Future<void> play() async {
//     final String path = _playList[_currentSongIndex!].audioPath;
//     await _audioPlayer.stop(); //stop current song
//     await _audioPlayer.play(AssetSource(path)); //play the new song

//     _isPlaying = true;
//     notifyListeners();
//   }

//   // pause current song
//   Future<void> pause() async {
//     await _audioPlayer.pause(); //pause current song

//     _isPlaying = false;
//     notifyListeners();
//   }

//   //resume playing
//   Future<void> resume() async {
//     await _audioPlayer.resume();

//     _isPlaying = true;
//     notifyListeners();
//   }

//   //pause and play
//   void pauseOrResuume() async {
//     if (_isPlaying) {
//       pause();
//     } else {
//       resume();
//     }

//     notifyListeners();
//   }

//   //seek to a specific position in the current song
//   void seek(Duration position) async {
//     await _audioPlayer.seek(position);
//   }

//   // play next song
//   void playNextSong() {
//     if (_currentSongIndex != null) {
//       if (_currentSongIndex! < _playList.length - 1) {
//         //go to the next song if it's not the last song
//         currentSongIndex = _currentSongIndex! + 1;
//       } else {
//         //if it's the last song, go back to the first song
//         currentSongIndex = 0;
//       }
//     }
//   }

//   //play previous song
//   void playPreviousSong() {
//     //if more than 2 seconds have passed, restart the current song
//     if (_currentDuration.inSeconds > 2) {
//       seek(Duration.zero);
//     }
//     // if it's within the first 2 seconds of the song, go to previos song
//     else {
//       if (_currentSongIndex! > 0) {
//         currentSongIndex = _currentSongIndex! - 1;
//       } else {
//         //if it's the first song, loop back to last song
//         currentSongIndex = _playList.length - 1;
//       }
//     }
//   }

//   //duration
//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   //listen to duration
//   void listenToDuration() {
//     //list fot total duration
//     _audioPlayer.onDurationChanged.listen((newDuration) {
//       _totalDuration = newDuration;
//       notifyListeners();
//     });

// //listen for current duration
//     _audioPlayer.onPositionChanged.listen((newPosition) {
//       _currentDuration = newPosition;
//       notifyListeners();
//     });

//     //listen for song completion
//     _audioPlayer.onPlayerComplete.listen((event) {
//       playNextSong();
//     });
//   }

//   //constructor
//   PlaylistProvider() {
//     listenToDuration();
//   }

//   //

//   /*
// GETTERS
//   */
//   List<Song> get playList => _playList;

//   int? get currentSongIndex => _currentSongIndex;

//   bool get isPlaying => _isPlaying;
//   Duration get currentDuration => _currentDuration;
//   Duration get totalDuration => _totalDuration;

//   /*
//   SETTERS
//   */
//   set currentSongIndex(int? newIndex) {
//     //update current song index
//     _currentSongIndex = newIndex;

//     if (newIndex != null) {
//       //play the new song
//       play();
//     }

//     //update UI
//     notifyListeners();
//   }
// }

// class PlaylistProvider extends ChangeNotifier {
//   final OnAudioQuery _audioQuery = OnAudioQuery();

//   final List<Song> _playList = [];
//   int? _currentSongIndex;

//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;

//   Duration _currentDuration = Duration.zero;
//   Duration _totalDuration = Duration.zero;

//   PlaylistProvider() {
//     listenToDuration();
//   }

//   // Pick songs from the phone storage
//   Future<void> pickSongs() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.audio,
//     );

//     if (result != null) {
//       List<Song> songs = result.files.map((file) {
//         return Song(
//           songName: file.name,
//           artistName: file.name.trimRight() ??
//               "Unknown Artist", // Set artist name if available
//           albumArtImagePath:
//               'assets/images/otunba_JSY.jpeg', // Set album art if available
//           audioPath: file.path!,
//         );
//       }).toList();

//       _playList.addAll(songs);
//       notifyListeners();
//     }
//   }

//   Future<void> play() async {
//     if (_currentSongIndex != null) {
//       final String path = _playList[_currentSongIndex!].audioPath;
//       await _audioPlayer.stop();
//       await _audioPlayer.play(DeviceFileSource(path));

//       _isPlaying = true;
//       notifyListeners();
//     }
//   }

//   Future<void> pause() async {
//     await _audioPlayer.pause();
//     _isPlaying = false;
//     notifyListeners();
//   }

//   Future<void> resume() async {
//     await _audioPlayer.resume();
//     _isPlaying = true;
//     notifyListeners();
//   }

//   void pauseOrResume() async {
//     if (_isPlaying) {
//       await pause();
//     } else {
//       await resume();
//     }
//   }

//   void seek(Duration position) async {
//     await _audioPlayer.seek(position);
//   }

//   void playNextSong() {
//     if (_currentSongIndex != null) {
//       if (_currentSongIndex! < _playList.length - 1) {
//         currentSongIndex = _currentSongIndex! + 1;
//       } else {
//         currentSongIndex = 0;
//       }
//     }
//   }

//   void playPreviousSong() {
//     if (_currentDuration.inSeconds > 2) {
//       seek(Duration.zero);
//     } else {
//       if (_currentSongIndex! > 0) {
//         currentSongIndex = _currentSongIndex! - 1;
//       } else {
//         currentSongIndex = _playList.length - 1;
//       }
//     }
//   }

//   void listenToDuration() {
//     _audioPlayer.onDurationChanged.listen((newDuration) {
//       _totalDuration = newDuration;
//       notifyListeners();
//     });

//     _audioPlayer.onPositionChanged.listen((newPosition) {
//       _currentDuration = newPosition;
//       notifyListeners();
//     });

//     _audioPlayer.onPlayerComplete.listen((event) {
//       playNextSong();
//     });
//   }

//   List<Song> get playList => _playList;
//   int? get currentSongIndex => _currentSongIndex;
//   bool get isPlaying => _isPlaying;
//   Duration get currentDuration => _currentDuration;
//   Duration get totalDuration => _totalDuration;

//   set currentSongIndex(int? newIndex) {
//     _currentSongIndex = newIndex;
//     if (newIndex != null) {
//       play();
//     }
//     notifyListeners();
//   }
// }

//

class PlaylistProvider extends ChangeNotifier {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<SongModel> _playList = [];
  int? _currentSongIndex;
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  PlaylistProvider() {
    _fetchAllSongs();
    _initializePlayerListeners();
  }

  Future<void> _fetchAllSongs() async {
    try {
      // Check if the necessary permissions are granted
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        // Request permission if not already granted
        permissionStatus = await _audioQuery.permissionsRequest();
      }

      if (permissionStatus) {
        try {
          // Attempt to query the songs if permission is granted
          List<SongModel> songs = await _audioQuery.querySongs();
          _playList = songs;
          notifyListeners();
        } on PlatformException catch (e) {
          // Handle platform-specific exceptions, like missing permissions
          print("PlatformException occurred: ${e.message}");
          // Show an alert or dialog to inform the user
          _handleError("We need permission to access your music library.");
        } on Exception catch (e) {
          // Handle any other exceptions that might occur
          print("Error querying songs: $e");
          _handleError(
              "Something went wrong while accessing your music library.");
        }
      } else {
        // Handle the case where permission is not granted
        print("Permission not granted. Cannot query songs.");
        _handleError("We need permission to access your music library.");
      }
    } catch (e) {
      // Catch any unforeseen errors
      print("An unexpected error occurred: $e");
      _handleError("An unexpected error occurred. Please try again.");
    }
  }

// Utility method to handle errors and potentially notify the user
  void _handleError(String message) {
    // Here you can show a dialog, a snackbar, or log the error
    // For example, you might want to show an alert dialog:
    // showErrorDialog(context, message);
    print(message);
  }

  void _initializePlayerListeners() {
    _audioPlayer.positionStream.listen((duration) {
      _currentDuration = duration;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });
  }

  List<SongModel> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    _playCurrentSong();
    notifyListeners();
  }

  // Future<void> _playCurrentSong() async {
  //   if (_currentSongIndex != null) {
  //     final currentSong = _playList[_currentSongIndex!];
  //     await _audioPlayer
  //         .setAudioSource(AudioSource.uri(Uri.parse(currentSong.uri!)));
  //     _audioPlayer.play();
  //   }
  // }

//play next song
  void playNextSong() {
    if (_currentSongIndex != null &&
        _currentSongIndex! < _playList.length - 1) {
      currentSongIndex = _currentSongIndex! + 1;
    }
  }

//play previous song
  void playPreviousSong() {
    if (_currentSongIndex != null && _currentSongIndex! > 0) {
      currentSongIndex = _currentSongIndex! - 1;
    }
  }

//pause and play
  void pauseOrResume() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

//adjust slider
  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  //
  bool _isShuffling = false;
  bool _isRepeating = false;

  bool get isShuffling => _isShuffling;
  bool get isRepeating => _isRepeating;

  void toggleShuffle() {
    _isShuffling = !_isShuffling;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeating = !_isRepeating;
    notifyListeners();
  }

  Future<void> _playCurrentSong() async {
    if (_currentSongIndex != null) {
      final currentSong = _playList[_currentSongIndex!];
      await _audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(currentSong.uri!)),
        preload: true,
      );
      _audioPlayer.play();

      _audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          if (_isRepeating) {
            _audioPlayer.seek(Duration.zero);
            _audioPlayer.play();
          } else if (_isShuffling) {
            _shuffleNextSong();
          } else {
            playNextSong();
          }
        }
      });
    }
  }

  void _shuffleNextSong() {
    if (_playList.isNotEmpty) {
      final random = Random();
      int nextIndex;
      do {
        nextIndex = random.nextInt(_playList.length);
      } while (nextIndex == _currentSongIndex);
      currentSongIndex = nextIndex;
    }
  }
}
