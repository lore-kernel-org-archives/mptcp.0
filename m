Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB220EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3bFTitWE9vr82YdN8eoD1RQdOFJA+RCH4L/0TorD/hly1A0vnA++DgLJeEMBI+zP/pNmM+0xOVwgTNAU9mk4Rgeme0XdD7NTic9TAa90E+MXjZNziFcPGbw0ypaFy8dwGlAg5G4lqxQUnuqidNjK6FlfNkt6MEi9zKQ9rh++yKoDlGJyR0Y7MguOOXHqAOEUF48idTJlDvfRYc6Kv51s2RItF9mCaogQLuO2WGw1wPQgiT45pGNak+af4N75YgHkbQ77nTX8S9oQunF/jtJDg7mNpctmULCvgGnXSxI53jvkRGRvDxdpVHD+mStOA8NsbjWqaL9ipvr9ukEj++4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVCf23pHbJT1HJQCQhY3kX8s21RFx7jKuR0SgHaereg=;
 b=RTpqwmiIwXe2+LAxWVSHAUrZskiqjuKek22h3VpaQZHVb8sbhwoc+gh6uCHD4Xj9ITzGUwLrZgdMKCNCF0nHZq9rZm+UYgCamXpmhridziEMoyqsM8+AFElaxLuhbj/0VrQWlUhryTzD6fkW1+bnrr0MKlUXyoqH7awj4GLTvxpcorPN2uPeXGVMfShPpwh8Z3HxuZkGjL73TvzlOfP8wrbYB99lCRm3/Q4phLwW554IzgdkQ+C79S2iEivrtVJ+zckPaetATfC0r1JcJJ7ACEmLyGhWHccsJXeLf+rPvOFqjMD3IcyyQ+IGwveLWbjLKIlctVBLag/VPYw0bSTmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVCf23pHbJT1HJQCQhY3kX8s21RFx7jKuR0SgHaereg=;
 b=KdpbJWbid6gCvTE9aNiy7IABkQ6hDHQLkwi5G8TAZff52oZArNPTMlclHF2g6zV6zyQJyoOPeTxG1fPGwaOxj2GuvcFNItw4+FSgJBLyFQFD/sODJTH9YAd9h3tPzixcR5zjUzzKyWHkxaXit2515vefBP0EdZVM4BCB0WPvzUCGNpIxm3bRrAnLn/lbamww/BuFTkWBmLC2CPBHDhR7jG8Ygw8tmUy2Uh7Ai5HcyBXG86s+MXA+Zads2TaewatkwFbGfo73wkmfgpK49TAPDo8P1h8Dj5tihCG9ijyHBUE52Jx3cv+ZvLal/tIEn6yQ4u1+BMOLFgQdgSBcJuOung==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/8] mptcp: add snd_burst in sched_data
Date: Sat, 27 May 2023 20:55:34 +0800
Message-Id: <cdf78d8e25872f2959a33c3acea3fd9d0ebbdc8c.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 404f17a3-4929-4fad-7130-08db5eb1c331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cQ5Ei6juEg18HptvUfQzAPa34qD18ZEE5Plmb6yAc2Y+7HdoRPaOGaQ5yf5mSq9jR5tD5+31YlTerp2ImNSPnXUDkGLCyM6+F7IpgfJIaYJems8jxR53V+zLUtWlu6WxAIK8j8w6kezc3QPr0UuDj7xd5ur9o0lJri5QXgbGCCkwm2cQ7QEwODu/p9Rrs9BAXPoXvvpQq24ddP+bW2clxdVp97JGDVj8BzmhiC/tYzgGSI66pX/MKmjHbrlkcoc1T9NfYQ7+Ag9Zdhpdd/THZTRMV+ZoIHcyGB+vlfkN1o+inUanCE2QP7nFdkPdZwySZwX7KoYbjwQo3yDd2KpZ6Vrf6Yftn0WRGNpjWu5X8cKMUSqXvhYiEFrDYOeh1P779mW3xmPzAsZwUGseahJMyBkAnlNctH8e3Ml3RLg+t2eI3kU1l8/EZNBT2dSfxUp3WglHjSoCR6OkBEiffmP0hBZZBxkHCnfJuPxBt5z+bhK1rQG0wzESRSm7DzjsItEXRbGp5NFruO/3ZFKYUYq+xnHYi61j5K+PPISSavNJ8y5opeSOKOYofAxiZRDNLxdr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6nLWWsoCi0RT8+UTbApDIw7nabpIGZQYso2YVpSIUwS+of8NZNk9R6lzc+Rh?=
 =?us-ascii?Q?fdfslDPKuWnndJM2wZMgUdZ2mDTSk16JBU1VIF1hYyP10fmfIl15NOrk2aQX?=
 =?us-ascii?Q?7i82hiAJSgnO+ax6JdkbLBP3hgt07pxvv7/T69va46I/DrLnQOrgiWKBTK2O?=
 =?us-ascii?Q?668PX3ZzJqjjuCU+oinTZUNwCg+58DbOc/HrK/ajpR124nKII6bT105VOOQ3?=
 =?us-ascii?Q?kpx0FYhRsgq4CCSD/GRih7hcZU43w1K4V7ymnnjcbigUYDvkjwGJsnNYHBOU?=
 =?us-ascii?Q?lsqSA7mEurdBB9Lu+dXz8R7ae506jzRp4ttFoEjQsdenK3OsONOgfh6m3xe4?=
 =?us-ascii?Q?q3WEwsIG1XaiUgBAv/PdX/d2QKygardt+MKuYFekapWZE6BkRxYEM8onyQ7X?=
 =?us-ascii?Q?xBd/56TUR9O6/kF66PXCgCfd4ERyPWMyMRMaTXoWrldHZMBtPrlsHm9UyS0c?=
 =?us-ascii?Q?ZsBxKY61hWnbSmC9OMIEZFDsbChtBeViGpYBs3APJPKyVEJDYc2yw/hr/Htf?=
 =?us-ascii?Q?JKoiES0375Irh1TCKoF8lpBEngDrTPUaNBF8129LQmVCG8QH5f4LHa9AfoGX?=
 =?us-ascii?Q?97fIoCQxINpzSm/LjT5SU7BopqxKDD6WkRvKTn4ayKOXIkjvL1k0CRg8J5Sx?=
 =?us-ascii?Q?Y91lj5/thiY7tK7eNEVoSHrz8G+Dv/JtKFvuZGiAIjmiy1nf51ob3Smh5MJE?=
 =?us-ascii?Q?qDAyS5GdldVtaQqFj0csAgpZ6oq/xmGgS90g+l90T3+BSMSkCbUAFy0zLbid?=
 =?us-ascii?Q?nxFJRaCglxAt6Gxxrr1OIltyxty7obpE9kNQnFW3amtKfckCj6MKTYMOObl3?=
 =?us-ascii?Q?m0HZynFmTC1lYQ3j5Pclvsl/ajP1m6orfnb0+g+TGZDwkJSIvTJqkLRq3RXV?=
 =?us-ascii?Q?jBOM45VMgkr4ICFmPGC0a582yCfMzefTPfH4sK8y7Q0L9GRjuk06KWaj1tBC?=
 =?us-ascii?Q?bj9CbQUHuDbAu9sHWE9Gb+Vz2qN3HWsVrEeVtMUQ/R1rDJhWFdog/UvkG45o?=
 =?us-ascii?Q?CN6E6+tmWrVu56PeFA0iUcp720d4oulSjRtZt/9VwlJiib01wKICY3nc73pS?=
 =?us-ascii?Q?DiLM06T6xjpx79BSq7h4iOTTI2KckpQVhVQ7KAeQOy+rlPafnSzPCF3cAUBv?=
 =?us-ascii?Q?Z2FuugefAzIWj/GK8bpyK7UzrZ3jxpontfOGs59GsWU80ZIWsE6ghE09DAVG?=
 =?us-ascii?Q?mNLwdYEk+LYhpj3Wl+UuHbetJxI5PDcBa+fHr3/PMQCYfoh4zBnL4xWImlFW?=
 =?us-ascii?Q?2pf5OZL+A0x6tA+RGEPQfqt6P/41NWmDai2UEdM7Yei7VaQclKkQjsHGwotl?=
 =?us-ascii?Q?kxVdb4suZz2NXfK8V90s56V2s9M3qy7uyftg5we6LTPkABPZNPdmhi1UbIxm?=
 =?us-ascii?Q?rEPWEIDaE72leTUsiHDRwWmjWMJWjzaVXeXFh8IzLLIvfan3KaofehK4g9Ke?=
 =?us-ascii?Q?CAtns3kueSTS1YbvPYAqybJecONL5EcSMe10I/EPIW5seEvPqK8IbCYU7xlk?=
 =?us-ascii?Q?WkTvPgrnHR9X/Wbg/m05lxNrYJ6HKO5cA9hvNGMwCoqjqAHALaewkzg64UCf?=
 =?us-ascii?Q?qzsO4PKEr1si+Dzv184zW1a63PX9eyugC3cnvyRE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404f17a3-4929-4fad-7130-08db5eb1c331
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:18.3657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqcKQvFslKkcwWMbwqVJ+MFNzksJ+JajbN8R8CcdThhMVyCEAYc/XTZOD9koOFEbzUC8/5rHwV9v2JeLdgXbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

This patch moves snd_burst from struct mptcp_sock to struct
mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4fd84768c5a3..d24f599b151f 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -102,6 +102,7 @@ struct mptcp_out_options {
 struct mptcp_sched_data {
 	bool		reinject;
 	struct sock	*last_snd;
+	int		snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 59d36b354f6a..83bdbd0a7bbc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1416,7 +1416,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1486,7 +1487,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1504,7 +1505,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2349,7 +2350,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 21d59b0875e7..760fdd888e31 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -659,7 +658,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 414b646dc9b1..e1c8548a52c0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -144,7 +144,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

