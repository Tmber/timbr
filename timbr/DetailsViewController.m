//
//  DetailsViewController.m
//  timbr
//
//  Created by Ankush Raina on 12/8/15.
//  Copyright © 2015 Tmber. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsTableViewCell.h"
#import "PNChart.h"
#import "ChartTableViewCell.h"
#import "Entry.h"
#import "Field.h"
#import "EntryViewController.h"
#import "UIViewController+BackButtonHandler.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addEntry;

@end

@implementation DetailsViewController

- (IBAction)onAddEntryButtonPressed:(id)sender {
    [self onAddEntryButtonPress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"DetailsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ChartTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChartTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    // A little trick for removing the cell separators
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.allowsSelection = YES;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (self.logCategory.entries.count > 0) {
        self.navigationController.hidesBarsOnSwipe = YES;
    }
    
    self.title = self.logCategory.name;
    
    self.navigationItem.leftBarButtonItem.tintColor = [self colorFromHexString:@"#8334DE"];
    self.navigationItem.rightBarButtonItem.tintColor = [self colorFromHexString:@"#8334DE"];
    
//    [self.addEntry setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:131.0 / 255.0 green:52.0 / 255.0 blue:222.0 / 255.0 alpha:1.00f]] forState:UIControlStateNormal];
//    [self.addEntry setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:104.0 / 255.0 green:41.0 / 255.0 blue:177.0 / 255.0 alpha:1.00f]] forState:UIControlStateHighlighted];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(onEditCategoryButtonPress)];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }

}

-(BOOL) navigationShouldPopOnBackButton
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    return NO;
}


-(void) overrideBack{
    
    UIButton *transparentButton = [[UIButton alloc] init];
    [transparentButton setFrame:CGRectMake(0,0, 120, 60)];
    [transparentButton setBackgroundColor:[UIColor clearColor]];
    [transparentButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:transparentButton];
}

-(void)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) onEditCategoryButtonPress {
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    categoryViewController.logCategory = self.logCategory;
    categoryViewController.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
    
    [self presentViewController:nvc animated:YES completion:nil];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"ic_event_note_48pt"];
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [NSString stringWithFormat: @"Add some entries to your %@ log!", self.logCategory.name];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Make a lumbr jack happy";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -self.tableView.tableHeaderView.frame.size.height/2.0f;
}


- (void)onAddEntryButtonPress {
    [self createUpdateEntry:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0) {
        [self createUpdateEntry:[self.logCategory.entries objectAtIndex:(indexPath.section - 1)]];
    }
}

-(void)createUpdateEntry:(Entry *)entry {
    EntryViewController *entryViewController = [[EntryViewController alloc] init];
    entryViewController.logCategory = self.logCategory;
    entryViewController.entry = entry;
    [self.navigationController pushViewController:entryViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)categoryViewControllerLogCategoryUpdated:(LogCategory *)logCategory {
    self.logCategory = logCategory;
    self.title = self.logCategory.name;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.logCategory.entries.count > 0){
        if (section == 0) {
            return 1;
        }
        else {
            Entry *tree = [self.logCategory.entries objectAtIndex:(section - 1)];
            return tree.fields.count;
        }
    }
    else {
        return 0;
    }
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ChartTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"ChartTableViewCell"];
        cell.logCategory = self.logCategory;
        return cell;
    }
    else {
        DetailsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"DetailsTableViewCell"];
        if (self.logCategory.entries.count > 0) {
            Entry *tree = [self.logCategory.entries objectAtIndex:(indexPath.section - 1)];
            Field *field = [tree.fields objectAtIndex:indexPath.row];
            cell.nameLabel.text = field.name;
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            [formatter setMaximumFractionDigits:2];
            [formatter setMinimumFractionDigits:2];
//            cell.valueLabel.text = [formatter stringFromNumber:field.numberValue];
            cell.valueLabel.text = field.getFormattedValue;
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.logCategory.entries.count > 0) {
        return self.logCategory.entries.count + 1;
    }
    else {
        return 0;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (Field *field in self.logCategory.schemaEntry.fields) {
            [names addObject:field.name];
        }
        
        // http://stackoverflow.com/a/7654733/566878
//        return [names componentsJoinedByString: @", "];
        return nil;
    }
    else {
        return [NSString stringWithFormat:@"Entry %ld", (long)section];
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 800;
    }
    else {
        return self.tableView.estimatedRowHeight;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    if (section == 0)
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    else {
        [headerView setBackgroundColor:[self colorFromHexString:@"#F5F5F5"]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, tableView.bounds.size.width - 10, 20)];
        label.text = [NSString stringWithFormat:@"Entry %ld", (long)section];
        label.textColor = [self colorFromHexString:@"#999999"];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        [headerView addSubview:label];
        return headerView;
    }
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
