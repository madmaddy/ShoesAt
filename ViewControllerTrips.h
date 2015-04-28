//
//  ViewControllerTrips.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 25/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import "ViewController.h"

@interface ViewControllerTrips : UIViewController< UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSMutableArray *tripsArray;
    NSMutableArray *countriesArray;
    NSMutableArray *usersArray;
}

@property (strong, nonatomic) IBOutlet UICollectionView *tripsCollectionView;
@end
