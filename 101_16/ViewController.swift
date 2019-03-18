

import UIKit

class ViewController: UICollectionViewController {
    
   
    
    var pictures = [String]()
    var titlefordetailview: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(getPictures), with: nil)
       
        title = "Panarama"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recMyAppToPeople))//add a classic icon to the bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(recMyAppToPeople))//adds a text button to the bar, our own icon
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCellCollectionViewCell
        pictures = pictures.sorted()
        cell.lable.text = pictures[indexPath.row]
        cell.imageView.image = UIImage(named:pictures[indexPath.row] )
        
        return cell
    }
   
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            vc.imageName = pictures[indexPath.row]
            vc.title = "picture \(indexPath.row + 1) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
   
    @objc func recMyAppToPeople(){
        let recApp = "I reccomend this app to you"
    let vc = UIActivityViewController(activityItems: [recApp], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem //for ipad
        present(vc, animated: true)
    }
    
    @objc func getPictures(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)}
        }
    }
}

