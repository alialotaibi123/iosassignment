
import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
