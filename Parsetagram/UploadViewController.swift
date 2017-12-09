//
//  UploadViewController.swift
//  Parsetagram
//
//  Created by Avinash Singh on 07/12/17.
//  Copyright © 2017 Avinash Singh. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        captionTextField.textColor = UIColor.black
        
    }
    
    @IBAction func onTapCameraRoll(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
  
    
    
    @IBAction func onTapTakePicture(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let size = CGSize(width: 288, height: 288)
        let newImage = resize(image: editedImage, newSize: size)

        pictureView.image = newImage
        
        // Do something with the images (based on your use case
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func onTapSubmit(_ sender: Any) {
        
        let image = pictureView.image
        let caption = captionTextField.text
        
        Post.postUserImage(image: image, withCaption: caption, withCompletion: { (success: Bool, error: Error?) in
            if(success == true) {
                
                self.dismiss(animated: true, completion: nil)
                 NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidPost"), object: nil)
                
                
            } else {
                let errorAlertController = UIAlertController(title: "Error!", message: "Some error occured", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    //dismiss
                })
                errorAlertController.addAction(errorAction)
                self.present(errorAlertController, animated: true)
            }
        })
        
        
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
