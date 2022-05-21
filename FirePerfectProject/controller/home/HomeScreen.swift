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
    @ObservedObject var realTimeStore = RealTimeStore()
    @State var isLoading = false
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(realTimeStore.items,id:\.self) { item in
                        ItemContact(contact:item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                
                if isLoading {
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.all)
                    
                    GeometryReader{ geometry in
                        VStack(alignment:.center) {
                            Spacer()
                            HStack {
                                Spacer()
                                ZStack {
                                    ProgressView("Loading...")
                                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                        .foregroundColor(.blue)
                                }
                                .frame(width: geometry.size.width / 3,
                                       height: geometry.size.height / 6)
                                .background(Color.white)
                                .foregroundColor(Color.primary)
                                .cornerRadius(15)
                                Spacer()
                            }
                           
                            Spacer()
                        }
                        
                    }
                }
                
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
        .onAppear{
            getAllContact()
        }
    }
    
    func logOut(){
        if session.signOut() {
            session.listen()
        }
    }
    
    func getAllContact(){
        isLoading = true
        self.realTimeStore.loadPost {
           isLoading = false
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(SessionStore())
    }
}
