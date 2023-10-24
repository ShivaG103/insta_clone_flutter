import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController; //for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool exit = false;
    return WillPopScope(
      onWillPop: () async {
        // return false;
        await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              shrinkWrap: true,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    const SizedBox(height: 20),
                    const Text('Are you sure you want to exit ?'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          exit = true;
                          Navigator.pop(context);
                        },
                        child: const Text('Yes')),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                  ]),
                )
              ],
            ),
          ),
        );
        return exit;
      },
      child: Scaffold(
        body: PageView(
          children: homeScreenItems,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileBackgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ],
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
