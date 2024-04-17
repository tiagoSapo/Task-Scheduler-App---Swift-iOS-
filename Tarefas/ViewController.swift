
import UIKit

class ViewController: UIViewController {
    
    @IBAction func criarNovaTarefa(_ sender: UIBarButtonItem) {
        print("novaTarefa")
        performSegue(withIdentifier: "criarNovaTarefa", sender: self)
    }
    
    @IBAction func tarefasNaoRealizadas(_ sender: UIButton) {
        print("tarefasNaoRealizadas")
        performSegue(withIdentifier: "tarefasNaoRealizadas", sender: self)
    }
    
    @IBAction func tarefasEmRealizacao(_ sender: UIButton) {
        print("tarefasEmRealizacao")
        performSegue(withIdentifier: "tarefasEmRealizacao", sender: self)
    }
    
    @IBAction func tarefasConcluidas(_ sender: UIButton) {
        print("tarefasConcluidas")
        performSegue(withIdentifier: "tarefasConcluidas", sender: self)
    }

    @IBAction func todasAsTarefas(_ sender: UIButton) {
        print("todasAsTarefas")
        performSegue(withIdentifier: "todasAsTarefas", sender: self)
    }
}

