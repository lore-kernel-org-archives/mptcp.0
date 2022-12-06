Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3F6AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:23:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1cOwUPgqglY55U1RHxOkw6VuD2zeRDr0iqM9aadTWU27kkbQ4z2ukRGJcpN6RDVej299GiM6ryYoiDaFpbAXd8v5f3cb+ZmGZ93z6OKLgULey6tHsV4o1uYW+S/iQbx2qg3qAV97f7MTUnzCT/k/YQ8LxzIm6BMU78YyrW+yYK5+1AsP4AR7W/SnH1Rx0TYXH9uUSbAgMLDcZmPlrJWiAbalhTIActJt0TgUvooXAjIkoE48vdoTgqcK8iHT37GifgC0otDvKoRBLEDy52QAG4pXMmoxwlA9k4L7pAqDdplYGIf8I5thHeahAm7r0YoyxcuE79NEucZBWK8PK92Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytO5i73bo8XabcHy8U0cm8c0E1rMBQue7d33gLK/K2c=;
 b=NSJZyIMf1ATufuMwSd7O1RMV62pyATIIqPMnZxssHjNIOjhrQh8wpZHNrD2A0oIpGxoHq8yzeHlDxjAeP2qdAHCdy3kT/ZBTq1/uFCjdC3gSkStVu8S4NRw2dtfxK4TSybVGM7SARpK5TSbIzcjJN4yC4gUcjVxCISake/EgVgeKnXEs0JQVccLMzIZplyyipqBUgf4jRnQqEQZteinNBjuFiFPh6DqGMW4IEcHJ21nCJig9o+sxsis10BbXcHUGOG0khbNAzHecEqDVXOH9LuSmm7+cxTxyqNJoabfaQRjAG20PXqZoka29hs2q3LTHm6AEqtR6s2bfcUbsoYlTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytO5i73bo8XabcHy8U0cm8c0E1rMBQue7d33gLK/K2c=;
 b=q6J1e+p0nUceQUQoUhIbU6/PAp1ojnXHv2DJZl9toyDcPZU59jeSTfjxkyLBdY9yCG5v9WnWkG0cqrbjJbkugcjD+If8dQFM1HxQLuxPB+Hunb+61cLp0o9SqG+uWApITXQCEuoPj+Y6yLHV07U0oc3+rJWClsm/1CdoxII2evRe0hVSVlkjNc9SOmCbvtqi3OPW9PfO/Tu9XGUM0HJPhS+KATlCCGHH+UHQaxu+E+dEixR/rHIq/hIiZjyUF2BPzeTtrZ8d/pvipimta3VGijmizVkmLWG+WXXA9PCTk0hzx5F8onua+ZZPhp8xfSQWA+3EKeWYAv2RUUEB/JOaAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Tue, 6 Dec
 2022 13:23:13 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:23:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 2/5] mptcp: use get_send wrapper
Date: Tue,  6 Dec 2022 21:22:18 +0800
Message-Id: <e55f8878f42b242e3ef22eef5536ea7e64d81f7e.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670332660.git.geliang.tang@suse.com>
References: <cover.1670332660.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 7accb003-7f6c-4925-5ba6-08dad78cfb10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wwwfq0Pn33eqBmUBaM7aE6fq7l3h9hflTdyioW3eH4ftBFerdY94/oK1HSlYBen60ljC549cbx+SRB7J2tWKXHHO0gQVAQY/FahbTj9/gQJc58+SJn1x44sujd+ps1cI1s82aQHckyUyOxj00/9+R2TFYMyvKyK1VS7oQz8Tz5iNbAMrB/vaf86aMG2TJgi+epe3ksW+QN3WsA/lKubwOb3XoxDdAgFfj39Fh6EiS5wufsxmAmLWPMpHonC4zPnF5f7f7jBTpxCQWpW/tioKsF9iHDoqOfT09FdObUNU0AOrR48Tha1LvEba99+8uKYe4qMK129jWkjFSM0wEPFC0vZQbovAour4mrS7ApA1kfG5wa7mXv8qHyqdUexNnrXveNalc6zJVLapB/PBQANMxAA6Q8fbABGKjBCJCuLdceVPwc4U42rg2CU7rm/NNRhqNHbeQ2W4fmkhI/frC/SnyLv61ajFoWcxf64Cer6TF7xERn6YYSf2vrfP0s7ik9ZGBzGY4LtuEeYwF/gPMb7msIkHCDiXfj/Ar4eFQYNbesjNKr5XLPURgcpEkmb62B6+3dFPtBL/O4Oay/QG5vRTJeZTCflDmn7M/7730rw7ETPUjda5fs+dBznojHdKt1CEp544GyxW4xOnAs4QNSt6vg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(36756003)(38100700002)(86362001)(41300700001)(8936002)(2906002)(4326008)(5660300002)(44832011)(478600001)(83380400001)(6486002)(66476007)(316002)(66946007)(2616005)(66556008)(6916009)(8676002)(6666004)(107886003)(6506007)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/LotZ8BaYUxX+eW94yzrd32TdjZ6lfhL/gWZRU+rGc39ERGnlhY97O6Y1vn?=
 =?us-ascii?Q?ZVj8GXHoekl/a8QUhEnKpI7I10e900LTd881OsSgvCf/bfKf0Q1zsvVFzwFS?=
 =?us-ascii?Q?4smTCrolM/FYoUSJdSHPu1D4B1Fd9/MTqMTTy7n7Jex1rw1gMurEZGey3kC/?=
 =?us-ascii?Q?fXv+tOqpaL4ZygicpiS/cSE2UoGy4U53NHMvaVCTXZZhLCjgoetifDk7TqiE?=
 =?us-ascii?Q?8LAa84MVW9NOkwKCiEuijE3DqKDZVySn0JZ0iqKjIOdLrxljhmoST0/8MbZk?=
 =?us-ascii?Q?IBpZY+tQDYWWhniyVGcYYmz5JAmUVBzGzqW47msWepiU6U3Ec27dTipGi+Dg?=
 =?us-ascii?Q?fuY3OOalQX0qqG1IJWhJWpYrLfMTs4/+GFuDmp+9YB9n8QSW0Hx0aXIXqPgo?=
 =?us-ascii?Q?c9+Cem/luCiFmFPyi5t7F6sRapoKIJat4oJBhrCvZcMXaBL3hsFa3FJBiKgL?=
 =?us-ascii?Q?9EXKQc4wtddTDros6RdyjWogt3sHj6VZ4c/w/amw/WLB8vAwYM1Y03ck2o3+?=
 =?us-ascii?Q?lOWrwnrdnH4E1AMdrb+6dpGuvPZzY4eQEEBGUV0FIE2eHPpGbMaAn8R6iNGB?=
 =?us-ascii?Q?h789remokdUpuflhiaJjMrg2UoQwyeCf6Q472Ii6T+0suqOGTuyXGP5yf5FY?=
 =?us-ascii?Q?YPFBhsusCs4s6uV3sk2H9d9La/PknhGM8bN286HtSiaOrhF+oCVCGdEmYJqG?=
 =?us-ascii?Q?uoMSERY/GTt6qIW0PudT+2pbPaL4xqfqIKmG8Gzk7Kddv/wvDIwvlIBuheCQ?=
 =?us-ascii?Q?Xux1wt0VniMzdPb2703V46VpD8xug+rfseOi5SDYUMWfhukO3b8b0Gbqj1IR?=
 =?us-ascii?Q?LVcsjEYCO1nG3EPx31bbpH13FB68TSuGZClk04gOBzs/WChMRBJVytUxBy/g?=
 =?us-ascii?Q?PC03JhPJHoyzgN46CsguGrxMBCI95tqfu3i98x5SrprBxpyUCku8FcPEkTRx?=
 =?us-ascii?Q?tKtaT/WdYPOCwPtGscO8+1uj95FnH9VnJPgx7alO2Hz1ALv3Kp/9Sfwha2TE?=
 =?us-ascii?Q?4tTuYoMrRdfGTNCDdzYZee12AhaxCQlKH/z3hUIGGRmWkIkhVra7gtKvuwBL?=
 =?us-ascii?Q?Tg90Svuwty/fAzj2m0mrpFR2YkzJ0Jy93cmLXHQtTl9EEAVSm83dRC/CG7L6?=
 =?us-ascii?Q?LL6liVqgwCqE3X5hhRF5gCRl/SvafgMVjDDTq6qASCgL4JCWGHhlo35HzcY4?=
 =?us-ascii?Q?IibWza2Xsru1b1r3IjZ9VUCliqFhAr2fbnq3ym59ydJdS0DyFPCDqpMpBb35?=
 =?us-ascii?Q?k5muWa+iQ74bFwwNC+XPOTyWISO/lLiYupawY/LyHL51t4qm+OJSNAitWb8T?=
 =?us-ascii?Q?+dloF4kk5jt4U9b1p9ogzW3lwu+OhUewHqKKriMGzhu1Qi0xmy7zKbc7I1pq?=
 =?us-ascii?Q?/h01vajwevkiCpzgRzHfnNGN2Diod/B38NHo0uLuZXqAB9gAft3+XYYm2zaB?=
 =?us-ascii?Q?Yvy6K8vHCqCJGAEtOJBJ+Uzbag2xUEcpc8TFqmaDx9trA+DjGwIP2lUu8ew4?=
 =?us-ascii?Q?mY5VGd6gDrDK70DIKTI8BpQYNStFCuwEZY4BNDFaR84m82kjNkLs2e3UsTYO?=
 =?us-ascii?Q?p8soVP1E5IBVUJqxotSx/4apCcu3Sj5IZvuQqEkzHAB3bOq9HoljD15E7ne1?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7accb003-7f6c-4925-5ba6-08dad78cfb10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:22:53.7017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e77d86S2plYEm0kZkzQ4WN8byfkzXo+dVFVy2khXhGO2Owgfnn6fIro+CBpS3CXdl2KnUL6t+WTZmA3a/AcDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

This patch adds the multiple subflows support for __mptcp_push_pending
and __mptcp_subflow_push_pending. Use get_send() wrapper instead of
mptcp_subflow_get_send() in them.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_send() wrapper
from mptcp_subflow_get_send().

This commit allows the scheduler to set the subflow->scheduled bit in
multiple subflows, but it does not allow for sending redundant data.
Multiple scheduled subflows will send sequential data on each subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 126 +++++++++++++++++++++++++++----------------
 net/mptcp/sched.c    |  13 +++++
 2 files changed, 93 insertions(+), 46 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d55a02c3f50..d5de01bae61c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1408,15 +1408,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	sock_owned_by_me(sk);
-
-	if (__mptcp_check_fallback(msk)) {
-		if (!msk->first)
-			return NULL;
-		return __tcp_can_send(msk->first) &&
-		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1563,47 +1554,61 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
+	int push_count = 1;
 
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && (push_count > 0)) {
 		int ret = 0;
 
-		prev_ssk = ssk;
-		ssk = mptcp_subflow_get_send(msk);
+		if (mptcp_sched_get_send(msk))
+			break;
 
-		/* First check. If the ssk has changed since
-		 * the last round, release prev_ssk
-		 */
-		if (ssk != prev_ssk && prev_ssk)
-			mptcp_push_release(prev_ssk, &info);
-		if (!ssk)
-			goto out;
+		push_count = 0;
 
-		/* Need to lock the new subflow only if different
-		 * from the previous one, otherwise we are still
-		 * helding the relevant lock
-		 */
-		if (ssk != prev_ssk)
-			lock_sock(ssk);
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				mptcp_subflow_set_scheduled(subflow, false);
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		if (ret <= 0) {
-			if (ret == -EAGAIN)
-				continue;
-			mptcp_push_release(ssk, &info);
-			goto out;
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
+				if (ssk != prev_ssk) {
+					/* First check. If the ssk has changed since
+					 * the last round, release prev_ssk
+					 */
+					if (prev_ssk)
+						mptcp_push_release(prev_ssk, &info);
+
+					/* Need to lock the new subflow only if different
+					 * from the previous one, otherwise we are still
+					 * helding the relevant lock
+					 */
+					lock_sock(ssk);
+				}
+
+				push_count++;
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					if (ret != -EAGAIN ||
+					    (1 << ssk->sk_state) &
+					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
+						push_count--;
+					continue;
+				}
+				do_check_data_fin = true;
+				msk->last_snd = ssk;
+			}
 		}
-		do_check_data_fin = true;
 	}
 
 	/* at this point we held the socket lock for the last subflow we used */
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1614,33 +1619,62 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
 	struct sock *xmit_ssk;
+	bool push = true;
 	int copied = 0;
 
 	info.flags = 0;
-	while (mptcp_send_head(sk)) {
+	while (mptcp_send_head(sk) && push) {
+		bool delegate = false;
 		int ret = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
-		if (!xmit_ssk)
-			goto out;
-		if (xmit_ssk != ssk) {
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-					       MPTCP_DELEGATE_SEND);
-			goto out;
+		if (first) {
+			ret = __subflow_push_pending(sk, ssk, &info);
+			first = false;
+			if (ret <= 0)
+				break;
+			copied += ret;
+			msk->last_snd = ssk;
+			continue;
 		}
 
-		ret = __subflow_push_pending(sk, ssk, &info);
-		first = false;
-		if (ret <= 0)
-			break;
-		copied += ret;
+		if (mptcp_sched_get_send(msk))
+			goto out;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				mptcp_subflow_set_scheduled(subflow, false);
+
+				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
+				if (xmit_ssk != ssk) {
+					/* Only delegate to one subflow recently
+					 */
+					if (delegate)
+						goto out;
+					mptcp_subflow_delegate(subflow,
+							       MPTCP_DELEGATE_SEND);
+					msk->last_snd = ssk;
+					delegate = true;
+					push = false;
+					continue;
+				}
+
+				ret = __subflow_push_pending(sk, ssk, &info);
+				if (ret <= 0) {
+					push = false;
+					continue;
+				}
+				copied += ret;
+				msk->last_snd = ssk;
+			}
+		}
 	}
 
 out:
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c4006f142f10..18518a81afb3 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -118,6 +118,19 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_send */
+	if (__mptcp_check_fallback(msk)) {
+		if (msk->first &&
+		    __tcp_can_send(msk->first) &&
+		    sk_stream_memory_free(msk->first)) {
+			mptcp_subflow_set_scheduled(mptcp_subflow_ctx(msk->first), true);
+			return 0;
+		}
+		return -EINVAL;
+	}
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

