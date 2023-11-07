Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2261FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tgYvOPHa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQADWyFDI3EptLt0/JxGYGk+kwO6NDQeEpBb/ZAn5Rv422dJXTujMy6X0QBCD1pr+s+YZ3pEtgx8F6YJxUN7kWi4XOz3MRT4YThBcjAuqd8xznh933P4jfnsNCWlmmcN4MEM7N6LuhT/vcDy52FwBfVg/ruk0YtruPIA/+50UregiiDyqggIdrEpROhz3zMqpU2pWU5JNABxtrRTpIpfh7SsINvhWJdXLKFv0pt4NJHBQh297G2zviTuBzhYZnz6Q4W4UvdrZ1z3N4jjEI9QVQjI/nzTKRN/yV9CY4RK3B059/dNZwST0JSDcngNZhJ7sE+7hfWb/36FBYfAwYIRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd0XmH1SYWu9fQnD3nT5KuFwrQBJ0oWIgOJZJRjOnhI=;
 b=PKUBNcocI8eA03UviBCZakQgC50zS1I1LYdfqb86Luv7Vf1oza9qlowHvQmDZBt4aA4xJP6POb00op/C9niQHpXAWf5vzPBMSypKQ5CRbOB2aM6hHSiuCtGm38dA2gaVUS6dVY+QlSYeauP9Z/XOc/iDpHiAqzxBx38DCCglTukekNDR4BrCkxSaKSAHGtFyQVWe0RUSjQo4Uqf44jhdnl6wex0xiPSD6OcTII/NFzYqCcCfaEfGMV7jKFTjD+rvMJKktOqc4iJiyoN60os2Dxp/t7wwusELWm9azOUUCH5kKMaETNBNLkydjDL6FmPdYb0cxHTI+Tr1IFrqanUh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd0XmH1SYWu9fQnD3nT5KuFwrQBJ0oWIgOJZJRjOnhI=;
 b=tgYvOPHab0fWMEk2/f/A3yl9TPUBRA1TlyygWdBPREkEW588LC6re5Bsh+NrNeB59W2Exy4PSS2e4BgempT0NHQhsZi/82ZPLiAwKuX1wAXwLZ/S5EPIYa02zeep2Ox/Uh8BiYlSVteqwMaK85blwrEEjn2rb4pJoKgXYOJSarKu8v10601paSLzYVvVQISH/562lzQa/IJUPoYKXbLxxwKbgpliUAdLtMO6OIv3p8wI6QT5AzuHywfBB+/jo5lAWNDkE8FWvCu+rzUUmlEjqb/s/AOx6lYr58U9/4jgPvV5MUQShOzonHF4zkNKN7ucM/SSy0xaF6ZtCIkR5RNY7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 07/21] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Tue,  7 Nov 2023 14:01:51 +0800
Message-Id: <43178d181a1772d116619063205eaf21f1aa88a5.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 57ea3636-0b58-4c50-01ce-08dbdf572e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HDwcwIUdY/0dq0jcUWEnQavCzNNIGd+pLU89BCUPl/Xm5NQ9iEr+6GihzNKSqqF4YzKUvhMsOjXr9yPymOfnPuoSB/NoR955K/CXURqZQPjSY2E3GvVAfCvCDy0ttMVeoURyB9p0s7A/6OTmSwn6DRGxmjraNhcspb5RXKfT6TCpEFgm7H5fLdcy5XoVAlylHf2cVS5BQs2ENTOLNC1vrMCOnCZveDDBomkF23QnYzDCZRER3KbaGSEW6IlsC4DuhS+c0glrd7KUuVjk6FCFeu1DibTmCPAqzgJ09/get+SfsOAsdAnoEe6bnN+drztNF9yEOVn0c1pttjlzpfoSI2nVGw+9tCOq26tnxHV6Tb8AY2IBLJcB/a9Af/t2OoEISLUZyJfhZc9Exx9apNHJ67U0C4RMXuxTOVbcKz2+B621vOPqd99/FZ45WrkPUdBX+xQkiGy4fzWiCSbaJidAN7CdoEJ+Puhhj8ylrKs5uBZnqQNbox/qk+Tap9pORhi7hnKsHpBQfvbb58X5I7nTaJLcyY7fABj99+nP+bRMJzOT9Ls5DUiuMFw37Nv++hPD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dktxV+gPCrNHxP6/yrbuvkY2c9nJvNt4b14I77Mz1SMlbRQ1N7hMSEBCdKc3?=
 =?us-ascii?Q?s0r2Nlu9acoEUgrvbMwTTc4rgULLsZGxCUw97TspH5GmPfA1j8GTSd4q9+72?=
 =?us-ascii?Q?6M5rUTZS6M40R4aPgedk80UJ9ohyMhlEfu4CQrinK/T9T8XboPd2op7hzSI2?=
 =?us-ascii?Q?6ffglytZsM39noLYxVJHAscQ6D/4GEtR8aL90HdWEcfHNpggVZuoiSED/1Ub?=
 =?us-ascii?Q?eb0fdowaGtmCfw3fr34xGXJaoFoKtWXdQpteWuOVyCIGYrHAD23/touSxLt1?=
 =?us-ascii?Q?wN0C+KWTPfPsCLMXsEj7cf4/IIEImY7verAfd8hB5KXqglKKLMX672+fRwmP?=
 =?us-ascii?Q?JieVf6wJ5YiNMsQv7TmMsxrPnREQNJpPH5YhkK+/3pZhoTw3ai5V67Dmragb?=
 =?us-ascii?Q?nXm2hlL2EeY47e+PnR0RCBqbiuEs0IYZuUVG8fqEp60l5062PhBnMCaH/fVj?=
 =?us-ascii?Q?W8V8KDqaOrfn3s5FhL/3DFroCHDHjITvEU81Eabjzm5o4Iw74oT7bJ34txSR?=
 =?us-ascii?Q?FOcVmkzrdRcTmb4TnEpTTe0VyFD5YU5cgfPjhMC5/dy27RzWDJZW0fQXi4Zm?=
 =?us-ascii?Q?vEwJNsz2JTYvpddTmbuecqKfAFoeq/7bj70kiX8e7+V3hlD8ykGnkaflCWCj?=
 =?us-ascii?Q?rvfP5byS9CuSB/sCfq43FgT5h5/IGAqKayLVcAWH2GTBHJt6VnVLL6LaX/SZ?=
 =?us-ascii?Q?0weBnbK8we1o0ZWBPWMqmWTlb4VxFpijtNEJ0fL91buXwNV43wf92HAwkq7z?=
 =?us-ascii?Q?I6kW556o40jaZi1NU+bcSKpgu6Zk+YPLJJUaXlZIiDR04jpc7ypax5dSh3d3?=
 =?us-ascii?Q?BW0NwKtEauMQfYJhVgTk7OvnxW77bwBFk+q7ZL+EFQ1QYwD3PDjoq4zHOtjc?=
 =?us-ascii?Q?j51fttc2GhMZV3rrf48nqQlYk0edkYYY9ToiCLd4bAT+Oyi/l4ZxvKC6ZUGh?=
 =?us-ascii?Q?xdn+a/Bo65MYMylUwXDDjR/BdJrCMO890c5HqXHFDmy8MIdb7A3/3cAXs19/?=
 =?us-ascii?Q?qu0AXuQMDByLsomPS4WyOqSxAvwtxPT51f6HClwfbzGeRd6Na3IFF2Hcc0RC?=
 =?us-ascii?Q?UcSy3seEeWec2s6HVVewxlT/Qp2RfQ0h+dnjbCRW1VtOaXQt0RBzPmN/+M+E?=
 =?us-ascii?Q?SraR2jKj4Z7K/iOJnOP9qaf6+bLiudxUA9HqZCdrHCBXP9GpR2DnChJ54ZsP?=
 =?us-ascii?Q?cfHypYQgNEI3SYaXqvIg6OfxHWSBOawXY83hJjtTHuMpMQ3eDowPvzF856OH?=
 =?us-ascii?Q?2L2NBResQBrhU8cBITV5QggCXG486nsw2er6fnsOHpTmZhJzr+3l8kiAGbnf?=
 =?us-ascii?Q?jqSxgPYh9R+UFnrGjlqCJNuUA4QkThufJBnZk1eF15sj7soebgur5Qj81bqx?=
 =?us-ascii?Q?Am9wI5dpYV658JqLZfhmiJSPYhbyLS7MRVXAv/2F4qYD60EL4Km/ttu2245W?=
 =?us-ascii?Q?j/banNw0sjActmMGeE7tN+H46z+RFgFlJeGJqaPpZgh8Dy2+Dp+HqNcp2SlI?=
 =?us-ascii?Q?c08eVYIaL5dnufAsMU2IemllpGt3GfQCQL1WaVhFfFDbewFlALKqAPWhn3rB?=
 =?us-ascii?Q?hKROE51kQw2AqGzgcRnFP2GA5FFWGccHHUwa4dJU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ea3636-0b58-4c50-01ce-08dbdf572e4b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:53.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tJsj2Itq4BT2gmfeOwfoFo7pCkrw4c02omB/9cjYh3R1OGnhJCZsjT8HWTArTzu+ZnmMzEsAUn8jOmJy/kf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 95a793c6702a..5d42b62cc3f6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1834,7 +1831,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

