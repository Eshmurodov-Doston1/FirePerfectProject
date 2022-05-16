//
//  SignUpScreen.swift
//  FirePerfectProject
//
//  Created by macbro on 16/05/22.
//

import SwiftUI
import Firebase

struct SignUpScreen: View {
    
    @State var fullname = ""
    @State var email = ""
    @State var password = ""
    
    @State var isloading:Bool = false
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var session:SessionStore
    
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing:10) {
                Spacer()
                Text("Create your account")
                    .font(.system(size:30))
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                    
                TextField("Fullname", text: self.$fullname)
                    .padding(.horizontal,10)
                    .frame(width:.infinity,height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(22)
                    .font(.system(size: 16))
                TextField("Email", text: self.$email)
                    .padding(.horizontal,10)
                    .frame(width:.infinity,height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(22)
                    .font(.system(size: 16))
                
                SecureField("Password", text: self.$password)
                    .padding(.horizontal,10)
                    .frame(width:.infinity,height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(22)
                    .font(.system(size: 16))
                
                Button(action: {
                    if fullname.isEmpty == false && email.isEmpty == false && password.isEmpty == false {
                        isloading = true
                        Auth.auth().createUser(withEmail: self.email, password: self.password){
                            (response,error) in
                            isloading = false
                            if error != nil {
                                print("Error SignUp \(error)")
                            }
                            session.listen()
                        }
                    }
                }, label: {
                    Spacer()
                    Text("SignUp")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                    Spacer()
                })
                .frame(height:45)
                .background(.red)
                .cornerRadius(22)
                Spacer()
                HStack(spacing:12) {
                    Text("Alreadey have an account ?")
                        .font(.system(size: 16))
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("Sign In")
                            .font(.system(size: 18))
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
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

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
            .environmentObject(SessionStore())
    }
}
