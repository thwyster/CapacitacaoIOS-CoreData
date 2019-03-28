import UIKit

class TableViewController: UITableViewController {
    var pessoas : [Pessoa] = PessoaModel().carregaContatos()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pessoas = PessoaModel().carregaContatos()
        self.tableView.reloadData()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pessoas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tbvContatos", for: indexPath)

        cell.textLabel?.text = pessoas[indexPath.row].nome

        return cell
    }
    
    //DELETAR
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            PessoaModel().deletarContato(pessoas[indexPath.row].idPessoa)
            pessoas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            self.tableView.reloadData()
        }
    }
    
    //EDITAR
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row: \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editarContato" {
            let contatos = segue.destination as! ContatoController
            contatos.idPessoa = pessoas[(tableView.indexPathForSelectedRow?.row)!].idPessoa!
        }
    }
}
