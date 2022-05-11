Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3115B9
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 07:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652255857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVxj7r/DO7WmmHjuG9sV1Fa3xU7BZHTs8Vnx4cTk1Wo=;
	b=IxlA/M95KQxTiCZplhy3pRyu6RM+NKOO2qjxoS+kUR51ql+Vcqqx0PPPRBjUjpht8+6cya
	bYBWeBv6FgN9Hpaw/RQoJubd2M45tl8pJHg4We6WAMDeRBzNVoy55wXvEbxXpPdExOKxcg
	yvMvFz9q2K8KGu5LW7IJtoqoYgY0W1I=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-DqHFTdHPNp-96wZq3_bYJQ-1; Wed, 11 May 2022 09:57:36 +0200
X-MC-Unique: DqHFTdHPNp-96wZq3_bYJQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ/etc/nyc/yLssBNez8sff3WvR2c7+/ItyndozVWZH4NVgh32Vq0ah4Ct7jPenZGYFDne7m3MXXQoNkrbQ7Cb29xA8aGFN8qxVXn20qYAmZO/3owREmgaScbwxKiU5UblNkzQHaokf0g3TEmARkRuEdQ/GUaqsSdYBm5Skl9LHGZ5mOk+T4AVcvAywP5rZx9HnlKtIWX4IKHnaUV4sJItoucyfv5Af2WOdVR8KnXCoJl+tJXi5EyX/2CP26n1zjWq7gNEopIY6a2McT9W7cqCewP2bP1SgVjLgJjikhGa29rrFfgiMupBMaGy1vpvZlkv3rs2dWUyILd0qomy0cKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZKH+jmRjjHcvw2C8uNF3rRV0lIs9iBD7qyfLQx5bHc=;
 b=mT8Fli5/pO853WwNeZ08OzNF7C+SR8ty8lvYKVbqec5lTvVs0QqGCWQ+hlvgM+g7HtWm1IvQN0Zan3tWFZktUjBUpr4dbNAm+Is7iD7iO2Sw10T4nkbRlOjgYZsrVengJo7rwczlFKZDi9RHIg5iBBcdsnuFoi3yH+0ntujfzk6dXM/ZS7BWe9ktB9GuLA5nWqf3NgwCz77HqzGbMKMQkKKx6Vmrd9UV83TljeTkWF2iwbDKmwkxbd4bKbuKExUDOD7YWBxFmWW4LbcxNhvyGOHA/bL0EBmqgGH/4JnG8NvNn8v/7wePiBEwEXIJE42eFuVhYLjJi4pAXAiuqsOQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR0401MB2653.eurprd04.prod.outlook.com (2603:10a6:800:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 07:57:35 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:57:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next v2 11/14] mptcp: add get_subflow wrappers
Date: Wed, 11 May 2022 15:56:17 +0800
Message-ID: <cf6d665cc645c44f536b4396f9277d437d411e92.1652255616.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e363acf0-cdf6-40e7-8152-08da3323e8e5
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2653:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB26535424136D79ACE8A7F1C5F8C89@VI1PR0401MB2653.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Rj6RGMs70p7y/tBnehndkDR7KeaFA3sTui4TkZuHxP5J7GHXN5NaV5NkwpS6vm0/F+BTcoCKVDfqa1I9KLg63DmVBUUynSgZlJsH9GeocSUUTsz+XI9ccChyjyDpu+O+IVUghMWopsUxiOZEpGUxDVvx9EP6krLs+5ffBOgk2s6pKU9RI2Ugq9rV/QUcrhz6Gc4LsTnrN3ts+aooCmGMTe9SlwJchmoVwdGJmM3mRPQQmqeZVGlm/I7faXYk1/5tHLscyMEw97MfvE8B5TMO2Scn9mwVeLyP3IIJT4mkdQxlxFAeuZb/IuIb9c1KL/CyfQxxYPDVZ6Wtjc29SpzwwTifapxQkXqJcQfvL6Dtf4YaAP6H6hbkjCZxMTEo4YD6SwWrAWvAYVh/12RyvC//mrjmEXknW/mSfEsAHqoiNA+41933WCiD80hxFSe27VMP7jSZ2BuvNHtun6phR4lOBdf7GNdJy4yuLvDkI59betU7OhFXrtalDvzEZUW3moQtfsS1gttxqFUkwBBgIxol/nrA9mjHuqcLScJ/bsIlMW+19MEDgk8IbLsWRvUQ9ptLJ4iwkSv3iOEJ2gitq8M/mOXNL8uaAnjLx4wbm9oHCV2h6ooIPO++nBY/EiZKYsIr0/M1Hd4I/uKAQe5UfKn5Td9v4GA0INUQMMJuxet/74zuIDZnYAY2NrQ/HOBcDDZb2BZ8H6IRZKL+Tku791IhYQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(66476007)(186003)(6512007)(86362001)(4326008)(8676002)(44832011)(36756003)(6506007)(26005)(2616005)(508600001)(6666004)(6486002)(316002)(6916009)(54906003)(83380400001)(2906002)(38100700002)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sYByicluh6tiLMP014plN10RXsvPr1KJvLxhDO7+DgUVVm7/gNZTX5xsmUdZ?=
 =?us-ascii?Q?XCpZZbitsbhADh4Arp/wwxKmkKo8WoRh+GbBgetcwleYSWG6YLq/W5IEf1uk?=
 =?us-ascii?Q?OHhd5AlvuF0VVdbizZB6IAt7QlPJePJwdn/wQRD0f0JZLYU2Qc+jrmgsk5zK?=
 =?us-ascii?Q?e/1WZAePhf9V9txM2tu24DnCHvBSx39V1K+4uRX/EKIkl4gAijqRz/p6mNMO?=
 =?us-ascii?Q?rZtN6RGhAeE4wObKyrzVgh2A0ozLjips/ObfN1+HTPr+8emYsE25HC89y4lA?=
 =?us-ascii?Q?9SQ5sLonmFXV6Vo1qQtwq1Wy+2H16xGa0rJvjbz9hu5/+PoL5JIxPerQVmq6?=
 =?us-ascii?Q?rIOGaGGJOw8zNuuGgWBI6fKu6BxAG0uxxc8PJvAIYWuM1XjBEO686FOxqVqL?=
 =?us-ascii?Q?S+eiwjqZZNXK5ErCfUorl47RgSkk6fpGPxZ5/ZlyLk4X2BbMJkg/HD/TKcDy?=
 =?us-ascii?Q?JblhoZ937MFFMfC8kP5yTgq2ClvL9oDeP7r1SaIaUCTQP5sUG8qLvFVxXBGC?=
 =?us-ascii?Q?laoM/OxcA3+4uGVv28sb5KFKCRMXnmjjV5Wae4Ly/kSc4YJAjFVBKL/PI3V6?=
 =?us-ascii?Q?ltWLI8IrwNWoXAEnvRTyztEBPvwr92zXomgDPBAowsJaw33CwgcauTTnkIC3?=
 =?us-ascii?Q?LobeFLvKrJt59sJyaczGGhhI3KGF6NUs8myhHBp2HngydjodvxYRzV4WJt6X?=
 =?us-ascii?Q?9YHlbCzRXYhTLpshKQ5JjMioX63h8GTl8nNbMo59JssypncZNrHESeVJRSaF?=
 =?us-ascii?Q?jeduAvcrm926MJ/apGE0pnoMa0mzA04tNJg8NxqHHUyKr23jIXSU4UBB+wRw?=
 =?us-ascii?Q?7+zabMsCMkGSNi62uCMU/ebzKkMclFtlalrY0gX/d+FFpUDZSc++Q9JLgQuk?=
 =?us-ascii?Q?Lh6GreY+AsB5ljMm+V6aLX6JL6CEHePpraYzc5XT9E/Y7Q8wzNZKGSCbTUKs?=
 =?us-ascii?Q?vQKC6FhvjFNRPjkkWk82W+hxTb4yw81bP/oPbgzKHo29lD0NOH05qLUA0uou?=
 =?us-ascii?Q?hFpSgeCw3iivntMz+9V9cinwTeh4fpu4jfcIdkEqRd1AhQ2nCHcocuZwPJPa?=
 =?us-ascii?Q?mq0sD7AVuACi3O2nUgIvlPbYQiwqKmqmS5UR32zoe+yDZY/zuvpyIn6gye/o?=
 =?us-ascii?Q?dsScU9PMoVJJNz1rB0DGrHFl5DOGDRsLTSOUJAZ1Ww8/ywswVssPWDk5hQha?=
 =?us-ascii?Q?9ePVw/Hkz1le16vMqK/oTbCsoyFaNmqCLu/Senovkzw0pTTgskKxb1c3nzqz?=
 =?us-ascii?Q?IKOeMpxp/DcmT8PCjJ5fiPC4nLUn45CjZH/7Ec1ZLPo2hXeASOA8wOclA2sE?=
 =?us-ascii?Q?KMLHIf9Ggkaj/sMaF1xFrLMMzSSw9K7CmAwn/yrF3seahBps/1k9PbVcucZt?=
 =?us-ascii?Q?gj8jkURqE8POzNJsai0CemMS3ovMBApwHEh0Rignb8gepjW2KtLD89MTsPml?=
 =?us-ascii?Q?jQlVVt6g0nze83EzmIiCVFS8Mf2o5QG478UGj7S6N5Uvvgl/Vs/OWdbcyEqZ?=
 =?us-ascii?Q?YE242cKRSlxqO0qyNM/JYug0CD5XakoW01YPD+w4qnLvrwc8MSgFNJCMrYr6?=
 =?us-ascii?Q?o0blFbciKpTNFvd4l75uQyb3mgrw9607WiM1TpkVAZ7f7w5zvvNKVrMZCoQ0?=
 =?us-ascii?Q?oqFes+kbMts0eew5MBmQxN+/RQlYqXgD3He5xYeVWwGz5/XUIBqfkkVjQXJv?=
 =?us-ascii?Q?skSIN7rYYDyjASsD3Ha7I2NBnFc3c+i/tASi0Zk0m8zy53fCBFD3kkKSVWud?=
 =?us-ascii?Q?EOOBhAicdJDkLoC/m8Rvt4ZLOhAdngw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e363acf0-cdf6-40e7-8152-08da3323e8e5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:57:35.2292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ukC42kKTtVAtDLokkSPDinY7MoDVhUaestBym23LvojxuT0b9a5XH/k08RMFHCrKymiFO0GIn5A3QvNUtaHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2653

This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
in them. Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 25 +++++----------------
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3e9246822412..ea3c93322592 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1427,7 +1427,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -1438,14 +1438,6 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk)
 	u64 linger_time;
 	long tout =3D 0;
=20
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* re-use last subflow, if the burst allow that */
 	if (msk->last_snd && msk->snd_burst > 0 &&
 	    sk_stream_memory_free(msk->last_snd) &&
@@ -1575,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_sched_get_send(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1642,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2216,17 +2208,12 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
@@ -2479,7 +2466,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3128,7 +3115,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 85dd69b8d9d5..59a23838782f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -629,6 +629,10 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops=
 *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53773668b5ee..3ceb721e6489 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -87,3 +87,55 @@ void mptcp_release_sched(struct mptcp_sock *msk)
=20
 	bpf_module_put(sched, sched->owner);
 }
+
+static int mptcp_sched_data_init(struct mptcp_sock *msk,
+				 struct mptcp_sched_data *data)
+{
+	data->sock =3D NULL;
+	data->call_again =3D 0;
+
+	return 0;
+}
+
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (!msk->first)
+			return NULL;
+		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
+	}
+
+	if (!msk->sched)
+		return mptcp_subflow_get_send(msk);
+
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, false, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
+
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
+	if (!msk->sched)
+		return mptcp_subflow_get_retrans(msk);
+
+	mptcp_sched_data_init(msk, &data);
+	msk->sched->get_subflow(msk, true, &data);
+
+	msk->last_snd =3D data.sock;
+	return data.sock;
+}
--=20
2.34.1

