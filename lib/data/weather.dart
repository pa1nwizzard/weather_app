class Weather {
  List<List<dynamic>> degreesCelsius = [];
  List<List<dynamic>> dateTimes = [];

  List<List<dynamic>> splitter(List<dynamic> A) {
    int n = 0;
    List<List<dynamic>> res = [];
    for (int i = 0; i < A.length; i++) {
      if (i - n == 23) {
        res.add(A.sublist(n, i+1));
        n = i+1;
      }
    }
  
    return res;
  }
}