//
//  CategoryViewController.m
//  timbr
//
//  Created by Ankush Raina on 12/1/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "CategoryViewController.h"
#import "FieldViewController.h"
#import "FieldsTableViewCell.h"
#import "LogCollection.h"
#import "LogCategory.h"
#import "Entry.h"

@interface CategoryViewController () <UITableViewDataSource, FieldsTableViewCellDelegate, FieldViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTextBox;

@property (strong, nonatomic) NSMutableArray *fields;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fields = [[NSMutableArray alloc] init];
    [self.fieldsTableView registerNib:[UINib nibWithNibName:@"FieldsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FieldsTableViewCell"];
    
    self.fieldsTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    self.title = @"New Category";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonPress)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveButtonPress)];
    
    // to stop navigation controller from hiding my controls http://stackoverflow.com/a/18825253/566878
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // TODO on selection, deselect the table row.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fieldViewControllerFieldUpdated:(Field *)field {
    // TODO find if exists else append
    [self.fields addObject:field];
    [self.fieldsTableView reloadData];
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        NSLog(@"was called2");
    return self.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"was called");
    FieldsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldsTableViewCell"];
    
    cell.field = self.fields[indexPath.row];
    cell.delegate = self;
    
    return cell;
}


- (IBAction)onAddFieldButtonPress:(id)sender {
    FieldViewController *fvc = [[FieldViewController alloc] init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];

    [self.fieldsTableView reloadData];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - private methods
- (void)onCancelButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSaveButtonPress {
    LogCategory *logCategory = [[LogCategory alloc] init];
    
    logCategory.name = self.categoryNameTextBox.text;
    logCategory.schemaEntry = [[Entry alloc] init];
    logCategory.schemaEntry.fields = self.fields;
    logCategory.entries = [[NSMutableArray alloc] init];
    
    [[LogCollection sharedInstance].logCategories addObject:logCategory];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fieldsTableViewCellDeletePressed:(FieldsTableViewCell *)cell {
    [self.fields removeObject:cell.field];
    [self.fieldsTableView reloadData];
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
