import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hadron_ide/swatches/pallette.dart';

class Menu_Bar extends StatefulWidget {
  const Menu_Bar({super.key});

  @override
  State<Menu_Bar> createState() => _Menu_BarState();
}

class _Menu_BarState extends State<Menu_Bar> {
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

    Navigator.of(context).push(
      CustomMenuOverlay(
        position: position,
        items: [
          MenuItem('File', 'file'),
          MenuItem('Edit', 'edit'),
          MenuItem('View', 'view'),
          MenuItem('Run', 'run'),
          MenuItem('Tools', 'tools'),
          MenuItem('Window', 'window'),
          MenuItem('Help', 'help'),
        ],
        onSelected: (value) {
          setState(() {
            _isMenuOpen = false;
          });
          if (value != null) {
            _handleMenuSelection(value);
          }
        },
        onDismiss: () {
          setState(() {
            _isMenuOpen = false;
          });
        },
      ),
    );
  }

  _CustomMenuItem MenuItem(String text, String value) {
    return _CustomMenuItem(
      value: value,
      child: Text(
        text,
        style: TextStyle(color: surfaceSwatch[100], fontFamily: 'Spacemono', fontSize: 12.5),
      ),
    );
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
      case 'run':
        print('Run is selected');
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

  void _handleLogin() {
    print('Login button pressed');
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
            LoginButton(onPressed: _handleLogin),
            const SizedBox(width: 8),
            WindowButtons(),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatefulWidget {
  final VoidCallback onPressed;
  const LoginButton({required this.onPressed, super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: isHovering ? primarySwatch[600] : surfaceSwatch[800],
            borderRadius: BorderRadius.circular(4),
            boxShadow: isHovering ? [BoxShadow(color: primarySwatch[400].withValues(alpha: .5), blurRadius: 4, offset: Offset(0, 2),
            )] : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.login,
                color: surfaceSwatch[100],
                size: 14,
              ),
              const SizedBox(width: 6),
              Text(
                'Login',
                style: TextStyle(
                  color: surfaceSwatch[100],
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      )
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

class CustomMenuOverlay extends PopupRoute {
  final RelativeRect position;
  final List<_CustomMenuItem> items;
  final Function(String?) onSelected;
  final VoidCallback onDismiss;

  CustomMenuOverlay({
    required this.position,
    required this.items,
    required this.onSelected,
    required this.onDismiss,
  });

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return CustomSingleChildLayout(
      delegate: _MenuLayout(position),
      child: Material(
        type: MaterialType.transparency,
        child: FadeTransition(
          opacity: animation,
          child: _AcrylicMenu(items: items, onSelected: onSelected),
        ),
      ),
    );
  }

  @override
  void didComplete(result) {
    onDismiss();
    super.didComplete(result);
  }
}

class _AcrylicMenu extends StatelessWidget {
  final List<_CustomMenuItem> items;
  final Function(String?) onSelected;

  const _AcrylicMenu({required this.items, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            color: surfaceSwatch[800].withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: surfaceSwatch[400], width: .5),
          ),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children:
                  items.map((item) {
                    return _CustomMenuItemWidget(
                      item: item,
                      onSelected: onSelected,
                    );
                  }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomMenuItem {
  final String value;
  final Widget child;

  _CustomMenuItem({required this.value, required this.child});
}

class _CustomMenuItemWidget extends StatefulWidget {
  final _CustomMenuItem item;
  final Function(String?) onSelected;

  const _CustomMenuItemWidget({required this.item, required this.onSelected});

  @override
  State<_CustomMenuItemWidget> createState() => _CustomMenuItemWidgetState();
}

class _CustomMenuItemWidgetState extends State<_CustomMenuItemWidget> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          widget.onSelected(widget.item.value);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          color: isHovering ? surfaceSwatch[800] : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Row(children: [SizedBox(width: 15), widget.item.child]),
        ),
      ),
    );
  }
}

class _MenuLayout extends SingleChildLayoutDelegate {
  final RelativeRect position;

  _MenuLayout(this.position);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
      Size(constraints.maxWidth, constraints.maxHeight),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = position.left;
    double y = position.top;

    // Ensure the menu doesn't go off-screen
    if (x + childSize.width > size.width) {
      x = size.width - childSize.width;
    }
    if (y + childSize.height > size.height) {
      y = size.height - childSize.height;
    }

    return Offset(x, y);
  }

  @override
  bool shouldRelayout(covariant _MenuLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}