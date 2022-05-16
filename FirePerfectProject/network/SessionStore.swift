import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject{
    var didchange = PassthroughSubject<SessionStore,Never>()
    @Published var session:User?{didSet{self.didchange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener { (auth,user) in
            if let user = user {
                print("Got user: \(user)")
                self.session = User(id:user.uid,email: user.displayName,displayName: user.email)
            } else {
                self.session = nil
            }
            
        }
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            self.session = nil
            return true
        }catch {
            return false
        }
    }
    
}
