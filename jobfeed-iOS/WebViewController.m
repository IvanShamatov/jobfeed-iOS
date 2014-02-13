//
//  WebViewController.m
//  
//
//  Created by Шаматов Иван on 13.02.14.
//
//

#import "WebViewController.h"

@interface WebViewController ()

@end


@implementation WebViewController
@synthesize job;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.job = job;
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString: job.link]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
