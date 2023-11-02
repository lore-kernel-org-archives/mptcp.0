Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC7C11CBD
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pgA0BIHM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZAslStPbSMmmPC0J4QbUdwZjKxWTjAjmhKbAOTwCVgD0PdRl0xEKIf2jgzPJYP244TPOPcrcIpspa4QfGLvhrb6UhKTpsUb1OUQ+BiJn+HFg+9ucLoa6rIXkB0maBkXrW29InCaaVlV2PbHb/138Ql1OD0n28qUtFeqNcZps+pAklVmKpLYyOoQTRhIWfDA6CjY362xqoJ+6PUDACbmK0kK76sWBApUTJ6PYqP4n6uho9eoRdk0KlANQCik/qtz+KT5dC42lnViUk/kEHLXqGjbSHJtf4vsGRmjzD/5J/VQ0wtm8XgJILE6jzHuxAaGUVF7NrDWMIt91y9YalPxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0as2Ixtg24aQko6phP6gZBk/cE160+IaTT/SEeXeOug=;
 b=DKGzL3Ro3kzmJeO1B8KLHrKFJxF/cWXSDFsZlJSD/EBxDF7HLIuXT1rwibxud3hAa+0Rp1fA8K3NGTgN+tdCJ3bj6vu0FoKfktwILELYqQkXk+P1/+jj6S8qksyPqHkv3lDUQKGqvsMiYHDz9hJzeBTGcr/SCnOlTDlqvdL/wQ1n3FbdsNylkse1te46aBVN74M+81iTT2tjJ9Qtbdr4r0sM/FdGltPc93Jz/MXMMX3tGm/nXrSz9CdUHfzckE5E6afT/Q4Bmc+Tyn5AHrDwSghdTED05dilZBU7PhJs0NgFTBtbu2FODt3eZj09mGWI/T56Xj4fGb7xogunKmTahQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0as2Ixtg24aQko6phP6gZBk/cE160+IaTT/SEeXeOug=;
 b=pgA0BIHMd1Fa5AcV6O7PFyTx2+N4qRVgUyuVHgTZpOu4mn6ozXjMOWvgTxiKhDpE1nAQu0K807516CEiLzhvtvV2kCEjf/xIP2EEjvHpwamA2ugmXYmNppscXLkwcRvPH6wnajEVGzQ+1Ew1u5YppfB3/5/MRRK9YrUkaah07sqMDXEqu9wdn3C6Azo+Dyu6eIUAXPxVbcYVjAnVoA1SqhTZjilQ8L3R7etaWoxj+1itsgBnGoOPvP1pXaDk60gyHlGoFoWBsr5A5um00Tm0BENh/LTuATR3pwG7HjWwV7stCou986eBLG7hGA9Yl4pP70JXZ4MyAIPc0T0QgAT0/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:52:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:52:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/10] mptcp: drop lookup_by_id parameter in __lookup_addr
Date: Thu,  2 Nov 2023 17:50:53 +0800
Message-Id: <3ceace2c77f6379e13bed5d6893766149eddb9a3.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1799dec3-6caa-474f-6196-08dbdb896038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iv3vPHY2GzcCx1qVz01VEYHIHaUI+iCBRCtb0GyzNgA0PQwF/qjuFuYDQwQEaHbs218v0tijEz/Jd9WDEWP9pAi1k1xXeMSBgzu/i4GngR8uuRh33czwoZfcEmm2WC60FAPekhUVza2idUFX3iswRljQvU2oKHCwr+Un5F4agXfgoMzKyDBMd45RYC0xVFmGT1ZFIJjWtzaCmsXeVzmizq/BaqZE6oUj+CBGlbqVzjl6vu7c2HlUB3JceDvTSGRzlN4LDJMlubkUzfmHnbCkfrRVqSFTroJKr0YFPhD2EpfiTH8AwioXwi4qVQNfUQBNhN4rOhwtphRDV3eprDlrmpEB3uvJFnPKT+ZpXGqR3IgJuNE81kWE9FcAeIIqAc9In/CszovSNLTI4SdNMgfwiczgClhzTgpkjs9haiHBEBd4X2LXgA/m2pg8DIThLamnU4d84JwNeC1kjIz8ePyQ1FIwSeIA/3gyXQ1BZW162DWXynvP2PWO27MFDmFaJpJ3anxIeeimnWoV1jazklpDj30kig8gCDwYCjMyYH/HCD4dkwQPrbcfrFA/L3b6Duyvxx9zzcNap5fxZERLOGehgcmPYH3h6dQn3eSHjr47/fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6512007)(107886003)(26005)(36756003)(86362001)(2906002)(83380400001)(478600001)(5660300002)(6666004)(8676002)(6506007)(6916009)(8936002)(4326008)(38100700002)(66476007)(66556008)(316002)(44832011)(66946007)(6486002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RqvnDBgHipxSj8xIZuU1yt6rN/0iJtlMOuS6GhaZmf2IWTDUjSefja3JbV8p?=
 =?us-ascii?Q?un30nuYjhZUjKWjRBQU0A8KIRZ6vPkgkjv5Z6peB5iGfLmgNn0TKRuN414R2?=
 =?us-ascii?Q?MqHg2P39udF4mRjA+TW5z0vcjGGUJoCuTuHoazWPEE8lazA/ytkkfy1ZyYia?=
 =?us-ascii?Q?yYQFe53jzWbZCoKbXBElLOMrx61vdlV2/S0cLQJYONAVpFiIkHWdpRS/dADj?=
 =?us-ascii?Q?7Y7d/lvDEmnP29UnBVF8AA4fKAvPIFIsymPjqEYGmI7LdSTlJPRULzcWSV6Y?=
 =?us-ascii?Q?kNtif6TavTZeVmOVNY9dagWmPtW1y5xvXAd1CG+1Zo4engjpXqgmbC0h7HkQ?=
 =?us-ascii?Q?dui3ggzQDhscDt/uaNEv5KHITYJE2Lak5uqxLInRE5U6VupSK8vvh+X+l58r?=
 =?us-ascii?Q?VkHSmfXqRYijYmzNVn29J2FeZFw0Z8D7SaMkFp/lKD1UeCAHbkDZKEf5F88M?=
 =?us-ascii?Q?jeJNuOvuVQ3Aa7bgNUCzlHkOR1Y1M7Ts5xfFIwVAZyh2gmcOsaSBD7HoENak?=
 =?us-ascii?Q?r/mWuA5+rb4/WmwE0IOVnfqV54ysdagO5QdT+isBRQzn8uIS18+iZjN+pzW4?=
 =?us-ascii?Q?52wgCd6WehNU4uabHTpnyQG6yZjC4Th25YlrW6Dxhq12OU0yj+GwUegX6bI+?=
 =?us-ascii?Q?eMIkSLgKIzsxRx4PxctjFhMH1S9/xhsbxxSWjIDXhUOXCJzFqaOwvUDQXmpN?=
 =?us-ascii?Q?JYcpYIWSMpuTkUK+S1yLhrU/Dm/jEDJ58hrix0LQpuYpJY6H0uw2d4P/7c8P?=
 =?us-ascii?Q?eJlFjSRCCrJCONy2cpub1XDQNectrI6Rg5wrGSYEBD7Gb4LT1y1A1O/fGoEh?=
 =?us-ascii?Q?89B7yWdFpAdrf1i3HIsjsp4mlz+/sO/6L3b86gks+CI8v76goSN4bM5bAd7U?=
 =?us-ascii?Q?gUnxZaygaPMKdbmiLpvLJle6jcKycPjt6+iIFLy0mtsYR36qkD7UgDthuQ83?=
 =?us-ascii?Q?2GbhIoi30JnS/hfzd3zRn1TfdN3OACvhDSpwL9ZKHZ4WGuFRT77RuX6p+aTp?=
 =?us-ascii?Q?DkR6zTR05VyPiPyADgn0qYqBPFdsGHD8Sa6hviecgyn5p1ygnDlaVkuCrDaJ?=
 =?us-ascii?Q?8MWIAVJJJNEsqNovdd2yt+EvOjX+/unP/AnwcNdEtEw5ClTQ009V3COU/4AZ?=
 =?us-ascii?Q?vmEqmqySeNP9KQwDKxPcp/8cdCQq9sivGKaGYN1/qKBb7yD+QuOySiTFM41Q?=
 =?us-ascii?Q?brjY1ytxo8rIR4TAksI5QjUY+ejnC18W21ihFjAdVMXLEsporQF4O15lyi2E?=
 =?us-ascii?Q?DM4hVA3bB39keG5PoLFwEhTAhtuvnzmzFtVxT2AEokR/MLOSK129Z2RcuDR4?=
 =?us-ascii?Q?TgERrxNfSszxcn1RCprfWMPl7+cvB6R8cPJfaAweznSc+GukKMuzONyaS0Q5?=
 =?us-ascii?Q?7Zblgp/EXOO46LjOfRLsTE7Gu8K/NLuuAcDfoGUw/bpy3h61MNCHvMvo++Cd?=
 =?us-ascii?Q?GU9CMdippg1iacP6actkIbz97r+vz3kFP0h6nGVaCOj4Aonss1K+0S8M3WPs?=
 =?us-ascii?Q?M+DZ870ir304hOKQCPkRcRHUk7MAlPOG5uAYbFTHFqLaVJChFLcVYe4K5Z98?=
 =?us-ascii?Q?qaXJN5RAamiXO3OZsPKLDzk3T72aZf3CL5NsxUWEO3Y1SEk6vXly1k521eMw?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1799dec3-6caa-474f-6196-08dbdb896038
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:52:07.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fif/+lvVbk+gBDEmoz2qyQKFci8afMFhdNT6L3NxlY11JjBXtNJ3fLvGBBjvMK8U1F5EaqctiLbicWf+hxejqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

When lookup_by_id parameter of __lookup_addr() is true, it's the same as
__lookup_addr_by_id(). Drop this parameter.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e900737d549b..0e10ff1050e7 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -555,15 +555,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
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
@@ -593,7 +590,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1932,7 +1929,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
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

