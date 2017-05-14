
import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //imgProfile.layer.cornerRadius=1
        //imgProfile.clipsToBounds=true
        
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = 100
        imgProfile.clipsToBounds = true
        
        
        let ud = UserDefaults.standard
        
        lblName.text = ud.value(forKey: "name") as! String?
        lblContact.text = ud.value(forKey: "contact") as! String?
        lblCity.text = ud.value(forKey: "city") as! String?
        
        let str2 = ud.value(forKey: "image1") as! String
        let str1 = ud.value(forKey: "image")
        let str = ud.object(forKey: "image") as AnyObject
        if !(str1 == nil)
        {
            if !((str2)=="out") {
                let img=UIImage(data: str as! Data)
                imgProfile.image=img
            }
            else
            {
                let img=UIImage(named:"pro.jpg")
                imgProfile.image=img
            }
            
        }
        else
        {
            let img=UIImage(named:"pro.jpg")
            imgProfile.image=img
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogout(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(" ", forKey: "signin")
        ud.set("out", forKey: "image1")
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBAction func btnImage(_ sender: Any) {
        let photo=UIImagePickerController.init()
        present(photo, animated: true, completion: nil)
        photo.delegate=self
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let img=info[UIImagePickerControllerOriginalImage] as! UIImage
        imgProfile.image=img
        
        let ud = UserDefaults.standard
        ud.set(UIImagePNGRepresentation(img), forKey: "image")
        
        ud.set("in", forKey: "image1")
        dismiss(animated: true, completion: nil)
        
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
