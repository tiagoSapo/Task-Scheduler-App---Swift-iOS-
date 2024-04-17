
import UIKit
import CoreData

class TarefaViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var estado: UISegmentedControl!
    @IBOutlet weak var data: UIDatePicker!
    @IBOutlet weak var descricao: UITextView!
    
    var nome_var = ""
    var estado_var = ""
    var data_var = Date()
    var descricao_var = ""
    var indice: NSManagedObjectID?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nome.delegate = self
        descricao.delegate = self
        
        var pos = 0
        switch estado_var {
            case "NaoRealizada":
                pos = 0
            case "EmRealizacao":
                pos = 1
            case "Concluida":
                pos = 2
            default:
                pos = 0
        }
        
        nome.text = nome_var
        descricao.text = descricao_var
        data.setDate(data_var, animated: true)
        estado.selectedSegmentIndex = pos;
        
    }
    
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        if nome.text != "" && descricao.text != "" {
            guardarAlteracao()

            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        else {
            alertaCampos()
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func guardarAlteracao() {
        
        var e: String?
        switch estado.selectedSegmentIndex {
        case 0:
            e = "NaoRealizada"
        case 1:
            e = "EmRealizacao"
        case 2:
            e = "Concluida"
        default:
            e = "Concluida"
        }
        
        do {
            let o = try getContext().existingObject(with: indice!)
            o.setValue(nome.text!, forKey: "nome")
            o.setValue(data.date, forKey: "data")
            o.setValue(descricao.text!, forKey: "descricao")
            o.setValue(e, forKey: "estado")
            
            try getContext().save()
        }
        catch {
            print("O objecto não existe")
        }
    }
    
    func alertaCampos() {
        let alerta = UIAlertController(title: "Campos inválidos", message: "Tens que preencher todos os campos!", preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default))
        present(alerta, animated: true, completion: nil)
    }
}

