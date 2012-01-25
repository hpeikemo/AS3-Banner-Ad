/*
Send comments, questions and suggestions to twitter.com/hpeikemo or hpeikemo@me.com.
Example usage (Document class):

package {
   import utils.BannerNavigator;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class Banner extends MovieClip {
      
      public var clickTAG:String;
      public var simpleButtonInstance:SimpleButton;
      
      public function Banner() {         
         clickTAG = root.loaderInfo.parameters["clickTAG"] || "http://clickTAG.missing";
         
         BannerNavigator.init(); //Ideally call init before any BannerNavigator.navigateToUrl calls.
         simpleButtonInstance.addEventListener(MouseEvent.CLICK,clickHandler); //The clickArea should always be a Button symbol. 
      }
      
      //The click-event-handler.
      private function clickHandler(event:MouseEvent):void {   
         BannerNavigator.navigateToUrl(clickTAG,"_blank"); //This method takes the url as a string, URLRequest object is created internally. 
      }
      
   }
}

*/

package utils {
   
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.external.ExternalInterface;
      
	public class BannerNavigator {

      public static var eiEnabled:Boolean;
      public static var isInitialized:Boolean;
      
      public static function init():void {
         if (isInitialized) { return; }
         isInitialized = true;
         if (ExternalInterface.available) {               
            try {
               var userAgent:String = ExternalInterface.call('function() {return navigator.userAgent;}').toLowerCase();
               eiEnabled = true;               
               
               //EI Enabled for all browsers but IE versions 6 and less.                                    
               if (userAgent.indexOf('msie') > -1) {
                  var ieVersion:uint = uint(userAgent.substr((userAgent.indexOf('msie'))+5, 3));
                  eiEnabled = (ieVersion >= 7);
               }                  				                                                      
            } catch (e:Error) {}
                        
         }         
      }
      
	   	   
		public static function navigateToUrl(url:String, window:String):void {
		   if (!isInitialized) { init(); }		   
		   if (eiEnabled) {
		      ExternalInterface.call('window.open', url, window);
		   } else {
		      navigateToURL(new URLRequest(url), window);
		   }
	   }
	   		   				
		
	}
}