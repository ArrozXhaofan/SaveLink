//
//  ContentView.swift
//  SaveLink
//
//  Created by Jean L2 on 22/08/23.
//

import SwiftUI

enum AutenticationSheetView: String, Identifiable {
    case register
    case login
    
    var id: String {
        return rawValue
    }
}

struct AuthenticationView: View {
    
    @ObservedObject var autenticationViewModel: AuthenticationViewModel
    @State private var authenticationSheetView: AutenticationSheetView?
    
    var body: some View {
        VStack {
            Image(systemName: "camera.filters")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
            
            VStack {
                Button(action: {
                    
                    authenticationSheetView = .login
                    
                }, label: {
                    
                    Label("Entra con email", systemImage: "envelope.fill")
                        
                })
                .tint(.black)
                
                Button(action: {
                    
                    //autenticationViewModel.loginWithFacebook()
                    
                }, label: {
                    
                    Label("Entrar con Facebook", systemImage: "envelope.fill")
                        
                })
                .tint(.blue)
                
                
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding(.top, 60)
            
            Spacer()
            
            HStack {
                Button(action: {
                    authenticationSheetView = .register
                }, label: {
                    Text("¿No tienes cuenta?")
                    Text("Registrate")
                        .underline()
                })
            }
            .tint(.black)
        }
        .sheet(item:
            $authenticationSheetView
        , content: { sheet in
            
            switch sheet {
            case .register:
                RegisterEmailView(authenticationViewModel : autenticationViewModel)
            case .login:
                LoginEmailView(authenticationViewModel: autenticationViewModel)
            }
            
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(autenticationViewModel: AuthenticationViewModel())
    }
}
