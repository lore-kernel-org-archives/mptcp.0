Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DB7F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZIMNuY7W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+EebAvNR7Rw5nUgc4siDVRIx496h5buX10zBesz75Ucv+wY88AcUy9GtTakhsepoOckzuCLtIETS66/oIQN3mt0bFpqxTjPeWhY0xsRojkiK50sK7UdB+50xM6TNLC/AY42ppA5pOcorcfWzXdvfuP/2v8nsnQEGNINvEycGf1TrZcIxGIj/gUYbXIhyF2TDbTYCen+ELWxNS9H3JFt2G2thMgFQO00fw7teeFNa7oQ+Jo864MK09pW1wTGBj4VahTghYDLIssrKFGQZJ5oUjHJjwKEcBVeuIlLQH3h8lwXLtJI5trJ6G4puh1Q+aPNQQYbDM/mrlK/TT+OwoiOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHVoi65t08h1ff0gC2emSVTLXNnVst+w6jAC1khZ3+M=;
 b=blEOVq32cs95SRmD8R6/2Q8CUU6gaIc1zpA//DGRwV+oe8wSYh1mfPbn/5n0M2zqr1FGEMR7pczJ1WhLKGZjTKZHzW2EFN97TgyAvfZ0s4UM8N/i7sff8jYgZq4KCj8RCCsye90LYrneJbjghyAcDDuqcTH8OKkadbpVp38PFGH4o2ulwVpw1/Ft0U8LopD8+cCPNOWoQwVdkHUbPMWBkNkyV8DyFfSLtsQQnEhyy665bLc87I7hP9huVmc2aNBLhDoK4ZxcKwZK0heewrwKftF48p1xJhJtGJCOS3/212bW1oWf6Ihe2EDhwGjnrAFBaDTwhZegPXfbY+MjhRxUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHVoi65t08h1ff0gC2emSVTLXNnVst+w6jAC1khZ3+M=;
 b=ZIMNuY7WE76VCeJkwlkYt5BHfxl+9xVl/YZTFPSPx8pCiJeFK5JipujpdRKuIvg48IfJyQqCPxCX4cZBWVXLSiX9kEU0qf2LQ0S1Ooj/QOl6uiv0Bz8yVMSIvIjr1XIqOh1si/ypWnE32ICt+4QlKrooOk5ZAYdymg+UZgWI7epFzFoOb+ahcZYZvAEkSzM6ztCfGAvA/el5TKO3bTmIidte+F9/I3sPA3IviTSARll1Gu7Caly4JrlWNBmuqxYodWV6E1ByYE85EoQfEcYTVVKqj+zrZ2ohias7FeH32np41vaK4Dpym7CJquCz158K3Te9x8DdyF5EHjVEJjlJ6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/9] mptcp: add userspace pm addr entry refcount
Date: Wed,  1 Nov 2023 12:38:20 +0800
Message-Id: <9e5303ad58a52fbd9d99c85e9aad476e3e1862b6.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: c6656e56-f4ec-42f1-3f1b-08dbda947039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	930WlSs7TbSCRDtaPoSd7j7EzVCWwGq4THYLO1G6aLA4DwGZXoot6u6j9bl7XOaCr/NW5oDInRq0j7ZOGQ5jbiTrcXmJMaLyw2+U2lNtqDnpjTCNcFZ1f3J1vlaQaTyISjB9Z0CFds1JYrJMSEX6qQDG2N4lbHWcY9uZKYZnLeQ4WRBgB6vutOuuyGQwcJZL8kriEtVK33YCGVXjhf3mHyWscoh0lL8L6LhFy8SNBWAhgLXpqUBTCTTpwBfl1uujLIDmRvr5Nef+6Q51vghBwfQ7SFXDlX+t8OZ7zkTQvgWyC7AbiOUNcRdu10LBQqPsq9IVDaR5dMTDct2QRKsAPd3Fj3LUi/jOTsXJOh04itx5M4gqj0OB5127OtEtgAKlcw9qihTsURDzI7PCIGMbyQkXqT6EW93Q4iSAe35X1Hi86mr7nIGfK1i10kj5X/q/tnClKMYdXreM8/13QV0GI0m19+7PeH5px0HWR14oL3J8H0u//rJhGlfJ8iUOaUnUm81RQOjIBT5vqDAhF3N4aw3ljEovinAlFEhT+N45aPB9CjI4H07Ss5Fp8DsEuHuiec+y3g30qFQBWKXzmOgRqa0Kd9Yg/m5bscdIVIHlXZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(966005)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwYdxboYZQkJKAKkbTkLc6iKBbK3KkM0OnRFRBB17alg7u0I4+5o3EtJShsD?=
 =?us-ascii?Q?siOD30gSpLx+GC3STa4A9BNF6xhxMzK6sJfQIP7LNw6FOiABCB8FK0+oAU69?=
 =?us-ascii?Q?HlnGTGZs0LBQP3EJt8zhEJUdN+D294ukciiXEgzsjkyUq8f//SGUCtVPED42?=
 =?us-ascii?Q?lHH154yJ2iIuLX0S0w6LpUL1ws1ziKhn1v/CfbgVpCrr0WBbbMd4masJoWAY?=
 =?us-ascii?Q?6coHyISMUVO9xokC/yqCjb/N1vSv2DX/xnUZMLSrCmUSqpR1vq29w/zHZZYK?=
 =?us-ascii?Q?17dGPZIgblxhlT1cWAU+UXzcO2NST7hFp9WllfBWO8YCCk3R6QPIiploywfO?=
 =?us-ascii?Q?KzBYt8kjCcSHk5HB4olqiTu9jrFFsVli9rHp9Diu430kNQTbeNgpc4h6ui1s?=
 =?us-ascii?Q?qlbey28e5RSB+wORZxUEmZKbmNPJBC0f2Bm90hvOy6O9lXVtFyAtZIs2j+Cl?=
 =?us-ascii?Q?fUB2saJdPBMit2AaOp3L0/LKoIdVnjJ0mom5l3SJqFlLZS6QwWHTRZeMtUnM?=
 =?us-ascii?Q?A+4e4pEhF7g58JMtE3Bq3gL5Tok381vKCt2204XWf+7nMSGeqPGUQ020nTWu?=
 =?us-ascii?Q?UZLE5w9IPdglLUBsCEiX5x/JEmeoF9c0VnEz0EziAnHWSFUlWeNgt+LsKj8D?=
 =?us-ascii?Q?26ROsojDUjfTDjm9J7wgf+6Hq9z1vbZieYVknPbPjC642I3mWNd+5lo5yNMW?=
 =?us-ascii?Q?EYe5cqtonrY8tl0UpaJZqZJYJnHZC0G1weXOubkhqJvBek/uJDVNzDxUdNbF?=
 =?us-ascii?Q?GfECcZfx3i3goexTP3XJRu3BtTc7rWd7VzqpQds3jK6SIoL6Dbdr1HU8D4w7?=
 =?us-ascii?Q?wf6KFRjLLkUZ9P5ui43vEL8XtMkR8+V3G6ppgcG4L7NIOA48+EdgFqm+Yh3o?=
 =?us-ascii?Q?INEvyqFkacd4RNu5pqqsSCyxBSFsOM/RWICZzrraFTRoaQDWkseo0uBSB6F+?=
 =?us-ascii?Q?9D9oKCadipYjwduE9Xf0IlIzOhU+Wa8C7XAgAo7QLFjUvw2RjgJ3OpO6l7zW?=
 =?us-ascii?Q?W8zAcwrnt98wkvp5Qiwy4Q5ir/eV2V4BENza2fBDaA7/1EjWMxhkuTb4iHpX?=
 =?us-ascii?Q?MLXd/kD4mZZ4/2/7jZRtwCrf1L3FQ+KNrKPRQhQ0CXZ+FX/hg/iivImEExUD?=
 =?us-ascii?Q?qWmpFPOJemaLDVVCSCQ1hpadLOt/PjLOnuCXhxgp/l86v0ocnFIRziZ7d4zX?=
 =?us-ascii?Q?64P4nIFM4oapXSNCqtqx3bQTphnM8UCulp8NzSetOqrE+HRYb/WZu4ptXXBu?=
 =?us-ascii?Q?ZVCrgI3GjmNg0lTZHbNICWx2SumBiCC4fgWtKaMmeWN2zACeqCgH3WarrERS?=
 =?us-ascii?Q?gf0tefset3+Zw0nnUxkfRwgnJllLD0carEEjoBRBPOa2fU2hZElWqE8SKmOM?=
 =?us-ascii?Q?5qGVN9y0vIC0GKh7EjG4/eXZrgRL+H04UUMmgwx86jtLzki5RriusiK9DtUI?=
 =?us-ascii?Q?PtsNtcaR3FScZ7aoNhbKapoJgxWZr2ag/aFvkuFDUcwgbuvLRRHikjtsgjFS?=
 =?us-ascii?Q?wY4yxp8BQUc6CFDkl+G3zgxwcA0LDuwn290mjk4Fo78PMLLQ19RTrGiTrVv1?=
 =?us-ascii?Q?OkGf93b/y3rZjSL7+Q07JLSnGx+zgz97HdHmd+lu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6656e56-f4ec-42f1-3f1b-08dbda947039
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:47.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /t/K3gZA0f6+WRuld8yJv4eIWNSted1SAHCpY5kZeMlyiMMRnzK14t96FLZI+DNHrhkkJVFGyKMn5b0HsoZWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 934afea24692..5602d9db8d85 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -70,6 +70,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -105,12 +106,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -209,6 +209,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -320,8 +325,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -400,10 +407,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..31058be1ef3d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

