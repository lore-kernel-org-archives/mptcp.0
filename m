Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70A196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qCfWoOEq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI8gXOCK/Mj/vuzEoUzxJG7gAcdBl2rRzgPgE8C4oWXZL7W0EMgCnBKZ49Rl01SBn0Qx56c4mhKNc2p72OAbszzej1kDl7ePjnGKpR1onMFGRFamrcpWgNaMm7VJyv3fYn8fvo5k86y2zEQN1H1xmghgMr0fa0/BqScLj4lqJSiS0hyxc1RRMgWbhvvpnCCs5vZCNobeJgIwtcbWg4gQ1Y7PANURIFIOPsruZh38Uu76b38b/aH34zyTGKDB4RkVK6NpFQm6SqmmCN7a4GlfwePJceWtP7m/Q02p/zQg6hXEz7okSFZNyDh9b6/ol2d1Cz+RurZu7kUSBTf8jFAtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Loqvs6NTWF8MRgHnvbu3VYqHVYb7aWxGThhYKOzPDEo=;
 b=HbJz5V7xh1HGuTs6mJWEZP8+f07+KoxJlMwmoGkmbhNljEVxpbmmeb6YtWFyVQxYBKRLUzbb5xdaqA0dYznGPi0yellXPyY2vUIriTNYFsCvON3KBibNBMd3vhzIPGWCgkJnLFxhzRARmSSXPJb1dbDkyU7jU5a2GiGFKA/QUI8/npMpPy6/zxlQOZ2H4by6j/2R1b0ctjvi96KQ4Ssdg/aThnf6CcqXP+LOaXLecc+lGCoJsb0wx0nAev2nqDf+ExsevyENwbnKza6N8yrLYEybGa2yIFdPr5rZMhf7PnfCdnhSMC+zhSAS+eIURmCXiZ3ER+0WT9sWQlX5OkfRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Loqvs6NTWF8MRgHnvbu3VYqHVYb7aWxGThhYKOzPDEo=;
 b=qCfWoOEqzvzmBnKbFC20hJyg1uQqY4MEF1oTmOAOV8Wbq0+jqTxlPhjfgMHvDq4qAhTxBN44qrutwUh2KGl73WbndFxRaALEj/SlTbTvqk4AJlouXQngulwtzkeZCTfqKXJX+IFYG2YJf18OYXv14SucdllIe4+9JzLykkl7KTUCK/p1QueVlFaIWuAwTHa1Z9SCLaPBdMKCTkn/YQOYcDd4s74xZ++RHUWlRJG9jPbRE6rBAjw9kz6rq5cGkWnDmHHBas38jSBG14/C1InXA549Im81T3cHLy9LS02CFAAcBleUailyVNCeORX0kjWR7rX03zGuFGq0NsdQpAiD5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/12] mptcp: use pernet id_bitmap in userspace pm
Date: Sat,  4 Nov 2023 08:26:14 +0800
Message-Id: <650d226aae97d8c2c16aca9171bb325687ad2663.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: a41fb641-5f68-4386-2d90-08dbdcccc480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WBIo6BrE5IyiQ27wGIztVBUFT5PXfnQ3ymllO3ZeWTJPqWvdb8ev9UyHr7nTiutawuDilMv1y2uOzr5QsKIQZZL5JknqykndGlHCjwZOoCVfL9dXwqdBEDk7U2Ug00hpwsej3N2YLOB2ClR/4ZOvSJGiCDQuXlx3GloY9tVm9z/re8opGI1SnR4CtGA6JPbBA4OK2KHI+2rCob8pHNI/0+Ew4ZF9W1MIfI0+BlwUlXdQLhmOKlQJN2/EvANujFDfIv5pHKK9WGBHy4vDjuqmlSFd6GDSQxK3efaPXo1UUDrLtlkdmoSki/BIViANa8LPsA+JqJJFfAwmtufK5JqmBAcZAuGkSd5t1ZR5282HqJlde6WLZ4CPHOGPNctk7eo2cwC1YZFFOiAAbZpLXAQuXNcolcELRCUVSMsp8FURAKqCS4+6JXJJD2YsOEEulLEv76G9SD/sWicYQ9MfLdhvqmgxLOirqqynmwvCX1L68tinRRJ5Lq0G0J5SkEbftZFLlbuM4cgH3PnWf7DNhhY5jpCacZ6x346+238oLADC9T9kL0AYQ6KtTsU4LOzKGMvuXwz1oRxY93yPa4OmuAo5X9Wt6hEN+Rx4lrqCwjE/J/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5qe/rF4Qv+8HDa5vMbE1GQQw4i94yON5SMent6HbO4mFiDR/nek+VnbqRHb?=
 =?us-ascii?Q?fE7vJOxEnQ6v5ljW9xX2zBuYbB48UkXP6Ip14kIKG8DwtjOCCtIWLrtM/vvM?=
 =?us-ascii?Q?26gshJlQSraZRV9NGaHQFwIUf6t0TIwMq7dRR4rsjRb3UGT325lvjbndVswB?=
 =?us-ascii?Q?zfpWmLhniLRS8cbbwCT2j6gxmOPNCrydkXCgzgdZJFghXollzJSE+uD/G8OU?=
 =?us-ascii?Q?ZO5YPuUEI1WntZNKrqnof+IrVtxqbKcyPoA0od+jiNC+SWTUfksShYqruYYa?=
 =?us-ascii?Q?+wwzw3bWBPPTURzlj5+2ARAYcVAIsMeHjk2ZHJlfnojOl2o8jfTtCM9GnDe2?=
 =?us-ascii?Q?kBqgHKyJ6nqVxdWsafcHArb0QTkRLqW31LSTHgIVZcE/97NmFh2yCa3Tb0L4?=
 =?us-ascii?Q?sMrbRfPJXIXfz/59ll4nTU6CtCivbCqkT2e23ekU1FN0uHvuPeh9RFMeA3cN?=
 =?us-ascii?Q?/ZCT5S/I4C+hgyXZqZ1OX9FEzPUdmaw3zGDwojQpxmf7Y8AmYQE0g8rjUkQR?=
 =?us-ascii?Q?14eEVBZ8ayv5h2Egsx+34cO0lMzkFJxHbVlidGXS9b75F7sPjZgRqAg5BJt6?=
 =?us-ascii?Q?jnslyR5GygDl7AmlsvdSnfe6/M+oTxYTMibO+ESQXvEpXMd1KSBGFJ+uTtQg?=
 =?us-ascii?Q?dFuzQmO/Dk6MKqTdw/eV092ZjmEKbci5MXl9GQDV+9PukMfu/9xubXWJGJ5z?=
 =?us-ascii?Q?2jjDDYMHYKEnnJTJp8PLUFlvehjOH373XfPU15oi3EJW2m1p4sMeLEEdHpGq?=
 =?us-ascii?Q?ybw+ljzJa0GVEEJiIo8vBS3Cqgfz7RnoWXzDh08He8GTED5bVQnUdC7SXHNd?=
 =?us-ascii?Q?hQJZZNljadq8C9GPN/CuYiantuHxMhYg9nD/+g1Q6Esje9/wNNWfAmGgzeXK?=
 =?us-ascii?Q?EhSNtcFX2R3VdDZtkwLH16IXFwjXYlyA7LTb0BxIwkVpT+jYzefQCFhzUE75?=
 =?us-ascii?Q?xnbqJnouDiOZIysvxu2ZSOuHZe8MM22rAKHXrc+Uiv1tQaQzskpTWH7h9i7R?=
 =?us-ascii?Q?NilbsXN4O0zCsdkEIiierHHok7bNyeKrHo5tRLzwSGHqnYUc+tEBdt0wI3d0?=
 =?us-ascii?Q?9RZ5tOlcN/jy5iwwpgS4E+fc9oguv9Fik1Z/SYxU/nINLOocInBm+jGOWFfV?=
 =?us-ascii?Q?vqhKO8uTSkcM3/KN4bf8lmLSBiKYIumRhIBDz96Fu7px5gIcumFighqwM0ZE?=
 =?us-ascii?Q?tAJ5f0JYwE9645JYL1R5LsfazeV89Kz2FrZnGAKMWLwIdbFmKBfF8NDlvAhm?=
 =?us-ascii?Q?Wz/sZT2ohk9XnRdzl4RyKSw795QZFXurchynZdoQlPWrh8qNOCT+iYNIVxZz?=
 =?us-ascii?Q?8L6xbMTzE98eDXTFLJYtgh8DKSg0H2h9HDKXuXLmcoZe4hE1wdBsYKIoINIZ?=
 =?us-ascii?Q?YYJm0UWCEHHltTOCgDcHqSa+Co5RuqfA51uuOhKK4bSVRD1Ow/ZVf4RYVccL?=
 =?us-ascii?Q?PhTkkawNwZ00E2DQvcfqSsYqyNYq9Flqn7MomoqE27xZfOE377cmIaAwvD1M?=
 =?us-ascii?Q?oYpRl6L3qIhytewUsW3P4s6kNSoBWSIpS5cdN9L4rH3yvf+b1vzn3T+lx9H6?=
 =?us-ascii?Q?oCFfdqrngq4ye/yZFLOulUY+bo/nd9q93qf09PQ3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41fb641-5f68-4386-2d90-08dbdcccc480
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:03.6065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+3+9qiVv2GSahYpAfjtK0NFtjcFV7BiFcrYR920hcmbwI6hxn82oB4ohamykSFVWYklBrGA6uDens+H5k+IsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch adds a new helper mptcp_pm_get_id_bitmap() to export the
pernet id_bitmap used by the in-kernel netlink PM. Use it in userspace
PM too instead of using a local bitmap when appending a new local
address into the userspace PM local address list.

Also add two helpers to lock and unlock the pernet locks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 24 ++++++++++++++++++++++++
 net/mptcp/pm_userspace.c | 11 +++++++----
 net/mptcp/protocol.h     |  3 +++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..d6594fa80cbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -228,6 +228,30 @@ unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
 
+unsigned long *mptcp_pm_get_id_bitmap(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return pernet->id_bitmap;
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_id_bitmap);
+
+void mptcp_pm_pernet_lock(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	spin_lock_bh(&pernet->lock);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_pernet_lock);
+
+void mptcp_pm_pernet_unlock(struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	spin_unlock_bh(&pernet->lock);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_pernet_unlock);
+
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b5687578e6ac..6856bde6c74c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,17 +54,19 @@ static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_soc
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
+	unsigned long *id_bitmap;
 	bool addr_match = false;
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_pernet_lock(msk);
+
+	id_bitmap = mptcp_pm_get_id_bitmap(msk);
+
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0)
@@ -76,7 +78,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -94,6 +95,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			e->addr.id = find_next_zero_bit(id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
@@ -102,6 +104,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 append_err:
+	mptcp_pm_pernet_unlock(msk);
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..cf72a57e6c54 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1030,6 +1030,9 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
+unsigned long *mptcp_pm_get_id_bitmap(struct mptcp_sock *msk);
+void mptcp_pm_pernet_lock(struct mptcp_sock *msk);
+void mptcp_pm_pernet_unlock(struct mptcp_sock *msk);
 
 /* called under PM lock */
 static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
-- 
2.35.3

