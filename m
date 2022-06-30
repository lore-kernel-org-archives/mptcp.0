Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD00EA6
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSd0+pGpZUvhQ/NfzFtGHMnD78yO+abdsqN5wgyM3vmBnGoe1gFNARqEXOK/mrmwwbjIQsP8vD5wdEfkY6POM29Pn7LjUQYmNnh/D9ctZ26VwcwIthEhoRH47OuBWQZxU0y8IZ3gazwFkm8jI1wfqKovWJyiP9NoKqaNZJOKx+PbexvVbvJjGPs/nxR8sdoCYayzm5yRN1VXjairt2A5sx1nEKc3bzxHZmEoKmPW8Rr7Zy1ap39KB2IEzj77GdMKIND2LIhxHYgVyx+hKBDNXv++/wsvn66GMqGrPcLMhwO7se/wBIN+DudURJc5ig/Tl2f1y8ihFCdjJeciUVFeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZB4xMH76SkwxyNpUeggaReNexgplLy3BOZmanOZBwA=;
 b=PvmIZaFTpA1Hg0I9KyTIKs0/rxlcw4+EeB10fWGE6s+bnRIpQfqVsd6uXE5jhoi+dxSkJbR4BDk/rXSKZaZ1TtZeXMPrmGdUg7xKXnuxYt+rKXG5S9z0C3oWqCaLyX3PdtGohS1N1NDMnZJtRSmAn2rjsIu+TAkmds439mVHwsT9FooaH0mfkVUvSNuml2zVkT9UQ4FQjCHi5X/Ysqbngd3WqH1FOWotbyKBWLO+WuAifctHOEATJ1DPjsJMeYYXGt5xcgGyeRR79JQLgSPlzTmnni6QuTZIxxixcbJrBNinSxmbOWUDzANSv1+i/p++prnr2L59yfI+mtlJejh1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZB4xMH76SkwxyNpUeggaReNexgplLy3BOZmanOZBwA=;
 b=E67SaPocE9sv5MCnIxhUnF5+bUrOIca89DzbBl8OXIKeoWxFHqslrofCYAzjGbFauDGtAXNqXjCoFE299eHGrb9SeDkcNfsdrO8LH5fu8u3tiSe1+wZ986SRBwg2owbDSsV5hcXspY3isbR2AbQ3NSLEktF+DADHTeHZDvPdpF+9W/beGTT0LEAWmRBdB1TUm9m5Iryz3xn86ZTYWX0DxfWZyO0FjJMXe3x9QQ16jEx1s7GTK+TkzACVlbUUY0jBo6gSOogf1y9x9btmMB+u/kxN5StnFY6j/FquNlzj3WTx2QEbOeFzz9olaNIJfCI8wssn6nAu2nkWoQqPhZZpqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7778.eurprd04.prod.outlook.com (2603:10a6:20b:24a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:50:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:50:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/5] Squash to "mptcp: add get_subflow wrappers"
Date: Thu, 30 Jun 2022 16:50:50 +0800
Message-Id: <9d0b6144bc645bd10e8c44dadbabfc1d8605d935.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656578856.git.geliang.tang@suse.com>
References: <cover.1656578856.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::12)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 329aa4e0-e49a-4078-06f4-08da5a75a1c6
X-MS-TrafficTypeDiagnostic: AM8PR04MB7778:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c7gKqgAeBr8tNWwsXvmCPvs2Bgx0pgjHesR7EWkbGrvfk7Qe5GA8rXooI6RMCnC9BT8RyfmbRYK+hoyMJD4hTumvw2XGP1tps3dDsEoKIJsdnzadKzOj9kEBfbfUNoI3SGVVG2XpTHsmKPs4ffmnCBjdQ2skeNstTNCB3qKRVwGzBkaBOjj7g5owsqrRjtP5LsdKDewQEqK8WooEJ5ycCxmiuYPB93WvMS+C7HQe8fdUHH9acgbn8JXVdF0l73gpuRImVnPeuM+3gxxfbtcMr8cLyz46uLQJRwDjrZ887tv9UMJuT7HPP5+0UtBVy6zvM/cqv7r5w03v6VDyH4SkK1VEZB96SsQt8iM+Jikgr9OFfzHFrOzCZNnQNBcHRyK9VAHzsfdsHYHcBDnrqej5pxyxRrJnpbfIk4qqsXEuGGqYatbJKmWMroYPBrV2ZKtPVO/VjeAbmK7AjoU5J9jecLBWh9ieEYasK4mElboUo3cN0pxMC8fij8iNpQcZ9PwQb2ndGz8kF958ULIKbLxAh3h+7vTmK6N1JGE0+L2LYKQOzjKb5gIA+8nfey21EEv/ww877mpsqcIsioxTzBMwXAJd5wdrRtxWI+5fa+JMKTTZKsUZ6b3P2xFOnFvQMzjOcrbzL2BiO6o2niSkgcXEFuf99OcsARHwFFLWHYvH6HhusQj+zCNs69RBqLvCm9rJfyNWHp+qgtu65R7EVJenP2t20Y7IiEzEYY4fnLa0DzLc8uOU9UyPHkRqC2uGu7h+lFwSd9cdlwmLtqPocsAUqAhzL5nt2+61XZfvfFnMcBMgd6v98ZE17+1ueVvu431o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(396003)(136003)(39860400002)(41300700001)(186003)(107886003)(6512007)(2616005)(6506007)(478600001)(26005)(66476007)(86362001)(83380400001)(38100700002)(5660300002)(36756003)(6916009)(66556008)(6486002)(44832011)(8936002)(66946007)(316002)(2906002)(4326008)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SR6g/Hc7pt8AHce35dIw9C+nQsxBXzRzLU1F3Zc4rHJ26ECE/yUoxq66f0Um?=
 =?us-ascii?Q?WPKOxbilDLF0CuhBCz0sS+5pFiyqswArMHby2YJFnxfepeGtwZISjk85+UOb?=
 =?us-ascii?Q?+hvLEZTIsxo2+I8abfRfGoeoiJUApFp2YqDFB7xODiQU+UO3QbPib5Zo8tI9?=
 =?us-ascii?Q?s7ciQYkuvLwEQRFCHo7Cppj1KMZGLHixq21C2OzLq4k/jifeIqrP7t45rW95?=
 =?us-ascii?Q?3mtYDEkg10IqCtG6jsoEM/Revm0oBIRJzJuh5zKKI4Bd0i7pxkMyoBK86dxQ?=
 =?us-ascii?Q?+Pui0b/+pG6vgfMQsgQZbhuGiuR85LRTykOUpGivpLN81wHgNGoR9ErMBN+h?=
 =?us-ascii?Q?FBLN56EtMHz4uBLJ48XKjh33+QovkgKTVsvmKKUCBgN/tsTMkaMNKfKJVbhj?=
 =?us-ascii?Q?Lgj8k2+tAVhAYLHtgO0JYpCEjktywBvEkNtS1Z/rG1Cr0xHdrQ3rgHpt7+Q9?=
 =?us-ascii?Q?QgUQs+Bc4nz6SydVf7kWPqn1cEusPrBwFi2oYqnNQ/Fd6Y964LGalG0HI2/y?=
 =?us-ascii?Q?aL69XfyrUv5uyvdPsAQrJWQlaLGZl77vh84czEtFPsUXNiU5Dos8KGi4vjtr?=
 =?us-ascii?Q?bvnEQgMF4om5tIX97Kvvt1Mz1RKFkRdm8tpgtVcsesWby6eslAy3OBSUpJwS?=
 =?us-ascii?Q?+gmUFBzaCJVoh8qOFYrd3hh3IZt2rO5YQMICR0e1WoFhLAhtVXObqk+vFB0l?=
 =?us-ascii?Q?VYD2D3hMuEJ73hbtcH2I9Y6ig5UbqrYpL+4ez/gzfk5y9gvAD87J0P7xAQMm?=
 =?us-ascii?Q?YEy2Rh+ulQxt3uiVjuzeGNE0ca0zuOOGBBq3SUoPu/Vr2JrRipCDDIZbhTzA?=
 =?us-ascii?Q?UMcCq+36o799URjzUzP//RKTHQ/HAInxWkHVPUtnCRfljgqtPlrfeIoGWHEY?=
 =?us-ascii?Q?Z3h3uq6mWlN8/Dm3vJkBUG+Kr7snF5IpBWoo3eDsTGkxrNg89CD5tApH0Aq7?=
 =?us-ascii?Q?qd9eHr6PCBsy2t8PKbWp8g/op0N8G8/64Y7piEtobvPJfTGLdGNuKY1DaLoX?=
 =?us-ascii?Q?oiQiZixJtZsAjRPc/8vKhXYcHC654gFWnASIcqeMYIbzy2s/cCx6jJizHYzj?=
 =?us-ascii?Q?O8YK1Sj3WKLe3/BZgVxUJwS5g3fiC9ZYAwDSSZ0cXs1LsvPH89B+Qw2Qgqkr?=
 =?us-ascii?Q?1vjBqS41uEgCf/6yQ5LUywE2jATD52VmJ8czBFSNsUxLdjhbUjRBXJTXXWYO?=
 =?us-ascii?Q?s8CkBdlo5tKoToITFGxHfmMHYSkBcuwIni2ti1eOPQk5UOmXvaw/kdcJtefQ?=
 =?us-ascii?Q?azXDAfNbUplTV8Dqtf6d7suWoOiqIa9jxml2uW7JlMQD7EFqfq4Kqbn44w6B?=
 =?us-ascii?Q?fAbIH8f00d8fZ8maUNExSeUTN51sepCO0J5R68COJGvDa99EWqYsNrFKmCpU?=
 =?us-ascii?Q?hhS8BApZ9RtpZPyaYtqf75UqGRu6O0hxlO85BeTQ/FILnNLmhE8ubUfxvUk9?=
 =?us-ascii?Q?cY7gqpHUknUiSQWoJYGRvzeq25JKh+FE0XIr3oeCwaxcS9VgOrGor96J8xnS?=
 =?us-ascii?Q?pzN9WcfxNG31iv2CSyFsAcRMFKQ9aWpVw9fyXpJ7FKGGEr1ExRwRReEYO/ec?=
 =?us-ascii?Q?C2CfexvLNa2Qq0+l45lD+mpgTvMEbtOHczmxAsftURkHbsUK7ol7utnXll/K?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329aa4e0-e49a-4078-06f4-08da5a75a1c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:50:50.0629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iv4ZgUPE9OfkDhgXef6B+A1ZZ8p20QENhWJK5PimbSGJ8zX86eGsZpiQBv6V1tdxOClfcL7LW8cWNrGEnqR/iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7778

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send/retrans() into the wrappers.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  2 +-
 net/mptcp/sched.c    | 56 +++++++++++++++++++++++++-------------------
 3 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b1fae2f747c9..6e44786e01fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1532,7 +1532,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 			int ret = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
+			ssk = mptcp_subflow_get_send(msk);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -2408,7 +2408,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_sched_get_retrans(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95c9ace1437b..af414cd8b7cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -636,7 +636,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..85c1fe85399d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -114,34 +114,46 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 
+	msk->snd_burst = 0;
+
 	return 0;
 }
 
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return msk->first;
+		}
+		return NULL;
 	}
 
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_send(msk);
+		if (ssk)
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return ssk;
+	}
 
 	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			/* TODO: Redundant subflows are not supported in
+			 * __mptcp_subflow_push_pending() yet. Here's a
+			 * placeholder to pick the first subflow for the
+			 * redundant subflows case.
+			 */
+			ssk = subflow->tcp_sock;
 			break;
 		}
 	}
@@ -149,31 +161,27 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
-	int i;
 
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
-		return NULL;
+		return -EINVAL;
 
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
 
 	mptcp_sched_data_init(msk, true, &data);
 	msk->sched->get_subflow(msk, &data);
 
-	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk = data.contexts[i]->tcp_sock;
-			msk->last_snd = ssk;
-			break;
-		}
-	}
-
-	return ssk;
+	return 0;
 }
-- 
2.35.3

