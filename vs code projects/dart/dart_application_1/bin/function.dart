void main() {
  function1();
  print(function2());
  function3('this is from main function');
}

void function1 () {
  print('its just a function');
}

String function2() {
  return 'this is returned string';
}

void function3(String str) {
  print(str);
}