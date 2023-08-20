import 'package:flutter/material.dart';
import 'package:instagrampj/screens/profile/grid_img_posts.dart';
import 'package:instagrampj/utils/colors.dart';

class TabBarPostsProfile extends StatefulWidget {
  const TabBarPostsProfile({super.key});

  @override
  State<TabBarPostsProfile> createState() => _TabBarPostsProfileState();
}

class _TabBarPostsProfileState extends State<TabBarPostsProfile>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex =0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabControllerChange);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabControllerChange);
    _tabController.dispose();
    super.dispose();
  }
  void _handleTabControllerChange() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.grid_on_outlined,color: _selectedIndex==0?textColor:Color.fromRGBO(0, 0, 0, 0.4),),
              ),
              Tab(
                icon: Icon(Icons.person_pin_outlined,color: _selectedIndex==1?textColor:Color.fromRGBO(0, 0, 0, 0.4),),
              ),
            ],
            indicatorColor: textColor,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  color: primaryColor,
                  child: Center(
                    child: ProfileGrid(),
                  ),
                ),
                Container(
                  color: primaryColor,
                  child: const Center(
                    child: Text("Photos and videos are present with you.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}