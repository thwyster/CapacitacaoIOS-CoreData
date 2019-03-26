import UIKit
import CoreData

class ViewController: UIViewController {
    
    var pessoas:[Pessoa] = []
    
    @IBAction func btnAddContatc(_ sender: Any) {
        
    }
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pessoas = PessoaModel().carregaContatos()
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contatos" {
            let contatos = segue.destination as! TableViewController
            contatos.pessoas = pessoas
        }
    }
}
