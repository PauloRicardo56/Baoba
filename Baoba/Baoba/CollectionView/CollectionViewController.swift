import UIKit

class CollectionViewController: UICollectionViewController {
    
    var numOfCells = 9
    var numOfSections = 1
    var lastIndex: IndexPath!
    var list: [CollectionViewCell] = []
    var listIndex: [IndexPath] = []
    var currCell: IndexPath? = nil
    
    
    // Como começar uma CollectionView na última cell?
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.scrollToItem(at: IndexPath(item: numOfCells-1, section: numOfSections-1), at: UICollectionView.ScrollPosition.top, animated: false)
    }
    
    
    @IBAction func multSelection(_ sender: Any) {
        multSelection = !multSelection
    }
    
    
    func setColor(indexPath: IndexPath) -> UIColor {
        if indexPath.row > numOfCells {
            return .black
        }
        
        return .init(hue: CGFloat(indexPath.row) / CGFloat(numOfCells), saturation: 1.0, brightness: 1.0, alpha: 0.5)
    }
    
    
    var multSelection = false {
        didSet {
            collectionView.allowsMultipleSelection = multSelection
            
            //            guard let shareButton = navigationItem.rightBarButtonItems?.first else { return }
            let removeButton = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
            removeButton.action = #selector(trashButton)
            removeButton.target = self
            let shareLabel = UILabel()
            let selectionLabel = UIBarButtonItem(customView: shareLabel)
            
            navigationItem.setRightBarButtonItems([removeButton, selectionLabel], animated: true)
            
            shareLabel.text = multSelection ? "Mult Selection Enabled" : "Mult Selection Disabled"
        }
    }
    
    
    @objc func trashButton() {
        numOfCells -= listIndex.count
        collectionView.deleteItems(at: listIndex)
        listIndex = []
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfCells
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell") // Configurando célula pelo código
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
//        cell.label.text = "\(indexPath.row)"
        cell.backgroundColor = setColor(indexPath: indexPath)
        lastIndex = indexPath
        cell.row.text = String(indexPath.row)
        print(indexPath)
        if indexPath.row != 4 {
            cell.isHidden = true
            print(1111)
        }
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if multSelection {
            return true
        }
        
        if let index = currCell {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                cell.backgroundColor = self.setColor(indexPath: indexPath)
            }, completion: nil)
        }
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if currCell == indexPath {
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                //                cell.backgroundColor = .init(red: 255, green: 255, blue: 255, alpha: 0)
                cell.backgroundColor = self.setColor(indexPath: indexPath)
            }, completion: nil)
            currCell = nil
        } else {
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromTop, animations: {
                cell.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
            }, completion: nil)
            currCell = indexPath
        }
        
        return false
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !multSelection {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromTop, animations: {
            cell.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        }, completion: nil)
        
        
        list.append(collectionView.cellForItem(at: indexPath) as! CollectionViewCell)
        listIndex.append(indexPath)
        print()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if !multSelection {
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        if let index = list.firstIndex(of: cell) {
            list.remove(at: index)
            listIndex.remove(at: listIndex.firstIndex(of: indexPath)!)
            UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                cell.backgroundColor = self.setColor(indexPath: indexPath)
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
}
