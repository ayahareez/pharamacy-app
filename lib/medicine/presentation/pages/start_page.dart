import 'package:flutter/material.dart';
import 'package:pharmacy/user/presentation/pages/login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double height = constraints.maxHeight;
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 80),
            child: AppBar(
              title: const Text(
                'Pharmacy',
                style: TextStyle(
                    fontFamily: 'CrimsonText-Regular',
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              centerTitle: true,
            ),
          ),
          body: Column(
            children: [
              Image.asset(
                'assets/images/halil-nuroglu-KReIqVw1qsQ-unsplash.jpg',
                height: height / 4,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Welcome to the Pharmacy',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CrimsonText-Regular',
                    fontSize: 24),
              ),
              Container(
                margin: const EdgeInsetsDirectional.all(16),
                width: double.infinity,
                height: 1,
                color: Colors.grey[500],
              ),
              Container(
                padding: const EdgeInsetsDirectional.all(16),
                child: Text(
                  'Homeopathy is a complementary medicine founded by the German physicist Samuel Hahnemann in the 1790s.'
                  ' It relies on the principle of "like cures like", meaning a'
                  ' substance given in small dose to an ill person treats the'
                  ' symptoms that in large doses it would induce in a'
                  ' healthy person. Thus in practice it consists of remedies'
                  'that are potentised, meaning they have been subjected'
                  'to repeated dilution and succession. These remedies'
                  'should in turn stimulate the bodies own healing abilities.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CrimsonText-Regular',
                      fontSize: 14),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsetsDirectional.all(24),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    //e8D0aa
                    //ffe8d6
                    backgroundColor: const Color(0xfff5e0c0),
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'CrimsonText-Regular'),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}