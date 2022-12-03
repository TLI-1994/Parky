# Parky

## Readme under preparation. Will be ppdated before Dec 3 12pm...



Parky shows the current parking situation near Cornell University. Depending on the available data, the main view shows the table view of all parking lots, including pictures, names, locations, fees, and open status. Besides, we can switch to a map view showing our locations with the authority as well as all parking lot locations on the map. Furthermore, each cell in the main view can be presented in a detailed view controller, which not only shows all information in the table but with the comment and location for a selected parking lot.

### Features of the app:

•	See parking lots in a table view and can add like by clicking the “heat” in both cells and the corresponding detailed view controller

•	Locate and Zoom-in and out are available in the map view.

•	The comments in a detailed view controller can automatically move one by one and can scroll manually. One can write a comment and add a photo (optional) and then submit it; the comment will jump into view and appear at the top.

The backend is also available at https://github.com/vcccaat/Cornell-Parking with API specs https://github.com/vcccaat/Cornell-Parking/blob/master/API-specs.txt 

### iOS Requirements Met

•	SnapKit is used to lay out all elements on all pages.

•	UITableView is used for all parking lots with information in the main page; the Like button (“heart”) delegate and store the Bool information to the main ViewController

•	Change to map view using push

•	Click cell of a parking lot can present a corresponding detailed ViewController

•	The comments showed in a detailed ViewController use UICollectionView and the Like button (“heart”) delegate to the Like button (“heart”) in TableViewCell

•	Integration with API: all the information is obtained from the backend database, and the submitted comments and photos are also stored in this database 

All people are welcome and encouraged to have pull requests and issue reports for this project.


