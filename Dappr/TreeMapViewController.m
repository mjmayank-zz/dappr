//
//  TreeMapViewController.m
//  Dappr
//
//  Created by Mayank Jain on 4/17/14.
//  Copyright (c) 2014 Mayank Jain. All rights reserved.
//

#import "TreeMapViewController.h"

@interface TreeMapViewController ()

@end

@implementation TreeMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.treeMapView setDelegate:self];
    [self.treeMapView setDataSource:self];
    
    PFQuery * query = [PFQuery queryWithClassName:@"ClothingItem"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            // The find succeeded
            NSLog(@"Successfully retrieved %lu photos.", (unsigned long)objects.count);

            self.array = [objects mutableCopy];
            
            [self.treeMapView reloadData];
            
//            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//            dispatch_async(queue, ^{
//                
////                for(PFObject * obj in objects){
////                    
//////                    NSDictionary * dict = @{@"name": obj[@"name"], @"value": obj[@""]};
////                    
////                    [self.array addObject:dict];
////                }
//                
//                self.array = objects;
////                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    //                    [self.collectionView reloadData];
//                    
//                });
//            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -

- (void)updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index {
	NSNumber *val = [[NSNumber alloc] initWithInt: [[[self.array objectAtIndex:index] valueForKey:@"price"] intValue]/[[[self.array objectAtIndex:index] valueForKey:@"timesWorn"] intValue] ];
	cell.textLabel.text = [[self.array objectAtIndex:index] valueForKey:@"title"];
	cell.valueLabel.text = [val stringValue];
    
    PFFile *theImage = [self.array objectAtIndex:index][@"clothingImage"];
    NSData *imageData = [theImage getData];
    UIImage * data = [UIImage imageWithData:imageData];
    
    UIImageView * imageview = [[UIImageView alloc] initWithImage:data];
    imageview.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    [cell addSubview:imageview];
    
    cell.backgroundColor = [UIColor colorWithHue:(float)index / (self.array.count + 3) saturation:1 brightness:0.75 alpha:1];
}

#pragma mark TreemapView data source

- (NSArray *)valuesForTreemapView:(TreemapView *)treemapView {
    
    
    
//	if (!fruits) {
//		NSBundle *bundle = [NSBundle mainBundle];
//		NSString *plistPath = [bundle pathForResource:@"data" ofType:@"plist"];
//		NSArray *array = [[NSArray alloc] initWithContentsOfFile:plistPath];
//        
//		self.fruits = [[NSMutableArray alloc] initWithCapacity:array.count];
//		for (NSDictionary *dic in array) {
//			NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//			[fruits addObject:mDic];
//		}
//	}
//
//	NSMutableArray *values = [NSMutableArray arrayWithCapacity:fruits.count];
//	for (NSDictionary *dic in fruits) {
//		[values addObject:[dic valueForKey:@"value"]];
//	}
    
    
    
//	return values;
//    self.array = [@[@{@"name": @"test", @"value":@1}, @{@"name": @"test2", @"value":@2}, @{@"name": @"test3", @"value":@3}, @{@"name": @"test1", @"value":@1}] mutableCopy];
    
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.array.count];
	for (PFObject *dic in self.array) {
		[values addObject:[dic valueForKey:@"timesWorn"]];
	}
	return values;
}

- (TreemapViewCell *)treemapView:(TreemapView *)treemapView cellForIndex:(NSInteger)index forRect:(CGRect)rect {
	TreemapViewCell *cell = [[TreemapViewCell alloc] initWithFrame:rect];
	[self updateCell:cell forIndex:index];
	return cell;
}

- (void)treemapView:(TreemapView *)treemapView updateCell:(TreemapViewCell *)cell forIndex:(NSInteger)index forRect:(CGRect)rect {
	[self updateCell:cell forIndex:index];
}

@end
