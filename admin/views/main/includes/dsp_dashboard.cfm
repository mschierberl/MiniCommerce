<cfoutput>
	<div class="cols2">
		<div class="col">
			<table>
				<tr>
					<th colspan="2">
						#rc.mmRBF.key('dailycartstats')#
					</th>
				</tr>
				<tr>
					<td class="varWidth">
						#rc.mmRBF.key('activecarts')#
					</td>
					<td>
						#rc.stats.activeCarts#
					</td>
				</tr>
				<tr class="alt">
					<td class="varWidth">
						#rc.mmRBF.key('closedcarts')#
					</td>
					<td>
						#rc.stats.closedCarts#
					</td>
				</tr>
				<tr>
					<td class="varWidth">
						#rc.mmRBF.key('addedproducts')#
					</td>
					<td>
						#rc.stats.addedProducts#
					</td>
				</tr>
			</table>
		</div>
	</div>
</cfoutput>