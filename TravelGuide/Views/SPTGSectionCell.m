//
//  SPTGSectionCell.m
//  TravelGuide
//
//  Created by Christopher Martin on 3/1/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import "SPTGSectionCell.h"

@interface SPTGSectionCell ()

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation SPTGSectionCell

-(void)prepareForReuse{
    self.sectionText = nil;
}

-(void)setSectionText:(NSAttributedString *)sectionText{
    _sectionText = sectionText;
    
    self.textView.attributedText = self.sectionText;
}

@end
