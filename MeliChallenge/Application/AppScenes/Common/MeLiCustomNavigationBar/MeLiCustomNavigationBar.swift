//
//  MeLiCustomNavigationBar.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 25/05/22.
//

import UIKit

class MeLiCustomNavigationBar: UIView {

    @IBOutlet weak var titleNavBarLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: MeLiCustomNavigationBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        viewSetup()
        contentView?.prepareForInterfaceBuilder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func viewSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth]
        self.addSubview(view)
        titleNavBarLabel.text = ""
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let nibName = "MeLiCustomNavigationBar"
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setupTitleNavBar(title: String?) {
        titleNavBarLabel.text = title ?? ""
    }
    
    @IBAction func backPressed(_ sender: Any) {
        delegate?.customNavigationBar(requestActionForButton: .back)
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        delegate?.customNavigationBar(requestActionForButton: .search)
    }
}
