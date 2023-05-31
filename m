Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80910EA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amYHl7ur/StFW3IJjTaW8GJ/iLSt9uz9NKFDCnLzpO/TjaDIncQdWrT/csmfCr2mXWiGmoqr9vUAtvvq2UtoKi9V5XLSBAvQ2KLjbdVUlH98cAQvaiSFqPHNC0veLVSshJfZ6hTd7n2Cxr/GX78FXSAn9NxclfhPMjKjogZOrwMKke4ri43fDgWPEBQUSwPgZDdtjK2EDzA/aVVEmMXxSu2lkEZOfe4EkTTyfokLMNBeDAd1jza9twvJFU6QNqZFFr8z3cYqjxOtvuYy+USnieLZArWHDNh7hc98T3RrqWNxnYBzbjQrxL1pjw0ciT11e+W3M6xIAYKzujcbtW06UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjstMBIpJb25g+U7v7VrmkLyDv6N1zC3CIpculI5m9s=;
 b=lEPEAvUQK034Fl3WY7KqRcL/1wC6Pt/kPqcK30j1HjeO49bujyhqbzrUoGi1ilS92LYZBFsjZsX96FNJpkBE60Riv2loe9VV4v3jf+0YqffgO352JKCKI/Emq6RGZ65mh9YADP+egS6A5Hr3N7eWhpTitu1bQbnG448SEHm0TFviPLnK145YoeOYstyphY/JQAIvHHydcCPDlYnlygKQaOEmyxNc9Q2mddwfpTSREhnsmBCsJkt2N2dgCAvAYSn9sj7yrPVciAhOFWN7gbUllxbU9fZQ18PjhSJrbsJo4oEmmrrZV4dY+McC3zv7Q+zsvcoq5cYR8HcLz9/Vu4eXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjstMBIpJb25g+U7v7VrmkLyDv6N1zC3CIpculI5m9s=;
 b=HLdz3oKtX8+QQeswUsfPlacAQUC4YFrMT1UPTczhLU1vvGMauuIV1o6rLBWIf1xfXdnqE0oj14SB3P/OIqGj6VL+AZRirlF2QzGs8sfTsAHNnW9W+NjtW+h5FH2+9ug8mu3u0flNzr6Z78ojddWqtgN6vJzzwcwMcQmcXHCx9aXb1BYpWBu8QIIDLTmt9CrRIsxwEeZr6fTf+Gwv5Z856jHJS6Q9o3H/z8VH2YnvXA9FWlagU4Wt04hIhOs50whqdPCo1pKniymNd9Dt0R6kWMg7Cak8BkoXMcZhj2FnNr4AGZJnANIpNNeTgxL2VlRDm5+OCGOq0Msny0RmtW5qpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:53:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:53:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/7] mptcp: pass addr to mptcp_pm_alloc_anno_list
Date: Wed, 31 May 2023 08:52:59 +0800
Message-Id: <afea116c44f2dd23abb19dc91ad9d5d7ac49f714.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 140e31d2-1034-4a7a-5f1e-08db61717449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nOFe8MND0+S0HD6w1BuYE4Xwg/a6dI/ve2x3vpSEpSni9eaAZdQbzoIU0trmLDE+z8zJE+FnYK1FGyRVWXrry++7yPlHuRWSJgXPQIz7UKqw2nRvcFN4SrzH+TvcFGF5a+nZhRaLtIGFsk80z4TQOGbi8F9ysKTNggEtttK4jdeDzWLudDB4oySaGgRfx/mE3XFFugcs4jBmYJ29LoxN+V6BlXq4130yzoIlZ66zWZikElo7Mf4HiWXFJ8lghlcXWj9sYt/BGDBAaxxAkkq7rTVp4PJg0EgZNJ8tDXNFAFyjDNNUr+8RQssKctH3fgfEaHxvgAd3s4M3Lz/VUp2t0kqrGIQ7AMQ09bw5COeh5pqdYfEgDEd02SpW7uyfwoITwCrkedD3LJHT+AnDSH4+b3XRVKYE4H0/znr5DBLQQRZMDIJTw+BYfhvs9uoO13KCikAtMwU1pj1QLuoXMaIhANX8zMjegme7yIEy0AUm0hZ61UY5uioSRPAPCa/Go01E2/QF5VgebJfC6iyKm3/yW3PHMtosTG50WB3hHWpk5Yr7EUMBvVLbxP+71lfuU0rd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waITNA9cmyhqCkOGjrbrsknbFXhdFLgBaz3nAVblC3wJK1FDp6YGkKff6QiG?=
 =?us-ascii?Q?gjxJKJ+g6wYMs8lx0nD4zfaVuTyCiBFPoSaRg8uXSaU0rGLHZNy0kqZtZ3TZ?=
 =?us-ascii?Q?+1/T9q6ryNp8iaVoYA0z27h8Cg4lpTOb6JFqGr5MK6TBqzK/pvkHQPwxFYpC?=
 =?us-ascii?Q?/vfHD2rJP+MzJ0L4vjDLR22TJDf+gVmNuFSPb0rS/WoRammnMvSDBRO1vev2?=
 =?us-ascii?Q?ojpnXppzgEruBFh/EtAVrBIhEmxbjMj/J0Qk45TGSq8fQZBR4X3S07YQlaS3?=
 =?us-ascii?Q?EJ/6OTU/u4zjR/jKCY286mPXwR3Nd8cwzOKvKop5Lxo2JiLpDzcHm3R8Eoal?=
 =?us-ascii?Q?+J0OqUddsjkKsCOQb/hWbBZKdCOfTP87R+QRdYjhhJiG4OTHvHJQr00tyol5?=
 =?us-ascii?Q?53K7H9t0veC1U76W+on32c8BPP6+TrA9yjeSs7u2H978LjJCOWYurr0Q0UOt?=
 =?us-ascii?Q?oIFGyGI4WGgBdQDTjdjvJUEFbM4xw0De49H565IzSembzT+hb6GIGc9q4jnC?=
 =?us-ascii?Q?Ux/ujiCwsc/2iW5lnMumSLVzfj77Y9NW/l6Mb/e7wqHefb/shTE+LKCwdV5H?=
 =?us-ascii?Q?jHhadkdvUaUpdy2r6UNgJVX0wC8PBCqccW04X5/F1M7QkbflnrXo/WOPXSbN?=
 =?us-ascii?Q?twFowTMsKSBWSAfzsUZoE3siSqvm/CzpdG2QxHKv9icySXVe3Dg/LAEuCjdp?=
 =?us-ascii?Q?e4UpDNZ0ro+ZRsZtPqaFV4q4T7smH0JBfCyE7MpOq8l9O6cCBFzTCfwfea8U?=
 =?us-ascii?Q?X2o+nyOBSa1DaNraqYijZrPNvE1WIe4vUK7/6ouCMxZVrmrDWxL3vmvEfbA5?=
 =?us-ascii?Q?xOoNlblRayZNh+/4UaTlQuaCeRsVysDbQJtq0IXaOyCD9m7lfqVYEywToU1J?=
 =?us-ascii?Q?/hudRX+h8LvdSH/27zPv/NPLaE86UeQ2/Wdi3COiuV1cHCyL0L+hxHt4Tfox?=
 =?us-ascii?Q?acJXK1x0hxIUUObBf1ISwuXmLO/lyTOv6thZNgnxirbixi3suMalPf94DNiB?=
 =?us-ascii?Q?6ljyUYQpRZ9hkvRxWpyys69+aGpKL4qSLi+vNI1pyNv4XA/9faHqK8Me0GHW?=
 =?us-ascii?Q?WXdjqYz1PJj8z57AwMbnnfhtx8nXShzcacge+hy5xj6k7yvcR06p9yJg77Kn?=
 =?us-ascii?Q?GmKOVjzYv1JNAE/voLdN2HT5OrZ0DZ8FB1AQRf+2WGIfn/mj/QC/gjiuGfWm?=
 =?us-ascii?Q?ky1xBGa1290pJ1hnO46MV+1GqOBtuFsJXocnTBzSsXFj+4MidhwbGwO0Yh2v?=
 =?us-ascii?Q?+yQCvH1cEz4i0p70k9zf7/s9Ak2qL3YAr9tdMvTrSMcU1hzOqEV37EO7UqNr?=
 =?us-ascii?Q?LXa3hTCvVKoAv7EiDtr8C45z2w5VRWN//nRvb/CpjvBgr7sqcTLrrxllVjPK?=
 =?us-ascii?Q?0QCfAgVR5Wd0Unrwdtx3VFoT6dYpga7Q/uSmC07++s4rhcJZiBgKmVJk9VO9?=
 =?us-ascii?Q?c542TQ6KqrqxPpYY1LFMxrlkdabtUvaNL5vU5o4EG25M/mNRNR+V4G+1rNO7?=
 =?us-ascii?Q?wAFRv4E76LyVswopc0W1qzqvq5yjVQ5KEboxpQ5Y22zmfp+7xiR81xoacE1M?=
 =?us-ascii?Q?odsIgB133WPicE9gnkmlzVBghxSyIAqBV68fFckR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140e31d2-1034-4a7a-5f1e-08db61717449
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:53:31.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKUWUGyodg0wenDW/0HwniuNCtUCLtD5UCmqMDSMFIw9EU8NhTOLakMO+GqXXQWVc7DwTxKtlpIW3G+Q6Rcmyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry. We
can reduce the scope, e.g. in mptcp_pm_alloc_anno_list(), we only access
"entry->addr", we can then restrict to the pointer to "addr" then.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 8 ++++----
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec892fb8d85f..082018e4b0bb 100644
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
index b06aa58dfcf2..3152c197811d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -196,7 +196,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	lock_sock((struct sock *)msk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4b5c5004f34..83b4cb16120e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -832,7 +832,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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

