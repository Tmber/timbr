//
//  EntryViewController.m
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "EntryViewController.h"
#import "FieldDataTableViewCell.h"

@interface EntryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"FieldDataTableViewCell" bundle:nil] forCellReuseIdentifier:@"FieldDataTableViewCell"];
    
    self.tableView.dataSource = self;
    self.title = self.logCategory.name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonPress)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveButtonPress)];
    
    // to stop navigation controller from hiding my controls http://stackoverflow.com/a/18825253/566878
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logCategory.schemaEntry.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FieldDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldDataTableViewCell"];
    
    cell.field = self.logCategory.schemaEntry.fields[indexPath.row];
    
    return cell;
}

#pragma mark - private methods
- (void)onCancelButtonPress {
    NSLog(@"Cancel button pressed");
}

- (void)onSaveButtonPress {
    NSLog(@"Save button pressed");
    // TODO Save name
    // TODO Save fields
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
