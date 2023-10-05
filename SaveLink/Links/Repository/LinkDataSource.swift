//
//  LinkDataSource.swift
//  SaveLink
//
//  Created by Jean L2 on 4/09/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LinkModel: Decodable, Identifiable, Encodable {
    @DocumentID var id: String?
    let url: String
    let title: String
    let isFavorited: Bool
    let isCompleted: Bool
}

final class LinkDataSource {
    
    private let database = Firestore.firestore()
    private let collection = "links"
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        
        database.collection(collection)
            .addSnapshotListener { query, error in
                
                if let realError = error {
                    print("Error getting all links \(realError.localizedDescription)")
                    completionBlock(.failure(realError))
                    return
                }
                guard let documents = query?.documents.compactMap({ $0 }) else {
                    completionBlock(.success([]))
                    return
                }
                
                let links = documents.map { try? $0.data(as: LinkModel.self) }
                    .compactMap { $0 }
                
                completionBlock(.success(links))
            }
    }
    
    func createLink(fromURl: LinkModel, completionBlock: @escaping (Result<LinkModel,Error>) -> Void) {
        
        do {
            _ = try database.collection(collection).addDocument(from: fromURl)
            
        } catch {completionBlock(.failure(error))}
    }
    
    
    func update(link: LinkModel) {
        
        guard let documentID = link.id else {
            return
        }
        
        do {
            _ = try database.collection(collection).document(documentID).setData(from: link)
        } catch {print("Error updating our database")}
        
    }
    
    func eliminar(link: LinkModel) {
        
        guard let documentID = link.id else {
            return
        }
        
        database.collection(collection).document(documentID).delete()
    }
    
    
}

