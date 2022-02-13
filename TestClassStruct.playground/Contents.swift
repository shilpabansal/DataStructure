func test(_ testA: A) {
    testA.value = 6
}

class A {
    var value = 0
}

struct B {
    let a = A()
}
let b = B()
b.a.value = 5
test(b.a)
print(b.a.value)
