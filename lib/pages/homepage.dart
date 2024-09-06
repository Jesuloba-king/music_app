import 'package:flutter/material.dart';
import 'package:music_player/models/playlist_provider.dart';
import 'package:music_player/models/song_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../components/my_drawer.dart';
import 'song_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//get the playlist provider
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //
  goToSong(int songIndex) {
    //update current song index

    playlistProvider.currentSongIndex = songIndex;

    // Navigate to the SongDetailsPage with the selected song
    // You can use the Provider.of<PlaylistProvider>(context) to access the playlist
    // and then access the song at the provided index
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const SongDetailsPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("P L A Y L I S T"),
        // backgroundColor: Colors.transparent,
        // foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<PlaylistProvider>().pickSongs();
        },
        child: const Icon(Icons.play_arrow),
      ),
      body: Consumer<PlaylistProvider>(builder: (context, value, child) {
        final List<SongModel> playlist = value.playList;

        if (playlist.isEmpty) {
          return const Center(child: Text("No songs found."));
        }

        return ListView.builder(
          itemCount: playlist.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final SongModel song = playlist[index];

            return ListTile(
              title: Text(song.title),
              subtitle: Text(song.artist ?? "Unknown Artist"),
              // leading: Image.asset(song.id),
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const Icon(Icons.music_note),
              ),
              onTap: () => goToSong(index),
            );
          },
        );
      }),
    );
  }
}
