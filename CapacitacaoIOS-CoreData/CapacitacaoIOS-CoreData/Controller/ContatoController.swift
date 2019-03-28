//
//  NovoContatoController.swift
//  CapacitacaoIOS-CoreData
//
//  Created by ALUNO on 25/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import Foundation
import UIKit

class ContatoController : UIViewController {
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtNumero: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    
    @IBAction func btnSalvar(_ sender: Any) {
        PessoaModel().salvarContato(txtNome.text!, txtEndereco.text!, Int16(txtNumero.text!)!, Int32(txtTelefone.text!)!)
        navigationController?.popViewController(animated: true)
    }
}
