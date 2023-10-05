//
//  LinkView.swift
//  SaveLink
//
//  Created by Jean L2 on 4/09/23.
//

import SwiftUI

struct LinkView: View {
    
    @ObservedObject var conexion: LinkViewModel
    @State var text: String = ""
    
    
    var body: some View {
        
        VStack {
            
            TextEditor(text: $text)
                .frame(height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 2)
                )
                .padding(.horizontal, 12)
                .cornerRadius(3)
            
            Button(action: {
                conexion.createNewLink(fromUrl: text)
                text = ""
            }, label: {
                Label("Crear Link", systemImage: "link")
            })
            .tint(.green)
            .controlSize(.regular)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            
            if let realError = conexion.messageError {
                Text("Error al agregar: \(realError)")
                    .bold()
                    .foregroundColor(.red)
            }
            
            List(conexion.links) {link in
                        
                VStack {
                    Text(link.title)
                        .bold()
                        .lineLimit(4)
                        .padding(.bottom, 8)
                        
                    Text(link.url)
                        .foregroundColor(.gray)
                        .font(.caption)
                            
                    HStack {
                        Spacer()
                                
                        if link.isCompleted {
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .foregroundColor(.blue)
                                .frame(width: 10, height: 10)
                                }
                                
                        if link.isFavorited {
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width: 10, height: 10)
                                }
                            }
                            
                        }
                .swipeActions(edge: .trailing) {
                    Button(action: {
                        conexion.updateIsCompleted(link: link)
                    }, label: {
                        VStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Ready")
                        }
                    })
                    .tint(.blue)
                    
                    Button(action: {
                        conexion.updateIsFavorite(link: link)
                    }, label: {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("Favorite")
                        }
                    })
                    .tint(.yellow)
                }
                .swipeActions(edge: .leading) {
                    Button(action: {
                        conexion.deleting(link: link)
                    }, label: {
                        VStack {
                            Image(systemName: "trash.circle.fill")
                            Text("Trash")
                        }
                    })
                    .tint(.red)
                }
                }
            .task {conexion.getAllLinks()}
        }
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(conexion: LinkViewModel())
    }
}
