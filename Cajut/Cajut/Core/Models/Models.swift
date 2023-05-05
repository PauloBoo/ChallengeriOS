//
//  Models.swift
//  cajut
//
//  Created by Paulo Vázquez Acosta on 21/4/22.
//

import Foundation

struct Models {
    
    struct Gameshow: Codable, Equatable {
        let gameshowId: String
    }
    
    struct JoinStatus: Codable, Equatable {
        let status: Bool
    }
    
    struct QuestionStatus: Codable, Equatable {
        let success: Bool // <- Pendiente de decidir la respuesta del servidor
    }
}
