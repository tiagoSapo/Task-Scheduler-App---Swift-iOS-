
import UIKit
import CoreData

class TarefasEmRealizacaoTableViewController: UITableViewController {
    
    var ultimoIndice: NSManagedObjectID?
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    @IBAction func criarNovaTarefa(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "criarNovaTarefa", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = table.dequeueReusableCell(withIdentifier: "celulaEmRealizacao", for: indexPath) as! CelulaEmRealizacao
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let date = df.string(from: (ler()[indexPath.row].value(forKey: "data") as! Date))
        
        celula.nome.text = ler()[indexPath.row].value(forKey: "nome") as? String
        celula.data.text = date
        celula.estado.text = ler()[indexPath.row].value(forKey: "estado") as? String
        
        return celula
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ler().count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            getContext().delete(ler()[indexPath.row])
            do {
                try getContext().save()
            } catch {
                print("Erro ao apagar")
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func ler() -> [NSManagedObject]! {
        
        let pedido = NSFetchRequest<Tarefas>(entityName: "Tarefas")
        pedido.predicate = NSPredicate(format: "estado == 'EmRealizacao'", 0)
        
        let ordenado = NSSortDescriptor(key: "data", ascending: true) // ordenado pela data
        pedido.sortDescriptors = [ordenado]
        do {
            let bd_tarefas = try getContext().fetch(pedido)
            return bd_tarefas
        } catch {
            print("Erro ao obter objectos da bd")
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ultimoIndice = ler()[indexPath.row].objectID
        performSegue(withIdentifier: "mostrar", sender: self);
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //let item = meu_array[sourceIndexPath.row]
    }
    @IBAction func editar(_ sender: UIBarButtonItem) {
        table.isEditing = !table.isEditing
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mostrar", let i = tableView.indexPathForSelectedRow
        {
            let vc = segue.destination as! TarefaViewController
            vc.nome_var = ler()[i.row].value(forKey: "nome") as! String
            vc.descricao_var = ler()[i.row].value(forKey: "descricao") as! String
            vc.estado_var = ler()[i.row].value(forKey: "estado") as! String
            vc.data_var = ler()[i.row].value(forKey: "data") as! Date
            vc.indice = ultimoIndice
        }
        else if segue.identifier == "criarNovaTarefa" {
            let vc = segue.destination as! CriarTarefaViewController
            vc.estado_seleccionado_segue = 1
        }
    }
}
