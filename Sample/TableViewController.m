//
//  TableViewController.m
//  Sample
//
//  Created by vignesh on 9/1/16.
//  Copyright © 2016 vignesh. All rights reserved.
//

#import "TableViewController.h"
#import "FirstViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    NSArray *lbl;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Recipe Book";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
   
    
    
    FirstViewController *value1 = [FirstViewController new];
    value1.name = @"creativeView";
    value1.detail = @"http://myTrackingURL/wrapper/creativeView";
    
    FirstViewController *value2 = [FirstViewController new];
    value2.name = @"start";
    value2.detail = @"http://myTrackingURL/wrapper/start";
    
    
    FirstViewController *value3 = [FirstViewController new];
    value3.name = @"midpoint";
    value3.detail = @"http://myTrackingURL/wrapper/midpoint";
    
    
    FirstViewController *value4 = [FirstViewController new];
    value4.name = @"firstQuartile";
    value4.detail = @"http://myTrackingURL/wrapper/firstQuartile";
    
    
    FirstViewController *value5 = [FirstViewController new];
    value5.name = @"thirdQuartile";
    value5.detail = @"http://myTrackingURL/wrapper/thirdQuartile";
    
    FirstViewController *value6 = [FirstViewController new];
    value6.name = @"complete";
    value6.detail = @"http://myTrackingURL/wrapper/complete";
    
    FirstViewController *value7 = [FirstViewController new];
    value7.name = @"mute";
    value7.detail = @"http://myTrackingURL/wrapper/mute";
    
    FirstViewController *value8 = [FirstViewController new];
    value8.name = @"unmute";
    value8.detail = @"http://myTrackingURL/wrapper/unmute";
    
    FirstViewController *value9 = [FirstViewController new];
    value9.name = @"pause";
    value9.detail = @"http://myTrackingURL/wrapper/pause";
    
    FirstViewController *value10 = [FirstViewController new];
    value10.name = @"resume";
    value10.detail = @"http://myTrackingURL/wrapper/resume";
    
    FirstViewController *value11 = [FirstViewController new];
    value11.name = @"fullscreen";
    value11.detail = @"http://myTrackingURL/wrapper/fullscreen";
    
    lbl = [NSArray arrayWithObjects:value1, value2, value3, value4, value5,value6, value7, value8, value9, value10,value11, nil];
        

    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return lbl.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
   
     FirstViewController *value = [lbl objectAtIndex:indexPath.row];
    
    UILabel *nameLbl = (UILabel *)[cell viewWithTag:101];
    nameLbl.text = value.name;
    
    UILabel *detailLbl = (UILabel *)[cell viewWithTag:102];
    detailLbl.text = value.detail;
    
    
    
    return cell;
}

@end
