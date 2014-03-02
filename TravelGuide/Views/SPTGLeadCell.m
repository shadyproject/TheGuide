//
//  SPTGLeadCell.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "SPTGLeadCell.h"

@interface SPTGLeadCell ()

@property (nonatomic, weak) IBOutlet UITextView *textView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bgImage;

@end

@implementation SPTGLeadCell

+(NSString*)cellReuseId{
    return @"SPTGLeadCell";
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    self.title = nil;
    self.bodyText = nil;
    self.backgroundImage = nil;
}

-(void)setTitle:(NSString *)title{
    _title = [title copy];
    
    self.titleLabel.text = title;
}

-(void)setBodyText:(NSAttributedString *)bodyText{
    _bodyText = bodyText;
    
    self.textView.attributedText = self.bodyText;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    
    self.bgImage.image = self.backgroundImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
