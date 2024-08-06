import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class StarRatingWidget extends StatelessWidget {
  final int starCount;
  final double? rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;
  final Color? borderColor;
  final double? size;
  final bool allowHalfRating;
  final double spacing;
  final Widget label;
  final bool onlyShow;

  const StarRatingWidget({
    super.key,
    this.starCount = 5,
    this.rating = 0.0,
    this.onRatingChanged,
    this.color,
    this.borderColor,
    this.size,
    this.spacing = 0.0,
    this.label = const SizedBox(),
    this.allowHalfRating = true,
    this.onlyShow = false,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating!) {
      icon = Icon(
        Icons.star_border,
        color: borderColor ?? Theme.of(context).primaryColor,
        size: size ?? 25.0,
      );
    } else if (index > rating! - (allowHalfRating ? 1.0 : 0.5) &&

        /// seem nonsense but it works :)
        index < rating!) {
      icon = Icon(
        Icons.star_half,
        color: color ?? Theme.of(context).primaryColor,
        size: size ?? 25.0,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color ?? Theme.of(context).primaryColor,
        size: size ?? 25.0,
      );
    }

    if (onRatingChanged == null) {
      return icon;
    }

    return GestureDetector(
      onTap: () {
        if (onRatingChanged != null) {
          onRatingChanged!(index + 1.0);
        }
      },
      onHorizontalDragUpdate: (dragDetails) {
        final box = context.findRenderObject() as RenderBox;
        final pos = box.globalToLocal(dragDetails.globalPosition);
        final i = pos.dx / size!;
        var newRating = allowHalfRating ? i : i.round().toDouble();

        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }
        if (onRatingChanged != null) {
          onRatingChanged!(newRating);
        }
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.start,
          spacing: spacing,
          children:
              List.generate(starCount, (index) => buildStar(context, index)),
        ),
        const SizedBox(width: 4),
        label,
      ],
    );
  }
}
