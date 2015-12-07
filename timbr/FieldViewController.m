//
//  FieldViewController.m
//  timbr
//
//  Created by Ankush Raina on 12/2/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "FieldViewController.h"

@interface FieldViewController ()
@property (weak, nonatomic) IBOutlet UITextField *fieldNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegmentedControl;
@property (strong, nonatomic) Field *field;

@end

@implementation FieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO pass field. If present it's edit else it's new
    // Do any additional setup after loading the view from its nib.
    self.title = @"New Field";
    self.field = [[Field alloc] init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonPress)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onSaveButtonPress)];
    
    // to stop navigation controller from hiding my controls http://stackoverflow.com/a/18825253/566878
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)onCancelButtonPress {
    NSLog(@"Field Cancel button pressed");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onSaveButtonPress {
    self.field.name = self.fieldNameTextField.text;
    switch (self.typeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.field.dataType = FieldTypeNumber;
            break;
        case 1:
            self.field.dataType = FieldTypeDecimal;
            break;
        case 2:
            self.field.dataType = FieldTypeCurrency;
            break;
            
        default:
            break;
    }

    [self.delegate fieldViewControllerFieldUpdated:self.field];
    [self dismissViewControllerAnimated:YES completion:nil];
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
