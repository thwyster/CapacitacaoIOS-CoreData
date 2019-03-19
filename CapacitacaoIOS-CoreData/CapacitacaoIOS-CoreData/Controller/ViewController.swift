//
//  ViewController.swift
//  CapacitacaoIOS-CoreData
//
//  Created by ALUNO on 18/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create
        let pessoa = Pessoa(context: contexto)
        
        pessoa.idPessoa = 1
        pessoa.nome = "Ronny Czerkus"
        
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar contexto: \(error)")
        }
        
        //Read
        var pessoas:[Pessoa] = []
        
        let requisicao: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        requisicao.predicate = NSPredicate(
    }
}

