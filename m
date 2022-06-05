Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9F7E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAJo9INBSqvIwcjehs+/byKlNFxKs4sGkO9HHSwQLgs=;
	b=mb/mTPYRns+eqPc+NC8g6yD2Sq1V+JPu6ey6hZ3AbZCtnhcS8in40Y6EaX3LrUVGjKDSvt
	l5lVwKKhscPdrxtseLnGC3DxHZTAyWDE1uZ5pFy6tLL1Wz60uhdn+df/C+N9OQ9/ewkVEl
	+GIYLCciffi/qDTFrMqrVvnoevLjDAo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-3oU3zKfINLi5Wa2AjVHx6Q-1; Sun, 05 Jun 2022 15:30:24 +0200
X-MC-Unique: 3oU3zKfINLi5Wa2AjVHx6Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjVBrQw4Ji4oh+RElLY1IPSOoLYmb/8C02cnfwDTPJkkTRSEBLMDg9VZ+yb9l71fMgYAgaP1XI04OGhSsIUjDHrHgnd7DToeUnEdl3fnghy1XOUTcc4xgIJXEqpxPA+iQQYH6qeKFxY15q/jKlQKUQNw3yOtVWJKFsL23Tw8JhacgMqk69lPqmS38ZdThBv0DW+npwzUl2ezcXhnp9uKLvkIn/Ipr8vmq4Q8zUc6CBQboX8vjbK+rZBbZ1ifGtwybtChUf1ZPeGlCXFdBlDxF/dXzo0eNKmWqRrgHj95ykZzkgT7t+hFAaho7SSp86KnDkyc2PsB3s/CihNFic4nVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPHHk4eIiSKUF/LPheUOfa8QNfSB5igLwxWmjCJV91E=;
 b=RcpOCkVhdmmIf+TXK6gyAPctNQBsiGooXWbL2LbhJnLHK/PyJkHhiiHl3qtff7c5F9CaxDCRBK1X9jWFM8jRsEGffIcfN9IUp5GZkE9OAh4iZ9sXAWz3ftee/Kgjn6q1FVwma+xbB6VDUex9/hSvd8Y3eeSLsHhlnhGO4u9yyqjKhhblPQukCyrSdYB7tYEpJGIM574zxm8GRhw/4Igr/Wwd4pKCwBJawc2hAsy+dnCj2Mxdllj5v3ISNR1tu8t/Kc5nTeW4rwIfLlvQvjzMrpeWiCsOpShLmcLXk7S425RVfFv4MvFKb1RKnp0bGx3DfOKRmLI3jgYWU9HcrZxgYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:30:23 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:30:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] mptcp: add __mptcp_sched_get_retrans wrapper
Date: Sun,  5 Jun 2022 21:29:37 +0800
Message-ID: <3868742e177e864bf48526683f5fa06b15dde42c.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654435294.git.geliang.tang@suse.com>
References: <cover.1654435294.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b0f9120-8129-4e72-7615-08da46f78ae6
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB50281E2B159EEE402A9CE43BF8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JpFkV0A6sgJovcSt4bqRtdsjSIaTGhogZacRs4a2XtLJVISe8jgy6tH9tHAXQlPW2MEWMSB8CwHcV+n2PvXeV5IGYKV6qqESFlZF+VzU21y+SR/qvp+k25duf1WPuvnqxqax/a0L8uiucAEdHO6kPSJH1FDcyFx6R+dgOKORRmY75VgiX11fNvwjdERvqWpxwHCiT9MOlG0UEW8+VjTd2TbtiyouBIbe7CuV4l23Hg6MLRG9Lm+ucc3pH368W0s5c+r1IUVrH/uDeisMWFCj3/HTClUR+8jHgslil3AHvnaRns3TM3zmawNKNz3YVHwoqYmrRcvwD18numF6IsVizLvFetkVPB1/trICnmD6F/xHmzOoXccVYxvzEprbzd5g41vuAMiIN654nXOZepm5Mfkwrc3CTFHUH6nFsVeJDAqJOzebVpTpca001ES0dgiyaDQk9lJVeN0UaciWvYra4tO+8Ow2T/BvPh1/+m07uc6Hcp0OaZuafAeco6PIDSgfV0FYnI2SOw92uNuh5bfcHrbjwPW665B8Y32dd2xTNJ27gISWj5JRt33huRNY4FOwsoWsmD4In2tegvjQExyb4XT55QYZybjgN6OeD2VOKZ1zyh1bF8MHwA1HLIPYiuiwG0BAjiFtMN2+pWTL0dODO4N9cUlfongAOlFlPea8ts1XMZ2KvebgvxNkH9twMJawEA81tED7UnA0LcpgPNv61A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5lvSzRlfFsmMbpjIgo+b9HOrmYdgq2VeXlfKp5jztL97RVBzjHY8rfkNBQLz?=
 =?us-ascii?Q?z9dJ9mClt20ngLFa+qY/OjYOW/ruyEYsPMBTtaR+ou6c9KtPKTzr9gpliEDS?=
 =?us-ascii?Q?1YPgFxNpiEMGT6GvK68Itj1STg9nccAZiZJLzJZziA5GrRlidxDqplSNTNNN?=
 =?us-ascii?Q?/mCYark0KveqlZr2JGkxW4B4ATzSWTFhZL3stZR2uJfPDcPWjyOfFrxAhzNj?=
 =?us-ascii?Q?tXHwbx4RqTJhU1KdK6P5nzpr21ao/yOrSp04Oc6NV3Ws1KSJ4htuw1+SHpyi?=
 =?us-ascii?Q?Pr4vRVvfyNJvWm2WJJaLSckJvLf/JrFZjsrnjA44vhnTw724xh0Mx7rkvSul?=
 =?us-ascii?Q?nLUI7bXhHj44pw6seAJqDo9qU6cpvg6YasyDqMPB5AYS8CasNInNpVYpd8ii?=
 =?us-ascii?Q?ASqw4quiKDiEyC+/00LALnlsnT1CFfvMKYL9CXBn2+kuivVD8FW6Bl+KsTb4?=
 =?us-ascii?Q?UYdP1q7Ihew1fYu3nQ5DL8i0XGaQ3gishYjlF4gTrtDXtJXlUtcW1EWpTKeK?=
 =?us-ascii?Q?f1WLCN/ahSd7gzh184taqLaQ/oxs2Ixbu1N/oyzZ3VUt239t5+GJ3inuLR24?=
 =?us-ascii?Q?lSwvYB1/MRO3doHGODIAUklGG22tP+Sb85HP7HdO1YqF3qzHLEnyVmpVh2Uq?=
 =?us-ascii?Q?+R04Oq+n3dMyw/jBx7JZF0iBs0bwcjOd5hqaHrt4fntpVO+PdAjf3j0FAQha?=
 =?us-ascii?Q?AaeIiPhryw1TvfL7TdsNoRnoN5Spz4gNvy/VOq8FVP6L/1sw6lxCL1CI1Xde?=
 =?us-ascii?Q?n2Jkg4wqS7X8hr2dLj+GWKdVH2nfqlPToBiD6QaSbT3QBulcvmY3LN7qv71j?=
 =?us-ascii?Q?Sj4CG/BYZMOBtjYS8OybH2+c2m+6cigcwNRxzSz7f04sE/6sMrMnsNoYi3Rr?=
 =?us-ascii?Q?uag0BrDqu2WIZqVJh+K/U6ohgcLX/79Heh3snYRR5MRMTOIyzP8uIVhEBc8R?=
 =?us-ascii?Q?9oBo3Ko7TkAyhSN2tTnPj6XJnCb3ycSl5vpmiJk9oHXS1PD0h/DHPu8XpjmR?=
 =?us-ascii?Q?qIT5FCxXen0yxGebxfwfKU8vhbKBG9NEOp0CR8Mfnw8+1zUaOsyXbKQ5f7wD?=
 =?us-ascii?Q?r/2Q8LeFILKQMMKmw/bxcTONYMX2d5nPvjLsY1i6pJmzbUwk8dpgViPeYMSL?=
 =?us-ascii?Q?pS6+k7CYI8UHd6NHUe/q/tCVnCskMuoCIlvHYTvLJAF7OT1JaeAekrBppc3C?=
 =?us-ascii?Q?7fni/73kbqiELJcfnwLfwD1c29nCeif/Yi4KwJIWE8170HkxBXPz0dc1S/+J?=
 =?us-ascii?Q?DyS70N3E8g+64h8zbVdicewu/YTmE3Mvk3o1GYKNQl8VlO72fUW11tLmRMLS?=
 =?us-ascii?Q?oHLf4Ws/0/XlGLN4zmyusepsBA0OGg+SUVH9Hqe7TFxcLp7P5GxbHV8zQCNV?=
 =?us-ascii?Q?tOaZUaEqG6aOeyRA6zEg3Uh35J7fSGOMsRRfibji9jN+D1Gq3lnyoSFfQPk1?=
 =?us-ascii?Q?93JAp0F+n894dL9riF8QmsZWqykAnGNUf/uoMn1d5wmvg93EbiopY1oLooFY?=
 =?us-ascii?Q?QKaA9KT3sdXjIb3SqsClae/zUXUUmRyw194QzQR0IvZDMf+WHS+cliddiuLw?=
 =?us-ascii?Q?fc+Lc9bWgAFpx97fRoPvKXPQKnbWLJOmTX0reGNdThOGfst9YWW4wWXNBwrb?=
 =?us-ascii?Q?r1kgXxeZepYLNl15Y0ySDoUQJeFMgM2OaDcSVs9JWvr/89VJsCWSQkgMGfWL?=
 =?us-ascii?Q?KJoM63HSlnIXeUgHnOJ2MpgZyuq1NueqyJbrB4v4GUr3ibMzKzlBed5tsJjY?=
 =?us-ascii?Q?aGPTKi1l7nZRhMTWepSTrBIlGQk1bLI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0f9120-8129-4e72-7615-08da46f78ae6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:30:23.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjU4BX0N85R3ILWF4YTHegq9alQK1+T8+8FQxrRIlsjybgLX3OE7g04PxgTCsg1a07RajeEAorzRqOZ4GVxsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

This patch defines the wrapper __mptcp_sched_get_retrans(), invoke
get_subflow() of msk->sched in it. Use this wrapper instead of using
mptcp_subflow_get_retrans() directly in __mptcp_retrans().

Check the subflow scheduled flags in __mptcp_retrans() to test which
subflow or subflows are picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 53 +++++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 25 +++++++++++++++++++++
 3 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06192eebbd57..3ae237f89bfa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2198,17 +2198,12 @@ static void mptcp_timeout_timer(struct timer_list *=
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
@@ -2452,16 +2447,17 @@ static void mptcp_check_fastclose(struct mptcp_sock=
 *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info =3D {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied =3D 0;
 	struct sock *ssk;
-	int ret;
+	int err;
=20
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_subflow_get_retrans(msk);
+	err =3D __mptcp_sched_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2480,32 +2476,49 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
=20
-	if (!ssk)
+	if (err)
 		goto reset_timer;
=20
-	lock_sock(ssk);
-
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent =3D 0;
 	info.limit =3D READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->al=
ready_sent;
 	while (info.sent < info.limit) {
-		ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <=3D 0)
-			break;
+		int ret =3D 0;
+		int max =3D 0;
=20
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				ssk =3D mptcp_subflow_tcp_sock(subflow);
+				if (!ssk)
+					goto reset_timer;
+
+				lock_sock(ssk);
+
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					break;
+
+				if (ret > max)
+					max =3D ret;
+
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+						info.size_goal);
+
+				release_sock(ssk);
+
+				msk->last_snd =3D ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied +=3D ret;
-		info.sent +=3D ret;
+		copied +=3D max;
+		info.sent +=3D max;
 	}
 	if (copied) {
 		dfrag->already_sent =3D max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
=20
-	release_sock(ssk);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a12507dcf1d5..4669d34f4d7c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,7 +632,9 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int __mptcp_sched_get_send(struct mptcp_sock *msk);
+int __mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9427d15b4c69..70ab43c59989 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -146,3 +146,28 @@ int __mptcp_sched_get_send(struct mptcp_sock *msk)
=20
 	return 0;
 }
+
+int __mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	return 0;
+}
--=20
2.34.1

