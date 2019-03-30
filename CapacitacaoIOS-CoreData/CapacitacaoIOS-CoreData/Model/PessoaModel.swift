import Foundation
import UIKit
import CoreData

class PessoaModel {
    private var pessoas: [Pessoa] = []
    private var enderecos: [Endereco] = []
    private var telefones: [Telefone] = []
    
    func carregaContatos() -> [Pessoa] {
        let requisicaoPessoa: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        let requisicaoEndereco: NSFetchRequest<Endereco> = Endereco.fetchRequest()
        let requisicaoTelefone: NSFetchRequest<Telefone> = Telefone.fetchRequest()
        
        do {
            pessoas = try CoreDataContextModel.contexto.fetch(requisicaoPessoa)
            
            if pessoas.count < 1
            {
                self.salvarContatoFake()
                pessoas = try CoreDataContextModel.contexto.fetch(requisicaoPessoa)
            }

            enderecos = try CoreDataContextModel.contexto.fetch(requisicaoEndereco)
            telefones = try CoreDataContextModel.contexto.fetch(requisicaoTelefone)
            return pessoas
        } catch  {
            print("Erro ao carregar contatos: \(error) ")
        }
        
//        if pessoas.count < 1 {
//            self.salvarContato()
//            return pessoas = CoreDataContextModel.contexto.fetch(requisicaoPessoa)
//        }
        return pessoas
    }
    
    func carregaUmContato(_ idPessoa: String?) -> (Pessoa, Endereco, Telefone) {
        var pessoa = Pessoa(context: CoreDataContextModel.contexto)
        var endereco = Endereco(context: CoreDataContextModel.contexto)
        var telefone = Telefone(context: CoreDataContextModel.contexto)

        let requisicaoPessoa: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        requisicaoPessoa.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        let requisicaoEndereco: NSFetchRequest<Endereco> = Endereco.fetchRequest()
        requisicaoEndereco.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        let requisicaoTelefone: NSFetchRequest<Telefone> = Telefone.fetchRequest()
        requisicaoTelefone.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        do {
            pessoa = try CoreDataContextModel.contexto.fetch(requisicaoPessoa).first!
            
            endereco = try CoreDataContextModel.contexto.fetch(requisicaoEndereco).first! //Sim isso esta errado pq deveria trazer todos os enderecos e telefones mas minha view nao esta preparada pra isso =/
            telefone = try CoreDataContextModel.contexto.fetch(requisicaoTelefone).first!
            return (pessoa, endereco, telefone)
        
        } catch  {
            print("Erro ao carregar contatos: \(error) ")
        }
        
        return (pessoa, endereco, telefone)
    }
    
    func deletarContato(_ idPessoa: String?) {
        let requisicaoPessoa: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        requisicaoPessoa.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        let requisicaoEndereco: NSFetchRequest<Endereco> = Endereco.fetchRequest()
        requisicaoEndereco.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        let requisicaoTelefone: NSFetchRequest<Telefone> = Telefone.fetchRequest()
        requisicaoTelefone.predicate = NSPredicate(format: "idPessoa = %@", idPessoa!)
        
        let pessoaParaDeletar = try! CoreDataContextModel.contexto.fetch(requisicaoPessoa)
        let enderecoParaDeletar = try! CoreDataContextModel.contexto.fetch(requisicaoEndereco)
        let telefoneParaDeletar = try! CoreDataContextModel.contexto.fetch(requisicaoTelefone)
        
        for item in pessoaParaDeletar {
            CoreDataContextModel.contexto.delete(item)
        }
        
        for item in enderecoParaDeletar {
            CoreDataContextModel.contexto.delete(item)
        }
        
        for item in telefoneParaDeletar {
            CoreDataContextModel.contexto.delete(item)
        }
    }
    
    func salvarContato(_ txtNome: String,_ txtEndereco: String,_ txtNumero: Int16,_ txtTelefone: Int64) {
        let pessoa = Pessoa(context: CoreDataContextModel.contexto)
        let endereco = Endereco(context: CoreDataContextModel.contexto)
        let telefone = Telefone(context: CoreDataContextModel.contexto)
        
        pessoa.idPessoa = UUID().uuidString
        pessoa.nome = txtNome
        
        endereco.idEndereco = UUID().uuidString
        endereco.idPessoa = pessoa.idPessoa
        endereco.rua = txtEndereco
        endereco.numero = txtNumero
        
        telefone.idTelefone = UUID().uuidString
        telefone.idPessoa = pessoa.idPessoa
        telefone.numero = txtTelefone
        
        
    }
    
    func salvarContatoFake() {
        //Criar contato fake
        let pessoa = Pessoa(context: CoreDataContextModel.contexto)
        let endereco = Endereco(context: CoreDataContextModel.contexto)
        let telefone = Telefone(context: CoreDataContextModel.contexto)
        
        pessoa.idPessoa = UUID().uuidString
        pessoa.nome = "Ronny Czerkus"
        
        endereco.idEndereco = UUID().uuidString
        endereco.idPessoa = pessoa.idPessoa
        endereco.rua = "Av 7 de Setembro"
        endereco.numero = 1000
        
        telefone.idTelefone = UUID().uuidString
        telefone.idPessoa = pessoa.idPessoa
        telefone.numero = 999999999
        
        do {
            try CoreDataContextModel.contexto.save()
        } catch  {
            print("Erro ao salvar contatos: \(error) ")
        }
    }
    
    init() {}
}
