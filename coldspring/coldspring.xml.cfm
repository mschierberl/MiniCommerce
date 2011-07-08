<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">

<beans default-autowire="byName">
	<!-- Mura -->
	<bean id="MuraDisplayObjectManager" class="[plugin]com.meldsolutions.mura.muraDisplayObjectManager">
	</bean>
	
	<bean id="MuraEventHandlerManager" class="[plugin]com.meldsolutions.mura.MuraEventHandlerManager">
	</bean>
	
	<bean id="MuraManager" class="[plugin]com.meldsolutions.mura.MuraManager">
	</bean>

	<!-- Utility -->
	<bean id="mmErrorManager" class="[plugin]com.meldsolutions.utility.mmError.mmErrorManager">
	</bean>

	<bean id="mmBreadCrumbs" class="[plugin]com.meldsolutions.utility.mmBreadCrumbs.mmBreadCrumbs">
	</bean>

	<bean id="mmFormTools" class="[plugin]com.meldsolutions.utility.mmFormTools.mmFormTools">
	</bean>

	<bean id="generalUtility" class="[plugin]com.meldsolutions.utility.utility.generalUtility">
	</bean>

	<bean id="mmResourceBundle" class="[plugin]com.meldsolutions.utility.mmResourceBundle.mmResourceBundle">
		<constructor-arg name="applicationKey"><value>${applicationKey}</value></constructor-arg>
		<constructor-arg name="pluginFileRoot"><value>${pluginFileRoot}</value></constructor-arg>
		<constructor-arg name="rblocale"><value>${rblocale}</value></constructor-arg>
	</bean>

	<bean id="MeldInterceptManager" class="[plugin]com.meldsolutions.utility.mmIntercepts.MeldInterceptManager">
	</bean>
	
	<!-- remote -->
 	<bean id="MeldMiniCommerceRemote" class="[plugin]com.meldsolutions.meldminicommerce.remote.MeldMiniCommerceRemote" />
	<bean id="MeldMiniCommerceRemoteAOP" class="coldspring.aop.framework.RemoteFactoryBean" lazy-init="false">
		<property name="target">
			<ref bean="MeldMiniCommerceRemote" />
		</property>
		<property name="serviceName">
			<value>MeldMiniCommerceRemoteAOP</value>
		</property>
		<property name="relativePath">
			<value>|plugin|com/meldsolutions/meldminicommerce/remote</value>
		</property>
		<property name="remoteMethodNames">
			<value>getTransactionList,getPaymentTypeList,getMerchantList</value>
		</property>
		<property name="beanFactoryName">
			<value>MeldMiniCommerceBeanFactory</value>
		</property>
	</bean>

	<!-- application -->
	
	<!-- Meld -->
	<bean id="meldminicommerceManager" class="[plugin]com.meldsolutions.meldminicommerce.application.meldminicommerceManager">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>

	<bean id="meldminicommerceEventManager" class="[plugin]com.meldsolutions.meldminicommerce.application.meldminicommerceEventManager">
	</bean>

	<bean id="meldminicommerceProductManager" class="[plugin]com.meldsolutions.meldminicommerce.application.meldminicommerceProductManager">
	</bean>

	<bean id="meldminicommerceProcessorManager" class="[plugin]com.meldsolutions.meldminicommerce.application.meldminicommerceProcessorManager">
	</bean>

	<bean id="productBean" class="[plugin]com.meldsolutions.meldminicommerce.core.product.productBean"  singleton="false" />
	
	<bean id="CartDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.cart.CartDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="CartGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.cart.CartGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
		<constructor-arg name="expirehours"><value>${expirehours}</value></constructor-arg>
		<constructor-arg name="expiredays"><value>${expiredays}</value></constructor-arg>
	</bean>
	<bean id="CartService" class="[plugin]com.meldsolutions.meldminicommerce.core.cart.CartService">
		<constructor-arg name="CartDAO">
			<ref bean="CartDAO"/>
		</constructor-arg>
		<constructor-arg name="CartGateway">
			<ref bean="CartGateway"/>
		</constructor-arg>
		<constructor-arg name="mmErrorManager">
			<ref bean="mmErrorManager"/>
		</constructor-arg>
	</bean>
	
	<bean id="CartproductDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.cartproduct.CartproductDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="CartproductGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.cartproduct.CartproductGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="CartproductService" class="[plugin]com.meldsolutions.meldminicommerce.core.cartproduct.CartproductService">
		<constructor-arg name="CartproductDAO">
			<ref bean="CartproductDAO"/>
		</constructor-arg>
		<constructor-arg name="CartproductGateway">
			<ref bean="CartproductGateway"/>
		</constructor-arg>
	</bean>
	
	<bean id="DisplaytypeDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.displaytype.DisplaytypeDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplaytypeGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.displaytype.DisplaytypeGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="DisplaytypeService" class="[plugin]com.meldsolutions.meldminicommerce.core.displaytype.DisplaytypeService">
		<constructor-arg name="DisplaytypeDAO">
			<ref bean="DisplaytypeDAO"/>
		</constructor-arg>
		<constructor-arg name="DisplaytypeGateway">
			<ref bean="DisplaytypeGateway"/>
		</constructor-arg>
	</bean>
	
	<bean id="TransactionDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.transaction.TransactionDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="TransactionGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.transaction.TransactionGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="TransactionService" class="[plugin]com.meldsolutions.meldminicommerce.core.transaction.TransactionService">
		<constructor-arg name="TransactionDAO">
			<ref bean="TransactionDAO"/>
		</constructor-arg>
		<constructor-arg name="TransactionGateway">
			<ref bean="TransactionGateway"/>
		</constructor-arg>
	</bean>

	
	<bean id="MerchantDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.merchant.MerchantDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="MerchantGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.merchant.MerchantGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="MerchantService" class="[plugin]com.meldsolutions.meldminicommerce.core.merchant.MerchantService">
		<constructor-arg name="MerchantDAO">
			<ref bean="MerchantDAO"/>
		</constructor-arg>
		<constructor-arg name="MerchantGateway">
			<ref bean="MerchantGateway"/>
		</constructor-arg>
	</bean>
	
	<bean id="PaymenttypeDAO" class="[plugin]com.meldsolutions.meldminicommerce.core.paymenttype.PaymenttypeDAO">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="PaymenttypeGateway" class="[plugin]com.meldsolutions.meldminicommerce.core.paymenttype.PaymenttypeGateway">
		<constructor-arg name="dsn"><value>${dsn}</value></constructor-arg>
		<constructor-arg name="dsnusername"><value>${dsnusername}</value></constructor-arg>
		<constructor-arg name="dsnpassword"><value>${dsnpassword}</value></constructor-arg>
		<constructor-arg name="dsnprefix"><value>${dsnprefix}</value></constructor-arg>
		<constructor-arg name="dsntype"><value>${dsntype}</value></constructor-arg>
	</bean>
	<bean id="PaymenttypeService" class="[plugin]com.meldsolutions.meldminicommerce.core.paymenttype.PaymenttypeService">
		<constructor-arg name="PaymenttypeDAO">
			<ref bean="PaymenttypeDAO"/>
		</constructor-arg>
		<constructor-arg name="PaymenttypeGateway">
			<ref bean="PaymenttypeGateway"/>
		</constructor-arg>
	</bean>
</beans>