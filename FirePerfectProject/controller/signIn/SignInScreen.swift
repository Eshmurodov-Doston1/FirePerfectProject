//
//  SignInScreen.swift
//  FirePerfectProject
//
//  Created by macbro on 16/05/22.
//

import SwiftUI
import Firebase

struct SignInScreen: View {
    
    
    @State var email = ""
    @State var password = ""
    @State var isloading = false
    @EnvironmentObject var session:SessionStore
    
    @State var isMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing:10) {
                    Spacer()
                    Text("Welcome Back")
                        .foregroundColor(.red)
                        .fontWeight(.semibold)
                        .font(.system(size: 30))
                    
                    TextField("Email", text: self.$email)
                        .frame(height:45)
                        .padding(.horizontal,10)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(22)
                        .font(.system(size: 16))
                    
                    SecureField("Password", text: self.$password)
                        .frame(height:45)
                        .padding(.horizontal,10)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(22)
                        .font(.system(size: 16))
                    
                    Button(action: {
                       if email.isEmpty == false && password.isEmpty == false {
                           isloading = true
                            Auth.auth().signIn(withEmail: email, password: password){ (response,error) in
                                isloading = false
                                if error != nil {
                                    print("Error Sign In \(error)")
                                }
                                session.listen()
                            }
                        }
                    }, label: {
                        Spacer()
                        Text("Sign In")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                        Spacer()
                    })
                    .frame(height:45)
                    .background(.red)
                    .cornerRadius(22)
                    Spacer()
                    HStack(spacing:12) {
                        Text("Dont't have an account ?")
                            .font(.system(size: 16))
                        Button(action: {
                            isMode.toggle()
                        }, label: {
                            Text("Sign Up")
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .font(.system(size: 18))
                                .keyboardType(.numberPad)
                        })
                        .sheet(isPresented: self.$isMode, content: {
                            SignUpScreen()
                        })
                        
                    }
                    
                }
                .padding(.horizontal)
                
                if isloading {
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
                                .cornerRadius(10)
                                Spacer()
                            }
                           
                            Spacer()
                        }
                        
                    }
                }
            }
          
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
            .environmentObject(SessionStore())
    }
}
