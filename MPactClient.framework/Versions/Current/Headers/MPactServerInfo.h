//
//  MPactServerInfo.h
//  MPactClient
//
//  Copyright (c) 2012 Motorola Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class holds the network information relevant to the MPact server.
 
 Refer to MPactClient
 */

@interface MPactServerInfo : NSObject

/** IP address of the MPact Server
 */
@property NSString* host;
/** Port number of the MPact Server
 */
@property short port;
/** Login user name that will gain access to the MPact Server
 */
@property NSString* loginID;
/** Login password to the MPact Server
 */
@property NSString* password;
/** Whether or not to use HTTPS to secure the communications to the MPact Server.
 
 @discussion Note that loginID and password will not be encrypted if this property is set to FALSE.
 */
@property BOOL useHTTPS;
/** Whether or not authentication will be performed on the server's certificate.
 
 @discussion This value should be set to TRUE when the product is released because
 setting this property to FALSE will make this app vulnerable to a Man-In-The-Middle attack.
 It is sometimes useful to set this value to FALSE during development so that
 a self-signed certificate can be used by the server until an official certificate
 can be requested from CA.
 */
@property BOOL authenticate;

/** Set this property to TRUE to use custom settings for the proxy server.
 */
@property BOOL overrideSystemProxy;
/** The IP address or name of the proxy server.
 @discussion Set this property to nil in order to disable the use of a proxy server.  This property only takes effect if overrideSystemProxy is set to TRUE.
 */
@property NSString* proxyServerAddress;
/** The port number of the proxy server.
 @discussion This property only takes effect if overrideSystemProxy is set to TRUE.
 */
@property short proxyServerPort;

/** Convenience method for creating an MPactServerInfo object.
 
 @param host IP address of the MPact Server
 @param port Port number of the MPact Server
 @return An MPactServerInfo object initialized with the input host and port
 */
-(id) initWithNetwork: (NSString *)host AndPort: (unsigned short)port;

@end

