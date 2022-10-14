Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7A20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeonwzFsRgewjR7Hso7BR9RmZSRtEfyMZ7FNumUHrNHZSxZ305CGP+TLy+9MpyrfP6MuMQGfcsiSjEB/L/QHmsLSppla+AwYpGAndZDxHzfjZJavOKH9GPJ7Mh7668XtwzodghiGs1MNOd06cQJ4gGb59dy6XFSNBACSIzprFGIKOKinY+un6oxEr2N9n95AwEKKyBMMASD5eB6BHbLnFSi81PNmPx0CTe/LcpkKVk+T0Vz9SMgOtME4LlKvgCgXUzEbXI9QnhstVxqz9JlKU2//RV9jxEK3Vv4xmbumiGzY6rV6cNuo8XvL468qpxnV4PVXPK1MYbh1B1AmoSuU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H//fhqCYpo2QBEM6CZIPzx844d9roZonsUtnhx4ZJrE=;
 b=P6EpCCWKCh0sJMUc5ljTiwOVgl5utfbysb0JPauv1/3376u+tO0eZUqGck02UpETXrerr/IjMDNBa2ezA1BtGYjt03OnM3aWVlu6wwggUcbCH5HZ0JL+9GjIo4oyy1SKlCIVCCrPXwyxbp7kfEVtzrzMU9Ge1J6KDosVOzPGiPj/HSW+BjlQVQWGmvIG+C64P0+kgpFCKdCwR8O4NHj6fBN6q91jnZPnveUKjIjvd/50xZ5d88nDc+VwvxSwLaiSeCYcu3eFTJT4i8E7XM5w/wL5ueNy0PwG4uqxKZ5OyNOmxbEg+xoDfHNdEd1EBb85POCdF0q7VZyAmyuuvPr89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H//fhqCYpo2QBEM6CZIPzx844d9roZonsUtnhx4ZJrE=;
 b=GZGZaM1YYfnkAlpDXI/yWnjDrio5wOiUbqPGlMCOaxcK1p4LJDqqVa8mhpOzM4KBTsv8ZznZDmhHs7I30kdSiqgkh+BqtC4kR8h/ToqaXvIFILwxh/cbZl6+PMgbp29tBSZ/KhZ1+KKJqBhtrAo8u43WVy3Q/GYUbysPTiMFe6yAGieq5J4L4hygR3iOIzrLafJ3Gx3Z680vAIhW3pfZxwTjAf1ILPa1U9OfxJlB5d0cHyEV4dJhvvcQkjdMqnuHi55A2IpjIw7qOw6Kq4QJoC+S9rC3HE+i9y4RIU54k3won/RPwoIMy2ANNCsdNPORQJZAuo4U0Lg5I2Bam7eFTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 06/15] mptcp: refactor push_pending logic
Date: Fri, 14 Oct 2022 21:32:13 +0800
Message-Id: <6536ea94e85d6a35da64268649b78fc82256bcce.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: d7cac847-3d70-4fb6-aba9-08daade8b363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WkmbvC4CQ8CkjEvUKcPfPJ/tl+P6QaF/mLym8ENe+V0Q3rkeKU97mRVuNxqNvfzCjowVk5KC/933943A18wLQPTe7ExDRKbuEqBhaPZG3b9c7Kjg9IwJfF8k3Yw5FOveCqmZyxhHtg+dWzn/NELf0a+im0P+BGakYBdocWQPQho7Yn5Dc0NdIQwZZsvScOONuhC4olaRj3oh/aTuzrxC6p364n99s77DERFz4ZuO5WnaXhw/kU5FjC52T7M+CtwTmWi55EyE7Oshva/0RkJ0vFk5/ClAVRCpVPwfkT9UhpP0zqVUl0J4OYeUwGzRaZOIRaPWyTVtxGsnArk5DPdh5bzvosrBiWdl6hefmZAWxhDGwUj2ZAtNW+4AZWOgwhZlgpe4YfE4rxt5BwjNEviy/FKHy/Z9GQ/yUq7ELVMor8cKBb5Exfktv4ANddhn2QtC1c2tJ80fKLb1q+GwJfZOSKaV8wuxmRVwz05AUCQHgzJEOijfa0Os0UfE5pAtQS5IYZv4qf6dZEt14AN0zLqQ7lxKSCLMRzfx054RcXUTgkZ4HNmY4XOdYlzQYQWg0tTgxkBIDeVd+jAISsCFL/bd23trRvyc6js9X2QBcQX45aSomqEaXV0Kt5b7+NW967VYTczCaDI4DR2HvAyf3I89pLx+Ul4aVF2I3VeJQMLxUd7Pqt9gVPrChdIqyJfA2km9CUYPQgkOhsrMiFv8NXLQ6DzK2iE0Eb3ix7tn261l0y69j/RJoNfdCnq++F4gkEGP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0aTGlOQUTki4NIIImek6wuh5saPuK3uxETB76oTFftAlPlbrbRCPR5zikysF?=
 =?us-ascii?Q?GieKjI8Dfi0anWKMuePVRSCqIIOtfdJn5f1373Im6XoCDv+EOwR7rmziu3E9?=
 =?us-ascii?Q?/kHOb7jup5dDzBC6RKHZZ4qr3T+ztSwV/PJCwsj5IAWtNH78o/g1jp5YS2R+?=
 =?us-ascii?Q?ZJCLG6Hr7XtUEiuLkoiMMmmiytpv5f4TOGMzrUrW3hxrc7dXtEEmRphNsJPq?=
 =?us-ascii?Q?TevesWjKdh2dsErsniHlBNGdBagkLxlrsTafOunjHEB8EBwaOb9hHWwf5vsr?=
 =?us-ascii?Q?nLdNa398GVClebHGIGtR4XI4l4340EQsXGg+/3fa93UV9NWOIeLk5JRCySZg?=
 =?us-ascii?Q?SQUiexh5eJEs5fVJaZY4QTRoi/Oqpv2LmCDxYenVWdh8xPb1VbsTyjXaui1D?=
 =?us-ascii?Q?wipI43aNkqNOLVsKsE9ZQqqbVZvGMFwTLeuDmlkmUEjD/lmFI7DV5P0m2l+v?=
 =?us-ascii?Q?GO8KYnZZ2vAaktTrhbzq0PUU2VBKL/6JELn7r+am6F+AN9SBJGnmlcUQRjyW?=
 =?us-ascii?Q?pUpErBwxOloRC2ri+tysLTgGksTdBjilaiHLBKXKwAkwKaWfX8m+rL4CbuM+?=
 =?us-ascii?Q?FcVYH4D/VX3/frmBz/pTaWVT0VqtbXWpzgb9M2DLSRfC/u8emFJf6X4qaC97?=
 =?us-ascii?Q?EX8n1T1RGt//+hZsCCptf/gMGHj0beLcjwfsgEfgUCtGa+d76jkNiMb8jqvi?=
 =?us-ascii?Q?LZY7/3ivKNFqaZSvU7sfx443YriKm5XMv7Kv4R9dg7DekhsUJgDxgVO+BMzu?=
 =?us-ascii?Q?AP/tNNPwGyQXZRvVC/6ln9axG2s4qCL7h0ujcB0O2RCRLL6i6rIV8rBLlUNp?=
 =?us-ascii?Q?F80PwGlKv8E7iMKLOJ/U+nzqtuoGKNZ4BTg+m1Zca62BkIvhTi2E+njXqV6U?=
 =?us-ascii?Q?2i8VzndNY4wYKzkMDc4bTY4JwCsuU9HWIx22apJNwYHXbCAVj9d+xkDsCYRW?=
 =?us-ascii?Q?2WgLB2Ywo5zd5CcaqbxKaNipz7wtEO6cPRxAIapzKCeV0gp2TIarUBZ+evGm?=
 =?us-ascii?Q?WOroQlJwmRMLDitdaw8JkRXlhIDV4h8aZfbH6FXduxxcIiq/TZVgccLCVNHa?=
 =?us-ascii?Q?du2+8jLmZ84BVZhSqF6OQ7wje1TO+96RDheeb7pkH0nDKmz0Sl0C6vAWq7TV?=
 =?us-ascii?Q?k8tB0u7a0UG2h3Gc6jFQ96Ci+9V47fJLeKzGWj1gungmaY+IxdrMpnOsCQmn?=
 =?us-ascii?Q?xhVcJNvCpol52dLkq3iQ6AeVc8nZ2ANljagqY7U4afCqw3mT9lGCfnwRcDse?=
 =?us-ascii?Q?gmfqFqnfYWWPr5sl/pHKMMGH5UgDWloEIsQPfogKtxL1SNp3WNo8BCfZHxSm?=
 =?us-ascii?Q?iq5GV1iTSNrsMjM1EDwYBA2f/w10HlOydc+bb1CCCE2ubw540apOzIoGUfmf?=
 =?us-ascii?Q?IAEAI0L70hpq7TluFRr4J0OoBj76rZg360IBY4dHsp62X9qmjXJqykCU0svT?=
 =?us-ascii?Q?bHh/PDRwF+RgiQwXw/zs9PMk+Rt5cDvWltCL/rQBR8HVK2Uno8qwqcpDwjEo?=
 =?us-ascii?Q?trxXPiUl5HxqwkWX9n9g3Ga1pTc7d/g7vU/iXEfFoj8Hw2YtCybcmgP5YPTP?=
 =?us-ascii?Q?E2UJy/mG9xbgS3JRmeFYkQJZcruCJXDsSM393/Tg8ZpjcDS6u60zwRGmULT1?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cac847-3d70-4fb6-aba9-08daade8b363
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:38.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXHITxQ+1vMe2CXcUyrb8KX6X0/4lXw83h8xqXsWlkNbxhsC/T0BIRxunONE/9FdP1xNOgyYy8ui4Pd+7VINCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

To support redundant package schedulers more easily, this patch refactors
__mptcp_push_pending() logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Update subflow locks (push/release/acquire as needed)
		Send the dfrag data with mptcp_sendmsg_frag()
		Update already_sent, snd_nxt, snd_burst
	Update msk->first_pending
Push/release on final subflow

->

While the scheduler selects one subflow:
	Lock the subflow
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc
	Push and release the subflow

Refactors __mptcp_subflow_push_pending logic from:

For each dfrag:
	While sends succeed:
		Call the scheduler (selects subflow and msk->snd_burst)
		Send the dfrag data with mptcp_subflow_delegate(), break
		Send the dfrag data with mptcp_sendmsg_frag()
		Update dfrag->already_sent, msk->snd_nxt, msk->snd_burst
	Update msk->first_pending

->

While first_pending isn't empty:
	Call the scheduler (selects subflow and msk->snd_burst)
	Send the dfrag data with mptcp_subflow_delegate(), break
	Send the dfrag data with mptcp_sendmsg_frag()
	For each pending dfrag:
		While sends succeed:
			Send the dfrag data with mptcp_sendmsg_frag()
			Update already_sent, snd_nxt, snd_burst
		Update msk->first_pending
		Break if required by msk->snd_burst / etc

Move the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). Simplify __mptcp_push_pending() and
__mptcp_subflow_push_pending() by invoking this helper.

Also move the burst check conditions out of the function
mptcp_subflow_get_send(), check them in __mptcp_push_pending() and
__mptcp_subflow_push_pending() in the inner "for each pending dfrag"
loop.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 160 +++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 88 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e95a49e5bc89..c3a4e0148c4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1427,14 +1427,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 		       sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && data->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1501,12 +1493,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1536,70 +1522,83 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
-void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info,
+				  struct mptcp_sched_data *data)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sched_data data = { 0 };
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
-	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
-	int len;
+	int len, copied = 0, err = 0;
 
 	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
 			int ret = 0;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk, &data);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
-
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
 			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+				err = copied ? : ret;
 				goto out;
 			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
+			info->sent += ret;
+			copied += ret;
 			len -= ret;
-			data.snd_burst -= ret;
+			data->snd_burst -= ret;
 
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (data->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			err = copied ? : -EAGAIN;
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+	err = copied;
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
 	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	return err;
+}
+
+void __mptcp_push_pending(struct sock *sk, unsigned int flags)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sched_data data = { 0 };
+	struct mptcp_sendmsg_info info = {
+				.flags = flags,
+	};
+	struct sock *ssk;
+	int ret = 0;
+
+again:
+	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk, &data))) {
+		lock_sock(ssk);
+		ret = __subflow_push_pending(sk, ssk, &info, &data);
+		release_sock(ssk);
+
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			goto out;
+		}
+	}
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (do_check_data_fin)
+	if (ret > 0)
 		__mptcp_check_send_data_fin(sk);
 }
 
@@ -1610,52 +1609,37 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
 	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			/* check for a different subflow usage only after
-			 * spooling the first chunk of data
-			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk != ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
-			}
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-			data.snd_burst -= ret;
-			first = false;
+again:
+	while (mptcp_send_head(sk)) {
+		/* check for a different subflow usage only after
+		 * spooling the first chunk of data
+		 */
+		xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk, &data);
+		if (!xmit_ssk)
+			goto out;
+		if (xmit_ssk != ssk) {
+			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+					       MPTCP_DELEGATE_SEND);
+			goto out;
+		}
 
-			mptcp_update_post_push(msk, dfrag, ret);
+		ret = __subflow_push_pending(sk, ssk, &info, &data);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			break;
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+	if (ret > 0) {
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

