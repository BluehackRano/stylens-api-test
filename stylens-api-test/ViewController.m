//
//  ViewController.m
//  stylens-api-test
//
//  Created by 김대섭 on 2017. 12. 9..
//  Copyright © 2017년 김대섭. All rights reserved.
//

#import "ViewController.h"

#import <SwaggerClient/SWGObjectApi.h>

NSString *imageName;
BOOL imageNameToggle;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initAPIButtons];
}

-(void)initAPIButtons {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGFloat curY = 50;
    
    UIButton* aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(10, curY, screenBounds.size.width-20, 50);
    aButton.backgroundColor = [UIColor blackColor];
    aButton.layer.cornerRadius = 8.0;
    [aButton addTarget:self action:@selector(postObjectsWithImageFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    self.objectsWithImageButton = aButton;
    
    UILabel* aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0];
    aLabel.adjustsFontSizeToFitWidth = YES;
    aLabel.textColor = [UIColor whiteColor];
    aLabel.text = @"(POST) /objects";
    [aButton addSubview:aLabel];
    
    curY += aButton.frame.size.height + 25;
    
    aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.frame = CGRectMake(10, curY, screenBounds.size.width-20, 50);
    aButton.backgroundColor = [UIColor blackColor];
    aButton.layer.cornerRadius = 8.0;
    [aButton addTarget:self action:@selector(getObjectsByProductId) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aButton];
    self.objectsWithProductIdButton = aButton;
    
    aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aButton.frame.size.width, aButton.frame.size.height)];
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0];
    aLabel.adjustsFontSizeToFitWidth = YES;
    aLabel.textColor = [UIColor whiteColor];
    aLabel.text = @"(GET) /objects/products/{productId}";
    [aButton addSubview:aLabel];
    
    UIImageView *anImageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenBounds.size.width/2 - 50, screenBounds.size.height - 150, 100, 100)];
    anImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:anImageView];
    self.previewImage = anImageView;
}

#pragma mark - APIs
-(void)postObjectsWithImageFile {
    self.objectsWithImageButton.userInteractionEnabled = NO;
    self.objectsWithImageButton.backgroundColor = [UIColor lightGrayColor];
    
    imageNameToggle = !imageNameToggle;
    imageName = imageNameToggle ? @"sample01.jpg" : @"sample02.jpg";
    self.previewImage.image = [UIImage imageNamed:imageName];
    
    // Supoorting Files/Images/ 안에 있는
    // sample01.jpg 혹은 sample02.jpg 이미지를
    // 'captured.jpg' 라는 이름으로 NSDocumentDirectory 저장공간에 저장한다.
    UIImage *anImage = [UIImage imageNamed:imageName];
    NSData *imageData = UIImageJPEGRepresentation(anImage, 1.0);
    NSString *filePath = [self documentsPathForFileName:@"captured.jpg"];
    [imageData writeToFile:filePath atomically:YES];
    
    // 'captured.jpg'를 NSURL type으로 변환.
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    
    NSLog(@"(POST) /objects \n Please wait ...");
    SWGObjectApi *apiInstance = [[SWGObjectApi alloc] init];
    [apiInstance getObjectsByImageFileWithFile:url
                             completionHandler:^(SWGGetObjectsResponse* output, NSError* error) {
                                 self.objectsWithImageButton.userInteractionEnabled = YES;
                                 self.objectsWithImageButton.backgroundColor = [UIColor blackColor];
                                 
                                 if (output) {
                                     NSLog(@"%@", output);
                                     NSLog(@"");
                                 }
                                 if (error) {
                                     NSLog(@"Error: %@", error);
                                     NSLog(@"");
                                 }
                             }];
}

-(void)getObjectsByProductId {
    self.objectsWithProductIdButton.userInteractionEnabled = NO;
    self.objectsWithProductIdButton.backgroundColor = [UIColor lightGrayColor];
    self.previewImage.image = nil;
    
    // PRODUCT ID param
    NSString *aProductId = @"5a13a92a247c1a00017051c2";
    NSLog(@"(GET) /objects/products/{productId} \n PRODUCT ID : %@ \n Please wait ...", aProductId);
    
    SWGObjectApi *apiInstance = [[SWGObjectApi alloc] init];
    [apiInstance getObjectsByProductIdWithProductId:aProductId
                                  completionHandler: ^(SWGGetObjectsResponse* output, NSError* error) {
                                      self.objectsWithProductIdButton.userInteractionEnabled = YES;
                                      self.objectsWithProductIdButton.backgroundColor = [UIColor blackColor];
                                      
                                      if (output) {
                                          NSLog(@"%@", output);
                                          NSLog(@"");
                                      }
                                      if (error) {
                                          NSLog(@"Error: %@", error);
                                      }
                                  }];
}

#pragma mark - Instance methods
- (NSString *)documentsPathForFileName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:name];
}

@end
