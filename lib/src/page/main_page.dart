import 'package:examen2p_ruilova/src/widgets/travel_form.dart';
import 'package:examen2p_ruilova/src/widgets/travel_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> 
with SingleTickerProviderStateMixin{
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Formulario'),
    Tab(text: 'Listado'),
  ];

  late TabController _tabController;

   @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Examen SQLITE'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: 
      TabBarView(
        controller: _tabController,
        children: [TravelForm(), TravelList()],
      ),
    );
  }
}