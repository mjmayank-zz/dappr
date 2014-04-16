//
//  AddOutfitTableViewController.h
//  Dappr
//
//  Created by Mayank Jain on 4/15/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddOutfitTableViewController : UITableViewController<UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) NSArray * searchResults;
@property (strong, nonatomic) NSMutableDictionary * tags;

@end
