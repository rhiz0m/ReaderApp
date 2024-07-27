//
//  UsersTexts.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-10.
//

import Foundation

class PoemTexts: ObservableObject {
    @Published var texts: [String] = []
    private let poemsRepository = PoemsRepository()
    
    init() {
        fetchTexts()
    }
    
    func fetchTexts() {
        poemsRepository.getPoems { result in
            switch result {
            case .success(let poems):
                let mergedTexts = self.poemsRepository.mergePoemLines(from: poems)
                DispatchQueue.main.async {
                    self.texts = mergedTexts
                }
            case .failure(let error):
                print("Failed to fetch texts: \(error)")
            }
        }
    }
}




//struct UsersTexts {
//    let whereTheWildThingsAre = WhereTheWildThingsAre()
//    let mathilda = Mathilda()
//    let harryPotter = HarryPotter()
//    let theHobbit = TheHobbit()
//    let theMetamorphosis = TheMetamorphosis()
//    let ninteenEightyFour = NineteenEightyFour()
//    let remembranceofThingsPast = RemembranceOfThingsPast()
//    let thePhenomenologyOfMind = ThePhenomenologyOfMind()
//    
//    let texts: [String]
//    
//    init(){
//        texts = [
//            whereTheWildThingsAre.excerpt,
//            mathilda.excerpt,
//            harryPotter.excerpt,
//            theHobbit.excerpt,
//            theMetamorphosis.excerpt,
//            ninteenEightyFour.excerpt,
//            remembranceofThingsPast.excerpt,
//            thePhenomenologyOfMind.excerpt,
//        ]
//    }
//}
