//
//  ViewControllerAddTrip.h
//  ShoesAt
//
//  Created by Bogdan Tudor on 11/03/15.
//  Copyright (c) 2015 Bogdan Tudor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerAddTrip : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *yourTable;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSMutableArray *searchResult;
@end
