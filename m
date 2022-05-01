Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823628EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651412979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZyOUQjMJfwRKeKP1HU0sWrzNal8KA4GAr4375iHPDQ=;
	b=a5ZGabWKMiQubw3yOT6NEdjgOB1l1al9gN2r7zc3EclXbaiYE72ggjVDlA5dDZtV86hnUM
	cv5WHfqVVZ+qta0wDu00Sh2t5yC26xgxiBfhBAqpZSL5rdeCAiK9isDIxHn4coFph/6Hla
	jFRtOIBkomNGBk7UU1syJoYXPrvfD+Q=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-nD2lIQ1WN52ih0yZN57QRA-1; Sun, 01 May 2022 15:49:38 +0200
X-MC-Unique: nD2lIQ1WN52ih0yZN57QRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFNZ3PoHk/hyO8JTQgTafe9dyF3dVyXZjP/jmmH1SEfxNeGhVhd7NwGrpKF3rNCEPmmapXZTtH4kXgWLBH59V2uaP7xpLzIU3h33YbO6j7Y7t3y8lHoD8Dtfdso76lsLmlYGMgQwPPpVD9el7PgO6aAr9I9Wq6DWwQJd3OZhDKFj0wjkXsQFmntf7Jn/du5H2Lcit1oknsmD/e1iH73w9JiQWtoJ6HU0dsjyACBTllsi9/Xwlb0m3DLcXDZlX3XbvyoRfMsm/kLnKguT3/LRnxJ3mPnXrs/U/V6n3l7eKqSMDdqLMRq8axXdj4y66uATN9vlaBH6iWN3R1szTsvtZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0jduHl37h2K8XdVq6vul9/jPvK8k0xVTcgcB5bn8u8=;
 b=SQ2LgiwovLklBpaX0DHPl8BTkryL98WxQtc/yqj4qe3tgTxVQc3/I1gF+gn7jrKVlKlsbKRQNfyuq5dOgcA2TiVT1zNP1ZREx1qC3BGsCpwVC6UrrLDQcFOmLZ++PBNAZ9HDkHjCaJB6v7kITLOHjrUbJ7oAqfXFXIT+fNFb2O6jO/316CvLx5vJuC/M2lV30hrYRX+yVVTFxML/wXB1dPQacNwcqVbtHeT5ecv6VqAmv+fcMV/mPdCira3oLNvjkIElE1eXKTTsesmTf0eKASlYBVHEdmg7v1f7y8OWxVytGT0FYz8jXkMVsIqLJxCN2JwBDtVrAnC9tUedQ5ZdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6283.eurprd04.prod.outlook.com (2603:10a6:10:d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Sun, 1 May
 2022 13:49:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:49:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 4/7] mptcp: add get_subflow wrappers
Date: Sun,  1 May 2022 21:48:47 +0800
Message-ID: <cd4c6792816c54af06862c70c85592b2667fc215.1651412613.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1596a315-2439-4513-550c-08da2b796e24
X-MS-TrafficTypeDiagnostic: DBBPR04MB6283:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB628394B8E1266E14CDECCB74F8FE9@DBBPR04MB6283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E0uQQHBdo+PJHmPe9VFc/RcTSKEcB9Mr4owY15eSNWiBXcaf5OS6Q9I76hrcdtZ68axWDsMQ4Hx3mdw1jFgC26d30KUQUdYfDb+8mgcdbyCtQCHCzcSxCI47Ou3h6CBDk4PeaQWYsII+qYMZkLZ0gFXjcsogsE12gFx55jQPmtuN31do5gmnfw86PM1rYJEeVnPmNBa08bnk3P4euoXp4AxDdR2Qukt/deYAiL4WICfc1HU+5iD0HGRV+s/yssKyY6AElnhixMJm5GXpbGybRgF73Rfz9MRsEdWwG/00UQ7dlil4ZGYw4e35bIgkavOQhnnoCDs0/a/fTGqRQKLQIG1+m09ukdqkLyZK5IP4PwH9jFHLWhip+QsxdF0hZtJff1OfO6wJqoVgXVwWxzAyU42b59bZXXAkc+aEy4pVnq/yBDVCWoVSSIe68PPufizdExlTrXsTxTYu5pubmbePxN+u6jrSHTcEA2OMLqNmUH30+vR/HDSAQfcDNfHy7NV+8y6i37dgseA6qnLhWppD1wrXRWr+g80s84WdHZVwTpH7EFvR89iQqQTJW1YvJjn3d+SMkgOgl3NO0AE75kcPZZI0UKJLDuojD+V+YrGyQlhBYKpOrG27v8nb7a2wif9Yu/sHB7JRHq2nQpSHteXsh7zKp7ADk6Dmj4u68fdsSvLqhqACUqfqOcebp6K0ug2q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6512007)(5660300002)(186003)(26005)(2616005)(316002)(4326008)(66476007)(66946007)(8676002)(66556008)(6506007)(2906002)(107886003)(86362001)(38100700002)(8936002)(6916009)(44832011)(36756003)(6486002)(6666004)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Tg7+SuHVzypIVHcGRLigg3S+Vpe5jPK7yGPWvLCL5g1rB1bhZU3/10txl85?=
 =?us-ascii?Q?QGbszE62V1JY8LoLlS7QWgZ5TMc1v7ASN+M8AvGSXZ+HFiVbA/r9CJNdMiRw?=
 =?us-ascii?Q?sTAYm95SSse3O93lmYE4udJX6d6TI0M7UpOeYrO2KpCdreVcEcorm5VD9F1V?=
 =?us-ascii?Q?5f6AccA/LeC1Y+o0stmfwA38cTBVWW2Nu+r6TXOYDIV+wBo/HrjjKn5Hq3fl?=
 =?us-ascii?Q?kog7KeE6NugD6BZDT4wXlXgDEBHKonr4c5EHTlyh2U30yUIbM0WCBcBDqt4L?=
 =?us-ascii?Q?DgOHDRPxQB2bWzoeZDuNtkW+HZEfEm/HYzuFc02UAUZYwayEhPh378VEu1u4?=
 =?us-ascii?Q?PUji+4L8IO61uptItGkybQ462Wb7O8FyHgeE/1QnJ83tEqSVHrq2Bd8a4F3R?=
 =?us-ascii?Q?5TQB+x4RotnW9rgeuGrlO4zowE0nqunkoB5rFv5VCGF7/nid37m992RHFiEa?=
 =?us-ascii?Q?ynJzo4l5VX3s/BNujCAVF8O3QwCbLyFCakJ3hp3TmK0maXxRGYEwPxdxH/8t?=
 =?us-ascii?Q?cpaRKG+6HKv4ZnlBGNHycI6Z0fVXVH9B663sgnOOFoWVLi6/cGXachT6NIUK?=
 =?us-ascii?Q?K3JpeS05wK74UiupMhNiYcJRIFYhA99jag9bY/iC7o0svrzVr340aFMyCZWj?=
 =?us-ascii?Q?H3uTgYpWtZpI2uCDpCPL+rak304o2RBZyIG9qkKrqTtjPvOZb4UKuGFvwdGW?=
 =?us-ascii?Q?TpJUPZdj0IXSG4+wEdiDVg7olT65BooYLgTlKxbQ5k7wZq+lCQ3w43Z+/f8r?=
 =?us-ascii?Q?Hm4DOC37uWMTRPlmWVouyziSBcpCJ6cT3GU8OHnG0k7trjgsYkp4SDl66m9u?=
 =?us-ascii?Q?DmiLYTkFWrZNrZ6tQi8twmToHx/geFO9E+kPnYZJGZVx/iydE/tNdpoEcVjs?=
 =?us-ascii?Q?oY40ge8ui2uEz9UKWuGvTQiNDj887D1uTIVvIphCTjxEPjbHWnPBN7EDkekO?=
 =?us-ascii?Q?ME3TYKG3m/p1tdlXA/UQH/VtSlQSI35DZLRQH6GzaLOkKyVoIqI7VjnBuu6S?=
 =?us-ascii?Q?E5bCICN31clSCgGIP0y0ssAnqPgCXe+Wnq6hnhJ3mTqifL4cjwS8nZqJ9wPN?=
 =?us-ascii?Q?lMqoFBe4hwUMDwuDhXqxmmd8Kt+cP5mVa0OwaDObS9SsA7HVwJjFXjJZykOk?=
 =?us-ascii?Q?mOdDGC6fzJDG50U/G44BkhyzZiQrOlYrtlygOi/hbr92XiU47u2h6qXcRbt0?=
 =?us-ascii?Q?E8UvnjFfMrTJsVCoNSNQaONhsxQvisa2/rQbRVD7GHRf2bAcQbg5gAyPu6su?=
 =?us-ascii?Q?iO6m4IindCA2NmiHn/cHBVQl3eYmku1Cm1j7MKlc9TbsZDQTKjU1hCrQ5i+q?=
 =?us-ascii?Q?MeGzeYiiQNLEV6YLxZkmws3UO7za3vAwpHiHHXIrNdpEGwV8Je1xtfcwnqzc?=
 =?us-ascii?Q?xR8eG0IclDczwRvjHvJ5edena9rH/LhB1b6MjM0Rzw+cz9dppptWhEpcQLE0?=
 =?us-ascii?Q?clb8i821GwCHRAhSsEFKDNypfCOLuMCI/MLRxtStsiRulMz97hW+UVTK84tM?=
 =?us-ascii?Q?uYr3aFShYB7QWYJ1yMHlJViLRST+2XJeznjOZx1aoHCmGwhbI/buz9wm9XWf?=
 =?us-ascii?Q?YDi9pnc9R7rtvJL7IX1JjfqrhersVka0BFkRsrA96aBmBlze2c/2+N+76L7F?=
 =?us-ascii?Q?ugqxX0sLM2wyfIatt8TOTp8jFqnkJep2I1nSAnsN2j1DfwRlgj/Xbou62Rs/?=
 =?us-ascii?Q?ZCsWjJA2LjPw5A4aU+4oN8W4+xpalyUT6IS8IIp450Qs3uV+XLHBS/H0NR33?=
 =?us-ascii?Q?36qjKric2nYkTFXU5/v/JDBhTu3yBa8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1596a315-2439-4513-550c-08da2b796e24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:49:37.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxm1OBwCOFKVfhoKtIiK4oZT5tV7StibwZ6k4hrbsaNAI++YW84gLExvPamc4yHiGVLbbFbCTauu7ei6WKAJIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6283

This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched
in them. Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 25 +++++---------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f599b702415e..5243c58789a4 100644
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
@@ -1644,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2218,17 +2210,12 @@ static void mptcp_timeout_timer(struct timer_list *=
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
@@ -2481,7 +2468,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	ssk =3D mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3146,7 +3133,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
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
index 723141a888f4..fc5dca44470c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -629,6 +629,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53773668b5ee..7a5654132ed3 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -15,6 +15,8 @@
=20
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
=20
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
@@ -87,3 +89,55 @@ void mptcp_release_sched(struct mptcp_sock *msk)
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

