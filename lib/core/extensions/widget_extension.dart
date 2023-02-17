import 'package:flutter/material.dart';

extension SliverWidget on Widget {
  SliverToBoxAdapter toSliverNoPadding() {
    return SliverToBoxAdapter(
      child: this,
    );
  }

  SliverPadding toSliverPadding(double horizontal, double vertical) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      sliver: this,
    );
  }
}
