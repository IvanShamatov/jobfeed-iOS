//
//  TableViewController.m
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 13.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"
#import "Job.h"
#import "JobCell.h"
#import <AFNetworking/AFNetworking.h>


@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray *jobs;
@end

@implementation TableViewController
- (IBAction)refreshTable:(id)sender {
    [self getJobs];
}


-(NSMutableArray *)jobs {
    if (!_jobs) {
        _jobs = [[NSMutableArray alloc] init];
    }
    return _jobs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getJobs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.jobs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"JobCell";
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[JobCell alloc] initWithStyle:UITableViewCellStyleDefault
                              reuseIdentifier:CellIdentifier];
    }
    Job *vacancy = self.jobs[indexPath.row];
    cell.textLabel.text = vacancy.title;
    cell.authorLabel.text = vacancy.source;
    return cell;
}

-(void) updateTable {
    [self.tableView reloadData];
}

-(void) getJobs
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://127.0.0.1:3000/jobs/ruby" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (int i = 0; i < [responseObject count]; i++) {
            Job *vacancy = [[Job alloc] init];
            vacancy.title = [responseObject[i] valueForKey:@"title"];
            vacancy.link = [responseObject[i] valueForKey:@"url"];
            vacancy.source = [responseObject[i] valueForKey:@"author"];
            
            [self.jobs addObject:vacancy];
            vacancy = nil;
        }
        [self updateTable];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GetJob"]) {
        WebViewController *dest = segue.destinationViewController;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        Job *vacancy = self.jobs[path.row];
        dest.job = vacancy;
    }
}



@end
