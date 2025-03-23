import 'package:flutter/material.dart';
import 'package:aurora/aurora.dart';
// import 'package:pixel_snap/pixel_snap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadron_ide/screens/components/status_bar.dart';
import 'package:hadron_ide/swatches/pallette.dart';
import 'package:hadron_ide/screens/components/menu_bar.dart';

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
            Menu_Bar(),
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
            Status_Bar(),
          ],
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
        color: surfaceSwatch[900].withValues(alpha: .5),
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
      child: Container(
        color: surfaceSwatch[900].withValues(alpha: .0),
        child: Center(
          child: Container(
            width: 550,
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/hadron_logo.svg',
                      semanticsLabel: 'HadronLogo',
                      width: 36,
                      height: 36,
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'Hadron',
                      style: TextStyle(
                        color: surfaceSwatch[100],
                        fontSize: 36,
                        fontFamily: 'Spacemono',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(thickness: .3, color: surfaceSwatch[200], indent: 100, endIndent: 100,),
                const SizedBox(height: 16),
                Text(
                  'Get Started',
                  style: TextStyle(
                    color: surfaceSwatch[200],
                    fontSize: 15,
                    fontFamily: 'Spacemono',
                  ),
                ),
                const SizedBox(height: 10),
                _buildActionCard(
                  icon: Icons.note_add_rounded,
                  title: 'New project',
                  description: 'Start a new project from scratch.',
                  onTap: () {
                    print('New project button tapped');
                  },
                ),
                const SizedBox(height: 10),
                _buildActionCard(
                  icon: Icons.open_in_new_rounded,
                  title: 'Open project',
                  description: 'Open an existing project.',
                  onTap: () {
                    print('Open project button tapped');
                  },
                ),
                const SizedBox(height: 10),
                _buildActionCard(
                  icon: Icons.cloud_circle,
                  title: 'New from VCS',
                  description:
                      'Start a new project from a version control system (Github).',
                  onTap: () {
                    print('New project from VCS button tapped');
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  'Learn & Explore',
                  style: TextStyle(
                    color: surfaceSwatch[200],
                    fontSize: 15,
                    fontFamily: 'Spacemono',
                  ),
                ),
                const SizedBox(height: 10),
                _buildActionCard(
                  icon: Icons.school_outlined,
                  title: 'Tutorial',
                  description: 'Learn how to use Hadron IDE effectively',
                  onTap: () {
                    // TODO: Implement tutorial
                    print('Tutorial selected');
                  },
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Hadron IDE Project ', style: TextStyle(fontSize: 10, color: surfaceSwatch[100]),),
                    Text('v1.0.0', style: TextStyle(fontSize: 10, color: secondarySwatch[500]),),
                    // SvgPicture.asset()
                  ]
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primarySwatch[900].withValues(alpha: .5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: surfaceSwatch[300], size: 18),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: surfaceSwatch[50],
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: surfaceSwatch[300],
                        fontSize: 11,
                        fontFamily: 'Spacemono',
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: surfaceSwatch[400],
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}