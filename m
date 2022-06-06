Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882928E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65fdPogXFwX9Lqq8VkGpRFvSWZ4mZlUKxIbEOzaZd9w=;
	b=B+InulMOctCutcmImYmZlbre6iWPUFIwjf94us6z1t8QtY5t+iJ126M4ppi+pR+nCA/qVD
	dpMR3qZeVROcY2wPfl498RAyL9y74XrvopeBmBGsEHGxxctzk5LALnPIlbonhuz1+xYgdI
	yaHmblR8B/epPLLP3yr7a6TmqS9nOEo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-kaCWs45aN4SbuhP7pf-_SA-1; Mon, 06 Jun 2022 16:41:45 +0200
X-MC-Unique: kaCWs45aN4SbuhP7pf-_SA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJa2K48qJqQuMj1Nm71LtpO8JF6BBiWsfseTPwHzeoEiCI01SofCzlqCjQRFI99iuQ3Iz/w4Wj35ERtVYHll00qdNchiOyVMAo7iDINayaegWyOHqGvqjHFG5NigLXEL7pOqLOa+XpkY8DuX6TFI19tAQCnsWAUuo0yHg8qLymzRTPzg6MR8tnPj/VqKJEBovgu0H/K3j7MyKPHZExE4/K+L5m4/y0x0+GZPPH7i12Ypswa0kFGDM4x2Xy3oAliqBb4h/YlhR+IDpbFPB6Si6HRo1AkkxSUfysjKnlZ6RSAyyvkZOLGQWY6Hd8yxkLOT43M2MbVWXMm/FcHBUn/x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIfwPhKvoMmPsO9Ij9WERPrC4/WDGmgP5zpnZr6BrBo=;
 b=OCSvU6GND7AGIR7TmuwUow15JI3jm9PLoQA3fnNPLE/IU+zuwxSWEXHUbCkTmOaOIzS/b8icpO+aIPBZ96mi56z6XKcTr5RQLRItsShxXT9gRSqZwFyZUSfa8i4pX+58q2eWONF7UthRqocJlZL/j8hO9bf/eex7rhmsp7zFJhf7obbFxAe4UnVcZi8bc7vcIZq2faMhrEreLJCR60CpWojfHck3x/TPQKsY5U9wpfaSFIjCXvCVTiDAu/d6Fhg99m/z6/anZqdO4uNsqONdsHHK7SCI3VyR1AOkKeF/sj2U8u5yhaMB2zgAEDt+VHzqAkeqgEfJpY8QePFFZUHs+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3536.eurprd04.prod.outlook.com (2603:10a6:803:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:41:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:41:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/7] Squash to "mptcp: add get_subflow wrappers"
Date: Mon,  6 Jun 2022 22:41:16 +0800
Message-ID: <ab89a19923717d2b6b65619e7bcc96b63261aa19.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:4:54::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45dd8662-09a8-4edf-223e-08da47caad7f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3536:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3536A2FEF20E374D0C85E46AF8A29@VI1PR0402MB3536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7qK2DPEAvTHcR7XMwQRSdHs7rIqIWCy4a5sbHp6cfXGlg2dyBbi+8pXe+abo6m2uZ7z0lutso72dvWInjtKPKSBqMjs5VxRA240nt/X9O5QzR8zvsH+UfXpVZt5p1SWWcoiSzFQyag3XbSBym2wghbIfOMu+lbBTYozg1+4NnQQOexyoKJ7xl79lAjqTdg63pjB3bAXxJnRm53UGmWi73Ei115yIHNwQztDJHIK02ziAfdo2Tes58Xt9XXRMaBY/9o0DUrUK7TnZUolW9xLkU7vQVb5JL6DCGkbt/9pRX53SSXRee7XvXdBA9AwVFM/YZbyMDMP+NvCG5BNFKQQ2/ToqyzzHS1o/4hAP3QzEPfcWdjF4BX0LYIrE4VnQBfEPmLp7oWhFmpf4n5uBjLUvxLU99q9mFjjtH1LgrkVfGwHXoxqLy2aZ4QbxMJn8+YOnTiD3ED+VynGeMn1rXliXa068Ns9lhxfwbSpMhjlYBubMqZgMdo48Bt/YK8GS8LXCrQ5SLyl7hcKOh50N6ZOkXhys5ySWGvpP35OnGcp0o7efuyt82uaH9+TPZBD5xMRX1kmjHXKXwo4OHahytORI6sCfvit5VOdMBYOaQqrUqG5OEoYJ55AqMtdLkWxGh+SSOmNSGA5rP4Xd5h1KhFkyFq9gy5XzWDvud3sTThdaDdzBBxFYmkepNwQ4h/9fAj5x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(36756003)(66946007)(186003)(2616005)(6486002)(6512007)(26005)(6666004)(6506007)(38100700002)(66556008)(66476007)(8936002)(44832011)(316002)(86362001)(4326008)(508600001)(8676002)(5660300002)(6916009)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsK2ntqCVybHRe6fwI2CUOUY0aM8p2DLQ3SLATh1zWqM0pANDfN5RvcSPg96?=
 =?us-ascii?Q?H6wxfBWYi45f7Lo+XPROxhu2yRpgqgtRwDSMQh4M5lwvnWtr8ZNab1+KhMXc?=
 =?us-ascii?Q?U4Q2P/r3Ru8msueIocspex8Ah4FJpSAMPJIcZ6iSVlN/rf4p7N0yAX1G8MEH?=
 =?us-ascii?Q?TJIzCTzQvVb8ieVD5+xLq5u4MaNdMLkB+ux3Tiy/uI1F2uSbFryY8hV0OCZR?=
 =?us-ascii?Q?I1xFv8ktcl72CyZ5J+I/RUFsz3Y1j1eYy+p7ZAgNzHWf4rob0u0s5hVivXy4?=
 =?us-ascii?Q?H4DSfFYrgSj88WnRMH9ssIc9ta2I+z7JKG0rFMQRIE8h9lqa4XlBw5lPejRj?=
 =?us-ascii?Q?HqWGrCkZwunrv0itMzZ4+la/MEXlIABtths/QqHl//ahcr5njQzal6eLTpnX?=
 =?us-ascii?Q?vIAYUuMnUFJVHWVvw61Ckyg+bnKilwwTLyh5kK1VvdxOXRwkYM+Zhib1HOCS?=
 =?us-ascii?Q?qdCxI255hglqTAVBe+9PybM5sHGX2fF50g0vUkG5a6T+U0lmZP4SNR+DeXv1?=
 =?us-ascii?Q?glyKNfOkXiGFr+XJhBJ3LvaZ9xmsJXrMlbUUk2TYBZdacFXH6g6j942Mj+9T?=
 =?us-ascii?Q?R9dn9OpbP6K7o9/74HkGU0ZtltPzHlj7oPZmIDAZa6MbHgQjP3W6XS3FEdcc?=
 =?us-ascii?Q?UT0k+MiznALE16xkYqNyjVQr2IoWtCHBBM+9WnmU0+8j2dOsnEbr+ehM+AMB?=
 =?us-ascii?Q?y2MNgzq6TMgVF1QoK/v/3X5Tm/zcS26pAfv+Ht/oRmu6x9mhjrTyulX+ckCA?=
 =?us-ascii?Q?B5CTd1iTsmnN3G1mEMt4US9Rd8p+WVQziulAiisezU4fm+RnyMXOenI8EeJo?=
 =?us-ascii?Q?d4ZF9tu720RZJZMAUfxv9AWUwzOSCqVqXCdqnj+7O6IUGUlvo0a+sdUAkB49?=
 =?us-ascii?Q?hcWarB/3g8tkvXv1BE0+jlY+T0GkyV1pkRL35z4u7UTsfXf3KuwtRX5FdAIv?=
 =?us-ascii?Q?6miuYDCZ/Cq/IEF4eowUTkitmbLqfDFW6oPMUYEopHCsuqjDA1LiGFCIMB0n?=
 =?us-ascii?Q?22Wwaf3sxK1g66sAOc2gBFXu7qGAnuR3g9+lXk9g7Ule14rIdG59FyG7or56?=
 =?us-ascii?Q?ijcp22/JD8fwRZAzRYBVXAArM9SNZgMfmLi4bcVQ4Q6hSChhzWHiDiBRsYxj?=
 =?us-ascii?Q?WofRirqe1eBVAKYdnKtPiD+rY+J75sDMqg61fov5S2YtCgnQpliVm30VrAaK?=
 =?us-ascii?Q?IT7WcXnKCYqG8sb6Lm8A+ymL2znn06L53cTcSZV3wjB0L72FErgvMqT2XvNb?=
 =?us-ascii?Q?IboWl941V/VNyBV8fx+3uaLqgWG/3Oe8vVv7qsXp63LQRbjEz0b84IK7/9O5?=
 =?us-ascii?Q?50QP2FGc6jap2oVEN2DyjbBLwrC3LqGePkDmelHIvpPR7OJ8qcxruDQcKhqe?=
 =?us-ascii?Q?sYXnMsPHE5OV8LoOv+Uk9wFrVvM8IcHTfyqoKixPNfDBZiRXeMZSWLBTRn+/?=
 =?us-ascii?Q?6D08SRdkLE7OY7F6opM+yrFH0Sa7OmKx6eQI3O4kpbc12NJn6wBc27T/OlBE?=
 =?us-ascii?Q?Na86jCCkYYdP5pE6d98se8R1umNEM7AFccnbG47p+a3GEcjbY/QrsAgeM52g?=
 =?us-ascii?Q?x4hKLpUDTvugMi51eOOhAkoWj2ml5XLeptKjqeR6NOX5hhdb/p1JNAJDuaNC?=
 =?us-ascii?Q?IPqS8FMii4Ix6dDAirie13rz6P/f0sLkLegqruvAAvVGgYNEvNiXxbflZS1Z?=
 =?us-ascii?Q?g8rX4Hmv/cbhxBxl5Wjz1j8/BFD9a+pefecTMC+SI+brUE+kSuGkEdYMNgDg?=
 =?us-ascii?Q?x/gHgRHs5lK6Kj83JAA7ayBPuGf/Y78=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd8662-09a8-4edf-223e-08da47caad7f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:41:44.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cZkG5Jeb4+BExGHSa23pvo23xYiAgXSt5rRDZa1qKJlbXP8mkKlCMmC3DQbFe1Rn4Ml78Bzpx4QW2AUOznpSOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3536

'''
mptcp: add sched_get_send wrapper

This patch defines a wrapper named mptcp_sched_get_send(), invoke
mptcp_subflow_get_send() or get_subflow() of msk->sched in it.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Move sock_owned_by_me() and the fallback check code from
mptcp_subflow_get_send() into this wrapper.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 15 +++++++----
 net/mptcp/protocol.h |  4 +--
 net/mptcp/sched.c    | 60 ++++++++++++--------------------------------
 3 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..8d93df73a9e3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_sched_get_send(msk);
+			ssk =3D mptcp_subflow_get_send(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -2195,12 +2195,17 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup =3D NULL, *pick =3D NULL;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count =3D INT_MAX;
=20
+	sock_owned_by_me((const struct sock *)msk);
+
+	if (__mptcp_check_fallback(msk))
+		return NULL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
=20
@@ -2453,7 +2458,7 @@ static void __mptcp_retrans(struct sock *sk)
 	mptcp_clean_una_wakeup(sk);
=20
 	/* first check ssk: need to kick "stale" logic */
-	ssk =3D mptcp_sched_get_retrans(msk);
+	ssk =3D mptcp_subflow_get_retrans(msk);
 	dfrag =3D mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -3107,7 +3112,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d406b5afbee4..0fb2970a7a2d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,9 +632,7 @@ void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8858e1fc8b74..a0585182a2b1 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -117,63 +117,35 @@ static int mptcp_sched_data_init(struct mptcp_sock *m=
sk, bool reinject,
 	return 0;
 }
=20
-struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
 {
 	struct mptcp_sched_data data;
 	struct sock *ssk =3D NULL;
-	int i;
=20
+	*err =3D -EINVAL;
 	sock_owned_by_me((struct sock *)msk);
=20
 	/* the following check is moved out of mptcp_subflow_get_send */
 	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
-	if (!msk->sched)
-		return mptcp_subflow_get_send(msk);
-
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk =3D data.contexts[i]->tcp_sock;
-			msk->last_snd =3D ssk;
-			break;
+		if (msk->first && sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			*err =3D 0;
+			return msk->first;
 		}
-	}
-
-	return ssk;
-}
-
-struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
-	struct sock *ssk =3D NULL;
-	int i;
-
-	sock_owned_by_me((const struct sock *)msk);
-
-	/* the following check is moved out of mptcp_subflow_get_retrans */
-	if (__mptcp_check_fallback(msk))
 		return NULL;
+	}
=20
-	if (!msk->sched)
-		return mptcp_subflow_get_retrans(msk);
+	if (!msk->sched) {
+		ssk =3D mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return NULL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		*err =3D 0;
+		return ssk;
+	}
=20
-	mptcp_sched_data_init(msk, true, &data);
+	mptcp_sched_data_init(msk, false, &data);
 	msk->sched->get_subflow(msk, &data);
=20
-	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
-			ssk =3D data.contexts[i]->tcp_sock;
-			msk->last_snd =3D ssk;
-			break;
-		}
-	}
-
 	return ssk;
 }
--=20
2.34.1

