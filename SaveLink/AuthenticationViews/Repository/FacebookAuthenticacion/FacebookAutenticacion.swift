//
//  FacebookAutenticacion.swift
//  SaveLink
//
//  Created by Jean L2 on 31/08/23.
//

import Foundation
import FacebookLogin

final class FacebookAuthenticacion {
    
    let loginManager = LoginManager()
    
    func loginFacebook(completionBlock: @escaping (Result<String, Error>) -> Void) {
        
        loginManager.logIn(permissions: ["email"], from: nil) { LoginManagerLoginResult, error in
            
            if let error = error {
                print("Error al logearse con Facebook \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let token = LoginManagerLoginResult?.token?.tokenString
            completionBlock(.success(token ?? "Empty Token"))
        }
    }
}
