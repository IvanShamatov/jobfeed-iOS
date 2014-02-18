//
//  SettingsViewController.m
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 16.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSMutableArray *sources;
@property (strong, nonatomic) NSMutableArray *keywords;
@property (strong, nonatomic) NSUserDefaults *settings;
@property (strong, nonatomic) NSMutableArray *settingsSources;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SettingsViewController

#define KEYWORDS_SECTION 0
#define SOURCES_SECTION 1
#define KEYWORDS_KEY @"keywords"
#define SOURCES_KEY @"sources"


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settings = [NSUserDefaults standardUserDefaults];
    self.sources = [NSMutableArray arrayWithObjects:@"Хантим",
                     @"HeadHunter",
                     @"ITmozg",
                     @"Mail.ru",
                     @"Яндекс работа",
                     @"Careers Stackoverflow",
                     @"We Work Remotely", nil];
    self.keywords = [NSMutableArray arrayWithObjects:@"ruby",
                     @"python",
                     @"mongo", nil];
                    //[self settingsKeywords];
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
        return self.sources.count;
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
        NSString *label = self.sources[indexPath.row];
        cell.textLabel.text = label;
        if ([self.settingsSources containsObject:label]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
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
            [self saveSources:cell.textLabel.text withValue:NO];
        }else {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [self saveSources:cell.textLabel.text withValue:YES];
        }
    }
}


# pragma mark - Custom methods

- (NSUserDefaults *) settings {
    return [NSUserDefaults standardUserDefaults];
}

- (NSMutableArray *) settingsSources {
    if (!_settingsSources) {
        _settingsSources = [[NSMutableArray alloc] init];
        [_settingsSources addObjectsFromArray:[self.settings objectForKey:@"sources"]];
    }
    return _settingsSources;
}

- (NSArray *) settingsKeywords {
    return [[self settings] arrayForKey:KEYWORDS_KEY];
}



- (void) saveSources: (NSString *)key withValue:(BOOL) value
{
    if (value) {
        [self.settingsSources addObject:key];
    } else {
        [self.settingsSources removeObject:key];
    }
    [self.settings setObject:self.settingsSources forKey:@"sources"];
    [self.settings synchronize];
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

#define SAVING_SETTINGS_SEGUE @"SavingSettings"
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:SAVING_SETTINGS_SEGUE]) {
        // SAVE SETTINGS
    }
}



@end
