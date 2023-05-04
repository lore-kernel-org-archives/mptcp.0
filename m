Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67CA2D
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBvr+hqGgoODDccs0mW+eC6Ls6aNKNCnUXKcpq/jfT2fTgPw8GWdSvI3VZppKiFfAMsQTPH5TNHjw3E2wdEI7VWEzVbykwyB+P9puOdTaQpoOl80IawawZ6IPu6Nhjng2e6TO5pWGKTQICYB5yhjtgpH18dMUqKIbPVYW8czXdtWUG/gX4rWtURhOlH7P+IgB9Sy13qImCFFepM5+14p1DHgOdj3i8hxnUadkpZAbOPCw6MnN3sIfkNvVNGl6X0IF5OtuOsCql+TwelAqoyZ085w2hSyDtJyvexD+dBOBK9wllVXgUShdtBadCTSFaabwYFrsdgN668Dn1B/gRwcFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caYF9Pq7RV3J2vCKGf+B0rGhUMM/OzFDIJZk8gQyU5I=;
 b=AVrtprU4ExUC/Kgdg9TEKbSzrxtvySphqMf/tvMPdwMV8zArlaG/FNcFukIk2Rj6U894B5c+JJFe40NPA4I5X7zUJLbprD9CUCge+Lb6APcAuurlV8rKfWe+ACcQbrQAAo0D6otEaYvT2AyNhbZYTogZ7KCIrJ7TglTH/4nXzdX7QI6S9/B1mBHRxuH2FXuV7SN5fE8WbDtkc1+GOmRxcGaCy6yEssIbQApHjmtUQpUeI/thCQb/tco0Yl0pMF03y5VFny9vSnKWhFgSApcg7quaz1u8Pnt3uLRbCF/Q3fgGNK/uybvZbxHXXEopU0pScGCKv8o7zjGgDAiREpvZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caYF9Pq7RV3J2vCKGf+B0rGhUMM/OzFDIJZk8gQyU5I=;
 b=3F1rDt9OtqDmrPF1qjb2EqCaqdJnvuKxPVCTOX6l74gn/K1l5xbrm4VjmLEZuUYALHGeobJTIjdvT6d/9pBqiMUL4beGNuTdg2J6yMBTpEFK4IoS1o5dK/8RZmLhEvy2A79zDIafulrBb84U1WemDJF35YwofThzsI9dtbK27kaBTXJ78iRUBwGugiVB7FZf+3LEmoxYg/XYEmZb2M2Kdq+uvB/cC21YBm35XzPb9UOnVbqTNVsKjGbPsQJLPfypGcu8rCYQFlu8u3y+NaDVr7hSSw5FTn6zsWr52trLNvQnT4a5OnQu89rUmgEBWxiAe6tDBkXbvNPL8BabgJmZqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8345.eurprd04.prod.outlook.com (2603:10a6:10:246::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:21:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:21:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 10/12] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Thu,  4 May 2023 18:20:15 +0800
Message-Id: <8316cade77dd3d6df4bed735355ba917c7eb8ac6.1683195386.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683195386.git.geliang.tang@suse.com>
References: <cover.1683195386.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: af0ffdc4-aaf3-42b8-71f9-08db4c895210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V5/J16e69PkAPTc4A/CZSU23dRLDd/58YJncbY0oixISU9IG8RU5btwE8AK/pijCBPT3XlV/4NuCKrLl2urJX2B9pMDL5CqOytZzL8NLdd6qPEu4pEBQKO27o3BjayYmvuUIcYoflPyh28w7EqrFm0ql1wwEbmrYpVAXe6Fs6aAw/O6aDaggpNW5NaR9EIaFds3LhwbYEtciAsMoZPN4cirpxwel44Q+LXdVNrdnrp3NA2Kc4uEj+auUQj3+LjnGt9gqoINNs2XgH50KPPQndHPDSdYub77GNn+t1B5j5BB/BWNnDix+wQ6FHrbYC8SfMM4v4NMx3jD6JW8kbzdy3aWPvpRPN5A6kbig1zjcUNcQL5ZWuY1zihGc5PPbCBeZl15No595rWb2Wu27Lj9ZDKDGjutP6fM95Js4I2HKzAwhlNLDOaW5e5KtCSYHHlsfQb8mMXF8QhjbJICyzqx0JFnzIRFDr9h0FBW9zhbldiN50kpSR52S0AwNMHIbsDMzOYbBbfDG0xJBV/Roppi3Bw1lqsCyJfB4c7m/EvoAf/gI26a3z84xcqRPobt2bpTS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6666004)(38100700002)(478600001)(86362001)(107886003)(83380400001)(26005)(186003)(6506007)(6512007)(2616005)(36756003)(6486002)(5660300002)(41300700001)(8936002)(8676002)(44832011)(2906002)(66556008)(316002)(66946007)(66476007)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ZFcUryQ+1ymNrx1Q6KSkFL8Ucs+EMOFkxFuDYrYsqjL908GTcoWST3YsT1v?=
 =?us-ascii?Q?0dMQf/lRpQnAv2NbTDpUb5ygwiv2bem0rpfvMJ2ARSVQcoHOQmDKg1mk0Ugy?=
 =?us-ascii?Q?hLbniVLso8QR3fQdU5XhWcSZcqX0vGWs2KKAxwiwHwARPAqOW1CR1eotqStv?=
 =?us-ascii?Q?m1cExeyIXS++SHPS2KVUr/mwg+SjydlsmP7jvrFRw4HAynK0+5lLB3DpeHsD?=
 =?us-ascii?Q?BzwCSKaCPn6BStcts79+A8/SMwhNKybbE/4/5qTo+5tfHxEdVtXeH/9WjCZn?=
 =?us-ascii?Q?tfvLxaJuzcE2YXk/EWlAShDKimFq3swE6K9f+BfCIhbCzoVvwEK9aJVVZPdi?=
 =?us-ascii?Q?VyE+cclfUEHCDw5xg+6PrnlHiXKspuZFOTYFydvZ7FTKLzzryz7qGJitusMM?=
 =?us-ascii?Q?3qEENpU9hZ+TeYbZDEEZZrejM7ggAo32YCqXApHM7bYVTmq50sDl5dOFaWgF?=
 =?us-ascii?Q?dDNG0wVZoo0OGWZ4GtLGpPoP/g+pwX3OepBYLk1lsQd+mGbP+Ltwa/wOnH2I?=
 =?us-ascii?Q?TYuvvLFWcYaIu/WiTaT0BtTRa/uzdqJY7L0HOv0e6MhksD5AzhKMpTbiV6dC?=
 =?us-ascii?Q?n53UNbslSm30nGOUfKUqvfPW0E3FTbz0Lpi1rSernu5dXLSy0eBbswObQaoj?=
 =?us-ascii?Q?unj+0SCJofaC0TsB7KKAOjo5qy6xCDzxHEOMBoJ8u6O3YtoYX3fE7CEl5jCi?=
 =?us-ascii?Q?X3rlCmNSV4JqsZVQrOb8k4pAbI4Zgv8FRKfzlBIdtulvEo0tqVZ3Lt4oNIne?=
 =?us-ascii?Q?s+wetfYVIRVIR6aOfruNlHxhMC9mMCq+DKSU77Ebl0lj6yc42zcvG5GOw4sz?=
 =?us-ascii?Q?Ynw+VEHGWvdpZBAc6eN5NRJ4JTHGdfjj/XR3q7npWzAhswvrXZ31cv7zCQzc?=
 =?us-ascii?Q?Nf6tSAViu+CXVyl4NaKo/Knz4el2qLgQFI9W87KUqrYLQEwKBny2YGwiSrdD?=
 =?us-ascii?Q?a8NoW/BMyCzxx7yRlUGpXQZs82rfuDMSy7ZNRluKVrGsxN3o9fQ58mga0YwA?=
 =?us-ascii?Q?dua+8hEgQ4znmtanc1I+a/Cba32z8mmlBepykhAgmxikiip02yfGsLIpGLkk?=
 =?us-ascii?Q?EEdoLS1VhvhqiW9LnycZK62QN19z6/PgipyZBSeVUDmmTeZbFmCFI0qbB0Hr?=
 =?us-ascii?Q?7pHTJ7sz+fN+41xWAWk3YHaTVKPfCpYc/sxG0Y0+sriLoTcGgiT2LTJtAOZL?=
 =?us-ascii?Q?EzJUe6laOsIWsjs61KK6odD4KmEJ0jkrIDtrfelYUEnYOhNcIC8Sp5WRQ753?=
 =?us-ascii?Q?gOd32sV3hoLBBZ3yxnZ2RRSLRN9538xevDG+kBUXsnk2qvqj7quf1I1ylwBX?=
 =?us-ascii?Q?FomSexjsoJIOpN9YUD071FDzmxMRseJ35TObmAaPY6Emog5Jm29cD8ciJx14?=
 =?us-ascii?Q?pUMaa2+xCmYx9XicL5aQclkV1M/lqcKyq1vVOckupFCb3YBckpXKFvwjafxq?=
 =?us-ascii?Q?4CRMcHQ0CVrwyR/wld0LlC+lRrubT4eSjFRoUqbh7VQT/GbFKu9gbY3kv2o/?=
 =?us-ascii?Q?ZgHHT+P05HrZxiCZbnMi/VEAz0IOtFAidT5Muiz6Eyw72CsbXHQggZogmt3j?=
 =?us-ascii?Q?fW71LlaKJSGPyquSr03Ng6X48P2FF1qDT4AwxxN1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0ffdc4-aaf3-42b8-71f9-08db4c895210
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:21:27.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byRRwvdiGVi6TZrNXAvlskU/AIQdeocvuReG9T3TXce3ZA3JvYO60KMpqfZJZzEUHEbZEjb15XCVzYS0QBgxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8345

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0b34b57fc8bc..ac68c8a5b8ae 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 }
 
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry)
+			      const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
@@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
@@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	list_add(&add_entry->list, &msk->pm.anno_list);
 
-	add_entry->addr = entry->addr;
+	add_entry->addr = *addr;
 	add_entry->sock = msk;
 	add_entry->retrans_times = 0;
 
@@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			return;
 
 		if (local) {
-			if (mptcp_pm_alloc_anno_list(msk, local)) {
+			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
 				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 				msk->pm.add_addr_signaled++;
 				mptcp_pm_announce_addr(msk, &local->addr, false);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 98a5c81083be..bc2259b441be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -188,7 +188,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -330,7 +330,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_lock_bh(&msk->pm.lock);
-	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
+	if (!mptcp_pm_alloc_anno_list(msk, &local.addr)) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
 		spin_unlock_bh(&msk->pm.lock);
 		goto create_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bfa7d93a1c1a..c08d05f48372 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 				 struct mptcp_addr_info *rem,
 				 u8 bkup);
 bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
-			      const struct mptcp_pm_addr_entry *entry);
+			      const struct mptcp_addr_info *addr);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
 struct mptcp_pm_add_entry *
-- 
2.35.3

