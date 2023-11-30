import 'package:flutter/material.dart';
import 'package:untitled/screens/tabs/tab1.dart';
import 'package:untitled/screens/tabs/tab2.dart';
import 'package:untitled/screens/tabs/tab3.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                tabs: [
                  _buildTab('Sign Up'),
                  _buildTab('Log In'),
                  _buildTab('Forgot Password'),
                ],
                labelColor: Color(0xFF515C6F),
                unselectedLabelColor: Colors.black.withOpacity(0.3),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.0, color: Colors.transparent),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Tab1Content(),
                      Tab2Content(),
                      Tab3Content(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
