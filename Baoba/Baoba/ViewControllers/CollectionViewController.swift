import UIKit
import CoreData

class CollectionViewController: UICollectionViewController,UITextFieldDelegate,UITextViewDelegate{
    
    var numOfCells = 9
    var numOfSections = 1
    var lastIndex: IndexPath!
    var list: [CollectionViewCell] = []
    var listIndex: [IndexPath] = []
    var indexPathRow: Int?
    var cell = CollectionViewCell()
    var persons = [Person]()
    var vetorPessoas: [Int:Person] = [:]
    //let desconhecido = Person(nome: "Desconhecido", sexo: "Desconhecido", descricao: "Desconhecido", image: UIImage(named: "imageDesconhecido")!)
    weak var mainPerson:PersonCD?
    
    //@IBOutlet weak var newUsrData: FirstFormController!
    @IBOutlet weak var newUsrData: UIScrollView!
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var addFotoBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addBtn2: UIButton!
    var context: NSManagedObjectContext!
    
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        UserDefaults.standard
        
        print("teste git add -i")
        
        UserDefaults.standard.set(nil, forKey: "mainPerson")
        
        getTimeRn()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        if UserDefaults.standard.object(forKey: "mainPerson") == nil {
            let mainPersonInicial = NSEntityDescription.insertNewObject(forEntityName: "PersonCD", into: context) as! PersonCD
            guard let imageDesconhecido = UIImage(named: "imageDesconhecido") else{return}
            //converter UIImage para NSData
            mainPersonInicial.image = imageDesconhecido.pngData() as NSData?
            mainPersonInicial.nome = ""
            self.mainPerson = mainPersonInicial
        }else{
            let request: NSFetchRequest<PersonCD> = PersonCD.fetchRequest()
            let id = UserDefaults.standard.object(forKey: "mainPerson") as! String
//            let predicteEqual = NSPredicate(format: "objectID == %@", id)
            
            
            request.predicate = predicteEqual
            
            
            let mainPersonRecuperado = try? context.fetch(request)
           
            self.mainPerson = mainPersonRecuperado![0]
            
            
            
        }
        
    }
    
    // Como começar uma CollectionView na última cell?
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfCells
    }
    
    func getTimeRn(){
        let urlString = "https://worldtimeapi.org/api/timezone/America/Sao_Paulo"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                if let JsonTime = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]{
                    let teste = JsonTime["datetime"]! as! String
                    var horaVet: [Character] = []
                    for letra in teste{
                        horaVet.append(letra)
                    }
                    let hora = String(horaVet[11]) + String(horaVet[12])
                    DispatchQueue.main.async {
                        if Int(hora)! > 06 && Int(hora)! < 18 {
                            self.collectionView.backgroundColor = .gray
                        }
                    }
                }
            } catch {
                print("error")
            }
        })
        task.resume()
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.image.image = nil
        cell.name.text = String(indexPath.row)
        cell.isHidden = true
        
        
        
        // Alterar para switch/case
        if let principal = self.mainPerson{
            if indexPath.row == 0{
                if let mae = mainPerson?.mae{
                    cell.image.image = UIImage(data: principal.mae?.image! as! Data)
                    cell.name.text = String(indexPath.row)
                    cell.isHidden = false
                }else{
                    cell.image.image = UIImage(named: "imageDesconhecido")
                    cell.name.text = "Desconhecido"
                    cell.isHidden = false
                }
            }else if indexPath.row == 4{
                cell.image.image = UIImage(data: principal.image! as Data)
                cell.name.text = String(indexPath.row)
                cell.isHidden = false
            }else if indexPath.row == 1{
                if let conjuge = mainPerson?.conjuge{
                    cell.image.image = UIImage(data: principal.conjuge?.image! as! Data)
                    cell.name.text = String(indexPath.row)
                    cell.isHidden = false
                }else{
                    cell.image.image = UIImage(named: "imageDesconhecido")
                    cell.name.text = "Desconhecido"
                    cell.isHidden = false
                }
            }else if indexPath.row == 2{
                if let pai = mainPerson?.pai{
                    cell.image.image = UIImage(data: principal.pai?.image! as! Data)
                    cell.name.text = String(indexPath.row)
                    cell.isHidden = false
                }else{
                    cell.image.image = UIImage(named: "imageDesconhecido")
                    cell.name.text = "Desconhecido"
                    cell.isHidden = false
                }
            }else{
                cell.isHidden = true
            }
        }
        
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
        
        // jkhfds
            
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.indexPathRow = indexPath.row
        mostraView(cell: cell)
    }
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if let index = list.firstIndex(of: cell) {
            list.remove(at: index)
            listIndex.remove(at: listIndex.firstIndex(of: indexPath)!)
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            }, completion: nil)
        }
    }
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSize = collectionView.bounds.width
        let numberOfCellsPerRow = 3
        if indexPath.row % numberOfCellsPerRow*2 == 0 {
            return CGSize(width: totalSize/2, height: totalSize/2)
        }
        return CGSize(width: totalSize/4, height: totalSize/4)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func mostraView(cell: UICollectionViewCell){
        collectionView.indexPathsForVisibleItems.forEach { (index) in
            collectionView.cellForItem(at: index)?.isHidden = true
        }
        
        newUsrData.isHidden = false
        newUsrData.alpha = 1.0
        usrViewBounds()
        
        newUsrData.transform = CGAffineTransform(scaleX: 0.3, y: 2)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            self.newUsrData.transform = .identity
        }) { (_) in
            print("oi")
        }
        
        self.arredondaView(view: personImageView, multiplicador: 0.5)
        self.arredondaView(view: descriptionTextView, multiplicador: 0.09)
        self.arredondaButton(button: addFotoBtn, multiplicador: 0.5)
        self.arredondaButton(button: addBtn2, multiplicador: 0.2)
    }
}



