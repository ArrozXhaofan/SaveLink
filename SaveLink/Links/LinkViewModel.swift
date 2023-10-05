//
//  LinkViewModel.swift
//  SaveLink
//
//  Created by Jean L2 on 4/09/23.
//

import Foundation


final class LinkViewModel: ObservableObject {
    
    @Published var links: [LinkModel] = []
    @Published var messageError: String?
    private let conexion: LinkRepository
    
    init(messageError: String? = nil, conexion: LinkRepository = LinkRepository()) {
        self.messageError = messageError
        self.conexion = conexion
    }
    
    func getAllLinks() {
        
        conexion.getAllLinks { [weak self]  result in
            switch result {
            case .success(let linkModels):
                self?.links = linkModels
                print(String(describing: linkModels))
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
            
        }
    }
    
    func createNewLink(fromUrl url:String) {
        
        conexion.createNewLink(fromUrl: url) { result in
            
            switch result {
            case .success(let link):
                print("Creado: \(link.title) added")
            case .failure(let error):
                self.messageError = error.localizedDescription
            }
        }
    }
    
    func updateIsFavorite(link: LinkModel) {
        let updateLink = LinkModel(id: link.id,url: link.url, title: link.title, isFavorited: !link.isFavorited, isCompleted: link.isCompleted)
        
        conexion.updating(link: updateLink)
    }
    
    func updateIsCompleted(link: LinkModel) {
        let updateLink = LinkModel(id: link.id,url: link.url, title: link.title, isFavorited: link.isFavorited, isCompleted: !link.isCompleted)
        
        conexion.updating(link: updateLink)
    }
    
    func deleting(link: LinkModel) {
        conexion.deleting(link: link)
    }
    

}
