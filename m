Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651F43C081
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="uaJgyx0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWE41ukBYmu2WJoF0ERHqLowsgnjSWZNZi1V4RTxJTWzF7mmCplVj5+LF7zzjHB55LdOW9Nc6FYklAMGx4Xrbr2nbftbTlwQymsS1Q/GKO8AMlMwkHguXDiHt7uLR81rEhF3863JRRRHj+K4LEqBdOm1Z7fXEsKf/Zi1xZJBY+N5mIdzcOGIkVSyjBP0PqN2WlI+g/HWNaNe1Lxz9cw3/aG6FvrBzXkg+FPi42o0c1hkj9C5poPLW7Ddqr8JJtKp5bsfFhkoDY6DU4aEO2UI6GTVtbXnYhjaoCEJ6y5CDXqyBXfD/8knl8qQQdNutaZYyxdXC3Qzkc7KQZXwLnbfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETTaZDMPn8hsI404iQqYPKTi3rlDeB9A11y9pe2W5Wg=;
 b=lxuVrWMeVY3f811V+LyBHDJa8IeFFuW/5j+JzmMEt5tt0BNNn5JdMQe3K3Kddg4Rs3LyCzczwyCaXICqtfxjVpEUAlo68FlvtBkEdM/rMC/ArPVu6dO3dHqHYioMyBXxx+FOiDjnvg8jAucmeif2/c2YJYz+9gYZsMNs8J/Z7ZEJZfZPo5t6KRwaNQG3kAw9dUvzDxRwYloSnqDUIcaXTzi/TZNjTAWGEMDHXkxO0Se78tA5DW4iGCSz9TpuCFPSryJhnWJJ7mSpg9pW5nTD+7RjvmCf/l6NBIcN27HVEkiEkeQxxUwDOxlKRzoYFcO4GsLUGmZNm5WPzNGucdfS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETTaZDMPn8hsI404iQqYPKTi3rlDeB9A11y9pe2W5Wg=;
 b=uaJgyx0X7k6/ljNi2Gz2THxW48PyRO0UH6pDJJT9uEerZmXvk4c9TSnI+jVHnB9ykuzaaQEAKnApxy2dww87h1SYnx6VaN2mYj7hJq72DX/4Sfj03B0fgA5ceKcccDRkuy0xgcKO5QxHZrgODIaJZAcmlzWHTNaPy6Y6menWRlRCufyLgpdBYEWckncxnV09hozym7C4cwYpsacTBvNshdByxIHjoz78UDblEsqWryQQ/ZixcEMCxyNRpffyOffBMT7xIb7fMvPt/a2nKinU6+ZlEloIfcEXOKIS98ob/BniHJLdGgwiaffrM8mPuGEa2MgbqunXwD1JCpAflOtwjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 27/28] mptcp: add userspace pm addr entry refcount
Date: Tue, 21 Nov 2023 17:52:50 +0800
Message-Id: <8dfc9059a1399626bba86005d236c618939fa320.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0087.apcprd02.prod.outlook.com
 (2603:1096:4:90::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 168491fa-40c8-46aa-0382-08dbea781f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	56v4HnR3z5usn1VuDNiNx5+pMMdPm0t+YrbK9dbVUErwnbYL6vgRq2PSmiFGqyzTdmFDJTiOB9jVoKHW5/ma3UvXH9tey/T1bNuCAumcLhsHJszvWKp7cdT7fNvFJOzdMkCZpQJ+tzvA49MuX28cvhsWZ6VD36UZ1aWNJVGQ+QWc9Y4vSoXkgveVwdtQdnI+GxYxEOoCVstdYDQvQKGJCOrmmTS9vWCQ9oqHGobIQSQNmPEihHNXWQ9ieG00psSgxiaV/i/plXGgDHF9S3gl6we+fAbp68qAqhJBCTR+sXw3SoovbXJpuVb4dQ8sN073dBaizsV9/ZJQsVxNKX4z+8xtzD5VkKjaM9u5EMHO5wvJrjM4gWv8ebxZvQxMNyoedqfPAb2RmdFSggJEDnnrfK8O3598Gqa+2UthhpwUQkrtbWTIBK9BRfWE3cpChU/XXSDMmEhJZ08i8FukskHkwtSfHpXFFu/NOnuSfrIfzNySXGnsVcNxWbqrMNAu7R2Y7cvjXMxV8QdHdpoZqoebDBdRuokcCM6HuJccJG+A5as=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(966005)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GmA6BaYytRQl+DW98nwlTW7vlwQy7RAHo4lC8N2t+GQU2GP4fLZAbbfD2Sum?=
 =?us-ascii?Q?f5tloGnGxyXyJvPjrXJEijpYqAHumxMU3LAHIiQdssMfu44O255jMmwE8oyF?=
 =?us-ascii?Q?Yuek12m3jxW0BEHBUarQY4qh2kyJUxGfvCe8FCJriSorUyeF6lwCWqOtJcHf?=
 =?us-ascii?Q?xvDEFbIVo7kMNYyBlwMf8XT1ozs8LWbZBKnVkmUpg8j6g7VAv+jcWz8XctWs?=
 =?us-ascii?Q?CY/giT/3hIddM401QA4i8c0mpTYthMm5G5e/bbcsqCure/yGk4ALiWPCjoZ2?=
 =?us-ascii?Q?DhC0DI66tfP1LzUZycq8xX9saVUQ1W5SCVD3nAfG0ojTgT723b0o783uRB9O?=
 =?us-ascii?Q?ulUXoChnfbaSvmTXQ4dP0pS6cGMNKHa2Aus8zkTwSa7bKnuX5NZkZqbSFuZ/?=
 =?us-ascii?Q?G32Fy3rwrV/kL1BrMK0WW7NJJ7ecNWRI6Jed5YBcBzm8I96SzCs8fuBzyj0n?=
 =?us-ascii?Q?BRG8fuPiNUfm+YBTLJ35+euVyF5yFEVANHWDLpgEEt8glK9yFY3FAFAlTcwy?=
 =?us-ascii?Q?FaGXpZqbd8a4EjKw1AeBbVTuMSMjohm5IIxDBEJimqJLxZwRZk4QkvOESXkp?=
 =?us-ascii?Q?5uyCZXI+H70cIObZinw/I59BcHz2njoAQJEPHsmMuU3BzuMCl2mj66Vn/eEH?=
 =?us-ascii?Q?OAa/XX2Bk48OgPJntTkpBpyCFzbcJ1iYesy0qV0EkCpcgMx7aoCWMEWCA2G8?=
 =?us-ascii?Q?TOY47bqFOo8nAg+VEXrcLZGbe6ENmtZTILpdmzO/nxn2XU2PHxdUQXlVDl6L?=
 =?us-ascii?Q?+HMbfxbIW7oWIbsUpVpY34vQT6IwvlXNmvp9Wc5lD7DH4YCBLNk0D3v0If/K?=
 =?us-ascii?Q?rBvcEXu3ieYKsWDHhY771Ix+dKj6tcw5hvCXrCrGTvNLkfVIobKLtwvfxEs2?=
 =?us-ascii?Q?Sk8Lf6mA1zwJXnOFBYO4xiOUNWTDNi8B0aUjW0FSGdgpuHVIGeeL20WOhF5L?=
 =?us-ascii?Q?6azk2S985Uvj4JMbw46D20Z4loc6G5p7JEnyP7YriPdCwary782XNMMacyfA?=
 =?us-ascii?Q?naOmIx7XMbsxJQ7vJGHbCkcNIMsr+mKzPUOb1dLgD4YWugujfYY3f4UUzbSK?=
 =?us-ascii?Q?3WvpAFYi7u4XpZAUFE/8W4gbLgZzfizbyiS84Ei1w4IHB8/tJG0+JzkWVOh9?=
 =?us-ascii?Q?yiOWrWIaBTtlBfyAdbQT8pWT7GO0o9GcA43ZHXe59Kr3ZhETHhxFGhi4NHcG?=
 =?us-ascii?Q?sipyF4StO0JfodLwXWRXVfVfjOT8hZnaWeTY70DFoChQq+gqxGO3Wx0m8yBv?=
 =?us-ascii?Q?txlPq6mH5aHa8Eqc/NrLqFiTNDgQVtGUR5izfX2cjhHVQa00xYkowlW+9CTx?=
 =?us-ascii?Q?u5Hu5XXm7sQ3H4cqL+qA0ww2YlUh8f8gBZmIZNXj5xEl197T6KQY9NPE3WAC?=
 =?us-ascii?Q?utMR5bqb4954B1LXN13Zloljn9Jns1pnayqWs2892zC10LeeVp8BnOrly1DC?=
 =?us-ascii?Q?x3CX2SbO9WKznB4phzwKiBHFwfbp/9eJpvmE7JC9+pSiSZvbK1AnVrm30DSd?=
 =?us-ascii?Q?ydf9GAMGaRKRsq+lkkDkY1jsXbmGLArt9vfv4GhU46TFQskrTDPaD0JcR+MX?=
 =?us-ascii?Q?x294RSZfpSIsQZVp1SML6b6mzLpjPIro0jMf+TncDB91KZBN+8nqI6p6BjRF?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168491fa-40c8-46aa-0382-08dbea781f3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:24.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FY6G0bobFMrdQK7Rx2bHqnG0iwC5hvpBZmv73zBQvAwznb3ZHE3liuktNa8OE/97HyuoUyJR+8/hB3I7yD/a4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 99ade938eef5..43a1217503ea 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -85,6 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -110,12 +111,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
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
 
@@ -216,6 +216,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -321,8 +326,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -408,10 +415,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d40e29419c04..3fccee77b739 100644
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

