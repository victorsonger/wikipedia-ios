
import UIKit

class DiffHeaderEditorView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var userIconImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var numberOfEditsLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func update(_ viewModel: DiffHeaderEditorViewModel) {
        headingLabel.text = viewModel.heading
        usernameLabel.text = viewModel.username
        if #available(iOS 13.0, *) {
            userIconImageView.image = UIImage(systemName: "person.fill")
        } else {
            userIconImageView.isHidden = true //TONITODO: get asset for this
        }
        //tonitodo: tappable usericon and username label
        switch viewModel.state {
        case .loadedNumberOfEdits(let numberOfEdits):
            numberOfEditsLabel.text = String.localizedStringWithFormat(viewModel.numberOfEditsFormat, numberOfEdits)
            numberOfEditsLabel.isHidden = false
        default:
            numberOfEditsLabel.isHidden =  true
        } //TONITODO: activity indicator and stuff
        updateFonts(with: traitCollection)
        
        //theming
        backgroundColor = viewModel.theme.colors.paperBackground
        contentView.backgroundColor = viewModel.theme.colors.paperBackground
        headingLabel.textColor = viewModel.theme.colors.secondaryText
        usernameLabel.textColor = viewModel.theme.colors.link
        userIconImageView.tintColor = viewModel.theme.colors.link
        numberOfEditsLabel.textColor = viewModel.theme.colors.secondaryText
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateFonts(with: traitCollection)
    }
}

private extension DiffHeaderEditorView {
    
    func commonInit() {
        Bundle.main.loadNibNamed(DiffHeaderEditorView.wmf_nibName(), owner: self, options: nil)
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func updateFonts(with traitCollection: UITraitCollection) {
    
        headingLabel.font = UIFont.wmf_font(DynamicTextStyle.semiboldFootnote, compatibleWithTraitCollection: traitCollection)
        usernameLabel.font = UIFont.wmf_font(DynamicTextStyle.semiboldCallout, compatibleWithTraitCollection: traitCollection)
        numberOfEditsLabel.font = UIFont.wmf_font(DynamicTextStyle.callout, compatibleWithTraitCollection: traitCollection)
    }
}
