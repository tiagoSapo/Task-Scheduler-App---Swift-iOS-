
import UIKit
import CoreData
import Foundation

class CriarTarefaViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nome_tarefa_label: UITextField!
    @IBOutlet weak var descricao_label: UITextView!
    @IBOutlet weak var data_limite_label: UIDatePicker!
    @IBOutlet weak var estado_label: UISegmentedControl!
    
    static var FICHEIRO = "ficheiro.txt"
    static var MAX_CARACTERES = 200
    var estado_seleccionado_segue = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descricao_label.delegate = self
        nome_tarefa_label.delegate = self
        
        if estado_seleccionado_segue != -1  && estado_seleccionado_segue <= 2 {
            estado_label.selectedSegmentIndex = estado_seleccionado_segue
        }
    }
    
    // Fechar teclado quando o utilizador clica em ENTER
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    // Fechar teclado quando o utilizador clica fora da label
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MAXIMO 200 caracteres
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let t = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return t.count <= CriarTarefaViewController.MAX_CARACTERES
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let alerta = UIAlertController(title: "Sair alerta", message: "Ao sair a tarefa será eliminada!", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Não sair", style: .default))
        alerta.addAction(UIAlertAction(title: "Sair", style: .cancel) { (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        })
        present(alerta, animated: true, completion: nil)
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        
        let nome_tarefa = nome_tarefa_label.text
        let descricao = descricao_label.text
        let data_limite = data_limite_label.date
        let estado = estado_label.selectedSegmentIndex
        
        if descricao == "" || nome_tarefa == "" {
            alertaCampos()
            return
        }
        
        let e: Tarefa.Estado
        
        switch estado {
        case 0:
            e = Tarefa.Estado.nao_realizada
        case 1:
            e = Tarefa.Estado.em_realizacao
        case 2:
            e = Tarefa.Estado.concluida
        default:
            e = Tarefa.Estado.concluida
        }
        
        let tarefa = Tarefa(nome_tarefa: nome_tarefa!, descricao: descricao, data_limite: data_limite, estado: e)
        guardar(tarefa: tarefa)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func alertaCampos() {
        let alerta = UIAlertController(title: "Campos inválidos", message: "Tens que preencher todos os campos!", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true, completion: nil)
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func guardar(tarefa: Tarefa) {

        let context = getContext()
        let nova_tarefa = NSEntityDescription.insertNewObject(forEntityName: "Tarefas", into: context)
        
        let nome = tarefa.nome_tarefa
        let descricao = tarefa.descricao
        let data = tarefa.data_limite
        let estado = tarefa.estadoToString()
        
        nova_tarefa.setValue(nome, forKey: "nome")
        nova_tarefa.setValue(descricao, forKey: "descricao")
        nova_tarefa.setValue(data, forKey: "data")
        nova_tarefa.setValue(estado, forKey: "estado")
        
        do {
            try context.save()
        } catch  {
            print("Erro ao guardar na base de dados")
        }
    }
}
