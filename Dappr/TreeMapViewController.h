//
//  TreeMapViewController.h
//  Dappr
//
//  Created by Mayank Jain on 4/17/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeMapViewCell.h"
#import "TreemapView.h"
#import <Parse/Parse.h>

@interface TreeMapViewController : UIViewController<TreemapViewCellDelegate, TreemapViewDataSource, TreemapViewDelegate>
@property (strong, nonatomic) IBOutlet TreemapView *treeMapView;

@property (strong, nonatomic) NSMutableArray * array;

@end
