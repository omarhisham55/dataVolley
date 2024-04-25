import 'package:data_volley_match/core/utils/colors.dart';
import 'package:flutter/material.dart';

class Tabs<T> extends StatefulWidget {
  final int length;
  final List<String> tabs;
  final List<Widget> tabsBody;
  final List<Widget>? actions;
  final bool? isScrollable;
  const Tabs({
    super.key,
    required this.length,
    required this.tabs,
    required this.tabsBody,
    this.actions,
    this.isScrollable = false,
  });

  @override
  State<Tabs<T>> createState() => _TabsState<T>();
}

class _TabsState<T> extends State<Tabs<T>> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: widget.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: widget.actions,
        bottom: TabBar(
          controller: _controller,
          isScrollable: widget.isScrollable!,
          tabs: widget.tabs
              .map(
                (tab) => Tab(
                  text: tab,
                ),
              )
              .toList(),
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          indicatorColor: MainColors.buttonColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          dividerColor: MainColors.primaryColor,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          widget.length,
          (index) => widget.tabsBody[index],
        ),
      ),
    );
  }
}
