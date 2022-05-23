import SwiftUI

struct AddPostScreen: View {
    @State var isLoading = false
    @ObservedObject var realTimeStore = RealTimeStore()
    @Environment(\.presentationMode) var presentation
    
    @State var firstName = ""
    @State var lastName = ""
    @State var phone = ""
    
    @ObservedObject var storageStor = StorageStore()
    
   @State var defImage = UIImage(imageLiteralResourceName: "user_image")
    
    @State var pickImage:UIImage? = nil
    @State var showImagePicker = false
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing:12) {
                    Button(action: {
                        showImagePicker.toggle()
                    }, label: {
                        Image(uiImage:pickImage ?? defImage)
                            .resizable()
                            .clipShape(Circle())
                            .padding(3)
                            .overlay(Circle().stroke(.red.opacity(0.7),lineWidth: 2))
                            .shadow(color: .red.opacity(0.3), radius: 3, x: 4, y: 4)
                            .frame(width: geo.size.width/3.8, height: geo.size.height/7)
                            
                    })
                    .sheet(isPresented: self.$showImagePicker, onDismiss: {
                        self.showImagePicker = false
                    },content: {
                        ImagePicker(image: self.$pickImage, isShow: self.$showImagePicker)
                    })
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
                        uploadImage()
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
    
    func uploadImage(){
        isLoading = true
        storageStor.uploadImage(pickImage!, completion: { url in
            let imageUrl = url!.absoluteString
            saveContact(url: imageUrl)
        })
    }
    
    func saveContact(url:String){
        if firstName.isEmpty == false &&
            lastName.isEmpty == false &&
            phone.isEmpty == false {
          
            realTimeStore.storePost(contact: Contact(name: "\(lastName) \(firstName)", phone: self.phone,imgUrl: url), complation: { success in
                isLoading = false
                if success {
                    presentation.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}
