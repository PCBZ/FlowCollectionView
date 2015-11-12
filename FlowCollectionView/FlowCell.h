//
//  FlowCell.h
//  FlowCollectionView
//
//  Created by Wenshuang Zhou on 15/11/11.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlowCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign, getter=isCardFront) BOOL cardFront;

- (void)setCellToFrontStyleAtIndexPath:(NSIndexPath *)indexPath;
- (void)setCellToBackStyleAtIndexPath:(NSIndexPath *)indexPath;

@end
