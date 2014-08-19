// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require local_time
//= require_tree .


/*
Copyright (c) 2012 Coding Stuff

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For more Check us out www.coding-stuff.com
*/
$(document).ready(function(){
			$('nav').navResponsive();
		});

(function($){
 
    $.fn.extend({
		
        navResponsive: function() {
 
            return this.each(function() {
				var nav = $(this);
		
				// s-collapse menu items
		
				nav.find('.nav-menu').find('li a').on('click',function(e){
					var ul = $(this).siblings('ul');
					if(ul.length){ e.preventDefault(); }
					if($(this).closest('nav').hasClass('s-collapse'))
					{
						ul.find('ul').hide();
						ul.find('a .s-collapse-trigger').removeClass('active').html('<i class="fa fa-plus-square fa-2x"></i>');
						if(ul.is(':hidden')){ $(this).find('.s-collapse-trigger').addClass('active').html('<i class="fa fa-minus-square fa-2x"></i>'); }
						else{ $(this).find('.s-collapse-trigger').removeClass('active').html('<i class="fa fa-plus-square fa-2x"></i>'); }
						ul.slideToggle(100);		
					}	
				});
				
				/* s-collapse entire menu */
				
				nav.find('.s-collapse-trigger').click(function(e){
					e.preventDefault();
					var nav = $(this).siblings('.nav-menu');
					if(nav.is(':hidden')){ $(this).addClass('active').html('<i class="fa fa-minus-square fa-2x"></i>'); }
					else{ $(this).removeClass('active').html('<i class="fa fa-plus-square fa-2x"></i>'); } 
					$(this).siblings('.nav-menu').slideToggle();
				});
				
				/* set s-collapse based on nav size */
				
				var defaultWidth = 0;
				nav.find('.nav-menu').each(function(){
					defaultWidth += $(this).outerWidth();
				});	
				if(nav.innerWidth() < defaultWidth + 150){
					nav.addClass('s-collapse'); 
					nav.find('.nav-menu').slideUp(500);
				}
				
				$(window).resize(function(){
					var el = nav.find('.nav-menu');
					if(nav.innerWidth() < defaultWidth + 150)
					{
						if(!nav.hasClass('s-collapse'))
						{
							nav.addClass('s-collapse', 300);
							el.find('ul').hide();
							el.hide();
							nav.find('.s-collapse-trigger').removeClass('active').html('<i class="fa fa-plus-square fa-2x"></i>');
						}	
					}
					else
					{
						if(nav.hasClass('s-collapse'))
						{
							nav.find('.s-collapse-trigger:last').addClass('active').html('<i class="fa fa-minus-square fa-2x"></i>');		
							nav.removeClass('s-collapse', 300);			
							el.find('ul').show();
							el.fadeIn();					
						}	
					}
				});
			
            });
        }
    });
     
})(jQuery);

