//
//  NetworkErrorView.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/4/21.
//


import UIKit
protocol NetworkErrorViewDelegate: class {
    func networkErrorViewDidTapRetry(_ networkErrorView: NetworkErrorView)
}
class NetworkErrorView:UIView {

    
    //MARK: Outlets

    
    
    //MARK: Variable
    var view:UIView!

    weak var delegate : NetworkErrorViewDelegate?

    
    
    //MARK: Setup functions

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }


    private func setup() {
        if let customView = loadViewFromNib() {
            self.view = customView
            
            view.frame = bounds
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]


            if view.superview == nil {
                addSubview(view)
            }
            
        }


    }
        


      private func loadViewFromNib() -> UIView? {
            let nib = UINib(nibName: "NetworkErrorView" ,bundle: nil)
            return nib.instantiate(withOwner: self, options: nil).first as? UIView
        }

    
    @IBAction func retryAction(_ sender: Any) {
        delegate?.networkErrorViewDidTapRetry(self)
    }
    
}

    

