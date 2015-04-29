//
//  ViewControllerAddTrip.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerAddTrip.h"
#import "ViewController.h"
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>




@implementation ViewControllerAddTrip {
    NSMutableArray *youArray;
    NSArray* items;
    PFFile *imageFile;
}

@synthesize searchBar;
@synthesize yourTable;
@synthesize tableData;
@synthesize searchResult;
@synthesize destination;
@synthesize visitedLabel;
@synthesize andLabel;
@synthesize dsriptionField;
@synthesize addPicBtn;
@synthesize photoView;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
   
    
    [self.searchBar setPlaceholder:@"Search for a country"];
    
    visitedLabel.hidden = YES;
    destination.hidden = YES;
    andLabel.hidden = YES;
    dsriptionField.hidden = YES;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"File"
                                                     ofType:@"txt"];
    
    //pull the content from the file into memory
    NSData* data = [NSData dataWithContentsOfFile:path];
    //convert the bytes from the file into a string
    NSString* string = [[NSString alloc] initWithBytes:[data bytes]
                                                 length:[data length]
                                               encoding:NSUTF8StringEncoding];
    
    //split the string around newline characters to create an array
    NSString* delimiter = @"\n";
    items = [string componentsSeparatedByString:delimiter];
    
    NSLog(@"%lu", (unsigned long)items.count);
    
    
     [self.tableData addObjectsFromArray:items];
   // self.tableData = @[@"One",@"Two",@"Three",@"Twenty-one"];
    self.searchResult = [NSMutableArray arrayWithCapacity:[items count]];
    self.yourTable.hidden = YES;
}



- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    //self.yourTable.hidden = NO;
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [items filteredArrayUsingPredicate:resultPredicate]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
   // self.yourTable.hidden = NO;
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResult count];
    }
    else
    {
        return [items count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
    }
    else
    {
        cell.textLabel.text = items[indexPath.row];
    }
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        visitedLabel.hidden = NO;
        destination.hidden = NO;
        andLabel.hidden = NO;
        dsriptionField.hidden = NO;
        
        destination.text = [items objectAtIndex:indexPath.row];
        destination.text = [[[tableView cellForRowAtIndexPath:indexPath] textLabel] text];
        [searchBar resignFirstResponder];
        tableView.hidden = YES;
        [self.searchBar setPlaceholder:@"Search for a country"];
        
    
        [searchBar resignFirstResponder];
        searchBar.text = @"";
       
    } else {
        // search results table view
            NSLog(@"ceva:%@", [items objectAtIndex:indexPath.row]);
    }
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (self.dsriptionField.text.length == 0){
        self.dsriptionField.text = @"describe your trip the best you can";
        
        [self.dsriptionField resignFirstResponder];
    }
    [self.dsriptionField resignFirstResponder];
}
/*
- (void) searchCoordinatesForAddress:(NSString *)inAddress
{
    //Build the string to Query Google Maps.
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@?output=json",inAddress];
    
    //Replace Spaces with a '+' character.
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    
    //Create NSURL string from a formate URL string.
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Setup and start an async download.
    //Note that we should test for reachability!.
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

//It's called when the results of [[NSURLConnection alloc] initWithRequest:request delegate:self] come back.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //The string received from google's servers
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //JSON Framework magic to obtain a dictionary from the jsonString.
    NSDictionary *results = [jsonString JSONValue];
    
    //Now we need to obtain our coordinates
    NSArray *placemark  = [results objectForKey:@"Placemark"];
    NSArray *coordinates = [[placemark objectAtIndex:0] valueForKeyPath:@"Point.coordinates"];
    
    //I put my coordinates in my array.
    double longitude = [[coordinates objectAtIndex:0] doubleValue];
    double latitude = [[coordinates objectAtIndex:1] doubleValue];
    
    //Debug.
    //NSLog(@"Latitude - Longitude: %f %f", latitude, longitude);
    
    //I zoom my map to the area in question.
    [self zoomMapAndCenterAtLatitude:latitude andLongitude:longitude];
    
    
}

- (void) zoomMapAndCenterAtLatitude:(double) latitude andLongitude:(double) longitude
{
    MKCoordinateRegion region;
    region.center.latitude  = latitude;
    region.center.longitude = longitude;
    
    //Set Zoom level using Span
    MKCoordinateSpan span;
    span.latitudeDelta  = .005;
    span.longitudeDelta = .005;
    region.span = span;
    
    //Move the map and zoom
    
    MKMapView *mapView;
    [mapView setRegion:region animated:YES];
}*/

- (IBAction)saveTripClicked:(id)sender {
    
    //[self searchCoordinatesForAddress:[searchBar text]];
    
    
    NSString *fullTextForTrip = [NSString stringWithFormat:@"I visited %@ and it was %@", destination.text, dsriptionField.text];
    // Convert to JPEG with 50% quality
    NSData* data = UIImageJPEGRepresentation(photoView.image, 0.5f);
    imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    // Save the image to Parse
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // The image has now been uploaded to Parse. Associate it with a new object
            PFObject* newPhotoObject = [PFObject objectWithClassName:@"PhotoObject"];
            [newPhotoObject setObject:imageFile forKey:@"image"];
            
            [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    NSLog(@"Saved");
                }
                else{
                    // Error
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
    }];
    PFObject *trip = [PFObject objectWithClassName:@"trip"];
    trip[@"username"] = usernameGlobal;
    trip[@"tripDetails"] = fullTextForTrip;
    trip[@"country"] = destination.text;
    trip[@"picture1"] = imageFile;
   
    [trip saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"saved");
           [self performSegueWithIdentifier:@"backFromAddTripToProfile" sender:self];

        } else {
            NSLog(@"error:%@", error.description);
        }
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.yourTable.hidden = YES;
    [self performSelector:@selector(getLocationFromAddressString:) withObject:destination.text];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (IBAction)goBackToProfile:(id)sender {
      [self performSegueWithIdentifier:@"backToProfile" sender:self];//backFromAddTripToProfile
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
   
    CALayer *shLayer = photoView.layer;
    shLayer.masksToBounds = NO;
    shLayer.shadowOffset = CGSizeMake(-1.0, 1.0);
    shLayer.shadowColor = [[UIColor grayColor] CGColor];
    shLayer.shadowRadius = 2.0f;
    shLayer.shadowOpacity = 0.80f;
    photoView.image = image;
    NSLog(@"picked");
    //[self dismissViewControllerAnimated:YES completion:NULL];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)takePhoto:(id)sender
{
    
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)loadPhoto:(id)sender
{
    
    picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker animated:YES completion:NULL];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        
        if (dsriptionField.text.length == 0)
        {
            dsriptionField.text = @"describe your trip the best you can";
            [dsriptionField resignFirstResponder];
        }
        
        return NO;
    }
    return YES ;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if (dsriptionField.text.length == 0)
    {
        dsriptionField.text = @"describe your trip the best you can";
        
        [dsriptionField resignFirstResponder];
    }
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"a inceput");
    if ([dsriptionField.text isEqualToString:@"describe your trip the best you can"])
    {
        
        dsriptionField.text = @"";
    }
    
    return YES;
}

- (void) alertStatus:(NSString *)msg : (NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message: msg
                                                       delegate: self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
    
   
}

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    NSString *esc_addr = [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}

@end
