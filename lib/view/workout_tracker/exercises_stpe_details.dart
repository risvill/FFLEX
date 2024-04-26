import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';
import '../../common_widget/step_detail_row.dart';

class ExercisesStepDetails extends StatefulWidget {
  final Map eObj;
  const ExercisesStepDetails({super.key, required this.eObj});

  @override
  State<ExercisesStepDetails> createState() => _ExercisesStepDetailsState();
}

class _ExercisesStepDetailsState extends State<ExercisesStepDetails> {
  List stepArr = [
    {
      "no": "01",
      "title": "Раскиньте руки",
      "detail":
          "Чтобы жесты казались более расслабленными, вытяните руки, когда начинаете это движение. Руки не сгибать.",
      "path": "assets/video/1.mp4"
    },
    {
      "no": "02",
      "title": "Отдых",
      "detail":
          "Основа этого движения - прыжки. При этом необходимо учитывать, что вы должны использовать кончики стоп.",
      "path": "assets/video/2.mp4"
    },
    {
      "no": "03",
      "title": "Регулировка движения ноги",
      "detail":
          "Прыжки Джека - это не просто обычные прыжки. Но также необходимо обратить пристальное внимание на движения ног.",
      "path": "assets/video/3.mp4"
    },
    {
      "no": "04",
      "title": "Хлопая обеими руками",
      "detail":
          "К этому нельзя относиться легкомысленно. Сами того не осознавая, хлопки в ладоши помогают вам сохранять ритм во время выполнения Jumping Jack.",
      "path": "assets/video/1.mp4"
    },
  ];

  //int selectedIndex = 0;
  // void OnSelectedIndex(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //     String videoPath = stepArr[selectedIndex]["path"];
  //     _controller = VideoPlayerController.asset(videoPath)
  //       ..initialize().then((_) {
  //         _controller.value.isPlaying
  //             ? _controller.play()
  //             : _controller.pause();
  //         setState(() {});
  //       });
  //   });
  //}

  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
        'assets/video/1.mp4') //from array data read path
      //  .networkUrl(Uri.parse(
      //       'https://www.youtube.com/watch?v=7BMbwZ_6Hq8'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }
  //   _controller.addListener(() {
  //     setState(() {});
  //   });
  //   _controller.setLooping(true);
  //   _controller.initialize().then((_) => setState(() {}));
  //   _controller.play();
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/closed_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: media.width,
                    height: media.width * 0.43,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: TColor.primaryG),
                        borderRadius: BorderRadius.circular(20)),
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Container(),
                    //return Container(
                    // _controller.value.isInitialized
                    //     ? VideoPlayer(_controller)
                    //     : Container(),
                    //height: media.width * 0.43,
                    //width: media.width,
                    // fit: BoxFit.contain,
                    //  )
                    // Image.asset(
                    //   "assets/img/video_temp.png",
                    //   width: media.width,
                    //   height: media.width * 0.43,
                    //   fit: BoxFit.contain,
                    // ),
                  ),
                  Container(
                    width: media.width,
                    height: media.width * 0.43,
                    decoration: BoxDecoration(
                        color: TColor.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                        });
                        // setState(() {
                        //   // Assuming index represents the selected step
                        //   int index = /* your logic to get the selected index */;
                        //   String videoPath = stepArr[index]["path"];
                        //   _controller = VideoPlayerController.asset(videoPath)
                        //     ..initialize().then((_) {
                        //       setState(() {});
                        //     });
                        //   _controller.value.isPlaying ? _controller.play() : _controller.pause();
                        // });
                      },
                      icon: _controller.value.isPlaying
                          ? const Icon(Icons.pause_rounded)
                          : Image.asset(
                              "assets/img/Play.png",
                              width: 30,
                              height: 30,
                            )
                      // onPressed: () {
                      //   setState(() {
                      //     _controller.value.isPlaying
                      //         ? _controller.pause()
                      //         : _controller.play();
                      //   });
                      // },
                      // icon: _controller.value.isPlaying
                      //     ? const Icon(Icons.pause)
                      //     : Image.asset(
                      //         "assets/img/Play.png",
                      //         width: 30,
                      //         height: 30,
                      //       )),
                      )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.eObj["title"].toString(),
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "Легкий | 390 Калорий",
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Описание",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 4,
              ),
              ReadMoreText(
                'Джампинг-джек, также известный как прыжок-звезда и называемый в армии США прыжком в сторону, представляет собой физическое упражнение по прыжкам, выполняемое путем прыжка в положение с широко расставленными ногами. Джампинг-джек, также известный как прыжок-звезда и называемый прыжок на боку в армии США - это физическое прыжковое упражнение, выполняемое путем прыжка в положение с широко расставленными ногами.',
                trimLines: 4,
                colorClickableText: TColor.black,
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Подробнее ...',
                trimExpandedText: ' Закрыть',
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
                moreStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Как это делать?",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "${stepArr.length} Сета",
                      style: TextStyle(color: TColor.gray, fontSize: 12),
                    ),
                  )
                ],
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: stepArr.length,
                itemBuilder: ((context, index) {
                  var sObj = stepArr[index] as Map? ?? {};

                  return StepDetailRow(sObj: sObj, isLast: stepArr.last == sObj
                      // onPressed: () {
                      //   OnSelectedIndex(index);
                      // });
                      );
                }),
              ),
              Text(
                "Повторения",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 150,
                child: CupertinoPicker.builder(
                  itemExtent: 40,
                  selectionOverlay: Container(
                    width: double.maxFinite,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: TColor.gray.withOpacity(0.2), width: 1),
                        bottom: BorderSide(
                            color: TColor.gray.withOpacity(0.2), width: 1),
                      ),
                    ),
                  ),
                  onSelectedItemChanged: (index) {},
                  childCount: 60,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/img/burn.png",
                          width: 15,
                          height: 15,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          " ${(index + 1) * 15} Калорий",
                          style: TextStyle(color: TColor.gray, fontSize: 10),
                        ),
                        Text(
                          " ${index + 1} ",
                          style: TextStyle(
                              color: TColor.gray,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          " Времени",
                          style: TextStyle(color: TColor.gray, fontSize: 16),
                        )
                      ],
                    );
                  },
                ),
              ),
              RoundButton(title: "Сохранить", elevation: 0, onPressed: () {Navigator.pop(context);}),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
