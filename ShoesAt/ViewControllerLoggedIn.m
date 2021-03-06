//
//  ViewControllerLoggedIn.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerLoggedIn.h"
#import "ViewControllerLogOut.h"
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
@synthesize greatView;

-(void)viewWillAppear:(BOOL)animated{
    
    
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
}


- (IBAction)goToTrips:(id)sender {
    [self performSegueWithIdentifier:@"trips" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PFQuery *query = [PFQuery queryWithClassName:@"trip"];
    
    [query whereKey:@"username" equalTo:usernameGlobal];
 
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
        cell.curvedImage.image = [UIImage imageNamed:@"linie-punctata-1.png"];
        // [cell.title setFrame:CGRectMake(cell.title.frame.origin.x, 10.0, cell.title.frame.size.width,cell.title.frame.size.width)];
        cell.pinTrip.image = [UIImage imageNamed:@"pin.png"];
        
        cell.title.text = [NSString stringWithFormat:@"My trip to %@", [[objects objectAtIndex:indexPath.row] valueForKey:@"country"]];
        
        PFFile *imageFile = [[objects objectAtIndex:indexPath.row] objectForKey:@"picture1"];
        
       
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                //cell.photoFromTrip2.image = [UIImage imageWithData:data];
            cell.photoFromTrip2.image = [self image:[UIImage imageWithData:data] scaledToSize:CGSizeMake(50, 50)];
            }
        }];
        CALayer *shLayer = cell.photoFromTrip2.layer;
        shLayer.masksToBounds = NO;
        shLayer.shadowOffset = CGSizeMake(-1.0, 1.0);
        shLayer.shadowColor = [[UIColor grayColor] CGColor];
        shLayer.shadowRadius = 2.0f;
        shLayer.shadowOpacity = 0.80f;

        NSLog(@"sizePh:%f, %f", cell.photoFromTrip2.image.size.height, cell.photoFromTrip2.image.size.width);
        
    }else if (indexPath.row %2 == 1 && indexPath.row < objects.count) {
         //[cell.title2 setFrame:CGRectMake(cell.title.frame.origin.x, 10.0, cell.title.frame.size.width,cell.title.frame.size.width)];
        cell.curvedImage.image = [UIImage imageNamed:@"linie-punctata-2.png"];
        cell.pinTrip.image = [UIImage imageNamed:@"pin.png"];
        cell.title2.text = [NSString stringWithFormat:@"My trip to %@", [[objects objectAtIndex:indexPath.row] valueForKey:@"country"]];
        PFFile *imageFile = [[objects objectAtIndex:indexPath.row] objectForKey:@"picture1"];
        
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
               // cell.photoFromTrip.image = [UIImage imageWithData:data];
            cell.photoFromTrip.image = [self image:[UIImage imageWithData:data] scaledToSize:CGSizeMake(50, 50)];
            }
        }];
        
        CALayer *shLayer = cell.photoFromTrip.layer;
        shLayer.masksToBounds = NO;
        shLayer.shadowOffset = CGSizeMake(-1.0, 1.0);
        shLayer.shadowColor = [[UIColor grayColor] CGColor];
        shLayer.shadowRadius = 2.0f;
        shLayer.shadowOpacity = 0.80f;
        NSLog(@"sizePh:%f, %f", cell.photoFromTrip.image.size.height, cell.photoFromTrip.image.size.width);
    }
    
    
    if(indexPath.row == ([objects count])){
        [cell.title setFrame:CGRectMake(cell.title.frame.origin.x, 10.0, cell.title.frame.size.width,cell.title.frame.size.width)];
        cell.title.center  = CGPointMake(cell.frame.size.width/2, 75.0);
        
        if (indexPath.row % 2 == 0) {
            cell.curvedImage.image = [UIImage imageNamed:@"linie-punctata-4.png"];
            [cell.curvedImage setFrame:CGRectMake(cell.curvedImage.frame.origin.x - 70.0, cell.curvedImage.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            cell.pinTrip.image = [UIImage imageNamed:@"qmark.png"];
            cell.title.text = @"Where to now?\nTap to add trip!";
           
        }else{
            cell.curvedImage.image = [UIImage imageNamed:@"linie-punctata-3.png"];
            [cell.curvedImage setFrame:CGRectMake(cell.curvedImage.frame.origin.x+ 20.0, cell.curvedImage.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            cell.pinTrip.image = [UIImage imageNamed:@"qmark.png"];
            cell.title.text = @"Where to now?\nTap to add trip!";
            
          
        }
    }
    
    if ([objects count] == 0) {
        cell.curvedImage.hidden = YES;
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


- (IBAction)goToAccount:(id)sender {
    [self performSegueWithIdentifier:@"logOut" sender:self];
}

- (UIImage *) image:(UIImage *)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContextWithOptions(newSize, NO, image.scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
