import Foundation
import UIKit
import CoreData

class PessoaViewModel {
    private var pessoas: [Pessoa] = []
    
    func carregaContatos() -> [Pessoa] {
        let requisicao: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        do {
            pessoas = try CoreDataContextModel.contexto.fetch(requisicao)
            return pessoas
        } catch  {
            print("Erro ao carregar contatos: \(error) ")
        }
        
//        if contatos.count < 1 {
//            self.salvarContato()
//            return contatos = CoreDataContextModel.contexto.fetch(requisicao)
//        }
        return pessoas
    }
    
    func salvarContato() {
        //Criar contato fake
        let pessoa = Pessoa(context: CoreDataContextModel.contexto)
        let endereco = Endereco(context: CoreDataContextModel.contexto)
        let telefone = Telefone(context: CoreDataContextModel.contexto)
        
        pessoa.idPessoa = 1
        pessoa.nome = "Ronny Czerkus"
        
        endereco.idEndereco = 1
        endereco.idPessoa = 1
        endereco.rua = "7 de Setembro"
        endereco.numero = 619
        
        telefone.idTelefone = 1
        telefone.idPessoa = 1
        telefone.ddd = 41
        telefone.numero = 999999999
        
        do {
            try CoreDataContextModel.contexto.save()
        } catch  {
            print("Erro ao salvar contatos: \(error) ")
        }
    }
    
    init() {}
}
