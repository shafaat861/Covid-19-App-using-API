import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/Utilites/states_services.dart';
import 'package:covid_tracker/View/countriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  _WorldStatesState createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {


  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }


  WorldStatesModel newsListViewModel = WorldStatesModel();

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices=StatesServices();

    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height:  MediaQuery.of(context).size.height * .01,),
                FutureBuilder(
                    future: statesServices.fetchWorldRecords(),
                    builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                      if(snapshot.hasData){

                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ),
                        );
                      }else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: const{
                                "Total": 54345,
                                "Recovered": 453454,
                                "Deaths": 345345,
                              },
                              animationDuration: Duration(milliseconds: 1200),
                              chartLegendSpacing: 32,
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              colorList: colorList,
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 25,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                                decimalPlaces: 1,
                              ),

                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: 'Total Cases', value: '65675675765'),
                                    ReusableRow(title: 'Deaths', value: '786786786'),
                                    ReusableRow(title: 'Recovered', value: '7868767867'),
                                    ReusableRow(title: 'Active', value: '6786876786'),



                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CountryList()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius:BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value ;
  ReusableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 1,),
          Divider()
        ],
      ),
    );
  }
}