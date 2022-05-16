//
//  StartScreen.swift
//  FirePerfectProject
//
//  Created by macbro on 16/05/22.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var session:SessionStore

    var body: some View {
        VStack {
            if self.session.session != nil {
                HomeScreen()
            }else {
                SignInScreen()
            }
        }
        .onAppear{
            session.listen()
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(SessionStore())
    }
}
