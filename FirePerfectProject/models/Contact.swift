import Foundation

struct Contact:Hashable {
    var name:String?
    var phone:String?
    
    init(name:String,phone:String){
        self.name = name
        self.phone = phone
    }
}
