//
//  EntryViewController.m
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "EntryViewController.h"
#import "FieldDataTableViewCell.h"
#import "HomeCollectionViewController.h"
#import "DetailsViewController.h"

@interface EntryViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Entry *workingEntry;

@end

@implementation EntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.entry == nil) {
        self.workingEntry = [self.logCategory.schemaEntry copyWithZone:nil];
    } else {
        self.workingEntry = [self.entry copyWithZone:nil];
    }
    
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
    return self.workingEntry.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FieldDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldDataTableViewCell"];
    
    cell.field = self.workingEntry.fields[indexPath.row];
    
    return cell;
}

#pragma mark - private methods
- (void)onCancelButtonPress {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onSaveButtonPress {
    if (self.entry == nil) {
        [self.logCategory.entries addObject:self.workingEntry];
    } else {
        NSInteger index = [self.logCategory.entries indexOfObject:self.entry];
        [self.logCategory.entries replaceObjectAtIndex:index withObject:self.workingEntry];
    }

    //[self dismissViewControllerAnimated:YES completion:nil];
    UIViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if (vc.class == HomeCollectionViewController.class) {
        DetailsViewController *dvc = [[DetailsViewController alloc] init];
        
        dvc.logCategory = self.logCategory;
        
        [self.navigationController pushViewController:dvc animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
