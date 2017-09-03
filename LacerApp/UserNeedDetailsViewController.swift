//
//  UserNeedDetailsViewController.swift
//  LacerApp
//
//  Created by Joan Angb on 28/08/2017.
//  Copyright © 2017 DevArtisant. All rights reserved.
//

import UIKit

class UserNeedDetailsViewController: ScrollViewController, UITextFieldDelegate, UITextViewDelegate   {
    
    //matchingProfilesTableView
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var matchingProfilesTableViewDelegate : MatchingProfilesTableViewDelegate!
    
    var matchingProfilesTableViewContainer : UIView = UIView()
    
    let matchingProfilesTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(MatchingProfilesTableViewCell.self, forCellReuseIdentifier: "MatchingProfilesTableViewCell")
        return tableView
    }()
    
    fileprivate func setupMatchingProfilesTableView() -> UIView{
        
        matchingProfilesTableViewDelegate = MatchingProfilesTableViewDelegate()
        matchingProfilesTableView.delegate = matchingProfilesTableViewDelegate
        matchingProfilesTableView.dataSource = matchingProfilesTableViewDelegate
        matchingProfilesTableViewDelegate.tableView = matchingProfilesTableView
        
        //SearchController parameters
        searchController.searchResultsUpdater = matchingProfilesTableViewDelegate
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        matchingProfilesTableView.tableHeaderView = searchController.searchBar
        
        //SearchController's search bar parameters
        searchController.searchBar.scopeButtonTitles = ["Particuliers","Entreprises"]
        searchController.searchBar.delegate = matchingProfilesTableViewDelegate
        
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: matchingProfilesTableViewContainer,
                view: matchingProfilesTableView,
                text : "De quoi avez vous besoin ?",
                labelHeight : 16,
                viewHeight : 380,
                leftMargin : 0,
                rightMargin : 0,
                debug: false),
            debug: false)
    }
    
    
    
    //needStatusSwitch
    
    var needStatusContainerView : UIView = UIView()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Je souhaite être contacté(e)"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var needStatusSwitch: UISwitch = {
        let uiswitch = UISwitch()
        uiswitch.isOn = false
        uiswitch.addTarget(self, action: #selector(needStatusSwitchChanged), for: .touchUpInside)
        return uiswitch
    }()
    
    fileprivate func setupNeedStatusSwitch() -> UIView {
        needStatusContainerView.addSubview(label)
        needStatusContainerView.addSubview(needStatusSwitch)
        
        needStatusContainerView.addConstraintsWithFormat("H:|-24-[v0]-8-[v1]", views: label, needStatusSwitch)
        needStatusContainerView.addConstraintsWithFormat("V:|[v0]|", views: label)
        needStatusContainerView.addCenteredYConstraint(about: needStatusSwitch, to: label)
        
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: needStatusContainerView,
            debug: false)
    }
    
    
    
    //titleContainerView
    
    var titleContainerView : UIView = UIView()
    
    let titleTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = " Entrez le titre de ce besoin"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        //border
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textField.backgroundColor = .white
        return textField
    }()
    
    fileprivate func setupTitleContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: titleContainerView,
                view: titleTextField,
                text : "Donnez un titre à ce besoin",
                debug: false),
            debug: false)
    }
    
    
    
    //descriptionContainerView
    
    var descriptionContainerView : UIView = UIView()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = ""
        textView.backgroundColor = .white
        //border
        textView.layer.borderWidth = 0.8;
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textView.backgroundColor = .white
        return textView
    }()
    
    fileprivate func setupDescriptionContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: descriptionContainerView,
                view: descriptionTextView,
                text : "Décrivez ce besoin",
                viewHeight : 226,
                debug: false),
            debug: false)
    }
    
    
    
    //rewardContainerView
    
    var rewardContainerView : UIView = UIView()
    
    let rewardTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = " Quelle récompense offrez vous ?"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        //border
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textField.backgroundColor = .white
        return textField
    }()
    
    fileprivate func setupRewardContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: rewardContainerView,
                view: rewardTextField,
                text : "Précisez la récompense",
                debug: false),
            debug: false)
    }
    
    
    
    //placeContainerView
    
    var placeContainerView : UIView = UIView()
    
    let placeTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = " Quelle est le lieu du besoin ?"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        //border
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textField.backgroundColor = .white
        return textField
    }()
    
    fileprivate func setupPlaceContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: placeContainerView,
                view: placeTextField,
                text : "Précisez le lieu",
                debug: false),
            debug: false)
    }
    
    
    
    //placeContainerView
    
    var timeContainerView : UIView = UIView()
    
    let timeTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = " Quelle est le moment du besoin ?"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textAlignment = .left
        //border
        textField.layer.borderWidth = 0.8;
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(white : 0.9, alpha: 1).cgColor;
        textField.backgroundColor = .white
        return textField
    }()
    
    fileprivate func setupTimeContainerView() -> UIView{
        return FormLabeledEntry.installEntryIn(
            parent: containerView,
            entry: FormLabeledEntry.composeEntry(
                containerView: timeContainerView,
                view: timeTextField,
                text : "Précisez la date ou le moment",
                debug: false),
            debug: false)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollView.contentSize = CGSize(width:view.bounds.size.width,height: 1100)
        containerView.backgroundColor = UIColor(white: 0.99, alpha: 1)
        
        setupMatchingProfilesTableView()
        setupNeedStatusSwitch()
        setupTitleContainerView()
        setupDescriptionContainerView()
        setupRewardContainerView()
        setupPlaceContainerView()
        setupTimeContainerView()
        
        containerView.addConstraintsWithFormat(
            "V:|[v0(400)]-16-[v1(54)]-16-[v2(54)]-16-[v3(250)]-16-[v4(54)]-16-[v5(54)]-16-[v6(54)]"
            ,views: matchingProfilesTableViewContainer,needStatusContainerView,titleContainerView,descriptionContainerView,rewardContainerView,placeContainerView,timeContainerView
        )
        
        disableRightBarButtonItem()
        setInputsDelegate()
        manageKeyboard()
        setTapToDissmissKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    
    //Mark : - Methods
    
    
    private func setInputsDelegate(){
        titleTextField.delegate = self
        descriptionTextView.delegate = self
        rewardTextField.delegate = self
        placeTextField.delegate = self
        timeTextField.delegate = self
    }
    
    
    
    //Global tap gesture
    fileprivate func setTapToDissmissKeyboard(){
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        singleTap.numberOfTapsRequired = 1;
        containerView.addGestureRecognizer(singleTap)
    }
    
    func hideKeyboard(_ sender: AnyObject) {
        titleTextField.endEditing(true)
        descriptionTextView.endEditing(true)
        rewardTextField.endEditing(true)
        placeTextField.endEditing(true)
        timeTextField.endEditing(true)
    }
    
    
    
    
    
    private func disableRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = false
        }
    }
    
    private func enableRightBarButtonItem(){
        if let rightBarButton = self.navigationItem.rightBarButtonItem {
            rightBarButton.isEnabled = true
        }
    }
    
    func needStatusSwitchChanged(_ sender: UISegmentedControl) { enableRightBarButtonItem() } //TODO
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) { enableRightBarButtonItem() }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { enableRightBarButtonItem() }
    
    
    
    
    
    fileprivate func manageKeyboard() {
        KeyboardNotification.addObserverOnKeyboardWillShow(observer : self, selector: #selector(keyboardWillShow))
        KeyboardNotification.addObserverOnKeyboardWillHide(observer : self, selector: #selector(keyboardWillHide))
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if !isKeyboardVisible{
            KeyboardNotification.adjustInsetForKeyboardShow(true, notification: notification, scrollView: scrollView)
            isKeyboardVisible = true
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        KeyboardNotification.adjustInsetForKeyboardShow(false, notification: notification, scrollView: scrollView)
        isKeyboardVisible = false
    }
    
    private var isKeyboardVisible = false
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    @IBAction func saveUserNeed(_ sender: UIBarButtonItem) {
        
        if let titletext = titleTextField.text{
            if titletext.characters.count < 1 {
                Alert.displayMessage(context: self, message: "Le titre doit être renseigné pour pouvoir sauvegarder ce besoin")
                return
            }
        }
        
        if needStatusSwitch.isOn {
            if descriptionTextView.text.characters.count < 1 {
                Alert.displayMessage(context: self, message: "La description doit être renseignée pour pouvoir être contacté")
                return
            }
            if rewardTextField.text!.characters.count < 1 {
                Alert.displayMessage(context: self, message: "La récompense doit être renseignée pour pouvoir être contacté")
                return
            }
            if placeTextField.text!.characters.count < 1 {
                Alert.displayMessage(context: self, message: "Le lieu doit être renseignée pour pouvoir être contacté")
                return
            }
            if timeTextField.text!.characters.count < 1 {
                Alert.displayMessage(context: self, message: "Le moment doit être renseignée pour pouvoir être contacté")
                return
            }
            
        }
        
        UserNeedSnap(
            ownerID : "59ab7691217e0e0294d2e1c9",
            searchText : searchController.searchBar.text!,
            visible: needStatusSwitch.isOn,
            title: titleTextField.text!,
            description: descriptionTextView.text,
            reward:  rewardTextField.text,
            place:  placeTextField.text,
            time:  timeTextField.text,
            ack: userNeedDidSave,
            _id : _id)
        
        disableRightBarButtonItem()
    }
    
    
    
    // MARK: - IO
    let regina = IO.r
    
    var _id : String?=nil {
        didSet {
            loadData()
        }
    }
    
    
    // MARK: - private methods
    
    private func userNeedDidSave (dataArray : [Any])->(){
        enableRightBarButtonItem()
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            Alert.displayMessage(context: self, headerTitle: "Votre besoin a été mis à jour", confirmable : false)
            disableRightBarButtonItem()
        })
    }
    
    
    
    
    
    
    
    private func loadData(){
        if let userid = self._id {
            regina.find(coll: UserNeedSnap.coll, query: ["_id" : userid], ack: dataDidLoad)
        }
    }
    
    private func dataDidLoad(dataArray : [Any])->(){
        Waiter.popNServ(context: self, dataArray: dataArray, drink: {res in
            if let res = res as? JSONObjects {
                populateUI(data : res)
            }
        })
    }
    
    private func populateUI(data : JSONObjects){
        if data.count == 1 {
            let need = data[0]
            self.needStatusSwitch.isOn = need["visible"] as? Bool ?? false
            self.titleTextField.text = need["title"] as? String ?? ""
            self.descriptionTextView.text = need["description"] as? String ?? ""
            self.rewardTextField.text = need["reward"] as? String ?? ""
            self.placeTextField.text = need["place"] as? String ?? ""
            self.timeTextField.text = need["time"] as? String ?? ""
            self.searchController.searchBar.text = need["searchText"] as? String ?? ""
        }else{
            Waiter.isConfused(self)
        }
    }
    
    
}
