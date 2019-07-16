import UIKit

class CollectionViewController: UICollectionViewController,UITextFieldDelegate,UITextViewDelegate {
    
    var numOfCells = 9
    var numOfSections = 1
    var lastIndex: IndexPath!
    var list: [CollectionViewCell] = []
    var listIndex: [IndexPath] = []
    var currCell: IndexPath? = nil
    var cell = CollectionViewCell()
    var persons = [Person]()
    var vetorPessoas: [Int:Person] = [:]
    let desconhecido = Person(nome: "Desconhecido", sexo: "Desconhecido", descricao: "Desconhecido", image: UIImage(named: "imageDesconhecido")!,visivel: true)
    weak var mainPerson:Person?
    
    //@IBOutlet weak var newUsrData: FirstFormController!
    @IBOutlet weak var newUsrData: UIScrollView!
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var addFotoBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sexoSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addBtn2: UIButton!
    
    let imagePicker = ImagePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.mainPerson = desconhecido
    }
    
    // Como começar uma CollectionView na última cell?
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.scrollToItem(at: IndexPath(item: numOfCells-1, section: numOfSections-1), at: UICollectionView.ScrollPosition.top, animated: false)
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfCells
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.image.image = nil
        cell.name.text = String(indexPath.row)
        cell.isHidden = true
        
        // Alterar para switch/case
        if let principal = self.mainPerson{
            if indexPath.row == 0{
                cell.image.image = principal.mae?.image
                cell.name.text = String(indexPath.row)
                cell.isHidden = false
            }else if indexPath.row == 4{
                cell.image.image = principal.image
                cell.name.text = String(indexPath.row)
                cell.isHidden = false
            }else if indexPath.row == 1{
                cell.image.image = principal.conjuge?.image
                cell.name.text = String(indexPath.row)
                cell.isHidden = false
            }else if indexPath.row == 2{
                cell.image.image = principal.pai?.image
                cell.name.text = String(indexPath.row)
                cell.isHidden = false
            }else{
                cell.isHidden = true
            }
        }
        
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: [indexPath])
        }, completion: nil)
        
        
            
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
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

        cell.isHidden = true
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



