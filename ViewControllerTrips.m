//
//  ViewControllerTrips.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerTrips.h"
#import "CollectionViewCustomCell.h"
#import "ViewController.h"
#import "ViewControllerLoggedIn.h"
#import <Parse/Parse.h>

@implementation ViewControllerTrips{
    NSMutableArray *objectsAll;
    NSString *idForSelectedCell;
}
- (IBAction)backToMyProfile:(id)sender {
   [self performSegueWithIdentifier:@"backFromTripsToProfile" sender:self];
}

-(void)viewDidLoad
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"trip"];
    objects= [query findObjects];
    
    NSLog(@"obj:%@", objects);
    
   
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return objects.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CollCell";
    
    CollectionViewCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    PFFile *imageFile = [[objects objectAtIndex:indexPath.row] valueForKey:@"picture1"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.cellImage.image = [UIImage imageWithData:data];}
    }];

    cell.cellLabel.text = [NSString stringWithFormat:@"%@\nby %@",[[objects objectAtIndex:indexPath.row] valueForKey:@"country"],[[objects objectAtIndex:indexPath.row] valueForKey:@"username"] ];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
    idForSelectedCell = [[objects objectAtIndex:indexPath.row] valueForKey:@"objectId"];
    NSLog(@"id:%@", idForSelectedCell);
    
    [self performSegueWithIdentifier:@"detailsOthers" sender:self];
    
}
@end
