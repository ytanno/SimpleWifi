//
//  ViewController.m
//  IOSWifiSender
//
//  Created by tanno on 2015/11/21.
//  Copyright © 2015年 tanno. All rights reserved.
//

//ref http://stackoverflow.com/questions/13047661/sending-udp-packets-in-ios-6

#import "ViewController.h"

#include <CFNetwork/CFNetwork.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@interface ViewController ()

@end

@implementation ViewController

int sock = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.LedLabel.text = @"Start LED";
    
    if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1)
    {
        NSLog(@"Failed to create socket, error=%s", strerror(errno));
        self.LedLabel.text = @"Failed to Create Socket";
    }

}
static void SendMessage(NSString *msg )
{
    unsigned int echolen;
    struct sockaddr_in destination;
    memset(&destination, 0, sizeof(struct sockaddr_in));
    destination.sin_len = sizeof(struct sockaddr_in);
    destination.sin_family = AF_INET;
    
    NSString *ip = @"192.168.11.2";
    destination.sin_addr.s_addr = inet_addr([ip UTF8String]);
    destination.sin_port = htons(33033); //port
    
    /* server port */
    setsockopt(sock, IPPROTO_IP, IP_MULTICAST_IF, &destination, sizeof(destination));
    const char *cmsg = [msg UTF8String];
    echolen = strlen(cmsg);
    if (sendto(sock, cmsg,echolen,0, (struct sockaddr *) &destination, sizeof(destination)) == -1)
    {
        NSLog(@"did not send, error=%s",strerror(errno));
    }
    else
    {
        NSLog(@"did send");
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChangeSC:(UISegmentedControl *)sender
{
    NSString *state = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.LedLabel.text = state;
    
    
    if([state isEqualToString:@"ON"])
    {
        SendMessage(@"1");
    }
    
    if([state isEqualToString:@"OFF"])
    {
        SendMessage(@"0");
    }

}
@end
