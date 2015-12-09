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
#import "IconPickerViewController.h"

@interface CategoryViewController () <UITableViewDataSource, FieldsTableViewCellDelegate, FieldViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IconPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTextBox;

@property (strong, nonatomic) LogCategory *workingLogCategory;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.logCategory == nil) {
        self.workingLogCategory = [[LogCategory alloc] init];
        self.title = @"New Category";
    } else {
        self.workingLogCategory = [self.logCategory copyWithZone:nil];
        self.categoryNameTextBox.text = self.workingLogCategory.name;
        self.title = @"Edit Category";
    }

    [self.fieldsTableView registerNib:[UINib nibWithNibName:@"FieldsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FieldsTableViewCell"];
    
    self.fieldsTableView.dataSource = self;

    self.fieldsTableView.allowsMultipleSelectionDuringEditing = NO;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(onCancelButtonPress)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(onSaveButtonPress)];
    
    // to stop navigation controller from hiding my controls http://stackoverflow.com/a/18825253/566878
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // TODO on selection, deselect the table row.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Field* field = self.workingLogCategory.schemaEntry.fields[indexPath.row];
        
        [self deleteField:field];
    }
}

#pragma mark - Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.workingLogCategory.schemaEntry.fields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FieldsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldsTableViewCell"];
    
    cell.field = self.workingLogCategory.schemaEntry.fields[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

- (IBAction)onSetImageButtonPress:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* choosePhoto = [UIAlertAction
                                  actionWithTitle:@"Choose from photo library"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      [self presentImagePicker];
                                      
                                  }];
    UIAlertAction* chooseIcon = [UIAlertAction
                                  actionWithTitle:@"Choose default icons"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      IconPickerViewController *ipvc = [[IconPickerViewController alloc] init];
                                      UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ipvc];
                                      ipvc.delegate = self;
//                                      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:nil action:nil];
                                      [self presentViewController:nvc animated:YES completion:nil];
//                                      [self.navigationController pushViewController:ipvc animated:YES];
                                      
                                  }];
    [view addAction:choosePhoto];
    [view addAction:chooseIcon];
    [view addAction: [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:view animated:YES completion:nil];
}

- (void)presentImagePicker {
    NSLog(@"camera clicked");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    UIImage *originalInfo = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.workingLogCategory.image = editedImage;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)iconsPickedImage:(IconPickerViewController *)iconPickerViewController image:(UIImage *)image name:(NSString *)name {
    NSLog(@"%@ %@", name, image);
//    [self.navigationController popToViewController:self animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.workingLogCategory.image = image;
}

#pragma mark - private methods
- (void)onCancelButtonPress {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSaveButtonPress {
    self.workingLogCategory.name = self.categoryNameTextBox.text;
    
    if (self.logCategory == nil) {
        [[LogCollection sharedInstance].logCategories addObject:self.workingLogCategory];
    } else {
        NSUInteger index = [[LogCollection sharedInstance].logCategories indexOfObject:self.logCategory];
        [[LogCollection sharedInstance].logCategories replaceObjectAtIndex:index withObject:self.workingLogCategory];
    }
    
    [self.delegate categoryViewControllerLogCategoryUpdated:self.workingLogCategory];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onAddFieldButtonPress:(id)sender {
    FieldViewController *fvc = [[FieldViewController alloc] init];
    fvc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    
    [self.fieldsTableView reloadData]; // Does this do anything?
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)fieldViewControllerFieldUpdated:(Field *)field {
    [self addField:field];
}

- (void)fieldsTableViewCellDeletePressed:(FieldsTableViewCell *)cell {
    [self deleteField:cell.field];
}

-(void)addField:(Field *)field {
    [self.workingLogCategory.schemaEntry.fields addObject:field];
    
    for (Entry *entry in self.workingLogCategory.entries) {
        [entry.fields addObject:[field copyWithZone:nil]];
    }
    
    [self.fieldsTableView reloadData];
}

-(void)deleteField:(Field *)fieldToRemove {
    [self.workingLogCategory.schemaEntry.fields removeObject:fieldToRemove];
    for (Entry *entry in self.workingLogCategory.entries) {
        Field *toRemove = nil;
        for (Field *field in entry.fields) {
            if (field.name == fieldToRemove.name) {
                toRemove = field;
            }
        }
        [entry.fields removeObject:toRemove];
    }
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
