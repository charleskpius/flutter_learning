void main() {
  var x = cs();
  x.function();
  var xx = cs.name();
  xx.function();
}

class cs {
  cs() {
    print('This is from Default constructor');
  }
  cs.name() {
    print('This is from named constructor');
  }

  void function() {
    print('This is from function');
  } 
}