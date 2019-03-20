import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBAction func btnAddContatc(_ sender: Any) {
        
    }
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Criar contatos no CoreData
        let pessoa = Pessoa(context: contexto)
        let pessoa2 = Pessoa(context: contexto)
        let pessoa3 = Pessoa(context: contexto)
        
        pessoa.idPessoa = 1
        pessoa.nome = "Ronny Czerkus"
        
        pessoa2.idPessoa = 2
        pessoa2.nome = "Joao Almeida"
        
        pessoa3.idPessoa = 3
        pessoa3.nome = "Bruna Lisboa"
        
        do {
            try contexto.save()
        } catch  {
            print("Erro ao salvar contexto: \(error)")
        }
        
        //Ler Contatos
        var pessoas:[Pessoa] = []
        
        let requisicao: NSFetchRequest<Pessoa> = Pessoa.fetchRequest()
        
        do {
            pessoas = try contexto.fetch(requisicao)
            print(pessoas)
        } catch  {
            print("Erro ao ler o contexto: \(error) ")
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "contatos" {
                let contatos = segue.destination as! TableViewController
                contatos.pessoas = pessoas
            }
        }
    }
}
