//
//  ViewController.swift
//  NameList
//
//  Created by shelly.gupta on 5/12/18.
//  Copyright © 2018 shelly.gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var names: [String] = []
    var filteredName =  [String: [String]]()
    var alphabetizedName = [String: [String]]()
    var sortedKeys: [String]?
    var index = 0
    var nameToPass: String?
    //By intializing the search view controller with nil, we tell the seach controller the we want to use the same view for displaying the result
    let searchViewController = UISearchController(searchResultsController: nil)
    var searchCheck = false
    
    @IBOutlet weak var namesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://raw.githubusercontent.com/dominictarr/random-name/master/names.json")
        
        do {
            let data = try Data(contentsOf: url!)
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let name = object as? [String] {
                names = name
            }
        } catch let error {
            print("Failed to load : \(error.localizedDescription)")
        }

        alphabetizedName = alphabatizedArray(namesList: names)
        filteredName = alphabetizedName
        
        //sort the keys
        sortedKeys = filteredName.keys.sorted(by: <)
        
        
        //search controller
        searchViewController.searchResultsUpdater = self
        searchViewController.hidesNavigationBarDuringPresentation = false
        searchViewController.dimsBackgroundDuringPresentation = false
        namesTableView.tableHeaderView = searchViewController.searchBar
        
    }

    func alphabatizedArray(namesList:[String]) -> [String:[String]] {
        var result = [String :[String]]()
        
        //
        for item in namesList {
            if let firstLetter = item.getSubstringFromStart(num: 1) {
                if result[firstLetter] != nil {
                    result[firstLetter]?.append(item)
                }
                else {
                    result[firstLetter] = [item]
                }
            }
        }
        
        // sorting the keys
        for(key, value) in result {
            result[key] = value.sorted(by: <)
        }
        return result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dataSegue" {
            let vc = segue.destination as! DetailsViewController
            vc.passedName = nameToPass ?? ""
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedKeys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //fetch the names in a section
        let key = sortedKeys![section]
        
        if let name = filteredName[key] {
            return name.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        //assign the name in cell
        let key = sortedKeys![indexPath.section]
    
        if let name = filteredName[key] {
            cell.textLabel?.text = name[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let selectedIndex =  tableView.indexPathForSelectedRow
        let selectedCell = tableView.cellForRow(at: selectedIndex!)
        
        nameToPass = selectedCell?.textLabel?.text
        performSegue(withIdentifier: "dataSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedKeys![section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sortedKeys
    }
}
extension String {
    func getSubstringFromStart(num :Int) -> String? {
        if self.count >= num {
            let index = self.index(self.startIndex, offsetBy: num)
            //capturing first letter of the string with the help of index
            let subString = self[..<index].uppercased()
            return subString
        }
        return nil
    }
}
// TO Allow view controller to respond to the search bar, it will have to implement UISearchResultsUpdating
//This protocol defines the method to update the search result based on the information the user enters into the search bar
extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchViewController.searchBar.text, searchText.count > 0{
            let firstCharacter = searchText.uppercased().getSubstringFromStart(num: 1)!
            let valueArray = alphabetizedName[firstCharacter]?.filter({ (value) -> Bool in
                return value.lowercased().contains(searchText.lowercased())
            })
            filteredName = [firstCharacter : valueArray] as! [String : [String]]
     }
    else {
            filteredName = alphabetizedName
    }
        sortedKeys = filteredName.keys.sorted(by: <)
        namesTableView.reloadData()
}
    
    
}

