Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00047.outbound.protection.outlook.com [40.107.0.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9157B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhqBzts0YCX0ypRZ+Hq0Hpre8l1jU3gdWsjl7l+bZC8CB4wgToVIKU3JDZhnC8cz1IUIdO5QDVjVSl5dhGmgUINOJFZVfAwMI/BEcLlPrwRsCCLwINoB8+LFMf9MJ4D80ui1fqoM8DaeI419KiiSv2AmK63Cm760/azkyP1ehn0s5tXkJhBi8ivy8nt0RdcPaYnLMWQV9fWrdlf3rbYBVa6Rudi5icvRANPAn1cbbZ33Odaismps1LaKxo3lIq90YXdTuMC/ZSTsklUpbaDUHq4gqi8BxxaUevrn4xmWXFb2JqcpvABJAmnCSTTeFymLD+O8IObSNxSX1WwCcE2ujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYZ3yaQfWYpYCN0UWfNREMFoQlGYUicica0wmEzwi6U=;
 b=anRhjkzk/9QKeLFdsNSkF0Xo4fnV368Z+Zjz+g4WXNQQKHyZGI2ks0SVClZIyff6jFKtepqIxODMuxdRpW3njn5fCXm1+sSqVMe9nBfXEV+ojzDKi9neLgqIyWTevTLDmxxoLP8L8BkTm/aF5GC/7Vuh8J7GesPSYmg1V7fx2gRjg/idWgod+mPuKKAJmNmv6dbyah8iQyL/P/77UMlE2EqLJ0FNySSY6zZzy4G4Y9EuP/MxjSaFJfvSssGlFVQ6esoTdn0Dd+08vvGx794abd3tbJCSOH1gu9o1OCS9MqZdwRViMsNVVjC5LfRKIizY3rMIvJu79HDI6KgCh3Tl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYZ3yaQfWYpYCN0UWfNREMFoQlGYUicica0wmEzwi6U=;
 b=H+LX1DRUfwZvjmhuq6iJEzi3fvut2OlFybLN2aG7UGENOoXJQYfNRgNC8CQ+ARqXzOKo1ypklQQFS2LBMTYiq908CVC1UBfRJFGABVHM3CE5XuTsT8JTN/Q/EceGuGjKJd2WAvc05P6NpYSDC0ZE8olmdcv+hZy8TCwjWItOtj/9dVnQEul4YzJKV7TWm4pC+ol8DfR3hSWvWbOblmFZTby+6itnSb5nCMKFXdV07mkLx5fVeywr/kRV/t9o4idPtqoJnR49eoFQwaQgWdOlzeqnqka8hnSyxhEWIdIOe4CVoHfqqSH7wvXntRuqdnrPihF0zdIO34DF2bqmlI8aJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:27 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 05/19] Squash to "mptcp: add get_subflow wrappers"
Date: Fri, 21 Oct 2022 18:59:57 +0800
Message-Id: <f52da9fd7a2eedc1d92151fc37b93da73c829f38.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: b994cc2a-ca02-4708-b338-08dab35399a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v19/AQdMAtLvwPCHvtqIiVhsk1H4sLn1KwK5dhCSXc2d9Rw1pVs0aX4TtyBXpHKcYWZdOdsYwEsq1wm0KNDlST6cjTHubEIikkcWsJwu+xsy1fN9IDHuFCRtBN10vqigXYYuTEeEoEm93Mx7Ys3tflxckkZdqLS2xRQuhXFR2uGJBmpBGzIYW30K95WFh/8nrBrxnEoTKLBjIAseLXYnsvsO9k9ztMJseTSGftd6P1AtafPyldbeCCEX6y5y2mSrE5ZXuCXyTY7YJYuc8qV2vyQHtn3tfZ08BlgfdbT6GV5clmX9P/m8acaHfjMoh8hBD61ISmtRbarcF2reqA3DDGYwcmFbfeZfVe6ZJplifx2YP0be9HY50HYOZnRJDGAhhlTpuugbqprxIUezoVf0bgZjIUHV7rD7usGNCCplU7mp3+xWPR0yd0Nn6YMAJTCvq8seIf1HVM9yS6wmZzPDzWXxdezHQ0UHdluuoc2Tq2Xi0f80bnYjErPbnx5coA/En8Ha7gC/K9KQb5q4MzvoJ96JJ26GNy8nW6KiSr8UgRF5oa9Bkdhr+AnJmuS1rmM79OqfshZ5Oc7MvTBR11vJgFXSTAPmYy6bN+D/Ggce243Zf6/EAuNJ7sGQ4u8xDpSSAS5gOZsWDqNUuD1nxOAFZ8Z44y7S8AGh5V7Dhr5UqddsYhnW/2Ed3FcUA25HPU34Ljh7p9U3jJqzIjtLyRZAiCDF25pd+0n1yjODl8zIwaW2Q/Xh67kx74+YafaETNcD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J/5qVyG9cxbHJEZwcbgSwzivhAzr0ZhgkIAWhCYHCxV3ODFbWegvc7YOdDzg?=
 =?us-ascii?Q?eKUSTeeYyE8kwXmawFmj59we5q1ti3BqbAc4zQBpcRwfz8PYheDvGwkQaUk3?=
 =?us-ascii?Q?SFh8ZAA1pO/ca7b6E4HHntnYRaWXwUHXFFexRIb0GlLQy8sXPQiXerDAMIGJ?=
 =?us-ascii?Q?H6+7WjS2ZjomEkz5b9hBqzpDI2IcBlJeUoK7Na7EHNSXNr0fyisSNxfc/dCC?=
 =?us-ascii?Q?wsaDiEL+7LRHoZTebCVQBzk/Yv9nLtMmydGwUVt23tLgb4EuTiZVbzwheD8T?=
 =?us-ascii?Q?Vx7XEoAUwV+0+sijZL8CoSNtDKEmLDIt4zBvpewxbeEmtYuSK6H28BUtqkAm?=
 =?us-ascii?Q?txFzRCDWykC2vcXsRHe4CfgBmNgLpYD3OLPCqcJmZzVL1LA6mDHGRtEVi5j1?=
 =?us-ascii?Q?hVyE0xvC4mHHhm8lqYHhRIEnVms/VVBTBCxft94i7WRz0e80FF46F7gP5k/c?=
 =?us-ascii?Q?BP2iV7ea3I89o7PLn4+o54I7MRYxf3n0d8MeN+XQ4ytDYPsYmYF0wtt++VKn?=
 =?us-ascii?Q?y8IzIh2tU0KQu4wxYuzRL8TPmQ8S6IJcOQkfcrxGBIJYCJuc1nrdktX0I0DL?=
 =?us-ascii?Q?WnzBHGNqkOLRrCyD6cmrQ8wCTu5gQqX07eBaQAm816kNQQk/P3uwrmtN86P4?=
 =?us-ascii?Q?jz5S5NUrZp/pbx3q7NpYB6Mr+2Sw2/cY4TWJrdqtZUHF132r2fiQZrT38bY9?=
 =?us-ascii?Q?1oSltnxVO2vVxKzRjyaELXhOZ6t8v7Q6Zyf7Z18Ia26jNuTYYdzXu5j8TcHF?=
 =?us-ascii?Q?WiRRXe8/cP9Om+LtVql6lavi0AfqDjb05MCKMk3/qgiu36Zhh2MQVIn3t9Vr?=
 =?us-ascii?Q?NmebOKL1sZJjMZnJP+3qSXHasPSHLE+8lxfmZc8vKQ7q57uyryrUySe2EwP8?=
 =?us-ascii?Q?kxRC4V+16OQd0D+LqhTxfvMkrf2XJSMys+payAXjT+HRXAd/U5VL5cDuNi4n?=
 =?us-ascii?Q?qFcVJDKjjrhEtWpi3gW4LuBJC1w+23PCgBCdR65lHRsVCcvpFsC2tEyMk6K0?=
 =?us-ascii?Q?EJA4C6QKC26Au3OCCjaeF0j5Rhq63p8KhoQfcVqWi0eZnzv7LKDawpmj2l93?=
 =?us-ascii?Q?TwENARsBXh0yPpgMn8lu9tSFgbBpcpRm6zksL/UJarygxeV7VD79zOaoOnPN?=
 =?us-ascii?Q?clN0O/B89fYV6oZwOX18PfavBoyf7+Cgzagz7VO1qf9SeufuWMjF4mOkqVi4?=
 =?us-ascii?Q?UZ/zzrqmFrFAiTPjswYi+hFBgO4EflH/l4rsYXG2KBYW+HiqkGH7bVgtYt2w?=
 =?us-ascii?Q?/kgKJ3TFRTbF2rY3XD4thJBmBxaNNQQh0xLEu63Z5pLIhRhNX5QckxSPpJIB?=
 =?us-ascii?Q?TJ8mrCFw3lJ2kQM/w8pywTs2CscF49LNicttT9Ri5ZYW2h+AAu6ED1yoqJbH?=
 =?us-ascii?Q?U03y8AJg8apHRnBTHYMac4/0i0bKv3xwbMxzrG97gGnuEDjKITufefhcbrSD?=
 =?us-ascii?Q?4+PsJxQbR1BLbsXiQjS/oKvvXA/PShlkrm7E9dNyuh8yfUddmUkfJDU0NBUS?=
 =?us-ascii?Q?V8Y3cnouiR5NppXqCyXRLkWY3iCHD+l4M7iMpg1cT3Q7FcPm7uaVHlAaSldS?=
 =?us-ascii?Q?9SHaj3ioyl/rf0kzNZD3hF1zOabwRo91qNScdNTNu3l9i0P7uM6MemOPthZs?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b994cc2a-ca02-4708-b338-08dab35399a8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:27.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6VXZqoleYXUkSm+cxWmIZBpwFRjBdCuygU4ApKTdGgUmKV57j9ezHo14xZoAJg50pHiMZ/Q9fdY79SwvXlClw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Please update the subject and commit log:

---
mptcp: register default scheduler

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.
---

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++-
 net/mptcp/protocol.h |  5 +--
 net/mptcp/sched.c    | 94 +++++---------------------------------------
 3 files changed, 54 insertions(+), 90 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 594206bfe9a5..4ea12a2e1f96 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,7 +1406,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1417,6 +1417,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
+	sock_owned_by_me(sk);
+
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return __tcp_can_send(msk->first) &&
+		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -2213,12 +2222,17 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2296,6 +2310,32 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	return true;
 }
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow    = mptcp_sched_default_get_subflow,
+	.name           = "default",
+	.owner          = THIS_MODULE,
+};
+
 /* flags for __mptcp_close_ssk() */
 #define MPTCP_CF_PUSH		BIT(1)
 #define MPTCP_CF_FASTCLOSE	BIT(2)
@@ -3879,6 +3919,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b4f4443fda3..e3e113e7f957 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,15 +633,12 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-int mptcp_sched_get_send(struct mptcp_sock *msk);
-int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0487206bb832..1ff2955c6f26 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -15,6 +15,7 @@
 
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
+extern struct mptcp_sched_ops mptcp_sched_default;
 
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
@@ -50,16 +51,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -73,7 +82,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
@@ -97,85 +105,3 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
-
-static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
-				 struct mptcp_sched_data *data)
-{
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	data->reinject = reinject;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-
-	msk->snd_burst = 0;
-
-	return 0;
-}
-
-int mptcp_sched_get_send(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_send */
-	if (__mptcp_check_fallback(msk)) {
-		if (msk->first &&
-		    __tcp_can_send(msk->first) &&
-		    sk_stream_memory_free(msk->first)) {
-			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
-			return 0;
-		}
-		return -EINVAL;
-	}
-
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_send(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
-}
-
-int mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk = NULL;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
-		return -EINVAL;
-
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
-	mptcp_sched_data_init(msk, true, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
-}
-- 
2.35.3

