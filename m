Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278123BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tUnQY+Ny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUyuEBRGnd0v+KOB3TxGI8Mz3NYgJLSfRywdTmFHZriGaVqYu9EOd17+DUm69QgsRWmzZRjygToYcT21KdOX1jPo9zMKaPVabbSN5WXVDAspPsuz9Q8GRRfO3QrYBA9/+lmND/M2wh6vxEkOV5nnvShfv93DciJRbilyQo2SKlDrnMSIywifpa2YMUHDa64tX4XV4cCHVGC2JZVH/0FBua4eeYJgvQky7/kEX8818UOw+oPBfuic9dp9O2cqfqUo77nXyL15qC6Q+ajSjfU+Z2c9Z8gbAzbRHzUYH+U4/73OQuRXV6GIqZWccbbC557Ja8tN4xz4e2MQ9ctvmBixqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=WYt9RhmBggLIpmoVqI4IJGj61Ay1f+jyP95qBdZmqgk/iPs3AL+vOHnESEHgQPsVinqpQStFBFNONXKOVe/aouM4Q/MIzvXp5/yeHmxSHKgifoQJyNkuABhOLHBbhLfTzoUsaWnJe5DZkwnVM7/OH8MyABawxBkk0zv4A2hUEn4RFm160ExyMVEjX3UIgDpTyvY+XDWGW2fYodc0pGhQLR0pg7Mm9I0psdymW7WCkCIXCYYEb3yaPAv9CzBP/igKseFoGdaXHicsUX8gDhNF9i+K3NXBnnWfyEV8OB4dLEE3m53OH5w7NW4Jt5BtqsdVoFUqiP0Nh55FQsd2TPn9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=tUnQY+NyCdyPvKv2aDUU4LJfFLLP7wbCg/eY9JJ9+segG7hbQS84ataNGtJigoG2dv6nby7U4LjNoDS8o8+AJKWBNhWuSaRL57S+O+y+rTNE/2YY5xExsRXTK/wFoOHxeQZLr4E7g1yV7J79L6Ac220qLIszulQ3BLf8D2LL0v2etKO4JhCpd864uIPgG/ySbP99W3ZC8s68c+DHuS9UjQxDJRlVs7u2o97dZw51zxwDxxUTBmMOWfJCBLLWZcSRqtQgyf278Plrp7L6SkW1dSGjJXhcZHvlmhCNX+VNQn90xF6zOp59iYmlIaxOFTQ2x/PEL32yKNbRgJErmHR63w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 13/28] mptcp: use set_id flag when appending addr
Date: Tue, 21 Nov 2023 17:52:36 +0800
Message-Id: <99e17e0aec758315b1aad49db5f4a610d592ad50.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a75de6f-1b29-47f5-e9c9-08dbea77e8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uUpRUNQj4TfDuzPDlxFc4Rj9nimSYBGJmu4E5cp/GYuk2SIY0dVKhm5yuPZhLDEWmrK+/Np6r+H+9ctT7JID5G8E/Y8h0jXz7C2P1WmXd8L9oP57W7IxLt3Ch8dYHh4DD4oR7/tB97exexpnEG0E0MGDitU5WjP/68J+YXnAbV7dAFe+AbSgJu9b3RBjDOLGvHcZsOQbh8cyt5ajHRxFT4CIxDgoniyn5FH3ZyWWTsIvDDUqWLfO1bJhEaGpS++km0xjWjXYaHItg14mZx0KEQP1rF9eFM4fBQygs3ItFdgIfkN92tW309E1lHcLVIBGASXprC2VPSz3CDwSk+K+JzzYgWJ063cjed2LvWOFGfSXBJPbY+Tv1sW41esgwQ7/KIbX6wAIox9HU6O43dBMCbIq2qFWz/UjD7qPSyrqYMxoZnxKjfUFueibMKQQXMFAe1E1R4ZHT/3ds+LFsDeCwf5O8Mx3oDUIXhIfLutQG+lMa7ca9I7sWmP5yZzzOc7JqFtn2muFo033sRaKfsIzgp+v8DVrsK/tWjWOMOazL2WevcfIbDvLfLQSkvgWyk3h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PLPar3l9JAQxAEDeLBjGdOx6OOofOYrzvywhC6L4Ya8cR/0mp1/e++7RTOpO?=
 =?us-ascii?Q?rDt2OK6kCbsva3zEjMEbyvNBHfxOBoRtyGaC4xWnF1MUgojSP9XqubxrSGvZ?=
 =?us-ascii?Q?5WY+0nmR7ijt8mG1EKaEVKvgt1GjmvCMIyTbr/1lzGxgo917uo3MhKis/RzG?=
 =?us-ascii?Q?UEJlJ/da0xZHkZyoAFw37Cc6KoiAHfENEiRjomh4uCgFw8uh2hl+Q/zUed1J?=
 =?us-ascii?Q?ncvUHa6a8LVoCYA1gQZPCUxTYFbc5riQehxF+tm07uf+rnk2UwZ2UOWovfnQ?=
 =?us-ascii?Q?kqWmx2OY6X0dmNgKEK7r96PpCDQTqecKAb0boc0O7uj+gN93aJyK4036OMhS?=
 =?us-ascii?Q?WzS2yqYKBQLP8ZD0tFCQ/34TY1cru5JBugaDgxL/bKqDEfVj9J8lF28/udRM?=
 =?us-ascii?Q?zsWNTrrRwu1bhDw6BzT7UC8pR8r6vqDAmA5GeXplJfDCxpGkag7Xrz/FYBeb?=
 =?us-ascii?Q?mrRhE0/LkHjlyBAGPvKRNbKEQq92aUxbsqvLZVVw/ILyoK4Jcwa2Jr52n8+9?=
 =?us-ascii?Q?DyNHli1gzc0je6PGl8hPqYvBFDvgh/PhhX3k9cLdJYSIY/Z8hHj2lm2MHOJW?=
 =?us-ascii?Q?bUOP9poIzhvbcXGubGpGJ5FSvEwRPAU6ZOZjJLWJpCjYC4IPOhfuR2njo84b?=
 =?us-ascii?Q?EkQefkpFRzjI34IEVOF06l+BET7EsKHLiTLX0dhck4I5Pf+rQCEVg22UVIic?=
 =?us-ascii?Q?xnjsaIBMoBRCD/N/vcM7NLliEkf1pv9EGFUiZ4XbTN93gJ1DCE63ScKsJ63j?=
 =?us-ascii?Q?G/tZrNCbAd/mLWjmK9vJU302eizAfb5Hoi+HUQCBpk88ZhlxMlU/QZshvlhB?=
 =?us-ascii?Q?9B1VBlGoLJEwtkwx72BARYwt5REk8yPK6026bTU3H8nD5qvquc8hyijwAsdk?=
 =?us-ascii?Q?Tos9tjR3sAV6gYtpxXnlQ3fC+fhMdodgJES7k0Vs+oUnqnNUI+BIe7/4RTS7?=
 =?us-ascii?Q?DetuhKOD79gUwyaW7uqE0VJjS+xEayuuQ4ncSrm6sYwvhvb1afDZPy6JcdJ0?=
 =?us-ascii?Q?khd0sXU8dla2i5zJRsoMUMQsOFrQFEHIS8+JxXM2JBoYcMe5CLWXH0CyK24m?=
 =?us-ascii?Q?p2fNrZ2Q8X2LPRwy9oAVvaJakMbVsfhP2elyae6w1LUt8/ospDIO+lxhU91O?=
 =?us-ascii?Q?jtVF34n220Ib6Fu8OWfd5qBo46702xzmhj4Dx73m6MiPmbaL1zGZG341slF9?=
 =?us-ascii?Q?55IyzzDqK5PDURnTOXNRiyzaD7f5VrN+ncUHwWcufoHsv8oVri03lhnYcD8d?=
 =?us-ascii?Q?XKtrg8yyQSjIpJG396voFCwpBT61J1V3p2xtsT9wQGx55cuP7ogO8Oi0SJeE?=
 =?us-ascii?Q?l90LJHpkPJQUuLu5ooA8+NLdBh08ovplE0EnDZ+Idxb6tLqy/uLxFAeV3Kf7?=
 =?us-ascii?Q?EhmJVtYCIR+a2u5so8o2fK4dAhqBMXUR52DtJsyg+OezEhgxkS8ME6m4bOM0?=
 =?us-ascii?Q?AiUAQZwDgM49Iwn5Z5F8K7DOdSasv0nEHtdcMt+3OUB6A2f9um7dIxuYRnK1?=
 =?us-ascii?Q?og5WnASvKuzN2G5wWKkjC50ZWbtiDmXwhBG1kl298GVjhBRSAiiCrAQZCJZf?=
 =?us-ascii?Q?wI62FRNvrt+81yYv3F+yLnlTenZsDv715E+fC0alWVFkadsUOGN9/kgRCwJe?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a75de6f-1b29-47f5-e9c9-08dbea77e8da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:53.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVtmoV8E0VP2QHC2z2pLgFY+PSFNzRgKAzqixSUppGa82E9raXK/n4R0YZh0hhhkpJ4l+JZR/NkJ7sIeikJWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

This patch uses 'set_id' flag when appending new addr, adds a new parameter
'set_id' for mptcp_pm_nl_append_new_local_addr() in pm_netlink and
mptcp_userspace_pm_append_new_local_addr() in pm_userspace. Pass the flag
'set_id', which was set when parsing the address, into these append new
local address functions. If this flag is set, do not alloc new address ID
from id_bitmap, just keep the userspace set address ID.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 11 ++++++-----
 net/mptcp/pm_userspace.c | 13 +++++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4db37baf74ed..cc4ac206f848 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -855,7 +855,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool set_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -903,7 +904,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && !set_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -914,7 +915,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && !set_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1041,7 +1042,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1281,7 +1282,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, set_id);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d4258d2e269..c9dc25fa8540 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -38,7 +38,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool set_id)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -51,7 +52,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -73,7 +74,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && !set_id)
 			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -147,7 +148,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, false);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -193,7 +194,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -374,7 +375,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.35.3

