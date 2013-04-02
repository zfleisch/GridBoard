//
//  GridView.m
//  GridBoard
//
//  Created by Zachary Fleischman on 4/1/13.
//  Copyright (c) 2013 Zachary Fleischman. All rights reserved.
//

#import "GridView.h"

@implementation GridView

- (void)awakeFromNib
{
    [self setup]; // get initialized when we come out of a storyboard
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup]; // get initialized if someone uses alloc/initWithFrame: to create us
    }
    return self;
}

-(void)setup {
    self.contentMode = UIViewContentModeRedraw;
    
}


- (void)drawRect:(CGRect)rect
{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    CGFloat vInterval = height / (float) self.rows;
    CGFloat hInterval = width / (float) self.columns;


    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Draw vertical lines:
    
    //seed the loop with the first point
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGPoint point = CGPointMake(hInterval, 0);
    CGContextMoveToPoint(context, point.x, point.y);
    
    //for each vertical line to draw, increment by correct distance and draow it
    for(CGFloat i = hInterval; i < width; i+=hInterval) {
        point = CGPointMake(i,height);
        CGContextAddLineToPoint(context, point.x, point.y);
        CGContextStrokePath(context);
        UIGraphicsPopContext();
        
        UIGraphicsPushContext(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, point.x + hInterval, 0);
        
    }
    UIGraphicsPopContext();
    
    //Draw horizontal lines:
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    point = CGPointMake(0, vInterval);
    CGContextMoveToPoint(context, point.x, point.y);
    
    //for each vertical line to draw, increment by correct distance and draow it
    for(CGFloat i = vInterval; i < height; i+=vInterval) {
        point = CGPointMake(width, i);
        CGContextAddLineToPoint(context, point.x, point.y);
        CGContextStrokePath(context);
        UIGraphicsPopContext();
        
        UIGraphicsPushContext(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, point.y + vInterval);
        
    }
    UIGraphicsPopContext();
    
    //Draw grid labels
    for(int x = 0; x < self.columns; x++) {
        for(int y = 0; y < self.rows; y++) {
            NSString *note = [self.dataSource stringForCellAtXValue:x YValue:y];
            CGFloat yPosition = height - (float) (y+1) * vInterval + vInterval/4;
            CGFloat exposition = (float) x * hInterval;
            CGRect rect = CGRectMake(exposition, yPosition, hInterval, vInterval);
            [note drawInRect:rect withFont:[UIFont systemFontOfSize:40] lineBreakMode:NSLineBreakByClipping alignment:NSTextAlignmentCenter];
        }
    }
}


@end