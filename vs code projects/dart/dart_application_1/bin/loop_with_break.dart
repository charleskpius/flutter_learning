void main(List<String> arguments) {
  for(int i = 0; i <= 5; i++) {
    print(i);
    if(i == 5) {
      print('breaked in $i');
      break;
    }
  }
}