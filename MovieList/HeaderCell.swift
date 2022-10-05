//
//  HeaderCell.swift
//  MovieList
//
//  Created by admin on 05/10/2022.
//

import UIKit

class HeaderCell: UICollectionReusableView {
    @IBOutlet weak var lbTitle: UILabel!
    var close: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbTitle.backgroundColor = .blue
    }
    
    @IBAction func didTap(_ sender: Any) {
        close?()
    }
    
}
