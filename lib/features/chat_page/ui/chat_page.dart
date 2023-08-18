import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:algo_ai_chat_bot/features/chat_page/widgets/feature_tile.dart';
import 'package:algo_ai_chat_bot/open_ai_services/services.dart';
import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final OpenAIServices openAIServices = OpenAIServices();

  final SpeechToText speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  bool speechEnabled = false;
  String lastWords = '';
  String? generatedSpeech;
  String? generatedImage;

  @override
  void initState() {
    super.initState();
    initSpeech();
    initTextToSpeech();
  }

  //This has to happen only once per app
  Future<void> initSpeech() async {
    speechEnabled = await speechToText.initialize();
    setState(() {});
  }

  //Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /*Manually stop the active speech recognition session.
  Note that there are also timeout that each platform enforces 
  and the SpeechToText plugin support setting timeouts on the 
  listen method.*/
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /*This is the callback that the SpeechToText plugin calls when 
  the platform returns recognized words.*/
  void onSpeechResult(SpeechRecognitionResult result) async {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  //iOS only->To set shared audio instance
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> speak(String speech) async {
    await flutterTts.speak(speech);
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.only(left: 20.w),
            padding: EdgeInsets.all(5.w),
            decoration:
                BoxDecoration(color: Pallete.tileColor, shape: BoxShape.circle),
            child: Icon(
              Icons.arrow_back,
              color: Pallete.greyText,
            ),
          ),
        ),
        title: BounceInDown(
          child: Text(
            'Chat Algo',
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                color: Pallete.whiteText),
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20.w),
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                  color: Pallete.tileColor, shape: BoxShape.circle),
              child: Icon(
                Icons.more_vert,
                color: Pallete.greyText,
              )),
        ],
      ), //@RivaanRanawat
      
      body: ListView(
        children: [
          SizedBox(height: 20.h,),

          //AI Logo Here
          ZoomIn(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 120.h,
                    width: 120.w,
                    margin: EdgeInsets.only(top: 4.h),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 123.h,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/algo_ai.png')
                      )
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 20.h,
          ),

          //Answer Container Box
          FadeInRight(
            child: Visibility(
              visible: generatedImage == null,
              child: Container(
                width: 330.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Pallete.greyBG,
                  borderRadius: BorderRadius.circular(10.w),
                ),
                child: AutoSizeText(
                      generatedSpeech == null
                          ? 'Artificial intelligence (AI) refers to intelligent computer systems that can learn, reason, and perform tasks that typically requires human intelligence. It involves techniques like machine learning, natural language processing, and computer vision to analyze data, make decisions, and interact with humans.'
                          : generatedSpeech!,
                      softWrap: true,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14
                              .sp, // FontSize: genetratedSpeech == null ? 25 : 18
                          color: Pallete.blackText))
              ),
            ),
          ),

          //Image Container
          if (generatedImage != null)
            Container(
              width: 330.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.w),
                image: DecorationImage(
                    image: NetworkImage(generatedImage!), fit: BoxFit.cover),
              ),
            ),

          SizedBox(height: 30.h),

          //Algo's Features
          SlideInLeft(
            child: Visibility(
              visible: generatedSpeech == null && generatedImage == null,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'These are few Algo features',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: Pallete.whiteText
                  )
                ),
              ),
            ),
          ),

          SizedBox(height: 5.h),

          Visibility(
            visible: generatedSpeech == null && generatedImage == null,
            child: Column(
              children: [
                SlideInLeft(
                  delay: const Duration(milliseconds: 200),
                  child: const FeatureTile(
                    title: 'ChatGPT',
                    subTitle: 'A smarter way to stay organized and informed with ChatGPT.',
                    color: Colors.blue
                  ),
                ),
                SlideInLeft(
                  delay: const Duration(milliseconds: 400),
                  child: const FeatureTile(
                    title: 'Dall-E',
                    subTitle: 'Get inspired and stay creative with your personal assitant powered by Dall-E.',
                    color: Colors.green
                  ),
                ),
                SlideInLeft(
                  delay: const Duration(milliseconds: 600),
                  child: const FeatureTile(
                    title: 'Smart Voice Assistant',
                    subTitle: 'Get the best of both worlds with a voice assistance powered by ChatGPT and Dall-E AI.',
                    color: Colors.pink
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),

      //Add Mic Floating Action Button Here
      floatingActionButton: ZoomIn(
        delay: const Duration(milliseconds: 800),
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission && speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIServices.isArtOrTextPrompt(lastWords);
              if (speech.contains("https://")) {
                generatedImage = speech;
                generatedSpeech = null;
                setState(() {});
              } else {
                generatedSpeech = speech;
                generatedImage = null;
                setState(() {});
                await speak(speech);
              }
              await stopListening();
            } else {
              initSpeech();
            }
          },
          backgroundColor: Pallete.purpleTile,
          elevation: 2,
          isExtended: false,
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic,
            color: Pallete.blackText,
          ),
        ),
      ),

    );
  }
}