//
//  ViewControllerLoggedIn.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerLoggedIn.h"
#import "ViewController.h"
#import "CustomCell.h"
#import <Parse/Parse.h>
#import <CoreData/CoreData.h>
#import <ParseUI/ParseUI.h>
#import "DetailsViewController.h"


@implementation ViewControllerLoggedIn{
    unsigned long total2;
    
}

@synthesize tableViewTrips;

-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (IBAction)addTrip:(id)sender {
     [self performSegueWithIdentifier:@"addTrip" sender:self];
}
- (IBAction)goToTrips:(id)sender {
    [self performSegueWithIdentifier:@"trips" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PFQuery *query = [PFQuery queryWithClassName:@"trip"];
    
    [query whereKey:@"username" equalTo:usernameGlobal];
    NSLog(@"user:%@", usernameGlobal);
    objects = [query findObjects];
 
    return objects.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    if (indexPath.row %2 == 0 && indexPath.row < objects.count) {
        cell.curvedImage.image = [UIImage imageNamed:@"dash1rev.png"];
         [cell.title setFrame:CGRectMake(cell.title.frame.origin.x, 10.0, cell.title.frame.size.width,cell.title.frame.size.width)];
        cell.pinTrip.image = [UIImage imageNamed:@"pin.png"];
        cell.title.text = [NSString stringWithFormat:@"My trip to %@", [[objects objectAtIndex:indexPath.row] valueForKey:@"country"]];
        
        PFFile *imageFile = [[objects objectAtIndex:indexPath.row] objectForKey:@"picture1"];
        
       
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.photoFromTrip.image = [UIImage imageWithData:data];}
        }];
        
    }else if (indexPath.row %2 == 1 && indexPath.row < objects.count) {
        cell.curvedImage.image = [UIImage imageNamed:@"dash1.png"];
        cell.pinTrip.image = [UIImage imageNamed:@"pin.png"];
        cell.title.text = [NSString stringWithFormat:@"My trip to %@", [[objects objectAtIndex:indexPath.row] valueForKey:@"country"]];
        PFFile *imageFile = [[objects objectAtIndex:indexPath.row] objectForKey:@"picture1"];
        
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.photoFromTrip.image = [UIImage imageWithData:data];}
        }];
    }
    
    
    if(indexPath.row == ([objects count])){
        if (indexPath.row % 2 == 0) {
            //cell.curvedImage.image = [UIImage imageNamed:@"dash1rev.png"];
            cell.pinTrip.image = [UIImage imageNamed:@"qmark.png"];
            cell.title.text = @"Where to now?";
        }else{
            //cell.curvedImage.image = [UIImage imageNamed:@"dash1.png"];
            cell.pinTrip.image = [UIImage imageNamed:@"qmark.png"];
            cell.title.text = @"Where to now?";
          
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [objects count]) {
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"details" sender:indexPath];
    NSLog(@"selected:%ld", (long)indexPath.row);
    selectedRow = (int) indexPath.row;
    }else{
         [self performSegueWithIdentifier:@"addTrip" sender:self];
    }
    
}


@end
