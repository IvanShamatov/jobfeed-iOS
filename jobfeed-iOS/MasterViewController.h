//
//  MasterViewController.h
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 05.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
