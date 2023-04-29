//
//  ViewController.swift
//  project1
//
//  Created by Julia Avila on 4/29/23.
//

import UIKit

class PokedexViewController: UITableViewController {
    
    var pokemon = Array(1...151)

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        title = NSLocalizedString("navigation-title", comment: "")
            
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = NSLocalizedString("pokemon-name-\(String(pokemon[indexPath.row]))", comment: "")
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dexDetailViewController = storyboard?.instantiateViewController(withIdentifier: "detailID") as? DexDetailViewController else { return }
        dexDetailViewController.pokemonID = pokemon[indexPath.row]
        navigationController?.pushViewController(dexDetailViewController, animated: true)
    }

}
