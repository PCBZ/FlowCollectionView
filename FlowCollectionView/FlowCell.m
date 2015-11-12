//
//  FlowCell.m
//  FlowCollectionView
//
//  Created by Wenshuang Zhou on 15/11/11.
//  Copyright © 2015年 PCBZ. All rights reserved.
//

#import "FlowCell.h"

@implementation FlowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:32];
        
        self.cardFront = YES;
        
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_label];
    }
    return _label;
}

- (void)setCellToFrontStyleAtIndexPath:(NSIndexPath *)indexPath
{
    self.label.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.cardFront = YES;
}

- (void)setCellToBackStyleAtIndexPath:(NSIndexPath *)indexPath
{
    self.label.text = [NSString stringWithFormat:@"%ld in back", indexPath.item];
    self.contentView.backgroundColor = UIColor.whiteColor;
    self.cardFront = NO;
}


@end
