//
//  UsersTexts.swift
//  ReadSpeedster
//
//  Created by Andreas Antonsson on 2024-01-10.
//

import Foundation

struct UsersTexts {
    let whereTheWildThingsAre = WhereTheWildThingsAre()
    let mathilda = Mathilda()
    let harryPotter = HarryPotter()
    let theHobbit = TheHobbit()
    let theMetamorphosis = TheMetamorphosis()
    let ninteenEightyFour = NineteenEightyFour()
    let remembranceofThingsPast = RemembranceOfThingsPast()
    let thePhenomenologyOfMind = ThePhenomenologyOfMind()
    
    let texts: [String]
    
    init(){
        texts = [
            whereTheWildThingsAre.excerpt,
            mathilda.excerpt,
            harryPotter.excerpt,
            theHobbit.excerpt,
            theMetamorphosis.excerpt,
            ninteenEightyFour.excerpt,
            remembranceofThingsPast.excerpt,
            thePhenomenologyOfMind.excerpt,
        ]
    }
}
