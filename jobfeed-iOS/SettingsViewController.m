//
//  SettingsViewController.m
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 16.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableDictionary *sources;
@property (strong, nonatomic) NSMutableArray *keywords;
@property (strong, nonatomic) NSUserDefaults *settings;
@property (strong, nonatomic) NSArray *sourcesForTable;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SettingsViewController

static int const KEYWORDS_SECTION = 0;
static int const SOURCES_SECTION = 1;
static NSString * const KEYWORDS_KEY = @"keywords";
static NSString * const SOURCES_KEY = @"sources";


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settings = [NSUserDefaults standardUserDefaults];
    self.keywords = [[self.settings objectForKey:KEYWORDS_KEY] mutableCopy];
    self.sources = [[self.settings objectForKey:SOURCES_KEY] mutableCopy];
    self.sourcesForTable = [self.sources allKeys];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == KEYWORDS_SECTION) {
        return self.keywords.count;
    } else if (section == SOURCES_SECTION) {
        return self.sourcesForTable.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == KEYWORDS_SECTION) {
        return @"Ключевые слова";
    } else if (section == SOURCES_SECTION) {
        return @"Источники";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == KEYWORDS_SECTION) {
        static NSString *CellIdentifier = @"Keywords";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = self.keywords[indexPath.row];
    } else if (indexPath.section == SOURCES_SECTION) {
        static NSString *CellIdentifier = @"Sources";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSString *label = self.sourcesForTable[indexPath.row];
        cell.textLabel.text = label;
        if ([[self.sources objectForKey:label] isEqualToString:@"ON"]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    return cell;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == SOURCES_SECTION) {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [self.sources setValue:@"OFF" forKey:cell.textLabel.text];
        }else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self.sources setValue:@"ON" forKey:cell.textLabel.text];
        }
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == KEYWORDS_SECTION) {
        return YES;
    }
    return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.keywords removeObject:cell.textLabel.text];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    NSString *new_keyword = searchBar.text;
    searchBar.text = @"";
    [self.keywords addObject:new_keyword];
    [self.tableView reloadData];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.settings setObject:[self.keywords copy] forKey:KEYWORDS_KEY];
    [self.settings setObject:[self.sources copy] forKey:SOURCES_KEY];
    [self.settings synchronize];
}



@end
