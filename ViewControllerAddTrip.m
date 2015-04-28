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

- (IBAction)saveTripClicked:(id)sender {
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
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (IBAction)goBackToProfile:(id)sender {
      [self performSegueWithIdentifier:@"backToProfile" sender:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
   
    
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

@end
