//
//  CaptureViewController.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/10/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var captureButton: UIButton!
    var editedImage: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onUploadTapped(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // Do something with the images (based on your use case)
            
            editedImage = resize(originalImage,newSize: CGSize(width: 560, height: 320) )
            
            // Dismiss UIImagePickerController to go back to your original view controller
            dismissViewControllerAnimated(true, completion: nil)
            captureButton.setImage(editedImage, forState: .Normal)

        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func onPostTapped(sender: AnyObject) {
        let caption = captionField.text
        if let editedImage = editedImage{
            if let caption = caption{
                Post.postUserImage(editedImage, withCaption: caption, withCompletion: { (completed: Bool, error: NSError?) -> Void in
                    if(completed){
                        print("success")
                    } else{
                        print(error?.localizedDescription)
                    }
                })
            }
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
