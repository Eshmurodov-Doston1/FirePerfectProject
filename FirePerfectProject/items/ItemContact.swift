//
//  ItemContact.swift
//  FirePerfectProject
//
//  Created by macbro on 22/05/22.
//

import SwiftUI
import SDWebImageSwiftUI
struct ItemContact: View {
    var contact:Contact
    var body: some View {
        HStack {
            if contact.imgUrl != "" {
                WebImage(url: URL(string: contact.imgUrl!))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
            }else{
                Image("user_image")
                    .resizable()
                    .frame(width: 70, height: 70)
            }
            VStack(alignment: .leading, spacing: 8, content: {
                Text(contact.name!)
                    .font(.system(size:18))
                    .foregroundColor(.red)
                    .fontWeight(.semibold)
                
                Text(contact.phone!)
                    .font(.system(size:15))
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
            })
            Spacer()
        }
        .padding(.horizontal,10)
        .padding(.vertical,7)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 2, y: 3)
        .frame(maxWidth:.infinity)
    }
}

struct ItemContact_Previews: PreviewProvider {
    static var previews: some View {
        ItemContact(contact: Contact(name: "Eshmurodov Dostonbek", phone: "+998994206278",imgUrl: ""))
    }
}
