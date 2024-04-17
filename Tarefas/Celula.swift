//
//  Celula.swift
//  Tarefas
//
//  Created by Tiago Simões on 8/9/18.
//  Copyright © 2018 Tiago Simões. All rights reserved.
//

import Foundation
import UIKit

class Celula: UITableViewCell {
    
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var estado: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
