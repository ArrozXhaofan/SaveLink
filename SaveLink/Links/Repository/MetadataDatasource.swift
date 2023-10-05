//
//  MetadataDatasource.swift
//  SaveLink
//
//  Created by Jean L2 on 12/09/23.
//

import Foundation
import LinkPresentation

enum CustomMetadataError: Error {
    case badURL
}

final class MetadataDatasource {
    
    private var metadataprovider: LPMetadataProvider?
    
    func getMetadata(fromUrl url:String, completionBlock: @escaping (Result<LinkModel,Error>) -> Void) {
        
        guard let url = URL(string: url) else {
            completionBlock(.failure(CustomMetadataError.badURL))
            return
        }
        
        metadataprovider = LPMetadataProvider()
        metadataprovider?.startFetchingMetadata(for: url, completionHandler: { metadata , error in
            
            if let realError = error {
                completionBlock(.failure(realError))
                print("Error getting metadata: \(realError.localizedDescription)")
                return
            }
            
            let newLink = LinkModel(url: url.absoluteString, title: metadata?.title ?? "No title", isFavorited: false, isCompleted: false)
            
            completionBlock(.success(newLink))
            
        })
        
    }
    
    
    
}
