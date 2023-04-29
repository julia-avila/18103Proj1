//
//  DexDetailViewController.swift
//  project1
//
//  Created by Julia Avila on 4/29/23.
//

import UIKit
import PokemonAPI


class DexDetailViewController: UIViewController {
    
    var pokemonID = 0
    private var pokemonType = [PKMPokemonType]()

    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokemonName.text = NSLocalizedString("pokemon-name-\(pokemonID)", comment: "")
        
        PokemonAPI().pokemonService.fetchPokemon(pokemonID) { [self] result in
            switch result {
                case .success(let pokemon):
                    getImage(for: pokemon)
                    pokemonType = pokemon.types!
                    let typeOne = pokemonType[0].type?.name ?? ""
                
                    DispatchQueue.main.async {
                        
                        self.type1Label.text = NSLocalizedString("\(typeOne)-display-text", comment: "")
                        self.type1Label.backgroundColor = UIColor(named: typeOne)
                        self.type1Label.layer.cornerRadius = 8
                        self.type1Label.layer.masksToBounds = true
                        self.type1Label.widthAnchor.constraint(equalToConstant: self.type1Label.intrinsicContentSize.width + 15).isActive = true
                    }
                    
                    if pokemonType.count > 1 {
                        let typeTwo = pokemonType[1].type?.name ?? ""
                        DispatchQueue.main.async {
                            self.type2Label.text = NSLocalizedString("\(typeTwo)-display-text", comment: "")
                            self.type2Label.backgroundColor = UIColor(named: typeTwo)
                            self.type2Label.layer.cornerRadius = 8
                            self.type2Label.layer.masksToBounds = true
                            self.type2Label.widthAnchor.constraint(equalToConstant: self.type2Label.intrinsicContentSize.width + 15).isActive = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.type2Label.isHidden = true
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
        title = NSLocalizedString("pokemon-name-\(pokemonID)", comment: "")
    }

    private func getImage(for pokemon: PKMPokemon) {
        guard let imageURLString = pokemon.sprites?.frontDefault,
              let imageURL = URL(string: imageURLString)
        else { return }
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data)
            else { return }
            // TODO: Do things here.
            print(image)

            DispatchQueue.main.async {
                self.pokemonImage.image = image
            }
        }.resume()
    }

}
