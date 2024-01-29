void main () {
  var obj = cs();
  print(obj.x);
}

class cs {
  var x = 'This is varable x and is a field';
  cs() {
    var y = 'This is cariable y from the constructor';
    print(y);
  }
}