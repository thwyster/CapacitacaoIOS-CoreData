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
    
    func salvarContato(_ txtNome: String,_ txtEndereco: String,_ txtNumero: Int16,_ txtTelefone: Int32) {
        let pessoa = Pessoa(context: CoreDataContextModel.contexto)
        let endereco = Endereco(context: CoreDataContextModel.contexto)
        let telefone = Telefone(context: CoreDataContextModel.contexto)
        
        pessoa.idPessoa = 1
        pessoa.nome = txtNome
        
        endereco.idEndereco = Int32(enderecos.count) + 1
        endereco.idPessoa = Int32(pessoa.idPessoa)
        endereco.rua = txtEndereco
        endereco.numero = txtNumero
        
        telefone.idTelefone = Int32(telefones.count) + 1
        telefone.idPessoa = Int32(pessoa.idPessoa)
        telefone.numero = txtTelefone
        
        do {
            try CoreDataContextModel.contexto.save()
            
        } catch  {
            print("Erro ao salvar contatos: \(error) ")
        }
    }
    
    func salvarContatoFake() {
        //Criar contato fake
        let pessoa = Pessoa(context: CoreDataContextModel.contexto)
        let endereco = Endereco(context: CoreDataContextModel.contexto)
        let telefone = Telefone(context: CoreDataContextModel.contexto)
        
        pessoa.idPessoa = 1
        pessoa.nome = "Ronny Czerkus"
        
        endereco.idEndereco = 1
        endereco.idPessoa = 1
        endereco.rua = "Av 7 de Setembro"
        endereco.numero = 1000
        
        telefone.idTelefone = 1
        telefone.idPessoa = 1
        telefone.numero = 999999999
        
        do {
            try CoreDataContextModel.contexto.save()
        } catch  {
            print("Erro ao salvar contatos: \(error) ")
        }
    }
    
    init() {}
}
