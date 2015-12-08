//
//  HomeCollectionViewController.m
//  collection-test
//
//  Created by Sean Kemper on 11/25/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "DetailsTableViewController.h"
#import "LogCollection.h"
#import "LogCategory.h"
#import "CategoryViewController.h"

@interface HomeCollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
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
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataArray = [[NSArray alloc] initWithObjects:[LogCollection sharedInstance].logCategories, nil];
    UINib *cellNib = [UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"homeCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(125, 125)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
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
    
    return cell;
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

    DetailsTableViewController *detailsTableViewController = [[DetailsTableViewController alloc] init];
    
    detailsTableViewController.logCategory = logCategory;
    
    // TODO detailsTableViewController.logCategory = figure out from sender
    [self.navigationController pushViewController:detailsTableViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
