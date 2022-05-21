import Foundation
import Firebase
import FirebaseDatabase
import Combine

class RealTimeStore:ObservableObject {
    var ref:DatabaseReference = Database.database().reference(withPath: "Contacts")
    @Published var items:[Contact] = []
    
    func storePost(contact:Contact,complation: @escaping (_ success:Bool) -> ()){
        var success = true
        let tobePosted = ["name":contact.name!,"phoneNumber":contact.phone!]
        
        ref.childByAutoId().setValue(tobePosted){ (res,error) -> Void in
            if error != nil {
                success = false
            }
        }
        complation(success)
    }
    
    func loadPost(complation:@escaping () -> ()) {
        ref.observe(DataEventType.value){ (snapshot) in
            self.items = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    let value = snapshot.value as? [String: AnyObject]
                    let name = value!["name"] as? String
                    let phone = value!["phoneNumber"] as? String
                   // let imgUrl = value!["imgUrl"] as? String
                    self.items.append(Contact(name: name ?? "", phone: phone ?? ""))
                }
            }
            complation()
        }
    }
    
}
