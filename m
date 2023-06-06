Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEB28C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKpYcljrvG1Sm52ppbA/SF95HBTb20VNHqFFFqCdDa3m9Y8XzqP00plZvwy0EuTeq+kLvNPLeOAOzceWoM8wBUy+flyxiHBk3sLB5hBehAs5ZNwoT3fnkdhFWaxc5Yncho3VQFZBRjYnSe8ZZEe/g7ljSFsTH+LtCgZInxQz9B3XKGGoqKWw0HkKwm9Ll9IwYHkj1nyBLw+GpeD08JARCFHfxHlzxlZfYuxf4xizbPlGFQVC/m7AFI1AOP03l355dXrhBnKe7LPCkgLavQ+Mbdn9VrpCJCVsO7psfP57tcORKDZ7nabJ7dSNQCIJpEXsRlO27jeomaXQNwf67HMNtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=T3tNOHJCLCd9NMPAM6HsjT/xvpx0GriX90VdxPLanps5sulRNrkIFF3wYdu7YKv2wfwOhpVs4Et8BsXSyKnpbTvJzIi4MxW7eSafjXsV7S+GUWMulkZqwhXtLU5G3Un8Ex3aS7B1quFxCUEej2KdNbVYLVZXcJsAqZV813r5zgjHJ4TA451RpEwRLHi7CD98xWb8dqvestZ+9zWd9+yxMgrm36IspZT8jj6IVpCRh6mOGAjqduBjE8tydRFg/0okwbEli1K86+lokif8yEA43P55ND1Q8FwROroIKkBTE/jKzvueiggw1PcnA6CU+7lJA7tBvWXkNAxqEP9fomt8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0gv1mvFKUIMpPvc9tNX5nkk28CQRKTkvJcnOwL4VHc=;
 b=Ul96iQvovwZXyVLYCB1vDLBCbHknEF0mLpeeKI5WNF8+iuWV+ID5pVuBm1x0my82GwxYY8USKRcuVGFRYl/Q1uPNTEAJ/ZkLE9hNyYcsgMBI8Co0qYht9DpiN0jeDmZSuv9t/FTgtlSiZSuzJgWFlZkqSyYiSCFFLs8HZMhNVHFxSAe31KFTO7vDB6t4vRMVWDHTbOsTnhtk6FOUrPQ365ZABs1m8l9Yh9PX3XKhM5UtXO3IuQMw6sd55iSSU/St23P9Y00BVjkjw3PvLbFZ9ipOV7uoz6bc9FCAodHnKaodt6+E6bBh8Zq6souFM5NQ0aWtLVUj219gqFfDaMa6cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:00:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:00:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 05/18] mptcp: add snd_burst in sched_data
Date: Tue,  6 Jun 2023 16:59:19 +0800
Message-Id: <3b72e88150e9189231ebdbd81b09fe4c65a1c5c9.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e2d38b7-bc99-4f54-f4b5-08db666c88d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69Ft/y1IepSQUWbZA+ox1hMABMgW/5EX92DS1v62WY0mVYokQYM4Y/CywFKyGDfRacKg1VXR346UPPsZG4w1oEkJL1fqtJAg7B9vX5fTn+p1QC3oCML/lUaN0E9y/fWyBj5G2UEhDlnlNVy9f3qZw54wB4O0gTKaH9HWJPqW9z1IDnKQWYHFLEvg76Hvkww238c6mwolECZNY4FRNeiPS7XTtW0LbMmy6r+ya7jUOUz0OgTav1tRKxuOYjqBGCzgOmeJxr0neFTrrWnfft9DfqJKLLwbf0o+WFwRGqU3hksTpu72AcD1rF0BaHkhmmccae2hn5vcYGeGDqSqoIVGAUEuk6nRNkMRw4llSWrIxheuPgRtyeXWB3JcUl5mRbOREXVtW7ZGt1mmljHap7OYQ/8F6pZpwhBC+jRLJ5p4F1MD4iRn+bG03ibz5QINxPVSoXKUaYVrLhOuZbgJeq7+b0QtQ7TmWK2VuK/YatPNckwQ3XgxHdn/HWuMd3YxbJNyVutbqUcfsWevxUiXIO/A6d2zrchMrt+YHDjFKHrMZtROL+D3eLZhgsCe2RYdn/LL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fK1xsxPl3FA7/cBihhD62rdyrWKPKDoba4mTL9H/gqplMOjOUWcfng34VKP9?=
 =?us-ascii?Q?fCd1DVuuo3eJ7XXU5Lw/ObsxgJh6E2HAAQ+7RwO4PTolE7fC8V6abeuY1cra?=
 =?us-ascii?Q?3RwZ0g1rrmzCTPrGX54nhIg+LvxCoDZyE/w6Fd4LfJODDXen7BSiIw9UHY5Q?=
 =?us-ascii?Q?5lpd2hhJ4L9Cr+lZET2pNt+SnnW/HPP4ZTYXilfwNubmt0s+upZY5YC6FNQg?=
 =?us-ascii?Q?IgAt8Mk2wc6BzGGK4iXjUnkMExtgqnmb5yAdWjWuTPDwtSGdCpP3CWlxxf7q?=
 =?us-ascii?Q?zCoonYb6cBweaPwK6t8WSlhiFNQ/33DL3y1ETShezgPF3f5swdoDtVQIDGjR?=
 =?us-ascii?Q?CHKS1UUI4/ole4FqMu5eBlUqs86HjkjTmSA7Rv35/NjlvuH0tGcXPYE4HXce?=
 =?us-ascii?Q?39wg09VCYrNn7vSshy05ufcxmJUcCZfU1VqJOa/oXwMW39+x+OpiftzG4z9e?=
 =?us-ascii?Q?inAjDyHz62HQGZ+DMqNz7b4521/t22r6sOz9/KKGgpbsmgr1F5yB9gpQvY0H?=
 =?us-ascii?Q?IpdW/RqYiwffUxt1y3u//jESQZY5+pWPW9eNpO1IzufEaG8RoqsYKaIhQiqn?=
 =?us-ascii?Q?rWo+XyEFTv5s5ZhD/7s3Xc9Ewrr2CPSo+8cXtsJd+WipDIHr7jSNH+L8Clao?=
 =?us-ascii?Q?pQH5QZvnIAx9IXBnE1FPS51wZ/LpPcDTB/GFcv4YTTLCtvqPS8SnK1vGSRSM?=
 =?us-ascii?Q?CzCeTsuvda9iRNBKZtVEIvBmFYwLuktBy6bwSpZtDk9uIrVD9bXv+ibGHSSL?=
 =?us-ascii?Q?tAvg6lHMu3vD3dP/HiQymTfwgKY7WX9P49QzCxVzwVXCzJN3VH6cOY+eyW0b?=
 =?us-ascii?Q?NMwsIkFazC+8/w4no9OIlB60uVp1mCXan5KrQFXh/AnOOA17YzYKHFfAv+b7?=
 =?us-ascii?Q?9MnN6a18WVNUM6jh3Fv/rUal5lbXYPymBcfSwfqxZhO9VkJZL3gVF/UtSIpg?=
 =?us-ascii?Q?8JVUJxxS/5ptO/zWgDoU0T26yTJIQUW+qBuTYfi3PdadLDi76RaD/BBCqm7/?=
 =?us-ascii?Q?U21JqhFd8HXdS6qvFfkinF/vKn0MiEKDChTTHbtZGnvmwoKy52Ijqzjhpwk3?=
 =?us-ascii?Q?piwD9JKGDqiu0swtyCIaZV1+/veoGQlM59peAsHgSh687aUHtYxAsW791Bjc?=
 =?us-ascii?Q?x1Lf5by/oUMiuSpUceGigymw9xefA3+yRcISyLuzKIolPcMZ1A335+ND6G4u?=
 =?us-ascii?Q?O7ApJAyb9RHq+ZPpAcdZI9P0hyeopXxITmLnb6h7//AISKePWXAN4xwzbYQ1?=
 =?us-ascii?Q?HBBsWd2u785K0XTazv71tg1PAYuZ5XOONKfkLhwwMX4l6TxWCyUvgHp3I/mY?=
 =?us-ascii?Q?3pt9t4YY4iQDN7i8q89yJ+vIgBqHmJIurkTBzNcCtl6l36iajYw6dSbycL1a?=
 =?us-ascii?Q?ZLRHBDGl+wrikxGuNRkvAI7PXlWodAddkfge2TDFF+qAHrLAhuf6pZK/vZEX?=
 =?us-ascii?Q?iZCUe5yPM8vTs9f7A8zUfqLEIoT1IL+lncCGOrDY2SgIK08hxzg2VLg8cUqy?=
 =?us-ascii?Q?yHfB8emv+elXxCMYNB0JRORWsHNgfrrt4OJwe+0/+BBxPnXP0bdeHeWCdDAg?=
 =?us-ascii?Q?RjNI2kcPs8wnfRG7Zab3dOZqJ8UG3mKTeuOiisdd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2d38b7-bc99-4f54-f4b5-08db666c88d9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:00:54.9673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sD0wnGGJPvwATft+dzUL7Mtx9dMu2CyUVBviJpKouNN28Ff+YDnKfAcUoL79mTLMRe8G5b+dmXIhkiefIEbkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

This patch moves the member snd_burst from struct mptcp_sock to struct
mptcp_sched_data to make it accessible to bpf schedulers.

To make mptcp_subflow_get_send() adapt with MPTCP scheduler API, it's
necessary to make the msk parameter of it const. Also an new parameter
sched_data is needed.

With this change, msk->snd_burst should be replaced by
msk->sched_data->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 11 ++++++-----
 net/mptcp/protocol.h |  4 ++--
 net/mptcp/sched.c    |  2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d52aeb8b4485..fb4e6a59afc8 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	struct sock	*last_snd;
+	int		snd_burst;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 42adc14a073e..27feabd92b3e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1414,7 +1414,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1484,7 +1485,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	data->snd_burst = burst;
 	return ssk;
 }
 
@@ -1502,7 +1503,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched_data->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1555,7 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched_data->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied;
@@ -2355,7 +2356,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
+	msk->sched_data->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 949f46d4c710..a4db0f8f00f4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
@@ -668,7 +667,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
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
index 5438a86e897a..a6210ec4ba5f 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -149,7 +149,7 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	if (!msk->sched) {
 		struct sock *ssk;
 
-		ssk = mptcp_subflow_get_send(msk);
+		ssk = mptcp_subflow_get_send(msk, msk->sched_data);
 		if (!ssk)
 			return -EINVAL;
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-- 
2.35.3

