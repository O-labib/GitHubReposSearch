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
class NetworkErrorView: UIView {

    // MARK: Outlets
    @IBOutlet weak var errorMsgLabel: UILabel!

    // MARK: Properties
    weak var delegate: NetworkErrorViewDelegate?

    // MARK: Setup functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    private func setup() {
        guard let view = loadViewFromNib() else { return }

        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        subviews.forEach({$0.removeFromSuperview()})

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: NetworkErrorView.identifier, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }

    @IBAction func retryAction(_ sender: Any) {
        delegate?.networkErrorViewDidTapRetry(self)
    }

    func setErrorMsg(_ errorMSg: String?) {
        if let errorMsg = errorMSg {
            self.errorMsgLabel.text = errorMsg
        }
    }
}
