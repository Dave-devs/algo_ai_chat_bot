import 'package:algo_ai_chat_bot/common/pallete/pallete.dart';
import 'package:algo_ai_chat_bot/features/chat_page/widgets/feature_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
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

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(10.w),
          decoration:
              BoxDecoration(color: Pallete.tileColor, shape: BoxShape.circle),
          child: Icon(
            Icons.arrow_back,
            color: Pallete.greyText,
          ),
        ),
        title: Text(
          'Chat Algo',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: Pallete.whiteText),
        ),
        centerTitle: true,
        actions: [
          Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                  color: Pallete.tileColor, shape: BoxShape.circle),
              child: Icon(
                Icons.more_vert,
                color: Pallete.greyText,
              )),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20.h,
          ),

          //Answer Container Box
          Container(
            width: 330.w,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Pallete.greyBG,
              borderRadius: BorderRadius.circular(10.w),
            ),
            child: Row(
              children: [
                //Algo AI Logo
                Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: Pallete.tileColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.more_vert,
                      color: Pallete.greyText,
                    )),

                SizedBox(
                  width: 10.w,
                ),

                Text(
                    'Artificial intelligence (AI) refers to intelligent computer systems that can learn, reason, and perform tasks that typically requires human intelligence. It involves techniques like machine learning, natural language processing, and computer vision to analyze data, make decisions, and interact with humans.',
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Pallete.blackText))
              ],
            ),
          ),

          SizedBox(height: 20.h),

          //Algo's Features
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text('These are Algo features',
                textAlign: TextAlign.left,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Pallete.whiteText)),
          ),

          SizedBox(height: 20.h),

          const Column(
            children: [
              FeatureTile(
                  title: 'ChatGPT',
                  subTitle:
                      'A smarter way to stay organized and informed with ChatGPT.',
                  color: Colors.blue),
              FeatureTile(
                  title: 'Dall-E',
                  subTitle:
                      'Get inspired and stay creative with your personal assitant powered by Dall-E.',
                  color: Colors.green),
              FeatureTile(
                  title: 'Smart Voice Assistant',
                  subTitle:
                      'Get the best of both worlds with a voice assistance powered by ChatGPT and Dall-E AI.',
                  color: Colors.pink),
            ],
          ),

          SizedBox(height: 20.h),

          //Add Mic Floating Action Button Here
          FloatingActionButton(
            onPressed: () async {
              if(await speechToText.hasPermission && speechToText.isNotListening) {
                await startListening();
              } else if(speechToText.isListening) {
                await stopListening();
              } else {
                initSpeech();
              }
            },
            backgroundColor: Pallete.purpleTile,
            child: Icon(
              Icons.mic,
              color: Pallete.blackText,
            ),
          )
        ],
      ),
    );
  }
}
