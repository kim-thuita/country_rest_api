import 'package:untitled/remote_services.dart';
import 'package:untitled/second_screen.dart';

import 'post.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class FirstPage extends StatefulWidget {
  String? id = 'firstpage';

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<CountryList>? countries;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    countries = await Remote().getData();
    if (countries != null) {
      setState(
        (() {
          isLoaded = true;
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Explore",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isboolicon = !isboolicon;
              });
            },
            icon: Icon(isboolicon ? darkicon : lighticon),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(97, 133, 122, 122),
                    hintText: "Search Country",
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: Icon(Icons.search))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.language,
                      color: Colors.black,
                    ),
                    Text(
                      'EN',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.filter_alt,
                      color: Colors.black,
                    ),
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: isLoaded,
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: countries.toString().length,
                  itemBuilder: (context, index) {
                    String timezone = '';
                    for (int i = 0;
                        i < countries![index].timezones!.length;
                        i++) {
                      timezone =
                          timezone + countries![index].timezones![i] + '';
                    }
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SecondPage(
                                name:
                                    countries![index].name!.official.toString(),
                                subregion:
                                    countries![index].subregion.toString(),
                                zone: timezone,
                                flag: countries![index].flags?.png.toString(),
                                population:
                                    countries![index].population!.toString(),
                                region: countries![index].region!.toString(),
                                capital: countries![index].capital.toString(),
                                religion: countries![index]
                                    .name!
                                    .nativeName
                                    .toString(),
                                language:
                                    countries![index].name!.common.toString(),
                                group: countries![index].subregion.toString(),
                                currency: countries![index]
                                    .currencies!
                                    .bBD
                                    .toString(),
                                government: countries![index].cca2.toString(),
                                area: countries![index].area.toString(),
                                code: countries![index].idd!.root.toString(),
                                side: countries![0].car?.side.toString(),
                              ),
                            ),
                          );
                        },
                        leading: Container(
                          height: 40.0,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(countries![index]
                                      .flags!
                                      .png
                                      .toString()))),
                        ),
                        title:
                            Text(countries![index].name!.official.toString()),
                      ),
                    );
                  }),
            ),
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}


