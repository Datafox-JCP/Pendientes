//
//  SettingsView.swift
//  Pendientes
//
//  Created by Juan Carlos Pazos on 08/06/21.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Propiedades
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Vista
    var body: some View {
        NavigationView {
            VStack(spacing: 60) {
                Text("Pendientes")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.red)
        
                
                Link(destination: URL(string: "https://www.apple.com")!, label: {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("Visitar Apple")
                            .font(.title2)
                    } //: HStack
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Capsule()
                                    .fill(Color.blue)
                                    .shadow(radius: 8, y:18))
                })
                
                Text("Derechos Reservados © 2021\n Datafox 🐈")
                    .multilineTextAlignment(.center)
                    //.font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            } //: VStack
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                }
        )
            .navigationBarTitle("Acerca de", displayMode: .inline)
            //.edgesIgnoringSafeArea(.all)
        } //: Navigation
        .accentColor(.red)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
