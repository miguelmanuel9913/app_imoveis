import 'package:biolo_app/layers/presentation/ui/controller/theme/dark_and_light_switch_controller.dart';
import 'package:biolo_app/layers/presentation/ui/pages/favorite_page/favorite_page.dart';
import 'package:biolo_app/layers/presentation/ui/pages/home/principal.dart';
import 'package:biolo_app/layers/presentation/ui/pages/profile/profile.dart';
import 'package:biolo_app/layers/presentation/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import '../../../components/colors_const.dart';


class PaginaInicial extends StatefulWidget {
  const PaginaInicial({
    super.key,
  });

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
PageController controlllerPage = PageController();
int controllerCountPage =0;

static final List<Widget> _pageList =<Widget>[

  const Principal(),
  const FavoritePage(),
  const ProfileUser(),
  Container(color: Colors.white,),

];
int _seletedIndexGnav=0;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     
    body:_pageList.elementAt(_seletedIndexGnav
          ),
       bottomNavigationBar:Padding(
         padding: const EdgeInsets.all(20.0),
         child:
            Container(

          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color
            :ColorsConst.sunstColor10,
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.black.withOpacity(.1),
              )
            ],
         ),
               child: SafeArea(  
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                backgroundColor:ColorsConst.sunstColor10,
                tabBorderRadius: 20,
         
                rippleColor: ColorsConst.sunstColor10,
                hoverColor:ColorsConst.sunstColor8!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: ColorsConst.sunstColor8,
                 selectedIndex: _seletedIndexGnav,
                onTabChange: (index) {
                  setState(() {
                    _seletedIndexGnav = index;
                  });
                },
                tabs: [
                  GButton(
                    
                    backgroundColor: ColorsConst.sunstColor8,
                    borderRadius: BorderRadius.circular(20),
               iconColor: ColorsConst.sunstColor8,
               activeBorder: Border.all(
                 color: ColorsConst.sunstColor8!,

                 width: 1,
               ),
               icon: LineIcons.home,
               text: 'Home',
             ),
             GButton(
                 
                    backgroundColor: ColorsConst.sunstColor8,
                    borderRadius: BorderRadius.circular(20),
               iconColor: ColorsConst.sunstColor8,
               activeBorder: Border.all(
                 color: ColorsConst.sunstColor8!,

                 width: 1,
               ),
               icon: LineIcons.heart,
               text: 'Likes',
             ),
             GButton(
                 
                    backgroundColor: ColorsConst.sunstColor8,
                    borderRadius: BorderRadius.circular(20),
               iconColor: ColorsConst.sunstColor8,
               activeBorder: Border.all(
                 color: ColorsConst.sunstColor8!,

                 width: 1,
               ),
               icon: LineIcons.user,
               text: 'Profile',
             ),
             GButton(
                 
                    backgroundColor: ColorsConst.sunstColor8,
                    borderRadius: BorderRadius.circular(20),
               iconColor: ColorsConst.sunstColor8,
               activeBorder: Border.all(
                 color: ColorsConst.sunstColor8!,

                 width: 1,
               ),
               icon: LineIcons.cog,
               text: 'Configurações',
                  ),
                ],
               
              ),
            ),
          ),
               ),
       ),
    );
  }
}
