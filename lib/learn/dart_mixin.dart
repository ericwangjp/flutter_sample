// 如果多个mixin 中有同名方法，with 时，会默认使用最后面的 mixin 的，mixin 方法中可以通过 super 关键字调用之前 mixin 或类中的方法
class Person {
  say() {
    print("say");
  }

  think(){
    print("person think");
  }

}

mixin Eat {
  eat() {
    print("eat");
  }

  think(){
    print("eat think");
  }
}

mixin Walk {
  walk() {
    print("walk");
  }

  think(){
    print("walk think");
  }
}

mixin Code {
  code() {
    print("key");
  }

  think(){
    print("code think");
  }
}

class Dog with Eat, Walk {
  @override
  think() {
    print("dog think");
    super.eat();
    // return super.think();
  }
}

class Man extends Person with Eat, Walk, Code {}
