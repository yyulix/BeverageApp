//
//  BeveragesListController.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit

protocol BeveragesListView {
    var presenter: BeveragesListPresenter? { get set }
    func updateCollectionView()
    func pushTranslucentSubstrate()
    func popTranslucentSubstrate()
    func notifyUser(with _: String)
}

final class BeveragesListController: UIViewController, UITextFieldDelegate {

    private struct UIConstants {
        static let collectionViewPadding: CGFloat = 20.0
        static let inputFieldBottomPadding: CGFloat = 143.0
        static let inputFieldWidth: CGFloat = 300.0
    }

    var presenter: BeveragesListPresenter?

    private lazy var inputField: InputField = {
        let inputField = InputField()
        inputField.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return inputField
    }()

    private lazy var coctailsCollectionView = CoctailsCollectionView()

    private lazy var activityIndicator = UIActivityIndicatorView()

    private lazy var translucentSubstrate: UIView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.layer.opacity = 0.5
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        inputField.textField.delegate = self
        coctailsCollectionView.delegate = self
        coctailsCollectionView.dataSource = self
        coctailsCollectionView.register(BeverageCell.self, forCellWithReuseIdentifier: BeverageCell.reuseIdentifier)
        
        setupKeyboard()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        inputField.textField.resignFirstResponder()
    }

    private func setupKeyboard() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            inputField.snp.updateConstraints { make in
                make.width.equalTo(view.frame.width + 10.0)
                make.bottom.equalToSuperview().offset(-1 * size.height)
            }
        }
    }

    @objc func keyboardWillHide() {

        inputField.snp.updateConstraints { make in
            make.width.equalTo(UIConstants.inputFieldWidth)
            make.bottom.equalToSuperview().offset(-1 * UIConstants.inputFieldBottomPadding)
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = inputField.textField.attributedText?.string
        presenter?.inputFieldUpdated(with: text)
    }
    
    private func setupUI() {

        view.backgroundColor = UIColor.AppColors.backgroundColor

        view.addSubview(inputField)

        inputField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIConstants.inputFieldWidth)
            make.bottom.equalToSuperview().offset(-1 * UIConstants.inputFieldBottomPadding)
        }

        view.addSubview(coctailsCollectionView)

        coctailsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(UIConstants.collectionViewPadding)
            make.left.right.equalToSuperview().inset(UIConstants.collectionViewPadding)
            make.bottom.equalTo(inputField.snp.top).offset(UIConstants.collectionViewPadding * -1)
        }
        coctailsCollectionView.reloadData()
    }
    
    public func notifyUser() {
        let alert = UIAlertController(title: NSLocalizedString("noBeverages", comment: ""),
                                      message: NSLocalizedString("tryAnother", comment: ""),
                                      preferredStyle: .alert
        )
        let action = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}

extension BeveragesListController: BeveragesListView {
    func notifyUser(with _: String) {
        notifyUser()
    }
    

    func updateCollectionView() {
        coctailsCollectionView.reloadData()
    }

    func pushTranslucentSubstrate() {
        view.addSubview(translucentSubstrate)
    }

    func popTranslucentSubstrate() {
        translucentSubstrate.removeFromSuperview()
    }
}

extension BeveragesListController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getAmountOfBeverages() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let currentBeverage = presenter?.getBeverage(with: indexPath.row) else {
            return UICollectionViewCell()
        }

        let cell = coctailsCollectionView.dequeueReusableCell(withReuseIdentifier: BeverageCell.reuseIdentifier,
                                                              for: indexPath) as? BeverageCell
        cell?.configure(with: String(currentBeverage.strDrink))
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputField.textField.resignFirstResponder()

        presenter?.beverageWasSelected(with: indexPath.row)
    }
}
