//
//  LinkRepository.swift
//  SaveLink
//
//  Created by Jean L2 on 4/09/23.
//
import Foundation

final class LinkRepository {
    
    private let conexion: LinkDataSource
    private let metadataConexion: MetadataDatasource
    
    init(conexion: LinkDataSource = LinkDataSource(), metadataConexion: MetadataDatasource = MetadataDatasource()) {
        self.conexion = conexion
        self.metadataConexion = metadataConexion
    }
    
    func getAllLinks(completionBlock: @escaping (Result<[LinkModel], Error>) -> Void) {
        conexion.getAllLinks(completionBlock: completionBlock)
    }
    
    func createNewLink(fromUrl url:String, completionBlock: @escaping (Result<LinkModel,Error>) -> Void) {
        
        metadataConexion.getMetadata(fromUrl: url) { [weak self] result in
            
            switch result {
            case .success(let link):
                self?.conexion.createLink(fromURl: link, completionBlock: completionBlock)
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
    }
    
    func updating(link: LinkModel) {
        conexion.update(link: link)
    }
    
    func deleting(link: LinkModel) {
        conexion.eliminar(link: link)
    }
    
    
}
