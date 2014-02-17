//
//  SettingsViewController.m
//  jobfeed-iOS
//
//  Created by Шаматов Иван on 16.02.14.
//  Copyright (c) 2014 Ivan Shamatov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (strong, nonatomic) NSArray *sources;
@property (strong, nonatomic) NSArray *keywords;
@property (strong, nonatomic) NSUserDefaults *settings;
@property (strong, nonatomic) NSMutableArray *settingsSources;
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
    self.sources = @[@"Хантим",
                     @"HeadHunter",
                     @"ITmozg",
                     @"Mail.ru",
                     @"Яндекс работа",
                     @"Careers Stackoverflow",
                     @"We Work Remotely"];
    self.keywords = [self settingsKeywords];
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
