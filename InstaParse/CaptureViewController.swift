//
//  CaptureViewController.swift
//  InstaParse
//
//  Created by Kwaku Owusu on 3/10/16.
//  Copyright © 2016 Kwaku Owusu. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var captureButton: UIButton!
    var editedImage: UIImage!
    let vc = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onUploadTapped(sender: AnyObject) {
        

        
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
                let loadingNotification = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                loadingNotification.mode = MBProgressHUDMode.Indeterminate
                loadingNotification.labelText = "Uploading to InstaParse"
                
                Post.postUserImage(editedImage, withCaption: caption, withCompletion: { (completed: Bool, error: NSError?) -> Void in
                    if(completed){
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        
                        self.captionField.text = ""
                        self.captureButton.setImage(nil, forState: .Normal)
                        self.tabBarController?.selectedIndex = 0
                    } else{
                        print(error?.localizedDescription)
                        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)

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
