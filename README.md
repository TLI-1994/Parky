# Parky - Your Parking Assistant @ Cornell

## Description

Parky tells the current parking lot availability near Cornell University. The main view shows a table of the information of all parking lots, including photos, names, locations, fees, and open status. Besides, Parky presents a detailed view when a table cell is selected. The detail view shows all information in the table as well as user comments and the location of the parking lot. Furthermore, a map view shows the user's location as well as all parking lot locations on the map.

<p align="center">
  <img src="screenShots/tableView.png" alt="drawing" width="25%" hspace="20"/>
  <img src="screenShots/detailView.png" alt="drawing" width="25%" hspace="20"/>
  <img src="screenShots/mapView.png" alt="drawing" width="25%" hspace="20"/>
</p>

## Features of the app

- Users can "like" a parking lot by either tapping the “heart” in the table cell or the "heart" in the detailed view.
- Centering on user's location and zooming are available in the map view.
- The comments in a detailed view controller automatically rolls and can also be scrolled manually. 
- Users can write a comment with an optional photo. After submission, the comment will be displayed as the first.

The backend code and API specs can be found [here](https://github.com/vcccaat/Cornell-Parking).

## iOS Requirements Met

- SnapKit is used to lay out all elements on all pages.
- UITableView is used for all parking lots with information in the main page. 
- The "like" status is synced between the table cell and the detailed view by delegation.
- Map view is pushed.
- The detailed view is presented.
- The comments are implemented using a UICollectionView.
- Integration with API:
  * All the information is pulled from the backend database by `GET`.
  * Submitted comments and photos are written to the database by `POST`.

Pull requests and issue reports are welcome!


