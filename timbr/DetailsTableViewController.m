//
//  DetailsTableViewController.m
//  timbr
//
//  Created by Chris Guzman on 11/21/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "DetailsTableViewCell.h"
#import "PNChart.h"
#import "ChartTableViewCell.h"
#import "LogCategory.h"
#import "Entry.h"
#import "Field.h"
@interface DetailsTableViewController ()
@property NSArray *data;
@property LogCategory *log;
@end

@implementation DetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChartTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChartTableViewCell"];
    
    LogCategory *mockLog = [LogCategory getMockLog];
    self.log = mockLog;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.title = self.log.name;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else {
        Entry *tree = [self.log.entries objectAtIndex:(section - 1)];
        return tree.fields.count;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self.tableView dequeueReusableCellWithIdentifier:@"ChartTableViewCell"];
    }
    else {
        DetailsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailsTableViewCell"];
        Entry *tree = [self.log.entries objectAtIndex:(indexPath.section - 1)];
        Field *field = [tree.fields objectAtIndex:indexPath.row];
        cell.nameLabel.text = field.name;
        cell.valueLabel.text = [NSString stringWithFormat:@"%@", field.numberValue];
        return cell;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.log.entries.count + 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Gas Price, Miles over Time";
    }
    else {
        return [NSString stringWithFormat:@"Entry #%ld", (long)section];
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 300;
    }
    else {
        return self.tableView.estimatedRowHeight;
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
