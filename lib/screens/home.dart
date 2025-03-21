import 'package:flutter/material.dart';
import 'package:aurora/aurora.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hadron_ide/swatches/pallette.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  double leftPanelWidth = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceSwatch[900],
      body: Column(
        children: [
          MenuBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  bottom: -10,
                  left: -10,
                  child: Aurora(
                    size: 500,
                    colors: [
                      primarySwatch[700].withValues(alpha: .5),
                      ternarySwatch[600].withValues(alpha: .3),
                    ],
                  ),
                ),
                Positioned(
                  top: -100,
                  right: -400,
                  child: Aurora(
                    size: 1000,
                    colors: [
                      surfaceSwatch[800].withValues(alpha: .5),
                      surfaceSwatch[900].withValues(alpha: .3),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 500,
                  child: Aurora(
                    size: 300,
                    colors: [
                      surfaceSwatch[300].withValues(alpha: .1),
                      secondarySwatch[500].withValues(alpha: .7),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      SizedBox(width: leftPanelWidth, child: LeftSide()),
                      ResizableDivider(
                        onDrag: (dx) {
                          setState(() {
                            leftPanelWidth = (leftPanelWidth + dx).clamp(
                              200.0,
                              MediaQuery.of(context).size.width * 0.4,
                            );
                          });
                        },
                      ),
                      RightSide(),
                    ],
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

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  final GlobalKey _menuButtonKey = GlobalKey();
  bool _isMenuOpen = false;

  void _showDropdownMenu() {
    final RenderBox button =
        _menuButtonKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    setState(() {
      _isMenuOpen = true;
    });

    showMenu<String>(
      context: context,
      position: position,
      color: surfaceSwatch[800],
      elevation: 8,
      items: [
        PopupMenuItem<String>(
          value: 'file',
          child: Row(
            children: [
              Icon(Icons.file_open, color: primarySwatch[500], size: 14),
              SizedBox(width: 8),
              Text('File', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, color: primarySwatch[500], size: 14),
              SizedBox(width: 8),
              Text('Edit', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'view',
          child: Row(
            children: [
              Icon(Icons.view_sidebar, color: primarySwatch[500], size: 14),
              SizedBox(width: 8),
              Text('View', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'tools',
          child: Row(
            children: [
              Icon(Icons.settings, color: primarySwatch[500], size: 16),
              SizedBox(width: 8),
              Text('Tools', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'window',
          child: Row(
            children: [
              Icon(Icons.window, color: primarySwatch[500], size: 14),
              SizedBox(width: 8),
              Text('Window', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'help',
          child: Row(
            children: [
              Icon(Icons.help, color: primarySwatch[500], size: 14),
              SizedBox(width: 8),
              Text('Help', style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono')),
            ],
          ),
        ),
      ],
    ).then((String? value) {
      setState(() {
        _isMenuOpen = false;
      });

      if (value != null) {
        _handleMenuSelection(value);
      }
    });
  }

  void _handleMenuSelection(String value) {
    switch (value) {
      case 'file':
        print('File is selected');
        break;
      case 'edit':
        print('Edit is selected');
        break;
      case 'view':
        print('View is selected');
        break;
      case 'tools':
        print('Tools is selected');
        break;
      case 'window':
        print('Window is selected');
        break;
      case 'help':
        print('Help is selected');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Container(
        color: surfaceSwatch[900],
        child: Row(
          children: [
            IconButton(
              key: _menuButtonKey,
              icon: Icon(
                _isMenuOpen ? Icons.menu_open : Icons.menu,
                color: _isMenuOpen ? primarySwatch[100] : surfaceSwatch[100],
                size: 17,
              ),
              onPressed: _showDropdownMenu,
            ),
            Expanded(
              child: MoveWindow(child: Container(color: surfaceSwatch[900])),
            ),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: surfaceSwatch[800].withValues(alpha: .5),
        child: Column(),
      ),
    );
  }
}

class ResizableDivider extends StatefulWidget {
  final Function(double) onDrag;

  const ResizableDivider({required this.onDrag, super.key});

  @override
  State<ResizableDivider> createState() => ResizableDividerState();
}

class ResizableDividerState extends State<ResizableDivider> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onPanUpdate: (details) {
          widget.onDrag(details.delta.dx);
        },
        child: Container(
          width: 5,
          color: Colors.transparent,
          child: Center(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              curve: Curves.easeInOut,
              width: isHovering ? 3.0 : 0.2,
              height: double.infinity,
              decoration:
                  isHovering
                      ? BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [primarySwatch[500], secondarySwatch[500]],
                        ),
                      )
                      : BoxDecoration(color: surfaceSwatch[500]),
            ),
          ),
        ),
      ),
    );
  }
}

class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(color: surfaceSwatch[900].withValues(alpha: .2)),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(),
      ],
    );
  }
}
