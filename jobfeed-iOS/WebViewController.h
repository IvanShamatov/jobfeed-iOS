//
//  WebViewController.h
//  
//
//  Created by Шаматов Иван on 13.02.14.
//
//

#import <UIKit/UIKit.h>
#import "Job.h"

@interface WebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) Job *job;
@end
