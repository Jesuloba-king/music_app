import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/themes/themeProvider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SongDetailsPage extends StatelessWidget {
  const SongDetailsPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      //get playlist
      final playlist = value.playList;

      //get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];

      //UI scaffold
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //app bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //back button
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),

                    //title
                    const Text("P L A Y L I S T"),

                    //MENU BUTTON
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                //album artwork
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: QueryArtworkWidget(
                          id: currentSong.id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(Icons.music_note),
                        ),
                        // Image.asset(currentSong.displayName),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // SizedBox(width: 10),
                                  Text(currentSong.artist ?? "Unknown Artist"),
                                ],
                              ),
                            ),

                            //HEART ICONS
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //

                //song duration progress
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //start time
                          Text(formatTime(value.currentDuration)),

                          //shuffle icon
                          InkWell(
                            onTap: value.toggleShuffle,
                            child: Icon(
                              Icons.shuffle,
                              color: value.isShuffling
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),

                          //repeat icon
                          InkWell(
                            onTap: value.toggleRepeat,
                            child: Icon(
                              Icons.repeat,
                              color: value.isRepeating
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          // end time
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),

                    //song progress bar
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        inactiveColor: Colors.grey,
                        onChanged: (double double) {
                          //during when user is using slider
                        },
                        onChangeEnd: (double double) {
                          //slidding has finished, go to that position in song duration
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //skip
                    Expanded(
                      child: InkWell(
                        onTap: value.playPreviousSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_previous),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    //play
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow),
                        ),
                      ),
                    ),
                    //
                    const SizedBox(width: 20),
                    //pause
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: NeuBox(
                    //       child: Icon(Icons.pause),
                    //     ),
                    //   ),
                    // ),

                    //previous
                    Expanded(
                      child: InkWell(
                        onTap: value.playNextSong,
                        child: const NeuBox(
                          child: Icon(Icons.skip_next),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}

class NeuBox extends StatelessWidget {
  final Widget? child;

  const NeuBox({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    //dark mode
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            //dark shadow on bottom right
            BoxShadow(
              color: isDarkMode ? Colors.black : Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4),
            ),

            //lighter shadow on top left
            BoxShadow(
              color: isDarkMode ? Colors.grey.shade800 : Colors.white,
              blurRadius: 15,
              offset: const Offset(-4, -4),
            ),
          ]),
      margin: const EdgeInsets.all(12),
      child: child,
    );
  }
}
