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

@implementation ViewControllerLoggedIn

@synthesize tableViewTrips;

- (IBAction)addTrip:(id)sender {
      [self performSegueWithIdentifier:@"addTrip" sender:self];
}
- (IBAction)goToTrips:(id)sender {
    [self performSegueWithIdentifier:@"trips" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    if (indexPath.row %2 == 0) {
        cell.curvedImage.image = [UIImage imageNamed:@"dash1rev.png"];
         [cell.title setFrame:CGRectMake(cell.title.frame.origin.x, 10.0, cell.title.frame.size.width,cell.title.frame.size.width)];
    }else{
        cell.curvedImage.image = [UIImage imageNamed:@"dash1.png"];
      
    }
    
    cell.pinTrip.image = [UIImage imageNamed:@"pin.png"];
    cell.title.text = [NSString stringWithFormat:@"My trip%ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"details" sender:self];
    NSLog(@"selected:%ld", (long)indexPath.row);
    
}


@end
