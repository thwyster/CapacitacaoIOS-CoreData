import Foundation
import UIKit
import CoreData

class CoreDataContextModel {
    static let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init() {}
    
    func save() {
        do {
            try CoreDataContextModel.contexto.save()
        } catch  {
            print("Erro ao salvar informações no banco de dados: \(error)")
        }
    }
}
