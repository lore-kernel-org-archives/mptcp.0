Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D44A03
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5VlTJY9JbPMMMUn2npO/epzkMLGx1UtryFk8cI1E08zxo0ZPBXh6WWk1HgYrVBD6NhZ8sFiMWMRG6nyB3UHn8oBi6WqWNWCzcygI1tuzqQJgT04I7MBgxC4gPVIuPmOqtCm6dalsWoCgBKhN7sQPigrH8PclY7Z1TzO96Fy8v2GnBGX47QXpVCxGvNKW0SxHehCxg0h2GG3I1L3zKx2sOM7vv3VV8/uS4NcrqNrTogo299aa8AKGWqJIslSvvZyhfxeXca4IDxuNyIeGwwpIsyScyeH6zkB9Gew75CWHQBPT2kUnp/E1b9bVGjtqHivJSiU7kgVz4k3osUM4RFUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20+GCnoBBzVbCgSvosIBVLqY0bUZqZx3sFmsORdhWXM=;
 b=l/pWo8aRZvs9q/Z/TIrrudN1lDkM3C4eHEExgfwGN+mRvmtr9lO22AEaJPNzC/duog4emO+F0EyUrNG+fveul1ekVkxXROs2lzEkLcc8ZEkh1Y2z6XrAVwMMwpm+mjT2EKvP+quF4LYK6arS9A9z9jHzvd4N12x6RYXX9QwrSe8Cn2b71U94I52r6YILbxYX6FaYzj/lI6mBIcV4nK8VTVh4VH6KqISHJ++io5Pas3zEn0AAq46bwrGoav+iv1aS7dXN/lnrPCl3saaMvyfWND1UJpCkniJ/QhAXMdh60slBnmwaLyotirbr7B0oNFLImr4Oxh1bkKblDwVRbpXcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20+GCnoBBzVbCgSvosIBVLqY0bUZqZx3sFmsORdhWXM=;
 b=cer19A9o3ceLK6tvYUbGJ9+BpaTOyQ8Xq95AWOwpgw85Tbx1+jKgZR6mUG8N3zpl4yaK5YD14GiU2t4pmRnuMk06iDfmVAndtzSjU9aPcaVFRaWd4C1C6XgM8Gp9iHF9fKoW3fmqHtC3ZdoPEcxbATnjVY/qNiluf9Wqd7pq8Q99G6BKpLnOGggOoc75mR0KdI0dz83GmvXjrTgCTuY53W7LENaSLl/j3hr9NI8N1LFydFIVqgUcYkyXBXYHMbSyg8dMxLWBbsoF8kqvUWZ4N56+XprnYF0bpR+tv8KftMi0xwfBBG0UvJ7jALoaD748t3NEf5ocwPg7usvo5XpUdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:17:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:17:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/5] mptcp: update __mptcp_push_pending
Date: Fri, 30 Sep 2022 22:17:32 +0800
Message-Id: <36cf55f71ccee9b9c35eef99b1d776685d2fae50.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664547250.git.geliang.tang@suse.com>
References: <cover.1664547250.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 693907fc-052b-46fc-fd73-08daa2ee7583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WKidw39z6jYwGcLHQGwVdm9zx7FX3I0ypoY7wNyqnmDU2t1YE8Q70+rf/9TWKZJgTUdyRiRLv1sMfDDLLbMRuIlqScBu/QDPmJm2fTi33Wf+H0dsZ9oPHhUHOIs2URGqMkUSgBXSf9L4SfHkWFgAnKRHKnR8mgVDl8gW/eiTdXsXFao6mnm1K5eqGDmtkc/9PEX6/W/yL5hsfrFjLejKe0lsa11engQxVk+ljfQ6K53nBeInK030tsSNyrU7R4myH92pR+lgpUm0/U+aODl9cJQMAE1/DMW9qY+hzn6CDy0Lv9nZLt8AQ2xaMedoVPBvPXCuG1LBUi2JrIG3ppiDgMpyv/JaNxwCIcdNJmGslh7ldY/Yn/sELBozL3CGb8WrqW572HoeXugPSehnxm2b1hQOT0agwQqhMWS2QEMSo946I8DIV3/C2kpHgbRY5V043v6MR/IDlA+1CID95tVISJJ4DZNYCLtZc9ibeM7XbPxyx8oxZlQwgSekQWlQRpJZtI1SlqT5mf1n4ga14HG0iwj7ti1yNc31/6LhatnqmVpABvAoNKN7RwPfI22GsPqjJV8pNNWKjO9JgwRL1CHSqqiGJ86KCxTK2/K7cu71o5xj05SO/o3FmxdvV1TB5wZG1Wlv8ULOViqlmZENY7EDpESKK40o1hM6o0Ftsn3ZuJTyyiywONtQGo05kccEiJVnUrluV96o9k6S6l34unI7vJp93zvKXbLbH9ycz86pq9Sr7Pv3EmZIHdoMUuLBCNqI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(6666004)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(15650500001)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D7HYBexqZDjv1Z7md2Q0UM8Etl206owfh1EAbrXZWVYBkNjMAbODjLf/HL4a?=
 =?us-ascii?Q?DTMFp1jXdx+na4ls0OblpX8NlqkTyLttWzb00Hi9rBCE1ef1FI0wFHbHDlNB?=
 =?us-ascii?Q?oCK1aDjNwWsyXvHspMGas7+7Tmm4jHDlCEII9AFXgaCp6bf6p3KngaPnvDYk?=
 =?us-ascii?Q?1v9vF1uEBbz2gpr+lMEXBzaQzmi9XB7lIAf/a+7YCaWJfs+XCxne8fIgPTeY?=
 =?us-ascii?Q?42+rKfazA2m+qVfrAJhgdkMCQcZaugAToD6KhkajhcI4a7eAwS4GxiOM9J5s?=
 =?us-ascii?Q?Jnb0M8qO8yEowcZsW+DhLGJhgU4w0XT+VCS86WV+ZKPx5Hm+CTx0yS5Sx1pf?=
 =?us-ascii?Q?jHE6/lm7BqgIE17FcTEHhRX5LQVPS6QvUTOG3mp0mBa3DLYCSNVTPfc/kDLo?=
 =?us-ascii?Q?3RXv43Xc5jJL/z4jD6xua6/N2ljuVm3jCnHYO0f25Kp1RmoRR6Y6iV9dalCj?=
 =?us-ascii?Q?19co40lYCp6Mnvu49mLbyZgw2nDx0EO1hvGePYy0F50YTec1GcM2P+Ik6KpI?=
 =?us-ascii?Q?5Fo/mHLyHhMKlXjbwp3XSK8+xIsEYcpW0KmBT2CAFnYl14gI3QEn9EDM8i9Q?=
 =?us-ascii?Q?RF2sPgQkv971Cp/3+hk6Ui/ew3WebRiRpIHB2WOEwJNuwkiJzeCHlzBt/2Qm?=
 =?us-ascii?Q?cY3+iltLCPXoBRrlNhYAVuk4cM73WpaVHZDpyDvZ6exgBErqRgqSDEiwgySf?=
 =?us-ascii?Q?lmJFgTGhxO9ahkrcWfpoft5Nh2/6vFphHHiIZ5CW3ybFNIu9ogJi1JBHJhzO?=
 =?us-ascii?Q?ezj/3LBdhZBtFYT2ZGZw+XwHMyeDRCSzwGGctmQbSgPKjmDWO4nUS+fLWrZR?=
 =?us-ascii?Q?Ca/C5+B1efwcs7bAdvPwuhDXG5R12N8wgyNXUZl430i6kl6TytrsBRzYUhXL?=
 =?us-ascii?Q?0uNn8wv8dYPKrZigIuViO5Pw2sREc24SdLNt9IG/0xuIODzc+ovvzu0Z2wjr?=
 =?us-ascii?Q?m/Hx9PromJVOwUvhJUHLvjXVkkeywjBFgMCaa1/Ro2PaLJyZGeTBpFJ5/Qv9?=
 =?us-ascii?Q?j7Y0kPZZkYmfIwCC+vrpHu9fzOEXsc3yyH4t2FNphz3BYLmsE7phuS59WsEi?=
 =?us-ascii?Q?uidiNwT9XoKyxvEghVQ3rurwrNk58sbE4kG0Shc8KLcYG8M6k24uWxhKjWhX?=
 =?us-ascii?Q?VO6uDcWeaVsnplj7o1krWCygEpGUoDJRiYVAAV+Pxwey/3qLBDirkCNyk3zB?=
 =?us-ascii?Q?1YSwQ6TpKFxxdE9cdPc4NiTZjwxk60JqcwIPhAMP//Wh6kE9B85Tl5FqzuuX?=
 =?us-ascii?Q?hy8hxwEy2qJkGq8Eq8FSKQdAHXsiwTj/GEMhGRrHM/23gdSqG5Ud7fdNDzQU?=
 =?us-ascii?Q?SeTwZe0Ou4ANtjVFj7naTqoEeWl9vfDbaACvTVNNeg3hw9akWJwctdh/Lb1u?=
 =?us-ascii?Q?0IB/TYnUM1Nk706ls/ctoCJEBEjZHoYrFTwBLrbxjsQgHSOcDLJXPFWnp9MY?=
 =?us-ascii?Q?7YXbaFhgKerzfGSfuoyc1Iegfeh2dOXNzCYyqURf+lMSo4CBM3z/D1NfQ1G7?=
 =?us-ascii?Q?RrHFQzrNpzLpgjZI5OWOf+61TPRScIWGYcvmAb1luCKEJWNbpEspeFFvmqkO?=
 =?us-ascii?Q?D1FBzSTzEAw1Pt4xj2Z53ym/nIZ91YvuMEspiFv3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693907fc-052b-46fc-fd73-08daa2ee7583
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:17:08.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCJCe5Jrg/Y0GjMZNTu2uuQUiaMMCeAyXX2/O8Jh9BubJH6MBRvGMRp6IoKlkN5tt0qT2v4KZ4ODz436zcmsrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

To support redundant package schedulers more easily, this patch moves the
packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
mptcp_sched_get_send() only once. And update the socket locks
correspondingly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 85 +++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3641fb73bc1f..99a9ec70c7e9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1417,14 +1417,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	u64 linger_time;
 	long tout = 0;
 
-	/* re-use last subflow, if the burst allow that */
-	if (msk->last_snd && msk->snd_burst > 0 &&
-	    sk_stream_memory_free(msk->last_snd) &&
-	    mptcp_subflow_active(mptcp_subflow_ctx(msk->last_snd))) {
-		mptcp_set_timeout(sk);
-		return msk->last_snd;
-	}
-
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
 		send_info[i].ssk = NULL;
@@ -1477,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
-	if (!burst) {
-		msk->last_snd = NULL;
+	if (!burst)
 		return ssk;
-	}
 
 	subflow = mptcp_subflow_ctx(ssk);
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->last_snd = ssk;
 	msk->snd_burst = burst;
 	return ssk;
 }
@@ -1530,60 +1519,52 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	struct mptcp_data_frag *dfrag;
+	struct sock *ssk;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_sched_get_send(msk);
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
+	while (mptcp_send_head(sk) && (ssk = mptcp_sched_get_send(msk))) {
+		lock_sock(ssk);
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
-				goto out;
+		while ((dfrag = mptcp_send_head(sk))) {
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					if (ret == -EAGAIN)
+						continue;
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+
+				do_check_data_fin = true;
+				info.sent += ret;
+				len -= ret;
+
+				mptcp_update_post_push(msk, dfrag, ret);
 			}
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
+			if (msk->snd_burst > 0 &&
+			    sk_stream_memory_free(ssk) &&
+			    mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+				mptcp_set_timeout(sk);
+			} else {
+				break;
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-	}
 
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
 		mptcp_push_release(ssk, &info);
+	}
 
 out:
 	/* ensure the rtx timer is running */
-- 
2.35.3

