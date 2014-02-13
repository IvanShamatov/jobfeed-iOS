//
//  DetailViewController.h
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 05.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
