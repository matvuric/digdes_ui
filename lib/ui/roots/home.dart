import 'package:digdes_ui/data/services/auth_service.dart';
import 'package:digdes_ui/ui/app_navigator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = AuthService();

  int _counter = 0;
  bool _showFab = true;
  bool _showNotch = true;
  FloatingActionButtonLocation _fabLocation =
      FloatingActionButtonLocation.centerDocked;

  void _onShowNotchChanged(bool value) {
    setState(() {
      _showNotch = value;
    });
  }

  void _onShowFabChanged(bool value) {
    setState(() {
      _showFab = value;
    });
  }

  void _onFabLocationChanged(FloatingActionButtonLocation? location) {
    setState(() {
      _fabLocation = location ?? FloatingActionButtonLocation.centerDocked;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _logOut() {
    _authService.logOut().then((value) => AppNavigator.toLoader());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} - $_counter"),
        actions: [
          IconButton(
              onPressed: _logOut, icon: const Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        children: [
          SwitchListTile(
            value: _showNotch,
            onChanged: _onShowNotchChanged,
            title: const Text("Notch"),
          ),
          SwitchListTile(
            value: _showFab,
            onChanged: _onShowFabChanged,
            title: const Text("Fab"),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text("Fab locations"),
          ),
          RadioListTile(
            value: FloatingActionButtonLocation.centerDocked,
            groupValue: _fabLocation,
            onChanged: _onFabLocationChanged,
            title: const Text("centerDocked"),
          ),
          RadioListTile(
            value: FloatingActionButtonLocation.endDocked,
            groupValue: _fabLocation,
            onChanged: _onFabLocationChanged,
            title: const Text("endDocked"),
          ),
          RadioListTile(
            value: FloatingActionButtonLocation.centerFloat,
            groupValue: _fabLocation,
            onChanged: _onFabLocationChanged,
            title: const Text("centerFloat"),
          ),
          RadioListTile(
            value: FloatingActionButtonLocation.endFloat,
            groupValue: _fabLocation,
            onChanged: _onFabLocationChanged,
            title: const Text("endFloat"),
          ),
        ],
      ),
      floatingActionButton: !_showFab
          ? null
          : Wrap(children: [
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ]),
      floatingActionButtonLocation: _fabLocation,
      bottomNavigationBar: _BottomAppBarTest(
        fabLocation: _fabLocation,
        shape: _showNotch ? const CircularNotchedRectangle() : null,
      ),
    );
  }
}

class _BottomAppBarTest extends StatelessWidget {
  _BottomAppBarTest({required this.fabLocation, this.shape});

  final FloatingActionButtonLocation fabLocation;
  final CircularNotchedRectangle? shape;
  final centerVariants = [
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: shape,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: centerVariants.contains(fabLocation)
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
          ],
        ));
  }
}
