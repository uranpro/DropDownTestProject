//
//  ActionSheetViewController.swift
//  dropdown
//
//  Created by Mikhail Bushuev on 11/05/2018.
//  Copyright © 2018 xtra. All rights reserved.
//

import UIKit

enum ActionSheetMood {
    case happy
    case angry
    case other(otherTitle: String, otherVariants: [String])
}

extension ActionSheetMood {
    var title: String {
        switch self {
        case .happy:
            return "Happy"
        case .angry:
            return "Such angry, so wow"
        case .other(let otherTitle, _):
            return otherTitle
        }
    }
    
    var variants: [String] {
        switch self {
        case .happy:
            return ["Happy", "Peace", "Love", "Sky"]
        case .angry:
            return ["War", "Annoy", "Internet explorer"]
        case .other(_, let otherVariants):
            return otherVariants
        }
    }
}

class ActionSheetViewController: UITableViewController {
    
    // MARK: User interactions
    
    let moods: [ActionSheetMood] = [.happy,
                                    .angry,
                                    .other(otherTitle: "Neutral", otherVariants: ["Fish", "Draw", "Work hard"])]
    
}

extension ActionSheetViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        variants(mood: moods[indexPath.row])
    }
}

extension ActionSheetViewController {
    func variants(mood: ActionSheetMood) {
        let alertController = UIAlertController(title: mood.title, message: "Select one", preferredStyle: .actionSheet)
        
        mood.variants.forEach { (variant) in
            let action = UIAlertAction(title: variant, style: .default, handler: nil)
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
