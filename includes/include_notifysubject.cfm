﻿<!---

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
<cfsilent>
<!---
	AVAILABLE
	-cartBean (bean)
	-transactionBean (bean)
	-paymentTypeBean (bean)
	-userBean (bean)
	-siteConfig (mura bean)
	-sProducts (struct)	

 --->
</cfsilent><cfoutput>Order ###transactionBean.getOrderIdent()# by #userBean.getFname()# #userBean.getLname()# <cfif len( userBean.getCompany() )>(#userBean.getCompany()#)</cfif> on #lsdateformat(cartBean.getDateLastUpdate(),"medium")# #lstimeformat(cartBean.getDateLastUpdate())#</cfoutput>
