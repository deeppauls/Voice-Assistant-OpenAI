import 'package:flutter/material.dart';
import 'package:sammy/models/color-model.dart';
import 'package:sammy/services/openAi-service.dart';
import 'package:sammy/widgets/features_box.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SpeechToText speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sammy"),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                        color: ColorPallete.assistantCircleColor,
                        shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/virtualAssistant.png'),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorPallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Hola, what task can I do for you?",
                  style: TextStyle(
                      color: ColorPallete.mainFontColor,
                      fontSize: 25,
                      fontFamily: 'Cera Pro'),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(
                top: 10,
                left: 22,
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                "Here are a few features",
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: ColorPallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                FeatureBox(
                  ColorPallete.firstSuggestionBoxColor,
                  'ChatGPT',
                  'A smarter way to stay organized and informed with ChatGPT',
                ),
                FeatureBox(
                  ColorPallete.secondSuggestionBoxColor,
                  'Dall-E',
                  'Get inspired and stay creative with your personal assistant powered by Dall-E',
                ),
                FeatureBox(
                  ColorPallete.thirdSuggestionBoxColor,
                  'Smart Voice Assistant',
                  'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.firstSuggestionBoxColor,
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await OpenAiService().isArtPromptApi(lastWords);
            print(speech);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
