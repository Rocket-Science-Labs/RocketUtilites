
#if os(iOS)
#if canImport(UIKit)
import UIKit
#endif
import RxCocoa
import RxSwift

extension Reactive where Base: LoadingButton {
    
    var isLoading: Binder<Bool> {
        return Binder(self.base) { button, isLoading in
            button.isLoading = isLoading
        }
    }
    
}

class LoadingButton: UIButton {
    
    var isLoading: Bool = false {
        didSet {
            isLoading ? showLoading() : hideLoading()
        }
    }
    
    var originalButtonText: String?
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        originalButtonText = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        centerActivityIndicatorInButton()
    }
    
    var indicatorStyle: UIActivityIndicatorView.Style = .white
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        activityIndicator.style = indicatorStyle
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    @IBInspectable
    let activityIndicatorColor: UIColor = .lightGray
    
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        super.setTitle("", for: .normal)
        showSpinning()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        self.setTitle(originalButtonText, for: .normal)
    }
    
    private func showSpinning() {
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}

#endif
