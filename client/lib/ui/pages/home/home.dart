import 'package:Tempo/ui/widgets/navigation/actions_menu.dart';
import 'package:Tempo/ui/widgets/navigation/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/project.dart';
import 'meeting_list.dart';
import 'task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controller;
  int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = 0;
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(_tabHandler);
  }

  _tabHandler() => setState(() => _selectedTabIndex = _controller.index);

  @override
  Widget build(BuildContext context) {
    bool isProjectTab = _selectedTabIndex == 0;

    Project project = Provider.of<Project>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(isProjectTab ? project.name : 'Meetings'),
        actions: [ ActionsMenu() ],
        bottom: TabBar(
          controller: _controller,
          tabs: <Tab>[
            Tab(text: 'TASKS'),
            Tab(text: 'MEETINGS')
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          TaskListScreen(project.tasks),
          MeetingListScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isProjectTab ? 'Add Task' : 'Schedule Meeting',
        child: Icon(isProjectTab ? Icons.add : Icons.schedule),
        onPressed: () {
          if (isProjectTab) TaskListScreen.addTask(context);
          else Navigator.pushNamed(context, '/addmeeting');
        },
      ),
    );
  }
}