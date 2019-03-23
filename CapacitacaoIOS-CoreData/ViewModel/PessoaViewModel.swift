import Foundation
import UIKit
import CoreData

class PessoaViewModel {
    private var contatos: [Pessoa] = []
    
    func carregaContatos() {
        let requisicao: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        do {
            contatos = try CoreDataContextModel().contexto.fetch(requisicao)
        } catch  {
            print("Erro ao carregar contatos: \(error) ")
        }
    }
    
}
