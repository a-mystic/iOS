import Darwin
var number : Int? = 3

if let unwrapnumber = number{
    print(unwrapnumber)
    
}


func unwrap(parameter: Int?){
    guard let unwrapsecond = parameter else{
        return
    }
    print(unwrapsecond)
}

unwrap(parameter: 3)


func say(funtion:() -> Void){
    sleep(2)
    funtion()
}

say(funtion:{
    print("sleep2")
})

func saysecond(funtion:(Any) -> Void) {
    sleep(2)
    funtion(45)
}

saysecond(funtion: { data in
    print("saysecondcall:\(data)")
})


protocol Naming{
    var name : String {get set}
    
    func getname(parameter: String) -> String
}

struct space : Naming{
    var name: String
    
    func getname(parameter : String) -> String {
        return self.name + parameter
    }
}

var sp = space(name: "mystic").getname(parameter: "hello")
print(sp)


protocol Aging{
    var age : String {get set}
    func getage() -> String
}

extension Aging{
    func getage()->String{
        return self.age
    }
}

struct age : Aging{
    var age: String
}

print(age(age: "20").getage())
