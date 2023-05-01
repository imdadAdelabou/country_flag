import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jovial_svg/jovial_svg.dart';
import 'package:pokemon/models/country.dart';
import 'package:pokemon/services/dio_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<List<Country>> getCountries() async {
    var response = await DioService().get(path: "/countries");
    if (response.data != null) {
      print(response.data);
      return (response.data["response"] as List)
          .map((e) => Country.fromMap(data: e))
          .toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(30.0),
            Center(
              child: Text(
                "Countries",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                ),
              ),
            ),
            const Gap(30.0),
            FutureBuilder<List<Country>>(
              future: getCountries(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                  );
                }
                if (snapshot.data != null) {
                  if (snapshot.data!.isEmpty) {
                    return Text(
                      "No countries show",
                      style: GoogleFonts.poppins(),
                    );
                  }
                  var data = snapshot.data;

                  return GridView.builder(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: SvgPicture.network(
                              data[index].flag,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  snapshot.data![index].name,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30.0,
                                  ),
                                ),
                                const Gap(8.0),
                                Text(snapshot.data![index].code),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
