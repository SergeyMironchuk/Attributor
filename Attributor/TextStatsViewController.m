//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Admin on 20.10.15.
//  Copyright (c) 2015 Stanford. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

-(void)setTextToAnalyze:(NSAttributedString *)textToAnalyze
{
    _textToAnalyze = textToAnalyze;
    if(self.view.window) [self updateUI];
}

-(void)updateUI
{
    self.colorfulCharactersLabel.text =
    [NSString stringWithFormat: @"%lu colorful caracters",
     (unsigned long)[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    
    self.outlinedCharactersLabel.text =
    [NSString stringWithFormat: @"%lu outlined caracters",
     (unsigned long)[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test"
//                                                         attributes:@{
//                                                                      NSForegroundColorAttributeName: [UIColor greenColor],
//                                                                      NSStrokeWidthAttributeName: @-3}];
}

-(NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    NSInteger index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName
                                         atIndex:index
                                  effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    return characters;
}

@end
