Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A65628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be2gIQIjOIFl4EVG7u6X5AtYzwBOD4mzvdHoGhZXwhfCqz0eeI0KL0RoVGFHspyzALxn5amsfvTnj8T5GQUFfMjK92y2bfB6Fn5PuUtGOOgaxLV4rIp3IzquVu+L1q4/CdnsCKrRNCuEDBjMXtl9nwdNKhiDsTkt5SCoIKLwkUdYRO9GtHzG7KSjUlo6jkDjxb1IGGCXImDaVYf9VYQGBEr+YBi15NqNsuiF/q1MiKpwjHjF/0cBkA6Cw1pUXa7R5Drx9t2H5KgpZXgle3xFGgcqA0O0W0zN2A18fyUyu3UOg4T6/cQG9zK+PNE+xdGSonkC4KSmUsNbIdAsopct8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4x6ilyecj7G59IAx4dSoeR0rRaK9u0Mc+SaHFNvT8ic=;
 b=QS3aXr79+nSG9e5txmBRAfNDWOTyxurVF8ihk2eQnLjm/BTCtzk+DiYLsnqGcwYUTOSar/keMrWX3l1klpxhMY0RlbALPbLrhfs3fAxqJvcyX66148IrmPn/I6UPA7z1gPHfRr0YRw1/t1t68l9s14NbfK9c4ktjHla8Ecpuff7aAu1C2RS8ky4ivU3d4RmvnH5ASeoJ3dKYSTDTB/juf6OV2UVTE7Zv8jJfFHzie5mloH3E/tCyFVAqFge9Q7Lc7GUfcnpOgQP8+Vx3auXDuO9JAfr8HYALi6nZzfV7SR4gE3CNPvGb5ApKa2e2zeMWAB7Wtg5wfb8vLL9VAkScLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4x6ilyecj7G59IAx4dSoeR0rRaK9u0Mc+SaHFNvT8ic=;
 b=LExYR385ifczbXh1ss5+uBpshz3Eah3DBAhIEHrzO1LPBQntavfPJQ26uwKmBAgMPISBH/GMEGb9hdB7CgJWnUY9t+LyjYOpLANTNfJBZm9S96QQFnK+noGtVjRsc/EovKPVO92m1UwyEZb43j9GpXEf0xMIozPbAfwdx9gFJcuvYQlF1NvvWMouyMYaTHhVrPN4uR3gIgCc0F5QmVhmsmxTkasXxQnx6If55c3dFdTMNio0WU+p8CMbkH3IlROLuBCVXeXNfCCfLc78M8cKrVbiT9E7EoyXD6kccuo9GgvIP8flVLS5OyTguv5cON2wP2wNwyzd4eJvm9D/apQsZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:48:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 06/17] mptcp: register default scheduler
Date: Thu,  8 Jun 2023 13:46:44 +0800
Message-Id: <349ae991a2bb5e70c82b13bb185665d3eeac0601.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfedbb8-2d77-44f9-e5fb-08db67e3f9e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nTj2iJ+1F4ViQnp5LuAUY2/eqzI1b8GrZw6VCJTVPnWqctlUVY8kUEFBX/5KPlyahVEfcbJPBFnuyVKn2z7Uoikg6t2ld1SYYM28TG9y5EhBWbMRnU+5cf+5EnQ7jegfnNYGR2uZY2EiQOXm3h7Vq0Ckivt6B3gg4Ff7dn0ncNsQMvYbF3mW8g9kTXhPNZuORV+RSnQu8WOD4j15IFQOEDEfOgelvnxwfxoCdi4+Du1XkYP9cWerx7f8KPBt8zXKRp6RxGiB+Q6qvHYfnr5968budazrowNa2r4eWNcTvWiw/LKo9n6g1VZBEIqd2/E23Aw4zQfR87c3Jan5BMXnjuFRs1twdfzKFZ93EFFhs92cZdO0h5TGtxVOWuRONYRJD4ExdRiEaNuJMNdC5E36SlfGWEhwCvEEr1GwZFiHVypANeRHM6XsXspLnV6v/oed1V2zd08MBddEJaue4lvE9rN2I4/nkDuIbYIzn50MqiNxvv+zpuiNZIhJb/1IxNmdrT5g2P3JULz6yoSkcklipvPJTlDI4drlNrXBcKT10WpdJC2gLr1fdqT2lqfvvBl/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P9y62T5x3HHmyLv5uDJ7x4kXRLIgDELKvCX0muElca7qf2jUtMDrHUl56SlI?=
 =?us-ascii?Q?vVcLM6ZCqYgu0gk5kD4nNX8x7qRgDltiHqVBKp35cJj+iOckmG6PFk1RsoxA?=
 =?us-ascii?Q?PQw78GpBAMv5nBC+wbetwLYr97s59UTgvzkc+oOTDfcpVY3Yfs+3Nzxdm/0F?=
 =?us-ascii?Q?sThd4d5vzcSRFWQuje3HUPKwXul8S73ZmF5a+abfAQ4POZfwLrN9+CuOc55Y?=
 =?us-ascii?Q?0jn4Yt/cZUJq1O/eQfduKZVka9aSlU8YJj26RELUZ/Ngn71aukDYry1Voomh?=
 =?us-ascii?Q?e3fW+y3SXa+J0O4Nt5LAg6TXxoeSKt6QX9BAn3L5V9NnUbygf35sQciC24nE?=
 =?us-ascii?Q?nAnWE7puyyIDp2TCSoqDOzoWqmfBIB4lamCvWdI944+nSc+Oa4f1+6qC+fW+?=
 =?us-ascii?Q?v9tCkHaWqolq8Ma8jiCZ3k8BMmDp53o/1fXCJGOZ6MjcH0eoXCCPiUVpTiae?=
 =?us-ascii?Q?hOOTtSWnPDNr0jbnIx+dP7hwd4Et4mVTGRxE0ShvQM8fHsVFgH9T3f0CV6GZ?=
 =?us-ascii?Q?xeW+kTPoijWSgfZ02x6J7MVqnlcJEXPYMUpwpssfCTKR12kELDvoMnU9bFTS?=
 =?us-ascii?Q?GeKCfxzdRUrcCckhFlZ2nGME190kFbMumm2tjEFa/aPVX6r2TzAUdrwPcO87?=
 =?us-ascii?Q?71tOobJ5Zhrn7VWZHFWGGPsixEP7Kbt6E//xIYjrHnhLoYMLXqyQ8STdnwIu?=
 =?us-ascii?Q?gMpV9DT5IN9qfDhlrPE3NO7Wn4kHgYPuHgQJzEuGw7dYOrPTkYmGgQc0podU?=
 =?us-ascii?Q?H8teUrhjyIJMKCooyWw2rzEVDofsDwiALgPBRWYytEd4p3+tfcB9GYzKDvWi?=
 =?us-ascii?Q?o2FoiySx9LkmAIduiz+tK3mdfTcH9JHv4Bw1ouVY3tRZI4jV0Jmwvj5krCT1?=
 =?us-ascii?Q?i/7UNJDy5Iu47WnmVJLqIlCsSLDWO2oOiTCOpYT0r2iRqe3Sa+aXP98pcxAf?=
 =?us-ascii?Q?td7a6P5uJo5XuVaKgg5eYuVo4c/hipH2ZmwH/He3dUHLm0sKaWRGs3aweDQ1?=
 =?us-ascii?Q?lC9Kou4V/mCIaN988jvj/MxnkVacAxWwUFpmGKQKa7y62+VMiiLHvNB5vO8R?=
 =?us-ascii?Q?jA7XkaysSBmc50pIe8c22KtdOO+IrcT/Lg111yvOHAJ7kL1VFCq+lQzTKdRU?=
 =?us-ascii?Q?Uox2MxlAl/c6QRRltfOfT6EBPxeOd8kKs9dUPrZTuqcnYZ0es+uwDLq6eXBb?=
 =?us-ascii?Q?APduF6oNStuDZhc/hCm4JYLg+xaSh/DAGlU2GpVpfbxa0wne1/5yVqxJldxG?=
 =?us-ascii?Q?VXhj0fWsZuKW9ss3eqCFUQgXNzR0Y4FH5iPevoOjSlZXtLfDxjt49SAjMpzQ?=
 =?us-ascii?Q?B1DbdTx6ILZGM5js092sARyp5U/fMH5vaMpfc74NHJcFQjAnbnfP+kVAKaJz?=
 =?us-ascii?Q?U27ucoR/1XGOElH4DAStKv8aNScjo8j3sEt9Ir1aPXIo4EEnIXOjfuWk3VVZ?=
 =?us-ascii?Q?AcCP7GUr57oL6YhEph7GUkfNJFZup4Ld4KNdT0fTg5b84yIB7KL2XqpunF68?=
 =?us-ascii?Q?3hXGi6Ra3fOpEV8vSSwAjj6ShfFO+ph0CfKmEl4RMlXxXjwNxeUxZPXEXQcd?=
 =?us-ascii?Q?+Dm6Rktt6EZ8NE7CDkdH+e8LBSGcFoO64NbvNo/u?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfedbb8-2d77-44f9-e5fb-08db67e3f9e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:25.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZqcIHougF5+nntkBLvSp7i5eEMQwI2NE1uiwHDhYilX0ISdflJSK9+3fXP8lUwxRVpU6lkIySuswYUd7Ey06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

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
index 81171d9f4aa3..a0291310d71e 100644
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
@@ -4021,6 +4021,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7d22f35a0ae4..f30af7891c20 100644
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
@@ -668,7 +669,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6ff4666a59c8..404be6cdb8a2 100644
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

