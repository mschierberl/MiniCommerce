/*
<!---

This file is part of the Meld MiniCommerce application.

Meld MiniCommerce is licensed under the GPL 2.0 license
Copyright (C) 2010 Meld Solutions Inc. http://www.meldsolutions.com/

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation, version 2 of that license..

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

--->
*/
function purchasevalidate( frm,terms ) {
	$terms = jQuery('#'+terms);

	if ($terms && !$terms.is(":checked") ) {
		alert( $terms.attr('message') );
		return false;
	}
	
	if (validate(frm)) {
		jQuery('##purchase_submit').attr('disabled', true);
		jQuery('##purchase_submit').css('background-color', '##ccc');
		return true;
	}
	else {
		return false;
	}
}

jQuery(document).ready(function() {

	jQuery('#purchaseterms').change( function() {
		jQuery('#purchaseterms_default').val( jQuery(this).val() );
	});

	jQuery('#paymenttype').change( function() {
		doHideShowCC();
	});

	doHideShowCC = function(){
		var isCC = $('#paymenttype option:selected').attr('data-iscc');
		
		if (!isCC || isCC == 'true') {
			jQuery('.meld-cc-info').each(function(){
				doShow(this);
			});
			jQuery('.meld-snail-info').each(function(){
				doHide(this);
			});
		}
		else {
			jQuery('.meld-cc-info').each(function(){
				doHide(this);
			});
			jQuery('.meld-snail-info').each(function(){
				doShow(this);
			});
		}
	};

	doShow = function( target ) {
		var $target = $(target);
		$target.show();
		$(":input",$target).attr('data-required','true');
	};
	doHide = function( target ) {
		var $target = $(target);
		$target.hide();
		$(":input",$target).attr('data-required','false');
	};
	
	doHideShowCC();

});
