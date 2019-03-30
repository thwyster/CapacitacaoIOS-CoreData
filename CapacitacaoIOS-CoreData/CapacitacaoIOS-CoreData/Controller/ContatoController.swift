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
    var idPessoa: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("row: \(idPessoa)")
        
        if idPessoa != ""{
            let contato: (Pessoa, Endereco, Telefone) = PessoaModel().carregaUmContato(idPessoa)
            
            txtNome.text = contato.0.nome
            txtEndereco.text = contato.1.rua
            txtNumero.text = String(contato.1.numero)
            txtTelefone.text = String(contato.2.numero)
        }
    }
    
    @IBAction func btnSalvar(_ sender: Any) {
        PessoaModel().salvarContato(txtNome.text!, txtEndereco.text!, Int16(txtNumero.text!)!, Int64(txtTelefone.text!)!)
        navigationController?.popViewController(animated: true)
    }
    
    
}
