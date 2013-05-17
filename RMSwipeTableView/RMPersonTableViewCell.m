//
//  RMPersonTableViewCell.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMPersonTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RMPersonTableViewCell () {
}

@end

@implementation RMPersonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:16];
        self.textLabel.backgroundColor = self.contentView.backgroundColor;
		self.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14];
        self.detailTextLabel.backgroundColor = self.contentView.backgroundColor;
        
		self.profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 54, 54)];
		[self.profileImageView setBackgroundColor:[UIColor whiteColor]];
		[self.profileImageView setClipsToBounds:YES];
		[self.profileImageView setContentMode:UIViewContentModeScaleAspectFill];
		[self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
		[self.profileImageView.layer setBorderWidth:1];
        [self.profileImageView.layer setCornerRadius:2];
        [self.contentView addSubview:self.profileImageView];
    }
    return self;
}

-(UIImageView*)checkmarkGreyImageView {
    if (!_checkmarkGreyImageView) {
        _checkmarkGreyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [_checkmarkGreyImageView setImage:[UIImage imageNamed:@"CheckmarkGrey"]];
        [_checkmarkGreyImageView setContentMode:UIViewContentModeCenter];
        [self.backView addSubview:_checkmarkGreyImageView];
    }
    return _checkmarkGreyImageView;
}

-(UIImageView*)checkmarkGreenImageView {
    if (!_checkmarkGreenImageView) {
        _checkmarkGreenImageView = [[UIImageView alloc] initWithFrame:self.checkmarkGreyImageView.bounds];
        [_checkmarkGreenImageView setImage:[UIImage imageNamed:@"CheckmarkGreen"]];
        [_checkmarkGreenImageView setContentMode:UIViewContentModeCenter];
        [self.checkmarkGreyImageView addSubview:_checkmarkGreenImageView];
    }
    return _checkmarkGreenImageView;
}

-(UIImageView*)checkmarkProfileImageView {
    if (!_checkmarkProfileImageView) {
        _checkmarkProfileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CheckmarkProfileImage"]];
        [_checkmarkProfileImageView setFrame:CGRectMake(CGRectGetMaxX(self.profileImageView.frame) - 10 - CGRectGetWidth(_checkmarkProfileImageView.frame), CGRectGetMaxY(self.profileImageView.frame) - 10 - CGRectGetHeight(_checkmarkProfileImageView.frame), CGRectGetWidth(_checkmarkProfileImageView.frame), CGRectGetHeight(_checkmarkProfileImageView.frame))];
    }
    return _checkmarkGreenImageView;
}

-(UIImageView*)deleteGreyImageView {
    if (!_deleteGreyImageView) {
        _deleteGreyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [_deleteGreyImageView setImage:[UIImage imageNamed:@"DeleteGrey"]];
        [_deleteGreyImageView setContentMode:UIViewContentModeCenter];
        [self.backView addSubview:_deleteGreyImageView];
    }
    return _deleteGreyImageView;
}

-(UIImageView*)deleteRedImageView {
    if (!_deleteRedImageView) {
        _deleteRedImageView = [[UIImageView alloc] initWithFrame:self.deleteGreyImageView.bounds];
        [_deleteRedImageView setImage:[UIImage imageNamed:@"DeleteRed"]];
        [_deleteRedImageView setContentMode:UIViewContentModeCenter];
        [self.deleteGreyImageView addSubview:_deleteRedImageView];
    }
    return _deleteRedImageView;
}

-(void)prepareForReuse {
	[super prepareForReuse];
	self.textLabel.textColor = [UIColor blackColor];
	self.detailTextLabel.text = nil;
	self.detailTextLabel.textColor = [UIColor grayColor];
	[self setUserInteractionEnabled:YES];
	self.imageView.alpha = 1;
	self.accessoryView = nil;
	self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView setHidden:NO];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.textLabel.frame), CGRectGetWidth(self.textLabel.frame), CGRectGetHeight(self.textLabel.frame));
    self.detailTextLabel.frame = CGRectMake(CGRectGetMaxX(self.profileImageView.frame) + 10, CGRectGetMinY(self.detailTextLabel.frame), CGRectGetWidth(self.detailTextLabel.frame), CGRectGetHeight(self.detailTextLabel.frame));
}

-(void)setThumbnail:(UIImage*)image {
	[self.profileImageView setImage:image];
}

-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated {
    self.isFavourite = favourite;
    if (animated) {
        if (favourite) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
            animation.fromValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.25;
            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor];
            [self.checkmarkProfileImageView setAlpha:0];
            [self.profileImageView addSubview:_checkmarkProfileImageView];
            [UIView animateWithDuration:0.25
                             animations:^{
                                 [self.checkmarkProfileImageView setAlpha:1];
                             }];
        } else {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.fromValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.25;
            [self.profileImageView.layer addAnimation:animation forKey:@"animateBorderColor"];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
            [UIView animateWithDuration:0.25
                             animations:^{
                                 [self.checkmarkProfileImageView setAlpha:0];
                             }
                             completion:^(BOOL finished) {
                                 [_checkmarkProfileImageView removeFromSuperview];
                             }];
        }
    } else {
        if (favourite) {
            [self.checkmarkProfileImageView setAlpha:1];
            [self.profileImageView addSubview:_checkmarkProfileImageView];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor];
        } else {
            [self.checkmarkProfileImageView setAlpha:0];
            [self.checkmarkProfileImageView removeFromSuperview];
            [self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
        }
    }
}

-(void)animateContentViewForPoint:(CGPoint)translation {
    [super animateContentViewForPoint:translation];
    if (translation.x > 0) {
        [self.checkmarkGreyImageView setFrame:CGRectMake(MIN(CGRectGetMinX(self.contentView.frame) - CGRectGetWidth(self.checkmarkGreyImageView.frame), 0), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
        if (self.contentView.frame.origin.x > CGRectGetWidth(self.checkmarkGreyImageView.frame) && self.isFavourite == NO) {
            [self.checkmarkGreenImageView setAlpha:1];
        } else if (self.isFavourite == NO) {
            [self.checkmarkGreenImageView setAlpha:0];
        } else if (self.contentView.frame.origin.x > CGRectGetWidth(self.checkmarkGreyImageView.frame) && self.isFavourite == YES) {
            if (self.checkmarkGreyImageView.alpha == 1) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     CATransform3D rotate = CATransform3DMakeRotation(-0.4, 0, 0, 1);
                                     [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, -10, 20, 0)];
                                     [self.checkmarkGreenImageView setAlpha:0];
                                 }];
            }
        } else if (self.isFavourite == YES) {
            CATransform3D rotate = CATransform3DMakeRotation(0, 0, 0, 1);
            [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, 0, 0, 0)];
            [self.checkmarkGreenImageView setAlpha:1];
        }
    } else if (translation.x < 0) {
        NSLog(@"%f", CGRectGetMaxX(self.contentView.frame) - CGRectGetWidth(self.deleteGreyImageView.frame));
        NSLog(@"%f", MIN(CGRectGetMaxX(self.contentView.frame) - CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetMaxX(self.contentView.frame)));
        [self.deleteGreyImageView setFrame:CGRectMake(MAX(CGRectGetMaxX(self.contentView.frame), CGRectGetMaxX(self.contentView.frame) - CGRectGetWidth(self.deleteGreyImageView.frame)), CGRectGetMinY(self.deleteGreyImageView.frame), CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetHeight(self.deleteGreyImageView.frame))];
    }
}

-(void)resetCellFromPoint:(CGPoint)translation {
    [super resetCellFromPoint:translation];
    if (translation.x > 0 && translation.x < CGRectGetHeight(self.frame) * 1.5) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.checkmarkGreyImageView setFrame:CGRectMake(-CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
                         }];
    }
}

-(void)cleanup {
    [super cleanup];
    [self.checkmarkGreyImageView removeFromSuperview];
    _checkmarkGreyImageView = nil;
    [self.checkmarkGreenImageView removeFromSuperview];
    _checkmarkGreenImageView = nil;
}

@end
