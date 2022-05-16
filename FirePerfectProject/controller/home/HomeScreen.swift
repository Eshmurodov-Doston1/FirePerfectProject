//
//  HomeScreen.swift
//  FirePerfectProject
//
//  Created by macbro on 16/05/22.
//

import SwiftUI
import Firebase

struct HomeScreen: View {
    @EnvironmentObject var session:SessionStore
    var body: some View {
        NavigationView {
            ZStack {
                Text("Welcome \(session.session?.displayName ?? "")")
            }
            .navigationBarTitle("Posts",displayMode: .inline)
            .navigationBarItems(trailing: HStack(spacing:7) {
                NavigationLink(destination: AddPostScreen(), label: {
                    Image("ic_add")
                })
                Button(action: {
                    logOut()
                }, label: {
                    Image("ic_exit")
                })
            })
        }
    }
    
    func logOut(){
        if session.signOut() {
            session.listen()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(SessionStore())
    }
}
