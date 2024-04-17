//
//  Tarefa.swift
//  Tarefas
//
//  Created by Tiago Simões on 8/8/18.
//  Copyright © 2018 Tiago Simões. All rights reserved.
//

import Foundation

class Tarefa {
    
    enum Estado {
        case nao_realizada
        case em_realizacao
        case concluida
    }
    
    var nome_tarefa: String?
    var descricao: String?
    var data_limite: Date?
    var estado: Estado
    
    init(nome_tarefa: String, descricao: String?, data_limite: Date?, estado: Estado) {
        self.nome_tarefa = nome_tarefa
        self.descricao = descricao
        self.data_limite = data_limite
        self.estado = estado
    }
    
    public func estadoToString() -> String {
        switch estado {
        case .nao_realizada:
            return "NaoRealizada"
        case .em_realizacao:
            return "EmRealizacao"
        case .concluida:
            return "Concluida"
        }
    }
}
