Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627638E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:22:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9q0hjvlefQeZcj846FbLs2LwrtOZVSn96tdoImhqicl6kkezY8bVpTWR34APu4omG9JoiJGMXc5yxjpk3HbRZEPOXe4QSg/9Rwo0nc36lRUXnJMl87c9w0KsPpcR9rDtMRG5LsDQpMwjQBxc/raQ5vu8KpjlDcMp2qyr0PzfZClS5T4KBzkDXFPhiHgx3qCy4gaf1vcAG5HWvDw21U+UoJidHd1DPhQWTnblTlSlICiRfVc+2Rmer0lY96XyLUL6NcUdb4Zd1WJu7jiD8urJ9yLRKex/vMdDOE5ixL6c8WsVaqfoU3qyFt6/rFXwBa7z/14sg09MJdWrotOSMgB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvWciKlXj5nmj4I0nsSslTULol8yxLJERkEoqRzpmRw=;
 b=js6KB6e0P26XAKt6A4p9pF/PJu6b64sIJ4OorT5mkO8uhZwVR/Yg9iiitYBs9kTHO6A7yFJfbyIDKjCFvw+qYLkfIM2Ja0G/Kfsx/fLzGqfB3y1mRxOuqH0FX+p9y9dKFssdzKRmQzlk6y8yx4uXOh/f5g/f7fsUibCgB5x9jtBfeseZyCgjpwoxgk3srx1r9PUkVxhGaFLn6/dJKTQsiGmcmhaJT7W3vPsG18Jv9oD+wclEBdw6rCHXt4Iw0xcuh6cKyQX+3EBsjEiAnQAGU7/fFo7hjiwN9ZKBd+YF/QO4lJ5BAA3X76nmS8s+ReyE9AwZz7V4g7pR1uEQDjiSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvWciKlXj5nmj4I0nsSslTULol8yxLJERkEoqRzpmRw=;
 b=S0gIDEXSkokNZjQXHHqieC5o3CwB8w3vnWfG2eRrSeOyFfeAmOUibRTNOynXKSAAGYMU6CIEiJdWaoLrJfz04R/2qfJcylkH7fI+FJmp2xC+teMl9/FhA7hmrzZqImSk4yijBOm4Q0W9eSG0lKfS+ZU3oCatcv5Y8bPdtcitmryG3qbijoL0FQqfAMSJayYz5El6iJwHOOFN8DcUBTbl4PYPbsIj67KILlozLbmRHPCaJYDvqOw7IY6t2fSBRjvbpqM/bEVMzdCMtcGXtu9rmoqliz74JOkDKoswxlVCe+UESr4hHrKWCKVWN3knVtPzYhXxLb2h0B4FauOP6xlnKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:22:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:22:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 08/23] mptcp: register default scheduler
Date: Wed, 14 Jun 2023 10:20:55 +0800
Message-Id: <42e3093010109a0050a1c6ac343354a9e7d2680f.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e174898-d16c-42c9-8a47-08db6c7e3cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cjEpTKZzTHu/WrXFoq6Mu8iDjZCMBdHzkO97e82ameCmoICPUijwdugw3IZsSciOyvofm0FrGKBwfo8oO7Rz6pnYcUt74hG7gvyqUsZ3F83ouKpYNJGSFSAnsrfJcUF6Xt5zKA2YPY+jbwenLXHLDDpn8E3G67818DhEx3BlJcNMq9L+uRdzJcv8MHxXohQcDcCLAMVn27BJOVaOkMfQzXcL438Uxkt+gPOstxRIISZTGemZLOdOGOrhh/FYRjqmwHaItucQ1YNQAgrqzSSxINgsAbA6gLEKOsP56om7wnx2+0VDXeXJ9r5jRs/jtyAmtrk48BjWFi1TmyJUMAKBVUJeEW1nBq69hkPBNv86/z1V5EHiQpCvMcY16/GP3hbqyQFJzDTKkpEkP81ZCkpDMFEN9tzH33ZMlFZEiZtvkoeSMQ/8GFBTLiM+qkWHMCdMbXKYnVUOPObha0P5P/1uOftkOWGjFyzgsgBPy13yHAHIfH5Xk3wsPMLmUujgvNZjG9nrqTgTRfxpEn8tF6qSDuNhxrKBUuaj/KhRHWjTpJDcIsv5zr2gaGCg08vtHbro
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAKTmgcqsQqrzXUFKFlBL5b5K0GX3DdnUDoKDlu3HXcpVWaJRs2elwwLXtd1?=
 =?us-ascii?Q?1pd4fJoMni1zDMf+aiGdRweirQpIySghKON73AEnvUHJMX5QnQxDqh7fCPuv?=
 =?us-ascii?Q?CkcwR7VJFUP6Rvkzq3cZcUmtwvX499P67NLUU078EMbA416GoB+7l4L+sa4x?=
 =?us-ascii?Q?X0uatYGCcqr6JqE1RiAQmZ8J8BM/9NbJg/tkrjA1YSy0soc+kELNfcsWNC2r?=
 =?us-ascii?Q?RZJa3WPqJ7Bj2GiPTeh6E9sbVp9v52DnGC8XVFtN35snySaxrwDI/2mEk7af?=
 =?us-ascii?Q?CStKGeZL6p/N1sO2FnFLZI+GytvRJgmF5zogAP2lfGA/RtenzHdAi1rfQxPH?=
 =?us-ascii?Q?PNkR2JtMkP2Lh/n2txfIYQ4UKEQLk+AlQFBP0PYp4yK2zxGLGNahB497ckk4?=
 =?us-ascii?Q?pA3dLiC+iZJH752Jc66FRXaPiQTjm/1baIsGjb+Ql1G6P4OdeJ6waaRK/i48?=
 =?us-ascii?Q?IPWYX43FB/4qrQBaNVqyiSYQpC/JuqxZGeMa9lS34Z4yg5HfQwAYU6A5j73S?=
 =?us-ascii?Q?4dFN8lGuDR7C3e8DPjKLzNsburcJNrdhWlxpa4bfNA52i29olw65Vp4UvXSf?=
 =?us-ascii?Q?0bHDA9Q3nwl/7+PbzoH79YPdoUol1o1Vjnk43yIuvMzDxlZFXiYBC3G6Bi/3?=
 =?us-ascii?Q?8tB01ZzCfxWWi+mtf0Nd1RLKsqSBjrmpebvA1wbvcpniXzY0kf6B2jSPIU2D?=
 =?us-ascii?Q?AKmhyHQub46QJQMdkegFaw1LuiPfxjqgRxrw1M3ANCn928PQtny18M80sb7X?=
 =?us-ascii?Q?NtQV4qDfmvVXsxD1J16y7V6Y8Xbeol2ZCe/xXs9QSmoRGiEz+kl5VqFqx7tL?=
 =?us-ascii?Q?+wGcyyrwXQcZgAZzc/Z/ZIhp1StYa/AqIW6644Qy23myomW4pA6nt6PRLRQY?=
 =?us-ascii?Q?aqDnjZATf13uIcV+lygTJ3xmUCmUb1Vh5BBAuJQa01OulnMP7awJmMiadR0G?=
 =?us-ascii?Q?NDk+sqe5y2YbcwQ73wKHXXfO++0CrXkTEXr8E5WLPeZmq+qaixQPME4PuX4O?=
 =?us-ascii?Q?znM7vaUl/nhHGN8WJ0oK6OTly7bpF2uuQeESlBF19dwCx+zTtvgkkFcHyUi4?=
 =?us-ascii?Q?072qjeHEn9LqUDjvSbJMZq+q/sbSJHSMBnSuLMszJ9A9I2BsZvZcGOW0M0t5?=
 =?us-ascii?Q?qr49m3TcTV329r9tFIn8L+fZWiwrbVq16wfBokmA0F8LAXz4d80pbA5zge52?=
 =?us-ascii?Q?4KHKoxIz5JvfruFns5Mp+LN8+fmdL75+ogvlvx5OsiuHxwnnlTnaA/23vLzt?=
 =?us-ascii?Q?wC/R6HJys9LM8Cbh5pzpo9/ZCDAU0jqHI4uAFT/3kQMOLc03dDy9vvHiJbNy?=
 =?us-ascii?Q?paZg6klztaqqxJN/8xcep0qzjHywiCLOWRu5FW01z6DBwhJlizrU554VPO6g?=
 =?us-ascii?Q?jI4FClWR6LWZ2DnD6ay18cX9ju7t2/iZHbqvJNsk5wDWppVWJTGuoOQYNjA0?=
 =?us-ascii?Q?RHmL9Z8loQorKGtKzVh76rqojMvMAJ5Rpe6bQ+OaOIBbxF63kWCeZtdm+e0q?=
 =?us-ascii?Q?Eg2D2nQbXrPIDKGn/6RebLtA0n0nseNMQT+R6EyF2KRpHS+ffYStZgq5pdwM?=
 =?us-ascii?Q?NCSaigT4/mGIhCoAAp43YlA084HFxNXx1C5I2asD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e174898-d16c-42c9-8a47-08db6c7e3cff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:22:45.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZ8+aMYZDH1iUXulBIVeVXovs65DHO0oXxYbtYNk6lfiu0WayJBo7tmkVMbBPs72/rpNFQLf22DyYG+s0gMX5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

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
index 3ca15f8935b3..cd96a0fb369c 100644
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
@@ -4025,6 +4025,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f404a5e313ca..e41b76f16729 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -659,6 +659,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
@@ -670,7 +671,7 @@ struct mptcp_subflow_context *
 mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 50ef71b17beb..ba3922a4fe62 100644
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
@@ -50,16 +77,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
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
@@ -70,7 +105,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

