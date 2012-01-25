# AS3 Banner Ad

A method to avoid pop-up block on click with ActionScript 3 ads and sites.
Send comments, questions and suggestions to [@hpeikemo](http://twitter.com/hpeikemo) or hpeikemo@me.com.



## Example usage (Document class):

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
    
