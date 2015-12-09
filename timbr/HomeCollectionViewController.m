//
//  HomeCollectionViewController.m
//  collection-test
//
//  Created by Sean Kemper on 11/25/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "HomeCollectionViewController.h"
//#import "DetailsTableViewController.h"
#import "DetailsViewController.h"
#import "LogCollection.h"
#import "LogCategory.h"
#import "CategoryViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "EntryViewController.h"

@interface HomeCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation HomeCollectionViewController

- (IBAction)onAddLogCategoryPressed:(id)sender {
    // Launch new category.
    // On completion refresh log collection
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:categoryViewController];
    
    [self presentViewController:nvc animated:YES completion:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.dataArray = [[NSArray alloc] initWithObjects:[LogCollection sharedInstance].logCategories, nil];
    UINib *cellNib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"homeCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(110, 110)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.barTintColor = [self colorFromHexString:@"FF86FF"];
//    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    LogCategory *logCategory = [data objectAtIndex:indexPath.row];
    
    NSString *cellData = logCategory.name;
    
    static NSString *cellIdentifier = @"homeCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    [titleLabel setText:cellData];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:10];
    imageView.image = logCategory.image;
    
    cell.layer.borderColor = [[self colorFromHexString:@"#DEDEDE"] CGColor];
    cell.layer.borderWidth = 1;
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    
    UIButton *plus = (UIButton *)[cell viewWithTag:15];
    plus.layer.borderColor = [[self colorFromHexString:@"#DEDEDE"] CGColor];
    plus.layer.borderWidth = 1;
    plus.layer.cornerRadius = 5;
    plus.layer.masksToBounds = YES;
    [plus addTarget:self action:@selector(myClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (IBAction)myClickEvent:(id)sender {
    
    UICollectionViewCell *cell = (UICollectionViewCell*)[[sender superview] superview];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    if (indexPath == nil) {
        assert(false);
        return;
    }
    else {
        NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
        LogCategory *logCategory = [data objectAtIndex:indexPath.row];
        EntryViewController *entryViewController = [[EntryViewController alloc] init];
        entryViewController.logCategory = logCategory;
        //[self presentViewController:entryViewController animated:YES completion:nil];
        [self.navigationController pushViewController:entryViewController animated:YES];
    }
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.dataArray count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    LogCategory *logCategory = [data objectAtIndex:indexPath.row];

    // DetailsTableViewController *detailsTableViewController = [[DetailsTableViewController alloc] init];
    DetailsViewController *detailsTableViewController = [[DetailsViewController alloc] init];
    
    detailsTableViewController.logCategory = logCategory;
    
    // TODO detailsTableViewController.logCategory = figure out from sender
    [self.navigationController pushViewController:detailsTableViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
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
