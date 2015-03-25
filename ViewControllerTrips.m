//
//  ViewControllerTrips.m
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewControllerTrips.h"
#import "CollectionViewCustomCell.h"

@implementation ViewControllerTrips
- (IBAction)backToMyProfile:(id)sender {
    [self performSegueWithIdentifier:@"backToProfile" sender:self];
}

-(void)viewDidLoad
{
    tripsArray = [NSArray arrayWithObjects:@"pin.png",@"pin2.png", @"dash1.png", @"dash2.png", nil];
    NSLog(@"%lu", (unsigned long)tripsArray.count);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return tripsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CollCell";
    
    CollectionViewCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.cellImage.image = [UIImage imageNamed:[tripsArray objectAtIndex:indexPath.row]];
    
    return cell;
}

@end
