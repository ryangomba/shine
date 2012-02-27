/*!
 * @function Singleton GCD Macro
 */
#ifndef SINGLETON
#define SINGLETON(classname) \
\
+ (classname *)shared { \
\
static dispatch_once_t pred; \
__strong static classname * shared = nil; \
dispatch_once( &pred, ^{ \
shared = [[self alloc] init]; }); \
return shared; \
}                                                           
#endif