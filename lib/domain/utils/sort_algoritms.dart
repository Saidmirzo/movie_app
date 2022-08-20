import 'package:move_app/domain/models/movie_model.dart';

class SortAlgoritm {
  bool greater<T extends Comparable>(dynamic v, dynamic w) {
    return v.compareTo(w) > 0;
  }

  bool swap<T>(List<T> array, int idx, int idy) {
    T swap = array[idx];
    array[idx] = array[idy];
    array[idy] = swap;
    return true;
  }

  List<MovieModel> sort(List<MovieModel> list, List array) {
   
    
    for (int i = 1, size = array.length; i < size; ++i) {
      bool swapped = false;
      for (int j = 0; j < size - i; ++j) {
        if (greater(array[j], array[j + 1])) {
          swap(array, j, j + 1);
          swap(list, j, j + 1);
          swapped = true;
        }
      }
      if (!swapped) {
        break;
      }
    }
    return list;
  }
  
}
