import 'package:deneme/bloc/menu/menu_bloc.dart';
import 'package:deneme/config/app_constant.dart';
import 'package:deneme/data/model/svg_avatar.dart';
import 'package:deneme/data/model/user.dart';
import 'package:deneme/util/http/http_manager.dart';
import 'package:deneme/util/screen_util.dart';
import 'package:deneme/widget/drop_down_picker_form_field_widget.dart';
import 'package:deneme/widget/form_input_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

class AvatarPickerPage extends StatefulWidget {
  static const String PATH = "/avatarPicker";
  final ValueSetter<SvgAvatar> avatar;

  const AvatarPickerPage({Key key, this.avatar}) : super(key: key);

  @override
  _AvatarPickerPageState createState() => _AvatarPickerPageState();
}

class _AvatarPickerPageState extends State<AvatarPickerPage> {
  MenuBloc menuBloc;
  User user = HttpManager.user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuBloc = MenuBloc()..add(GetAvatarsEvent());
  }

  @override
  void dispose() {
    menuBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1080),
      width: ScreenUtil().setWidth(900),
      child: BlocBuilder<MenuBloc, MenuState>(
        cubit: menuBloc,
        builder: (context, state) {
          if (state is AvatarsLoadedState) {
            return GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 8,
                children: state.avatars
                    .map<Widget>((e) => GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: SvgPicture.string(e.avatarSvg),
                          ),
                          onTap: () {
                            widget.avatar(e);
                            Get.back();
                          },
                        ))
                    .toList());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
