import 'package:flutter/material.dart';
import 'package:vtc_application/models/dao_user.dart';
import 'package:vtc_application/ui/screens/add_reservation.dart';
import 'package:vtc_application/ui/screens/reservation.dart';
import 'package:vtc_application/ui/screens/start_page.dart';
import 'package:vtc_application/ui/commons/design.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  bool oneTime = true;

  @override
  Widget build(BuildContext context) {
    final Map args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final DAOUser user = args['user'];
    int? idCurrentTab = args['idCurrentTab'];
    if (oneTime) {
      idCurrentTab != null ? currentTab = idCurrentTab : 0;
      oneTime = false;
    }
    List screens = [
      StartPage(user),
      Reservation(user),
      AddReservation(user),
      Settings(user)
    ];
    return Scaffold(
      body: screens[currentTab],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.house,
                            color: currentTab == 0
                                ? AppColors.secondaryColor
                                : Colors.grey,
                          ),
                          Text(
                            'Accueil',
                            style: TextStyle(
                              color: currentTab == 0
                                  ? AppColors.secondaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet,
                            color: currentTab == 1
                                ? AppColors.secondaryColor
                                : Colors.grey,
                          ),
                          Text(
                            'Réservations',
                            style: TextStyle(
                              color: currentTab == 1
                                  ? AppColors.secondaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_box_outlined,
                            color: currentTab == 2
                                ? AppColors.secondaryColor
                                : Colors.grey,
                          ),
                          Text(
                            'Rendez-vous',
                            style: TextStyle(
                              color: currentTab == 2
                                  ? AppColors.secondaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: currentTab == 3
                                ? AppColors.secondaryColor
                                : Colors.grey,
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              color: currentTab == 3
                                  ? AppColors.secondaryColor
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
