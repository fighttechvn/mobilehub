import 'package:flutter/material.dart';

class DotSlideWidget extends StatelessWidget {
  const DotSlideWidget({
    super.key,
    required this.countItem,
  });

  final int countItem;

  @override
  Widget build(BuildContext context) {
    var totalItem = countItem;
    if (countItem % 2 == 0) {
      totalItem--;
    }
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: totalItem,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemBuilder: (context, index) {
        final size = index % 2 == 0 ? 2.0 : 5.0;
        return Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            width: size,
            height: size,
          ),
        );
      },
    );
  }
}
