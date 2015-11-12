//
//  FlowViewController.m
//  FlowCollectionView
//
//  Created by Wenshuang Zhou on 15/11/11.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "FlowViewController.h"
#import "FlowCell.h"
#import "FlowLayout.h"

@interface FlowViewController ()

@end

@implementation FlowViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[FlowCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
    FlowLayout *flowLayout = [[FlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(200, 300);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(120, 100, 120, 100);
    flowLayout.minimumInteritemSpacing = 80;
    flowLayout.minimumLineSpacing = 80;
    self.collectionView.collectionViewLayout = flowLayout;
    
    // init the cell attributes;
    self.flowCellAttributes = [NSMutableArray arrayWithObjects:@(YES), @(YES), @(YES), @(YES), @(YES), nil];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.flowCellAttributes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.cardFront = [self.flowCellAttributes[indexPath.item] boolValue];
    if (cell.isCardFront) {
        [cell setCellToFrontStyleAtIndexPath:indexPath];
    } else {
        [cell setCellToBackStyleAtIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FlowCell *selectedCell = (FlowCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView transitionWithView:selectedCell
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        if (selectedCell.isCardFront) {
                            [selectedCell setCellToBackStyleAtIndexPath:indexPath];
                            self.flowCellAttributes[indexPath.item] = @(NO);
                        } else {
                            [selectedCell setCellToFrontStyleAtIndexPath:indexPath];
                            self.flowCellAttributes[indexPath.item] = @(YES);
                        }
                    } completion:NULL];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
 Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
