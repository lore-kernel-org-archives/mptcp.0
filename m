Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BD20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1JUDea3u35pK+b67ztNT0z3GiPoCZ36mlUzo34oiEAwe0zdyjj/xRmfY8RQt9mT+TvlVgotwxqRiNO9LTUFrtojG0zACz69sI0Na7XNHFXPt7Z7hbhatOqLluMKW+fYZGn/9+bUyf300onrXqk3jkn00pwnWlrfyEy/PcjDIMYLJj7EvU2GKKTT0IJ/5cIPavJU9zo+gNO8yXhg2coOXPCPRlNu4WeMJzoFltmQohSmH6RlSFd/ObvuTsZ8KbOsZYe3nlV/TdqgLulH8usFkKRh9xa8TLqClq0Rdk5uUSfqQTPnsSHkJtBMcutYbHxx0FqZOmugkZDjFFDnqPhSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Vwv5BYX8jKLSSrZ/QfAEh4OknHdTPPElyfStic/MXM=;
 b=Jp4D+Pn7KZL/rHlHD7nOk/u0EMSR9j2QtDegM5mKikDIsbnq1evTvd81ov47aCYamT+nOP5Q60TyuaxSAg/5lIpGWXLAz+GoQChhTif8sSNNidmJwGL3u7OW7KGUYVzCxskhW6M0GM81OmhL5SSM4Ta7Os7I8lhPCYoupB9DPJw/lPRPDAc68dlLO35nhdZaZnOnbEJzDJLs19s9nPDB1TK7YT7siHCngGOSukPTPwteIT9u3HPGbYtsnPtt/nI5m/1nOXQf7mMpIAfoqUx7iyAg68W6gjHeNn/JAX/xZZXDlUcQoBHDxG34vWgSTBRSAhKToY258CU8rdLCuZaiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Vwv5BYX8jKLSSrZ/QfAEh4OknHdTPPElyfStic/MXM=;
 b=hL9sHiPr+DGxALuJGholgjO73iu2kyNJ9YAu2+u+mr6WAI84aBTjTCcQPMesHm7Sl04OzcjjZFLDEsCH3379zJVreK1eQxAXi+DSm/W5HJozA4cl0Qh1MQeYAalXsR3+uU4oT16fKbAV6ob17Rw7UPzRPgCxhKFvFlBx+PrZFUDz8mTXnQu+swxO/dT5lkGMm7WiOOFwAv6DIG/RWDIxxSv0GCTxzVckEq/inK1m2vEywUz8ITvwbG8YnnoX1MrH6PTEhIhfT/Kip6Sflxw1zWjgzsmboogRUMxkzEmkSwmPOM62o51m2kziaXEh2FWh3uagov+mGjy6Si+IPp8m5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:34:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:34:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 09/15] mptcp: register default scheduler
Date: Fri, 14 Oct 2022 21:32:16 +0800
Message-Id: <39bb9f95dc6bb94f22df5522b46f427c0888b415.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8788253d-b496-4f50-f3a7-08daade8c68d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Z8fuIKcTkua36dTi2AdKDr0pBPMkcEdeqIgeSb6xCbZRkFKlfCorPcnujTktb5ezKbPDjc+ZU2ABA/ZWw8RneOkQJydM5vQq3eJT3SEHFZPq4mGzYC9jz4xy5ULaWynqHMzHiwGD1wZ5mgUzi9HnxfDM171nxdoG0vPvNTL4mz/7SyyGvwYLijyihRVd5swWVYNTlJl0+Niug6McGMZ9BjbLSvHjApgJu0PA0kG8jKcVl8yL33sWgQ6qMhGL6NyfSthR2oCIY4d1ZJL5/0Jkz6ImsUYqKCQ9MW2Ts+4GSHSk768tUqDghyN+UPB4h4pLiWgNeW2RCReleWdYT+ZTXOP51lskK06+isoY+LOUKPC73ZC+RvA5Yw/NkeXDAjSudHDo3eUIyWnOICa9oPGyUW3ttZswscyJ8uUvCoVH8kbI1xZpGojaC4pRlimtcJYZKcBW1dLwSy43JFtd4C4WpeHYEKM8sP0MtmTR5nOymKclryORoXPYnOQGeNgv7S/ZuF3QmuF6zPV4Eu4Ne/Y51ER0rR9gxWLDQ8fBZnHmXjJ5jSzH8+uUj7VWkn0PKSMYu13ltycfE2JdT9veT3ziIW9gk+vG5hQuxnMWzIA8A698xpPUtaQ+MWPymwFH6KJUqmew5c9nYOeCm6b06rYd8Lime0L3ly1KjduE0mf9VEtoWA+lXXrNPTHfX9uQPSZKBlJk/BAvK68iBDNhhUJGDyMRUSh/2oLq5Pzs5qhS1fZKRElhUy3+TaZwijIpsjZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gAEplqOcihju9/aIhYzPP+UwXpo+x8zw3jzEw7iaEY3UrIqhuXvMjnMHU0yy?=
 =?us-ascii?Q?oQb9JzdC+c8X+yeeF43IIqvG+gbUaXTN6oyCqB1/0F9eZXcc+fLw1a9Uk7vU?=
 =?us-ascii?Q?5oYQXxMjF5nXE6gJ+LrRL5rgPzB3czOYVJubNGch3/6T2lvbGXy5Pp4ISkhr?=
 =?us-ascii?Q?gDmOJPqIVfAZ9LR5dYrEnXs7CVoVveZm+1eFwDDREWuQIwXFGZGEqq6gFeIJ?=
 =?us-ascii?Q?LGndNIQLL77JnI5zVb0YjAotkYg5yOOa0P/yFazwdLRtGX+ttqFEWgmM7Unm?=
 =?us-ascii?Q?Vie1Fe0AY/fEq5OGetOZtU5eEv6XZDO6bmFQA2fCgF2TSbLb/q42BZpuwlAG?=
 =?us-ascii?Q?y3/vqA4I/aUf++6ilQi8DVJ4mqNgYVt7HQrfpspAc5Ukk+PQhtrdBVkwZxKV?=
 =?us-ascii?Q?SlIJytblUnjgctmmGQDnz9zAXvqJm11BRGQE4oL9lwpt9R6vtTg+weT3ypQS?=
 =?us-ascii?Q?AGSPx2Hmw88QRX2zFIiML5797E+flAf/6HZeASTjlRS9z/+bI0abWWp1WIGX?=
 =?us-ascii?Q?H8cS+vx0BShYejcLICqQFh47M7Lhd109HDoLOCRwUT+OJK5hTpv6c+gYrs2A?=
 =?us-ascii?Q?C+ZdAw02zgDoEeY22aPntoHxvh25txo1KdWgsfOSYw8Q4ij8wOnNKq5Z0lqG?=
 =?us-ascii?Q?2tSfYziyb+64NvXMsBQioCOmceBIUkkK4G8C3YuhnIJ1zHZFR1AD/a6A0Z8G?=
 =?us-ascii?Q?8KQI3sn2Kzkh7n6JDqgcBqzqQtRLKTD3jLXgRsm+ZevsU+QbP7HTMiHKmcdq?=
 =?us-ascii?Q?ACUu+DJrNgn4Fu0v0UpbrO/iEVidTGjFi466D2aRZDUgr6N3tw6qcSDNZW60?=
 =?us-ascii?Q?i6XMF5uoSrYaKnUT8s3CZH1vHpNJiz33f4nRa0h+j61ZSlhpy0jbDuBmcKjm?=
 =?us-ascii?Q?IyJRxqJe0X5iXZmnvdmujd6kU8K8OsMxcVZxZCWSgMtvOjmzRwn5V7gFdZwu?=
 =?us-ascii?Q?hNjJc8AKdTyxy3VxDbt8DX+s46hVNsnHw9Cpvxeyu8z+6lAV2SXuwXMZgHpu?=
 =?us-ascii?Q?2zEJ7EvHa8yDK6jg6mTizaWAVS3M8rsGA1CxdMeKZPVnQkdu+/KLy5lo5JJM?=
 =?us-ascii?Q?r8/cfLE8OZBiWdALLAGZpX4Hm1rXAg9FtY6O4viy5bPpIVG7IPpQcF+g3kAV?=
 =?us-ascii?Q?MHmdARn87B9DTukt7NXNIMg19lOgnAKZs+9t43IEePoFCHlH8+igrTidnLBN?=
 =?us-ascii?Q?7ogxGm6iYVjwGp/6wEGgqAkTbJAzA8IMpOZgQ4ql4MLuJqAkZeFKI2hAcoYG?=
 =?us-ascii?Q?7oSBmI5gU/XWK6FG3rViEimRRrsMQ+V/3kE81bDDL9WzvE9UI/vDUON5GnC5?=
 =?us-ascii?Q?VwYpmwpxVRYXni14a43U2QQ0PbXOEoI3aioGlon4vfD2iILFV2DmEtPjW/pX?=
 =?us-ascii?Q?10M0DTexujl3r3jbYSOHDzU1EeYDV+iW8g3JnRTMudArKRxaznUOoWvmMaH8?=
 =?us-ascii?Q?lcGp+eKGhl0B3nVVq36BkEJ4C+nT0g6U2j2V1Uxl5BtklEX+1Idq/CxkF084?=
 =?us-ascii?Q?6hII63+JL7Y3W3g94JAnsyN70b7vvtXV3bnyqd4I6uO8Lsdzyq7NXJd0YTlu?=
 =?us-ascii?Q?rvX8GYtNY7KgAAWu5YPpAoc64uxFcYtSPaVPvgW6h5INM+SIVbjRyoP082Eq?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8788253d-b496-4f50-f3a7-08daade8c68d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:34:10.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXfQz+FHNV/uSL9GAxU7oWPchBcDTP58ONV+dczt2uY7XBEjZgzVyxcKW/SppQmXIHapYdsmp5QLC7+C52fGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  7 ++++---
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 106d22730954..93c2b5d71254 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1406,8 +1406,8 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
-					   struct mptcp_sched_data *data)
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2184,7 +2184,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -3851,6 +3851,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e553fe70f9a2..cdea1efb14a5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -633,11 +633,15 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
+struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
+				    struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..92057ca94cf4 100644
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
+	.get_subflow    = mptcp_sched_default_get_subflow,
+	.name           = "default",
+	.owner          = THIS_MODULE,
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

