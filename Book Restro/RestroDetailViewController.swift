
import UIKit
import MapKit

class RestroDetailViewController: UIViewController {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblHours: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBAction func btnMenu(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    @IBAction func btnLoc(_ sender: Any) {
        
        let u = UserDefaults()
        let s = u.value(forKey: "rLatitude") as! String
        let s1 = u.value(forKey: "rLogitude") as! String
        let myNumber = NSNumber(value:Float(s)!)
        let myNumber1 = NSNumber(value:Float(s1)!)
        
        
        let latitude: CLLocationDegrees = CLLocationDegrees(myNumber1)
        let longitude: CLLocationDegrees = CLLocationDegrees(myNumber)
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = u.value(forKey: "rName") as? String
        mapItem.openInMaps(launchOptions: options)
    }
    @IBAction func btnRate(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "review") as! ReviewsViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCall(_ sender: Any) {
        let u = UserDefaults()
        var s = (u.value(forKey: "rPhone") as! String)
        s = s.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "telprompt://\(s)") {
            print(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func btnBook(_ sender: Any) {
        let sec=self.storyboard?.instantiateViewController(withIdentifier: "book") as! BookViewController
        self.navigationController?.pushViewController(sec, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let u = UserDefaults()
        var s = ""
        s = String(format: "%@.jpg", (u.value(forKey: "rId") as! String?)!)
        imgView.image = UIImage(named:s)
        lblName.text = (u.value(forKey: "rName") as! String)
        lblAddress.text = (u.value(forKey: "rAddress") as! String)
        lblDetail.text = (u.value(forKey: "rDetail") as! String)
        lblHours.text = (u.value(forKey: "rHours") as! String)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        let u = UserDefaults()
        let dml = DMLOperation()
        lblRating.text = dml.reviewAvg(query: String(format:"SELECT * FROM ratings WHERE restro_id=%@",(u.value(forKey: "rId") as! String)))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
