import Foundation

struct Contact:Hashable {
    var name:String?
    var phone:String?
    var imgUrl:String?
    
    init(name:String,phone:String,imgUrl:String){
        self.name = name
        self.phone = phone
        self.imgUrl = imgUrl
    }
}
