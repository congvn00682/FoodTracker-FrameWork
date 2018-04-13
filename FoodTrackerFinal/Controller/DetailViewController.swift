//
//  DetailViewController.swift
//  FoodTrackerFinal
//
//  Created by Vu Ngoc Cong on 4/4/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var index: Int!
    
    var isCheckName: Bool = false {
        didSet {
            if isCheckName {
                isError = !((DataServices.shared.meals.filter { $0.name == nameMealTextField.text ?? "" }).count == 0)
                print(isError)
                isCheckName = false
            }
        }
    }
    
    var isError: Bool = false {
        didSet {
            if isError {
                let alertController = UIAlertController(title: "FBI Waring", message: "Please enter name other!!!! Fuck you!!!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var nameMealTextField: UITextField!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meals = DataServices.shared.meals
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if index != nil {
            nameMealTextField.text = meals[index].name
            photoImageView.image = meals[index].photo
            ratingControl.rating = meals[index].rating
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = selectImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromLibrary(_ sender: UITapGestureRecognizer) {
        nameMealTextField.resignFirstResponder()
        let imagePickerControl = UIImagePickerController()
        imagePickerControl.delegate = self
        imagePickerControl.sourceType = .photoLibrary
        present(imagePickerControl, animated: true, completion: nil)
    }
    
    @IBAction func btnSingleton(_ sender: UIBarButtonItem) {
        nameMealTextField.resignFirstResponder()
        nameMealTextField.endEditing(true)
        
        if let indexPath = index {
            if meals[indexPath].name != nameMealTextField.text ?? "" {
                isCheckName = true
            }
            if !isError {
                meals[indexPath].name = nameMealTextField.text ?? ""
                meals[indexPath].photo = photoImageView.image
                meals[indexPath].rating = ratingControl.rating
            }
        } else {
            isCheckName = true
            if !isError {
                let meal = Meal(name: nameMealTextField.text ?? "", photo: photoImageView.image, rating: ratingControl.rating)!
                DataServices.shared.addNewMeal(meal)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
