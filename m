Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5812BC8C0
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dpk+16n9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvio3ZMclqqWuiaIhK8C7u1IBpRmrzGtIPv0VxuX1GrpQAJp0eq1PKt/n2X5etd2+Bv1twx13JFZGq682cw9M+g2Wy5SpAsfSTe6h5p4Vy59RWYBQR8GjJiL/ev6c3IQQQepdKsrpVcPi7iwiMQ+sSUa6cxPGO5oGev+d8CJu3Thv54F6pN4PrDQoYSahLvFRANbAtW0teV4Qs584DAlyGbO3PlmEhgBRmS5R+H+hufpWCyhts1Sqp8TIeEi1Ld8FQhC7oe8NPvSOB3AGsgHSOeN9V4QG57dlrmbG27Q/3PbBtRJ/HsZ2zX5YnBjfjqb0nO22277ejVA146Svs2MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf5bQUbh5eEFZga+1M+nElTrKfqhdkRszfzsQuNXB3c=;
 b=IpDmeFoRLdljOxMJEHFxQiAOOleZPs0Fq6UMAXW9nTs8psDUxm6Rvbsh6WwmkXOz4rfZhemXzfrp2IXP/rj3RuAfX/4kMJbysN2X2aTX+YYI+RGUuwJ+7NIuGbjHPWFX9DVKemw9U0W7Mq+kKXZVz2LZIKTJhanvb9FluPcqrKuvLImkPBH0NUIRTgmhPGfTcwe9cN3LtKrI6PTFPmHYzHsj75OQtZFYUO2E1kqG3LL13PCrIB7Fk1WrwanfnEw1VLiQ95iHTrU9kRidBm35QXMZKbrw0gXsL4p0EcI7/J6v9jd62GGEmFpX1IDQV8amMM5vJQILdqnBMd49ME+M4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf5bQUbh5eEFZga+1M+nElTrKfqhdkRszfzsQuNXB3c=;
 b=Dpk+16n9tgxVR7TQnx49gC3CrLmzAFOyTcoPvkUVdj9TU0GOB3OlfpDXEE7abL6NGxFdRUV3KUProwo+Q9rms3ZmV2XNl6eU57MqCAY2FyI/cwySGxpj3idk3KiFtdkcDNae28EZtoNsN4CfKzhNpfckDZbBrcYs69DfLNEHjtTZvdIFn5IcEsCILpp/CUIhpGESJ5P5DVO9ikhYNN9//hnE/IjrNoa7NnZnUJURx4vDPlFCpLuxxWyAiEEfsG7bI9QgKWr3PL23FMYB71RXxnU21DILX7kK9nsapRWxQJupNCMPbUQbqepYKMA5/+OU0DuvKq4sDpW5NE9D0pcFFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:55:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 20/28] mptcp: flush userspace pm addrs list
Date: Tue, 21 Nov 2023 17:52:43 +0800
Message-Id: <c2f2c83f4762dfa29603f4e60960949c7d524e00.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 5790789d-ba4b-4a68-9c29-08dbea78068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NWn6BUOGZWFoqIH7odyHpp3btCSDUxchBi2zNAyUYEi5xBMT8jEHuiMCi9EaxkjMcmb6T3PZh+2mXMmlygK80+5FERd47TFP7u756pGJPLn1lWoi6eGgv8teuj9AX01sStayve4f9q5SzNbFfv17GuVO4S78CIc7nYzuEbaO2lMrnIyS7DaD87xRIBVvpiuEAWHNmzrvEOOIEnsimw8XYpSf5pXRJU6JzuuHis5F8zH+NcSKC/ktPYHBk+vKTDIYns7Ur1NcBNNT8G7hGTeYhv16EnZ6TlGyemkUFr1QV9w8DSXmeS7cOF+sIfGM02i5Cpo3QJlOV1yNFGPMX7f980yJgUwWJ/0/RPbOGNFsEVTYNd1K/BDnboMUm1aknDqYNomINw/5gpjLa9zYqZsm+O11ILBKbeJZzsL2P5LytYgfLrcDeLBHYWnUAxjazLabkaN6Rgmzygs7lMcd+2pbYiI9sM5edVTEl256uaYRbAj7VH9iomsiHD8mPMf7W5Zgpv8cN25Oyh2nr8L1OZTeyvufXOgwaOrMiLPbJvNDBFdzNEpSKYW7sRBDqijrfHHc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k+j5o4MeQ/bwP5tojGKE1Fj6E4/9OlYvIu4lJObMM1eUggiqgRlgHKsDZ7QN?=
 =?us-ascii?Q?KyfqAKxyfyv0IZ+lMiP3rVZBMKywiJJmLSzzDE49E8QxdZw5XjuDl//NQ98n?=
 =?us-ascii?Q?inl5nCyRMbLmewaFe+P8KOrVSBa3bHcG8tjH+0+PeakaQ2xpvA5NW7W/Wj/x?=
 =?us-ascii?Q?7lRTh2sFpQmLyOCDEc9x/JXZ42w90KR+QnEtgw0xzzkn/Lc4nFxvBs69TBTX?=
 =?us-ascii?Q?8+4FWzMkAvTWRSW9LeF6e+2DWWU0csLhjRTtoQsOmbl0kRd7DxsNajShHYAc?=
 =?us-ascii?Q?e87overJnCyKIEPMgMgestY8Ft5UAR+0qrVCWnJibS0SAbbcQp5hL4jkVw89?=
 =?us-ascii?Q?tqje1B2hXnn5/yNWZoEjPoN/xBa0BVTYzzLGtqM0pBBBOF9+F6dkQ2eilGnf?=
 =?us-ascii?Q?2KE5WC4iifSMJ5ZgyHO5MEZt4fQJahlQwX0ucEvoqvgl83kX44F65Z4gGAOy?=
 =?us-ascii?Q?VZxvj//arNdsVwazrpN+qFCh7XhGpRE65qXLW6QtlvgOuZ8UWhpTWyhuLKDm?=
 =?us-ascii?Q?eKOjuHUQz+0i0VVQpqMbZVok3pMBoz9CeGRepvrPkbuhQ19yTxXNe9aorQAP?=
 =?us-ascii?Q?4V4lsoH/KNe+s7dtxKMgRbW3Yui58qTSm/LIiU6r6dD5IgSVNaItp/MM9vK/?=
 =?us-ascii?Q?8cq1S0wd+XOYWZLQBaefLLjJ7c9PR/wTIesbmCFFA+fny3xfAZqxg6hD0r7f?=
 =?us-ascii?Q?irajjjYMAi1YfuJ/mi5Xv8vLZ8EBbGYfb8rjH3hakge2OGMSLb/uhZlrykCJ?=
 =?us-ascii?Q?IPThgokViPepyFvpvRvB/45hrICiQ6dOrgYkMd6uyAhA/v7W65RtJALjA2gx?=
 =?us-ascii?Q?QVWqjHBaO4cVxRX/lKe0zXY4Fa6Z02ByrLrBEPLRbIZDqp8wX9l7atkONU+w?=
 =?us-ascii?Q?uqfFn3w38BcOByIjIJAkBUUakPp/lYA/4/tnxGxqggYq1HTKW7KhRBSWpnCn?=
 =?us-ascii?Q?73Coul3JQ29jYAgCG4GNar7hk/+xKzPqHjZsI7Fp1GC+OWLjLA+uIPSQV0WR?=
 =?us-ascii?Q?Iyo2XeS8kFNMocqtHdYq8V+baIAHWLTfNPPao/carNCoF+twcZHX33PPB0gs?=
 =?us-ascii?Q?hVmy/E2ixPfONgMNeZDPOa1oIlvbB566IBx/FLRbkIfxbG5R4WV2r3ostlMi?=
 =?us-ascii?Q?62jPAzVR8gDSpxLhMTr4vkRfzggKagYWc5J0jbpzzJGvgMJSp/5nTTPuFvyM?=
 =?us-ascii?Q?uusQ2rZrxlorwZ2m0Hg59JTGjaWSy6JZvsLGDX2klPFtUIsbTCYhOADjLEzl?=
 =?us-ascii?Q?1wZKm8GtjtEXURI6zSQubHnHrM1PzJ1GSGcnE5p6PhEHR8lcyGDQy9UsSij8?=
 =?us-ascii?Q?7yZWTkqzIprhgPUpKmdePoEKKCSCjo3WOR47z0hbeiFh0jleaK+XkbD0RMX+?=
 =?us-ascii?Q?R7r/JMVYzK1Etd2EG9VvUvv3mgroEEQouTedUBRNB+vGqC20+fB/veqvqY/T?=
 =?us-ascii?Q?I6863fRlyJWgcJu+c/+u7mdko98T2wKIRkypEs+1YFFe6SN+5KcJ9z67B3wA?=
 =?us-ascii?Q?9CSJV6oTwjEWqDa5jmhoB6D1hyPEkjkEOAfBAdLqO17xznpK/Ob1FcDuHxK7?=
 =?us-ascii?Q?W97uRDU/lnXsFsS5g6F7LnCwJ/WR37emlqi/gJoCp2670olBu4v3EVLNLAXD?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5790789d-ba4b-4a68-9c29-08dbea78068b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:43.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI13iplwIHX6LBZYDDaepHIsjUzK0hL1efB3s8wn7Ef9wYPZhz6x5bpsBg7lAC3t8O6bD3JIrZa+OdrzEWebIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a4dc2bc8fb55..6bc1a6b5b4f0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1587,6 +1587,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 674262face65..8494d6df866a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -597,3 +597,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
 	return entry;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index efb24c05a7e2..7441e3b9443d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

