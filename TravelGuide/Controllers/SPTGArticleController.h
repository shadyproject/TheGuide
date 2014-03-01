//
//  SPTGArticleController.h
//  TravelGuide
//
//  Created by Christopher Martin on 2/28/14.
//  Copyright (c) 2014 shadyproject. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@protocol SPTGArticleControllerDelegate

-(void)didFetchArticle:(NSAttributedString*)article forLocation:(CLLocation*)location;

@end

@interface SPTGArticleController : NSObject

@property (nonatomic, weak) id<SPTGArticleControllerDelegate> delegate;

@end
