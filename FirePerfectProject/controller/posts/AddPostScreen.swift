import SwiftUI

struct AddPostScreen: View {
    @State var isLoading = false
    @ObservedObject var realTimeStore = RealTimeStore()
    @Environment(\.presentationMode) var presentation
    
    @State var firstName = ""
    @State var lastName = ""
    @State var phone = ""
    
    var body: some View {
        ZStack {
            VStack(spacing:12) {
                TextField("FirstName", text: self.$firstName)
                    .padding(.horizontal,10)
                    .frame(height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .font(.system(size: 16))
                TextField("LastName", text: self.$lastName)
                    .padding(.horizontal,10)
                    .frame(height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .font(.system(size: 16))
                TextField("Phone", text: self.$phone)
                    .padding(.horizontal,10)
                    .frame(height:45)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(10)
                    .font(.system(size: 16))
                Button(action: {
                    if firstName.isEmpty == false &&
                        lastName.isEmpty == false &&
                        phone.isEmpty == false {
                        isLoading = true
                        realTimeStore.storePost(contact: Contact(name: "\(lastName) \(firstName)", phone: self.phone), complation: { success in
                            isLoading = false
                            if success {
                                presentation.wrappedValue.dismiss()
                            }
                        })
                    }
                }, label: {
                    Spacer()
                    Text("Add")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                    Spacer()
                })
                .frame(height:45)
                .background(.red)
                .cornerRadius(10)
                Spacer()
            }
            .padding()
            
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
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}
