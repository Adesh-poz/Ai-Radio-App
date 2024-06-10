import 'package:alan_voice/alan_voice.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import '../model/radio.dart';
import 'package:ai_radio_app/utils/color_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<MyRadio> radios;
  late MyRadio _selectedRadio;
  late Color _selectedColor;
  bool _isPlaying = false;
  final sugg = [
    "Play",
    "Stop",
    "Play rock music",
    "Play 107 FM",
    "Play next",
    "Play 104 FM",
    "Pause",
    "Play previous",
    "Play pop music"
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setupAlan();
    fetchRadios();

    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
    });
  }

  setupAlan() {
    AlanVoice.addButton(
        "65b2b7144720868051f565f0d603a8642e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
    AlanVoice.callbacks.add((command) => _handleCommand(command.data));
  }

  _handleCommand(Map<String, dynamic> response) {
    switch (response["command"]) {
      case "play":
        _playMusic(_selectedRadio.url);
        break;

      case "play_channel":
        final id = response["id"];
        // _audioPlayer.pause();
        MyRadio newRadio = radios.firstWhere((element) => element.id == id);
        radios.remove(newRadio);
        radios.insert(0, newRadio);
        _playMusic(newRadio.url);
        break;

      case "stop":
        _audioPlayer.stop();
        break;
      case "next":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index + 1 > radios.length) {
          newRadio = radios.firstWhere((element) => element.id == 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index + 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;

      case "prev":
        final index = _selectedRadio.id;
        MyRadio newRadio;
        if (index - 1 <= 0) {
          newRadio = radios.firstWhere((element) => element.id == 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        } else {
          newRadio = radios.firstWhere((element) => element.id == index - 1);
          radios.remove(newRadio);
          radios.insert(0, newRadio);
        }
        _playMusic(newRadio.url);
        break;
      default:
        // print("Command was ${response["command"]}");
        break;
    }
  }

  fetchRadios() async {
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    _selectedRadio = radios[4];
    _selectedColor = Color(int.tryParse(_selectedRadio.color)!.toInt());
    // if (kDebugMode) {
    //   print(radios);
    // }
    setState(() {});
  }

  _playMusic(String url) async {
    // print(url);
    await _audioPlayer.play(UrlSource(url));
    _selectedRadio = radios.firstWhere((element) => element.url == url);
    // print(_selectedRadio.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AIColors.primaryColor2,
      drawer: Drawer(
        // backgroundColor: Colors.deepOrangeAccent,
        child: Container(
          color: _selectedColor ?? AIColors.primaryColor2,
          child: [
            100.heightBox,
            "All Channels".text.xl.white.semiBold.make().px16(),
            20.heightBox,
            ListView(
              padding: Vx.m0,
              shrinkWrap: true,
              children: radios
                  .map((e) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(e.icon),
                        ),
                        title: "${e.name} FM".text.white.make(),
                        subtitle: e.tagline.text.white.make(),
                      ))
                  .toList(),
            ).expand(),
          ].vStack(crossAlignment: CrossAxisAlignment.start),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Vx.purple500,
              _selectedColor ?? Vx.orange400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              title: "AI Radio".text.xl4.fontFamily(GoogleFonts.ubuntu().fontFamily!).bold.white.make().shimmer(
                  primaryColor: Vx.purple300, secondaryColor: Colors.white),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              actions: [
                ElevatedButton(
                    child: Icon(
                      Icons.logout_outlined,
                      size: 20,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        if (kDebugMode) {
                          print("User Signed Out!");
                        }
                        // Deactivates the Alan Button
                        AlanVoice.deactivate();
                        Navigator.pop(context);
                      });
                    }),
              ],
            ).h(100.0).p16(),
            "Start with - Hey Alan 👇".text.italic.semiBold.white.make(),
            10.heightBox,
            VxSwiper.builder(
              itemCount: sugg.length,
              height: 50.0,
              viewportFraction: 0.4,
              autoPlay: true,
              autoPlayAnimationDuration: 3.seconds,
              autoPlayCurve: Curves.linear,
              enableInfiniteScroll: true,
              itemBuilder: (context, index) {
                final s = sugg[index];
                return Chip(
                  label: Text(s),
                  backgroundColor: Vx.randomColor,
                );
              },
            ),
            radios.length != null
                ? VxSwiper.builder(
                    itemCount: radios.length,
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    onPageChanged: (index) {
                      final color = radios[index].color;
                      _selectedColor = Color(int.tryParse(color)!.toInt());
                    },
                    itemBuilder: (context, index) {
                      // print(radios.length);
                      final rad = radios[index];
                      // print('Building item for index: $index with image: ${rad.image}');
                      return VxBox(
                        child: ZStack(
                          [
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: VxBox(
                                child: rad.category.text.uppercase.white
                                    .make()
                                    .px16(),
                              )
                                  .height(40)
                                  .black
                                  .alignCenter
                                  .withRounded(value: 10.0)
                                  .make(),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: VStack(
                                [
                                  Text(
                                    rad.name,
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.ubuntu().fontFamily,
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    rad.tagline,
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.ubuntu().fontFamily,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                                crossAlignment: CrossAxisAlignment.center,
                              ),
                            ),
                            Align(
                              // alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.play_arrow_solid,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Double tap to play',
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.ubuntu().fontFamily,
                                      color: Colors.grey.shade300,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                          .bgImage(DecorationImage(
                            image: AssetImage(rad.image),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.3),
                                BlendMode.darken),
                          ))
                          .clip(Clip.antiAlias)
                          .border(color: Colors.black, width: 5.0)
                          .withRounded(value: 60.0)
                          .make()
                          .onInkDoubleTap(() {
                        _playMusic(rad.url);
                      }).p16();
                    },
                  ).centered()
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            10.heightBox,
            // const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomCenter,
              child: [
                if (_isPlaying)
                  "Playing Now - ${_selectedRadio.name} FM"
                      .text
                      .fontFamily(GoogleFonts.ubuntu().fontFamily!)
                      .white
                      .makeCentered(),
                Icon(
                  _isPlaying
                      ? CupertinoIcons.stop_circle
                      : CupertinoIcons.play_circle,
                  size: 50.0,
                  color: Colors.white,
                ).onInkTap(() {
                  if (_isPlaying) {
                    _audioPlayer.stop();
                    setState(() {
                      _isPlaying = false;
                    });
                  } else {
                    _playMusic(_selectedRadio.url);
                  }
                }),
              ].vStack(),
            ).pOnly(bottom: context.percentHeight * 12),
          ],
        ),
      ),
    );
  }
}