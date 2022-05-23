import Foundation

func b_1463(N : Int) -> Int{
    var counter : Int = 0
    var input : Int = N
    while !(input == 1){
        if((input>3 && (input-1) % 3 == 0) || (input>2 && (input-1) % 2 == 0)){
            input = input - 1
            counter = counter + 1
            if (input % 3 == 0){
                input = input / 3
                counter = counter + 1
            }
            else if (input % 2 == 0){
                input = input / 2
                counter = counter + 1
            }
            else {
                input = input - 1
                counter = counter + 1
            }
        }
        else{
            if (input % 3 == 0){
                input = input / 3
                counter = counter + 1
            }
            else if (input % 2 == 0){
                input = input / 2
                counter = counter + 1
            }
            else {
                input = input - 1
                counter = counter + 1
            }
        }
    }
    return counter
}
