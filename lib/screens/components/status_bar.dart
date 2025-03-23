//status bar widget

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:system_resources/system_resources.dart';
import 'package:hadron_ide/swatches/pallette.dart';

class Status_Bar extends StatefulWidget {
  const Status_Bar({super.key});

  @override
  State<Status_Bar> createState() => _Status_BarState();
}

class _Status_BarState extends State<Status_Bar> {
  late Timer _timer;
  String _currentTime = '';
  String _cpuUsage = '0%';
  String _memoryUsage = '0MB';

  @override
  void initState() {
    super.initState();
    _updateTime();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
      _updateSystemResources();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void  _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm').format(DateTime.now());
    });
  }

  Future<void> _updateSystemResources() async {
    try {
      final cpuPercentage = await SystemResources.cpuLoadAvg();
      final usedMemory = await SystemResources.memUsage();

      final usedMemoryMB = (usedMemory / (1024 * 1024)).round();

      setState(() {
        _cpuUsage = '${cpuPercentage.round()}%';
        _memoryUsage = '$usedMemoryMB MB';
      });
    } catch (e) {
      setState(() {
        _cpuUsage = 'N/A';
        _memoryUsage = 'N/A';
      });
      print('Error fetching system resources:  $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primarySwatch[800], secondarySwatch[800]],
        ),
        border: Border(top: BorderSide(color: surfaceSwatch[500], width: .7)),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 10, color: Color(0xff00ff51)),
          const SizedBox(width: 6),
          Text(
            'IDE status : Ready',
            style: TextStyle(color: surfaceSwatch[100], fontSize: 11),
          ),
          const Spacer(),
          _buildStatusItem(Icons.memory, 'CPU: $_cpuUsage'),
          const SizedBox(width: 20),
          _buildStatusItem(Icons.storage, 'Memory: $_memoryUsage'),
          const SizedBox(width: 12),
          Text(
            _currentTime,
            style: TextStyle(color: surfaceSwatch[100], fontSize: 11),
          ),
        ],
      ),
    );
  }
}

Widget _buildStatusItem(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 14, color: surfaceSwatch[100]),
      const SizedBox(width: 4),
      Text(text, style: TextStyle(color: surfaceSwatch[100], fontSize: 11)),
    ],
  );
}
