import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class StatusMenuItems extends StatefulWidget {
  final String title, image;
  final bool textDim, trailingIcon;

  const StatusMenuItems(
      {Key key,
      this.title,
      this.image,
      this.textDim = false,
      this.trailingIcon = false})
      : super(key: key);
  @override
  _StatusMenuItemsState createState() => _StatusMenuItemsState();
}

class _StatusMenuItemsState extends State<StatusMenuItems> {
  Color _hoverColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: _hoverColor,
      padding: const EdgeInsets.only(left: defaultPadding),
      height: 30.0,
      child: InkWell(
        onHover: (hover) {
          setState(() {
            if (hover)
              _hoverColor = Colors.white.withOpacity(0.3);
            else
              _hoverColor = Colors.transparent;
          });
        },
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(right: defaultPadding),
          child: Row(
            children: [
              SvgPicture.asset(widget.image),
              const SizedBox(width: defaultPadding),
              Text(
                widget.title,
                style: widget.textDim
                    ? Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.white54)
                    : Theme.of(context).textTheme.subtitle1,
              ),
              Spacer(),
              widget.trailingIcon ? Icon(Icons.arrow_right) : Offstage(),
            ],
          ),
        ),
      ),
    );
  }
}
