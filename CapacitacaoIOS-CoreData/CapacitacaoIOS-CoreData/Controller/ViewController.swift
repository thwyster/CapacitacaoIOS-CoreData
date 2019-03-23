import UIKit
import CoreData

class ViewController: UIViewController {
    
    var pessoas:[Pessoa] = []
    
    @IBAction func btnAddContatc(_ sender: Any) {
        
    }
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Criar contatos no CoreData
        let pessoa = Pessoa(context: contexto)
        let endereco = Endereco(context: contexto)
        let telefone = Telefone(context: contexto)
        //let pessoa2 = Pessoa(context: contexto)
        //let pessoa3 = Pessoa(context: contexto)
        
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
        
//        pessoa2.idPessoa = 2
//        pessoa2.nome = "Joao Almeida"
        
//        pessoa3.idPessoa = 3
//        pessoa3.nome = "Bruna Lisboa"
        
        CoreDataContextModel().save() //Salva o context
        
        //Ler Contatos
        let requisicao: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        do {
            pessoas = try contexto.fetch(requisicao)
            print(pessoas)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contatos" {
            let contatos = segue.destination as! TableViewController
            contatos.pessoas = pessoas
        }
    }
}
