//
//  HomeView.swift
//  SaveLink
//
//  Created by Jean L2 on 23/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel
    
    @StateObject var conexion: LinkViewModel = LinkViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                Text("Bienvenido \(authenticationViewModel.user?.email ?? "No user")")
                    .padding(.top, 32)
                
                Spacer()
                
                LinkView(conexion: conexion)
        
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    authenticationViewModel.logout()
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(authenticationViewModel: AuthenticationViewModel())
    }
}
