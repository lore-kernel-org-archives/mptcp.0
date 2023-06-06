Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A81813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:46:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B14G86p5DRAyzzUW2bjpq7EK408VeRBNIm+P6ToKf0Fe+KhUyBiuGK8T5TWoD8/OpvL8cdo6bCtf6GEcvTVOFbDNHnWAtkO+ZtlMy996zaBD58gCLr5rh80ODuIX9qP5AgoV/ogBmcmMElkDwQkxrdtB2+jhuh+LXMmawEAzYJFquB8e+kQaY36QkOmysbleMb2tTqJzt1TwIxw7no2E02f0WOxHZgiTXkTpXjAI7dRiDmTDk1P/pYLlUiQ02LP6GvfYLvliPlQ0x9gN8/KnJ7KDXi2OE3QMZhDRZb7Z6y+QXiU2HWN/qU0k4eCDI6GbKvk7fcbyuUncgVSJfiTmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=fnKbZayevxa/pe/TjE3DJ5n88OHF8+J+abQIqDjWL0s1Xc1rQ2ov3hALj3ii9TLPCVgNKY6Qr+txWYWsFrOPEUyNA9mtxklCPkO7UAaj2XgcQUKv6+IUWERt5n0/g1ziWHtBpNjjw8woVT6A8TRifNCMyaPyak3iKGKNS99BtiFm5PgJwyYTVgtq5pJDmtw5a0osay9c6Jrj5QgN1HY2sOlRHq3PuGv5hwuQGeTVBb/Ax/9+H9i5ULEgK1eQtfzMyAlw/oFLLruRQFqPtA2CH2Ja2jO/B/GtNBGMDSsXoGRE8wFN/eZ8fYMy3lsKIi/9GT8uAtHuMDzFrPaD9BqP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=hk5kge8pb0U61uY5Y/Nlyjlytq2A6FGg5Ykb4ilmDOHzx8xrhwOwdH/TVUmVTfUJ9t/pA+vsrGyTbi09GuHWDNaWuNSC2qj4keQg7Cxu3P6nEMLoAYV8qddpDN+r7wcfsZywDtx1cHGROHXiEMul0OUSSH0fx+2wIPaQPfwDagUp8Up9/L32RES1KatnAxPkAB5hfex4eyjWx5vyg8sfFY5ggszTIgH1A2EvzwQd5CowSEY7NpB3ZZsN148CR3T19eiBCmmmcHIQ/MupKp+n6rhBcMVd9ITOBzQi8nf4ZAFQeunPfxaE/Z94aW5ffXx2omlOs/YsHwOs+RqJXRVpQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:46:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:46:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 06/18] mptcp: register default scheduler
Date: Tue,  6 Jun 2023 14:45:05 +0800
Message-Id: <288dd136623517b207b1a315030bb51ecdd0a829.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de04133-cd79-487f-cb56-08db6659abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qeRfkm3kfoAlhnSgvtAEr2zLgHZAHQKZrJntyoCOLSQ6DIS3Cq7vDYPf/sm3EVcU3KpRfD7z4tFW4p5JKahP8Xl3P5JCzjjNfb7X/U3Olh9PO5KuWUzqMN3/HEoQLeIpLe5EV2EhsP8S/FM5Ht6SKdgp9XX2td5BFgQ43gN7A/Ycpw5JhTZD+LsMwhVardaqYYCGdXqME7lYechdCeDvyQTmuBNzFR3CnnCdHuf+Li5sY7d0Th11ZjKodR4qLgl/KAa9aKJbsBSPEhTxbD32zB+R4GGTPiVjK6HcPQIX2DerA7Csapw3xlUH/3/yz0mvbWfXcMDMyQxIRPLZTlgUx7qiSt1fJ7aR7sxv7oEfYqzG/L5C+uZPbr289bU3RjGXNpETqSWwt0Sn3EFzqpv1gSsXNzD36xiYMr4sajLrm6xdIbIG7IOiIwYGeZUXNFSFprk3/g7qOfcFOf3fOhwZJe9bnniUmNfoepEFPeDejl4LfwIZyIZ93lnhjO6KD88bVBNs1y83HC3zMbtbWINJHYqgYMOfIUupwyIv5qZkfa/TtmRmBfpu6d3WE9PzFMM2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YAme0NBfP7JXBX2MdecdjYy2euypOLpAAZ1nbk11zZBUBAzmVrcl0Ti9afx3?=
 =?us-ascii?Q?Xb/C762AuTJ2INvPgQfyjDg5mwXjy6x12n6QUzpIS2fPCBbYz9g36z37zzIW?=
 =?us-ascii?Q?7+lxdj5E4IyJ3TyoiepcvXpRiUjohzZWqnQvn40++DXjSxVxCktccARHvdFr?=
 =?us-ascii?Q?hGACoQeDhP8k/Mik1qE6rGGoetm6qBB6wcrgcTAegxSk60UjFQW8xylSYAAI?=
 =?us-ascii?Q?eUST87wImmesy9xQ1fXIvkFupE1mGyWdOxqBm0sFI5PaQDBMo3C+91edJZ/+?=
 =?us-ascii?Q?Xzw70eQ4lks/ggkzJrNH7pxQRT/m2XCUKlQQ6J/nJmTXwvxhk8hBilFAUjtE?=
 =?us-ascii?Q?kGD4+SWsayyUJioSOlJdEhNxU49F7776ZMz3Z6DeuiRnvIWwg98UKnj7/CgS?=
 =?us-ascii?Q?45Us7aKhPHeWIPoyvnzBmYmNAceUvCKZQfQi9kwCmCfI7sqydp/zUOGSmcRL?=
 =?us-ascii?Q?dnhG685RuX7aZ1v7dTla0i4Ze0nvKoOlx20fqKgurLQNp0dzvaORTwMUx58t?=
 =?us-ascii?Q?rzZR/mT2QYBqntWpl8ruruaebe9UnNQIMEe9RWwt9WFgMBlBFBh5mEFuSAbj?=
 =?us-ascii?Q?OHV95ii4jQd8WPXMu/LPMZYh/7R5VYuJn82Rcqa7mFxs8P/Pe5LHs7Q+3Q0x?=
 =?us-ascii?Q?W4B7pIp+yiPjdOUtVXdEJB6XoYGZ0ogHwaaUKyqh2h9IkVai3sYZVdx4tSfr?=
 =?us-ascii?Q?Akj/MwEjvuwHkzT4R8xPgmdQajUjt5FpDAB4FYpK7LFJpBCqhMjzqCw/Uh9T?=
 =?us-ascii?Q?SJu/6NtFkW0U0fzJ6/cWq1Yp14EfuIgwC72Wuf2HsZyKG7p+HjLl7SSPAc3u?=
 =?us-ascii?Q?iklpAaSJbyke/PuxhE9BMeWswLmeZnG4ON12HWhJgz5DQNuqzOihEif76qf3?=
 =?us-ascii?Q?4cU7t+fi0BJbIhOE08FGchOR4NC6DkuoE0Mna9guuyYQqrSPaC1usZAqETdO?=
 =?us-ascii?Q?pn5V3pNU7omqxTT9+qdpppAN57MbCB6Db69l96rzAaub1bJU9jBVy2Jxf+kz?=
 =?us-ascii?Q?e1OyIbxpY/2ONf5AmE05dSZqBX11vQB69yH4MxzJO8ZZ8DEqdQ3HLQpLw9zA?=
 =?us-ascii?Q?jZYFfjxYpfoA7nlvdopeZ8wM6nhUWahchSak2dQPSACSd95cR2vxwB8nIKC9?=
 =?us-ascii?Q?7ryajLIynVsbT84kF6qsLwND9NDQCyvKVxMzAyGwE11B593nghgWNWiMAKTz?=
 =?us-ascii?Q?t2rPPd/q5ci7n0tBvStrAjqlSGiBtYvKEpydxgK2YD01UZrtARa56DwC9l4m?=
 =?us-ascii?Q?iuuV4fvpYTOA9M7sbSF0qzv6W1imlOHQnagIKH3P4YpV5lf4rDqbd5X7N26w?=
 =?us-ascii?Q?8KP29oLoBqt+LSAJU7heORPfN0WEeDJS6CPMBHp7Jipn4EbKXjvThcvh0uIh?=
 =?us-ascii?Q?YV3b5ocqw/NkC3DEM8SL2gJLFmov3dxPQQ3R/HDtPEtHqkP3NNnPWxKkWjrZ?=
 =?us-ascii?Q?d5LlGlCHV/DCamyVJba2X7v3hWTRMntdQbrpmHWHIpVyfubzOPzXxElV+x3B?=
 =?us-ascii?Q?l7F8OBRV3Q4WvevN6F74sVAzCH4pEBFhs1ww0BWeLpjC8E4f6VVugwgL5PyE?=
 =?us-ascii?Q?cDAoQklYml96SfsMcFP3EV6VjC7tz7JWaDX5dweq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de04133-cd79-487f-cb56-08db6659abe1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:52.7615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CT2lZgev8Vl7Z2aQx0+i/WBwosIPNRTFimxpQC1DLj/G8ZnVxWVdQKB2cSR62iALPPN83W2I83FpEwfluiRIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

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
index 27feabd92b3e..27407b48f3ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2284,7 +2284,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4030,6 +4030,7 @@ void __init mptcp_proto_init(void)
 
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
index a6210ec4ba5f..fdf2459a0fcc 100644
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

