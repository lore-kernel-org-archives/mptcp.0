Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62736653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZXmBYwxfOIYg6SBaxXzizPjZhCQTvXuC6+z7tgp8UF8lLSoUwOlaLzy+m75mojNVlkc+lIgmGCoRK+vwowPMQ04kUk8kkCoYQOvQYt6vktrBX0kFS/mRE/DT6oElWN4Vv3cZLec7LkHPtPMVH3fknGerZQcep+56E2RFJf5TzEEpkcBji8traE6KGOwlj0rVtPxZ7HlAz5Cg7f8dZSMQcZYz6DaxiRy6T4p+Lblc8JrlsWvUE1+XY02qpfZdd1BGAmioHgajjGaMAH6q0MY0Lx50xewxBEWD9q/Mk4RGOWPXJ/uNBpuOat9tVieZ22t1n9qBQegoNIEs1lunk4QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BBIMtE6kJ2IvdvIdYAFb0srgiWrKSfGIzUN613Hhlk=;
 b=T/KMyWt0990K9B1YZ7Kqkw6C66jy3ijQwW1rwrs9LedIJav6RE95zUtIV3VBgYl2CZd8hPmHz4hnRLxYsLuiLWpK4TTyfT9J4JttYwwIOqzLErn75JZv5LKHS2cvTAaNKKbiJZ9eKMgSDcp7l9RWbkCCmXce2cyQkjgpKtNxvZXCHW56hIHabkSZMtWBtGd5j8XwV7FJ93+Q+6A3wdpcAF8wLBIxuDhAEE5oNG/S51DCj+CPyfuJ8Kdi28HWsy8QaS1ZA3yWrJtQtOr2AnbsTQUbSZ42soOB34PuvLV3yUEhZMZ7Tl8ywSEbHGqBw2NMgrf5+EcqE0bcgE37MWjabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BBIMtE6kJ2IvdvIdYAFb0srgiWrKSfGIzUN613Hhlk=;
 b=ZFqMdzDctp2Ycqs879zV50AP7fH1x6lFNSh9UgU3V+45biH74ccQEY/kaTlK4Xnata59Y5v9gS8W3Cw2AYQamPJUaLg8I2jHygSHKljuxQGiLowcTAOyo38s8Do1S6+fiLNU/a7AC3haG9d+XvL8VJ52W5jIuJf1qz5AAg1lhaffKzvzdBG6pTP/0q81g0zRNT/7GCtyInyEoafmoVBcoksMxU8h3pANMMoPPuZKRlojoaA74nxdUHXkfPVcYuOslU6Ot5ftJwOD1L31vzcIbXA9FOspAp0TDqFEj3MlxRSJK4AbEqneRYsuV/EvcjMSOZd8iuLR45ME9k3hq7SHFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:40:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:40:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 07/19] mptcp: register default scheduler
Date: Wed,  7 Jun 2023 16:38:22 +0800
Message-Id: <79599e28d8f7052cebae06d36b3caea183c525a0.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:404:e2::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: eadd5e53-a059-4f4a-6685-08db6732c8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4RehrmySMtqbqPlRfedekwxOe/1gqJb7fu2yTw39o4RHLzTH441u2jdRRw0AZ3I/FinxJfg4H408nep5Nf/KVQIuELOgdWI3iq6JjOBr+Z630ALS9g01YfgNkqQbaTHnmXUo4zZy+KxuKlJwlWvyuLJqtuN9im1UazTcwGw/dwKsthQVywX5TbrE/AsHyGAEkD/ZTKzeDqDgjhUrVueRlPSXlaVAwuwzVPVJ3T+USMmEm91nrdnc3NzgA5qUJ8tqSUalg55GyzcGLbNxoxlD13sX+lOQ0OGc7lwluh/vDkjqmD07LzVoS7buAt6O/uHK+cxKfuZaXXNXUdsGYXgQGjNycXG1qi+cAsALu2F3EqS8n4Th81hiJkGZ1wFbao8CXipffeiYVk0mA9FcNZ/ISf5jztl04ucZicQpH8a4UhkpEwoDh29zCPcjA1/TdV3gI9bxNcDY9bDfdkFr691D6/lfvh69CSXRWpLNlak09eq03kZYqvopVRHPcEGFfSu3gpDMa2fIxjRJzWmCL44NuwWGWWAfd4H/cxpziV3/K1hy98754A+xHq/ELEK25nHh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199021)(107886003)(6506007)(26005)(186003)(6512007)(2616005)(83380400001)(6666004)(36756003)(2906002)(6486002)(8936002)(8676002)(44832011)(478600001)(6916009)(5660300002)(86362001)(41300700001)(66946007)(38100700002)(316002)(66556008)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gK/sbdbFLWQAGS//bbeR/Vmidqbwc3Ba+uDLFG8nhJVKfYFczdAR4ystlR12?=
 =?us-ascii?Q?sCdqoz4P/IkL/95PcSlZ7nT0yAiraRXSpJRtvrDx3vypnmvlr4wMu7oEqQnR?=
 =?us-ascii?Q?W9kFSPUYR8PGX+KJdJnhCRjH2YuvWlphc2c7lkdKEkzVNN8jPI2Nau30tiEW?=
 =?us-ascii?Q?JMio2NRBPPxnr7HSjidFjsv9oHQ1raAzibwWDWgEmGWiuM8RJ1de7QWYETY4?=
 =?us-ascii?Q?S4NzZb0e9KXTZr2K5Eqvw1uXUxGYuIuxxAdIDB/LM/3EJrP2I3RlosFymXGd?=
 =?us-ascii?Q?RWaOLKoCIq2Iarl91kZoAZakZCrvYYppoVo5LEKX8NFe7j+9OiwM0zyZylDm?=
 =?us-ascii?Q?eBwuMRQh9mHkJmO0Mg0RH4H165CQECKK35IWRIV0wgdaaSVAm3E+Kl31QE9G?=
 =?us-ascii?Q?XDZBD5A0uOn+3X2GC0X4pu06uKL1wj+Y0BovJdu+qnun/64iKEZVXHHkO6xO?=
 =?us-ascii?Q?7J5xjNm689cXd0KW4rQFMOiKqkLJW3MjFUENfMkCqv2eP7EeNKFHz8t63VU5?=
 =?us-ascii?Q?V+eG2e9SBvi8Hx2Zir3IB7qM6bBOa2cMn+or1o4/nQJXu1+p801wYxCFZGmL?=
 =?us-ascii?Q?GdwpgJ4DApRcqlUQK0TpUqkvSLeokP6FyrbV2G8qmRI1sBHh43+3bWv2WQpG?=
 =?us-ascii?Q?4795s+ZhhOoS+LnKFnQovIfT9m+588AC9UbeP16GzSCAiKRxtZ4yzIEdkODA?=
 =?us-ascii?Q?kRTjMc/iVHhetATVsoPcBAIxS4bsNpBjulGFKgd5weyCsvxX7C7vgskri3Lr?=
 =?us-ascii?Q?x+Iohc+vIsmFY6eRDBe3FWnc3+mZJzLbey87ixIVbtMk0JX8LWWjHgP/nbnO?=
 =?us-ascii?Q?of8j5ht5WzfKiG9KU3sWQHNJQFSCCAXKLF6AmEMiYuQaio3KPMTzLyJ5keVW?=
 =?us-ascii?Q?LTxOIaiDepxe7+AuVsPq/yTFDWEkywHQzMeKf2F8i9VCvoCgP66TgOPTGlN5?=
 =?us-ascii?Q?XHOBV3nXOnuRo0dbRL3EfPl5mEJ3fcKJYVEzcdmb/PCQNhgbvOArzw1eZuRI?=
 =?us-ascii?Q?iT7HJVB8IusDWd3G0xyzqE9GHi844yr7BjQN9BarCUMBVIwA2fDHmKd6d8Sd?=
 =?us-ascii?Q?pUjOvbMVKZc6i9Vt4Le39Uerbxjc2NicFD+fBWYr8GkPzbAARfXsSUSKm9Zr?=
 =?us-ascii?Q?qlhPA6tCT+uUV5xTYYlH7zJv1q7tPZUifMjJUb2sLOnD1yh/tds6WjWDoH/w?=
 =?us-ascii?Q?iUrWUGDWVQhyLJWCDSKWfBWdPVKwj+0NOy4Xn8POXgHh9wert3s+RhIoKbKL?=
 =?us-ascii?Q?/qftCiySJZ3BUfbqCTPgyJTqYKBuNJ8Y53r1I7ygEqqANA1LsHcDE5wH8HZD?=
 =?us-ascii?Q?mPUkcLcI6JPZahbXllMTS11+ofyDqtksUB2oins8Kstw7IuVqLZXV6Tr/pBK?=
 =?us-ascii?Q?qROIGT/69VY83Sqtqo75PLhp6uj8c0VnrQkXY0y3wwzag217dQiPJbshTJ1Q?=
 =?us-ascii?Q?08qQtZhpbXrTBjGF+H39egBCQPpC86QMNT0u/+W+gVCl+G0MSYh2mUyqJa38?=
 =?us-ascii?Q?pMs934VUR1y7gKI4SvKgVv1pT4dJwcoLm+iNbwLVA1LJPY9Pz+E8nWr1Y9DI?=
 =?us-ascii?Q?q/anzX/lQBMK+tbRdHiFusmd/AOowCt77XMc0p5w?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadd5e53-a059-4f4a-6685-08db6732c8c5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:40:02.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3DW0pQvBOUf14/QvTyBl8ADI5kGDVbiU+wccUdJ1P16cYN4K5so58F5aHqEi3SBZqwpVoN4OMsKWtc5pPCEzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71fad937ea0b..4a17cffafb58 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2281,7 +2281,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4022,6 +4022,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4db0f8f00f4..12c8c95abf52 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -659,6 +659,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp);
@@ -669,7 +670,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 130e53ac2c55..195f1fc34728 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,17 +77,25 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
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
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -77,7 +112,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

