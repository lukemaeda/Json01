//
//  ViewController.m
//  Json
//
//  Created by MAEDA HAJIME on 2014/05/09.
//  Copyright (c) 2014年 HAJIME MAEDA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

// 読込ローカル
- (IBAction)proc01:(id)sender {
    
    // データの取得
    NSBundle *bnd01 = [NSBundle mainBundle];
    NSString *pth01 = [bnd01 pathForResource:@"Test01"
                                      ofType:@"json"];
    NSURL *url01 = [NSURL fileURLWithPath:pth01];
    
    NSURLRequest *req01 = [NSURLRequest requestWithURL:url01];
    
    NSData *dat01 = [NSURLConnection sendSynchronousRequest:req01
                                          returningResponse:nil
                                                      error:nil];
    
    // JSONオブジェクトの取得
    NSDictionary *cor01 =(NSDictionary *)
    [NSJSONSerialization JSONObjectWithData:dat01
                                    options:NSJSONReadingMutableContainers // 基本的にはこれを選ぶ
                                      error:nil];
    
    for (NSDictionary *cor02 in cor01[@"menu"]) {
        NSLog(@"%@, %@, %@",
              cor02[@"name"],
              cor02[@"price"],
              cor02[@"kcal"]);
    }
}


// 読込ネット
- (IBAction)proc02:(id)sender {
    // データの取得（ネット）
	NSString *str01 =
    @"http://api.quizken.jp/api/quiz-index/api_key/ma7/";
    //	NSString *str01 =
    //		@"http://api.quizken.jp/api/quiz-index/api_key/ma7/"
    //		@"genre_name/entertainment/count/1";
	NSURL *url01 = [NSURL URLWithString:str01];
	
	NSURLRequest *req01 = [NSURLRequest requestWithURL:url01];
    NSError *err = nil;
    
	NSData *dat01 = [NSURLConnection sendSynchronousRequest:req01
										  returningResponse:nil
													  error:&err]; // &err:アドレス
    if (err) {
        NSLog(@"%@", err.description);
        return; // 中断さす
    }
	
	// JSONオブジェクトの取得
	NSArray *cor01 = (NSArray *)
    [NSJSONSerialization JSONObjectWithData:dat01
                                    options:NSJSONReadingMutableContainers
                                      error:nil];
	
	// 表示
	for (int i = 0; i < [cor01 count]; i++) {
		
		NSDictionary *cor02 = cor01[i];
		
		NSLog(@"問題%d：%@", i + 1, cor02[@"question"]);
		
		NSArray *cor03 = cor02[@"answers"];
		for (int i = 0; i < [cor03 count]; i++) {
			
			if (i == 0) {
				NSLog(@"　正　解：%@", cor03[i]);
			} else {
				NSLog(@"　不正解：%@", cor03[i]);
			}
		}
	}
}

@end
