import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  // Page View Stuff -- Start --
  PageController pageController = PageController(
    initialPage: 0,
  );
  List<Widget> screens = [
    Scaffold(appBar: AppBar( backgroundColor: Colors.deepPurpleAccent ), backgroundColor: Colors.pink[800] ),
    Scaffold(appBar: AppBar( backgroundColor: Colors.deepPurpleAccent ), backgroundColor: Colors.green ),
    Scaffold(appBar: AppBar( backgroundColor: Colors.deepPurpleAccent ), backgroundColor: Colors.purple ),
  ];
  // Page View Stuff -- End --

  // Animation Stuff -- Start --
  late AnimationController controller;
  late Animation<Offset> animation;
  late Animation<double> sAnimation;
  late Animation<double> borderRadiusAnimation;
  late Animation<double> testAnimation;
  // Animation Stuff -- End --

  @override
  void initState(){ super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300), reverseDuration: const Duration(milliseconds: 300));
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(0.5, 0)).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutSine));
    sAnimation = Tween<double>(begin: 1, end: 0.9).animate(controller);
    borderRadiusAnimation = Tween<double>(begin: 5, end: 20).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      children: [
        Container(
          height: height,
          width: width,
          color: Colors.deepPurple,
          child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton( onPressed: (){
                  pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  controller.reverse();
                },
                child: const Text("P a g e   O n e", style: TextStyle(color: Colors.white),),
              ),
              TextButton( onPressed: (){
                  pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  controller.reverse();
                },
                child: const Text("P a g e   T w o", style: TextStyle(color: Colors.white),),
              ),
              TextButton( onPressed: (){
                  pageController.animateToPage(2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                  controller.reverse();
                },
                child: const Text("P a g e   T h r e e", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
        ScaleTransition( scale: sAnimation,
          child: SlideTransition( position: animation,
            child: Container( height: height, width: width,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow( color: Colors.black, blurRadius: 30, spreadRadius: -20 )
                ]
              ),
              child: AnimatedBuilder( animation: controller, builder: (context, child) => ClipRRect(borderRadius: BorderRadius.circular(borderRadiusAnimation.value),
                  child: GestureDetector(
                    onTap: () => controller.reverse(),
                    child: Scaffold(
                      body: PageView( controller: pageController, children: screens, scrollDirection: Axis.horizontal ),
                      floatingActionButton: FloatingActionButton( onPressed: () => controller.forward() ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}