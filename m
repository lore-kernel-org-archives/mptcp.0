Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00081.outbound.protection.outlook.com [40.107.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CE7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1BmI+2UQfpwmZBYCQ5HJRkh8+Fc51tZXGGwxshcBxDUFVrDtYEAI69rBBeGn/S5JVkhvgEHUo3szyH24rEIjZ1XYz1gZSQj1yfg7ycpfe5flpXsieD1EB68SLTPUDeZ9fLtNeuSg6y28AEy9OGze1OHlJ5x/ifGIRkblSFq6KtNqZXkLkzRn1EofWK3VLJgaxeX7BfGzGIEoWvwn831vcT7HiUQ60c/JwPlY2psCFhbt8H+Z97eDSozr+Ratqcb+p8pF9vO9vsGPjYdUaeb+dIwvDArIymmPuUaAjVbwSGyR3v0he7I+p8x8GRus5SQJmNHXDYIVLltrJkPdgZ9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQeH3ImbzrYpv0878OqP8I7EW8lXturQl8QJE9rbHhg=;
 b=NRP/dyyBFD2fXXEiuPSMLJXtwrGWr4EbvxIWx7EcoFek7GI/CugEv8yNarwFoUGJ1g+QA8OZtNWXUaI3cHI5Gw+By08KXj7grKJ0ZkC4HbLvmSXKnhypCaFma5CNxvABfvdU6GgLBNR2Lm/y3qA25at3pQ2v0OHBMIenLkPe04Tz9OwO1yyVO0kZ1IJhQoPBcDer/JPDMoT5rCIrAz8nV8RvdJCAnrevRTKdSRFrj5kMiQl3osnLn/5mPgK7lLRo5wR+5gtKnrtTYm9xhTNorilPtCBgJkWvlfBSH84icBjWwM8mTTZ9FYmT78UGmnw7RNbwYax2B+XfU5iWgCT9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQeH3ImbzrYpv0878OqP8I7EW8lXturQl8QJE9rbHhg=;
 b=b9CpFVOLE72gjoQYH96qmK7J7LcqTzE/RyogY7gnrr7SqDffxJQFJnmUXXcZ/825aiwKgZTjEISQ2sIKWatf4TUcsxh1WjrQ1iorkQLOmhrtuUWagdAzFkMnAsMxgwtDj3AVLQ06zicOHj64pjb4/uXBm+jK8vPcFKcWZ93xyMs1uUslqFa9g0j8lWcXHs16ckTdiMtnYB0GFUSpdkr00MzDH9X/6CZGqOLfPrkpT7QsVEkFZrlml8y2HaxSZ3qEUIR0M4Y2b/V+8kLZwEOUAizjyvl9svYmpSfY7buJJ6zahn4oEZ3bVmmthWk++N2PcS5y+baxGj5cpCVzzrUVQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:06 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 03/19] mptcp: move last_snd into mptcp_sched_ops
Date: Fri, 21 Oct 2022 18:59:55 +0800
Message-Id: <a552af9d09a972538976a1b5ae3159707baa24a8.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::30) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 37964bd8-2a51-438e-eb33-08dab3538d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ixbyFIbaCx4GJXj554W4KvTyUMW7sjr/RmR/GXDtSv9eIzA0qWdfM8cewTLxhGNLGld7t9Yu1nCBr4z4mOiZgBDNUDZg67IayInQ6JWWVIrn5+136fepu/x05BDEDGAkieQN3mozTFuiE5Wujm3RxJEt+fUN4S5rKRwQQTbdslFRJoFQwEP8s1JQO7jkU3NcjEW8OY92aHHRuFgTWgI1tvmvMg1aDyBEeyBtLpGQAC+xcexeRCHc0tfCKghc9Fo02w2TuBo7Zyf6CMS1FY9SVkV3acAb+Jw69m8n2yoAiuZYQD/Yp8OwNdCjTKVzZujxnHEq7bsgc827fg3f+sdxJzvJSI1aUASna1T2vpeKLOKtskVVU9mBYXoxYFLX2rQE55gYNv3BmJwVKKD1YpvGeXXZwL1YzWApfEEscoW6esBkQeZbXAskSfSRLEb05+FQYQzVyjD2KZqjST124NSyy+8S4iDpoOVTFGV3Njf+Hsh6vELTO8SXYru+Sf8t5B0x7I5S9juL7QIokhTfhUTZHHBAS18TMJ05H7t/PGCXH+oMTGxa0kef64ML5ykrWE2plTs3Mh/skJnwjyDP6cmftBWKmTV20d/pTF316/SP39humS+VBOjg/4/+F27XsnTVAqjA4MpeHZ6kFQYNi9CCU5U1m88uIjy7J2eirx7bJbGp67nQ+micNJl4FcBPY1giKkMRhLsh2YREtK9b8uKFBP7gCkXbnJ/jLNbD6Puw3Hw7VM5HOPQrGkx+1neizwII
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KDllGfzk7VbyIDbpvRUidiJNgyPxyTRWF8tN1GeUgJBrQlxs/SCxhuhYAsLq?=
 =?us-ascii?Q?UF+J7eY/ftFXXly9HnZcJaM5Jfxx5YFQU+KJGrqp+z9qwjTrdG7kaoNWJkW4?=
 =?us-ascii?Q?WY7qIX2qfyHToK3ZO12swtXdiE8LPJiCpgogERfAwUQLywqHlpHKPa9pqA6E?=
 =?us-ascii?Q?j3imsFHSPSxrOWdi1d6v2DLHDGUjUL16JM6zCf0wg8Hcw820JvQxwcukw5tH?=
 =?us-ascii?Q?WXN6VUIqtVnvOl3Iw65Z/QmHP1lPniJ0UaARmMuPS96L3a6tEv9vnp9nnHvi?=
 =?us-ascii?Q?Ln3E6AyWnDdMXNU8ULnpPOZZcRv1UmMmTSbEwCzkHBnJSghw2y+1DtGaZA2I?=
 =?us-ascii?Q?6GA5KtE8Xr7gdsC8/MfNw506mvWivizee1wNdZXQXzLvXgbBzRGS7vCvDsD1?=
 =?us-ascii?Q?3+NOtJqoIsvGvxI8G+iIKmGKxXA7LLx9vF6nPKmAEY7qwuUhklGgm1z4pp7s?=
 =?us-ascii?Q?dvoxIDG5Y+GGH7XPuN5pE9OymFJ6Vllo/TlQsE4f67lcydDMZvfN9NXIKczx?=
 =?us-ascii?Q?4km1HYA4PGZ2/LMmnb14wlzjBxkRQor1jQVtjngoJXZGrHS6jyRP6geDo+3b?=
 =?us-ascii?Q?xrmCPV+qrZ8yz5XKDi3InLKlSu9penI5jsbHRaelixO1NA/PeDnrDDVXC98J?=
 =?us-ascii?Q?yATKe5ZFiC+NMtKWAjufKNz7T/lcHmbPgBRSfukpnswnhXGUA/aLyU7X/KE9?=
 =?us-ascii?Q?Sh6C6N5mi8Av8VsqwhjA7hccwQmX214Cj0OGWYlLRdBTGXG26OyZQZv6Nej4?=
 =?us-ascii?Q?MHsfcBb0oGTPALJgH61pS19o3pudYivKZkhHGosaTIzuif/5XIGeeXc9oBFJ?=
 =?us-ascii?Q?pL77y8Ep8ImVyNlwrzS9HiHYVQzweGIsDkdktbyXh9oB8YuczXdWL4D55gaB?=
 =?us-ascii?Q?B+MX0aRhyebJDZUmgkDNyq4hN1M7T3Gukd6Q88ElcVdFkNIeYk/Sp2sDdrTY?=
 =?us-ascii?Q?qBLJbJgncJRwpnnOc2Q/y6MshNY+/jdFDqRxF3w4AQ4KQBfWDDUZu6RFpJ0y?=
 =?us-ascii?Q?XzURfRGly36NjpZM4DveI7aLVLlhePhUfA1Zl2krM+Hn50LuKVkUPCEGYGE9?=
 =?us-ascii?Q?LGzXEubKhmRamH20IU57fDybA2ZS3rp3IW4FUHzps2E+4BnYQT7GO5ai8eYJ?=
 =?us-ascii?Q?cd5kjsZ3cxLuwAp2UeM/UwoR1WtXSlE5eI4i8+FLnUryyknijPPCuyYyWrdR?=
 =?us-ascii?Q?yikiN1BRqYdl8Jz4gD/r4TC93IgS7my/B3Qe0dkpP8ymkUIi/itrjVakF2n7?=
 =?us-ascii?Q?kPT2W4u8Yyk4Mc97eEjK8Oolo0U8Yjvw9WoXLdJUtG3yr+zENNhC5Z/U2PY4?=
 =?us-ascii?Q?drVJvELSfnlSZ9Xpp6kgw06W4/cJCMFQrNddZlLVwNyqxyczUINaKo0Y8bRU?=
 =?us-ascii?Q?y+urc1PM5Wqa16xBg4GDfJ0UA53MO042OErmjBXc8ABCJOpQb4Bm1LbF921n?=
 =?us-ascii?Q?oIfCMsIL440GVeGuyhPKvFFEU884MpmDvIV9osLbiim3aRB6DIG5BrlA3WQ8?=
 =?us-ascii?Q?N9e1/vaFR3+wA+mTJaFqn36dvVCVRyBmiVgYU3Pt+PpI5k6l1IqoPA5lubFD?=
 =?us-ascii?Q?eW22vowdZrTWCbANkPaDnSWiLfzGHHSucMkdpESFtn1YMRamJWRfpoOKi4Ny?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37964bd8-2a51-438e-eb33-08dab3538d83
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:06.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzNcny/Qi1YI4uzOAdzd+H8X+iSTIHHaCAB/eRd9U8fQSL7paD7hCcIaWRmFE/xuYMA+MCmVT9aoqjalhOSMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Drop the useless msk->last_snd and macro MPTCP_RESET_SCHEDULER. Move
last_snd from struct mptcp_sock into struct mptcp_sched_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h    |  3 +++
 net/mptcp/pm.c         |  9 +--------
 net/mptcp/pm_netlink.c |  3 ---
 net/mptcp/protocol.c   | 13 ++++---------
 net/mptcp/protocol.h   |  2 --
 net/mptcp/sched.c      |  3 +++
 6 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0f386d805957..a45e00bf2f3e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -110,6 +110,9 @@ struct mptcp_sched_ops {
 	int (*get_subflow)(const struct mptcp_sock *msk,
 			   struct mptcp_sched_data *data);
 
+	/* round-robin scheduler */
+	struct sock	*last_snd;
+
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
 	struct list_head	list;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 45e2a48397b9..cdeb7280ac76 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -282,15 +282,8 @@ void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
 
 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
 	msk = mptcp_sk(sk);
-	if (subflow->backup != bkup) {
+	if (subflow->backup != bkup)
 		subflow->backup = bkup;
-		mptcp_data_lock(sk);
-		if (!sock_owned_by_user(sk))
-			msk->last_snd = NULL;
-		else
-			__set_bit(MPTCP_RESET_SCHEDULER,  &msk->cb_flags);
-		mptcp_data_unlock(sk);
-	}
 
 	mptcp_event(MPTCP_EVENT_SUB_PRIORITY, msk, ssk, GFP_ATOMIC);
 }
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..1f2da4aedcb4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -475,9 +475,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 
 	slow = lock_sock_fast(ssk);
 	if (prio) {
-		if (subflow->backup != backup)
-			msk->last_snd = NULL;
-
 		subflow->send_mp_prio = 1;
 		subflow->backup = backup;
 		subflow->request_bkup = backup;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 03312e762606..a9d33dea2a8a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1469,16 +1469,13 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
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
@@ -2378,8 +2375,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		msk->first = NULL;
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (msk->sched && ssk == msk->sched->last_snd)
+		msk->sched->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -3013,7 +3010,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->sched->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
@@ -3274,8 +3271,6 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_set_connected(sk);
 		if (__test_and_clear_bit(MPTCP_ERROR_REPORT, &msk->cb_flags))
 			__mptcp_error_report(sk);
-		if (__test_and_clear_bit(MPTCP_RESET_SCHEDULER, &msk->cb_flags))
-			msk->last_snd = NULL;
 	}
 
 	__mptcp_update_rmem(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8f48f881adf8..a58fa261f487 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -124,7 +124,6 @@
 #define MPTCP_RETRANSMIT	4
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_CONNECTED		6
-#define MPTCP_RESET_SCHEDULER	7
 
 static inline bool before64(__u64 seq1, __u64 seq2)
 {
@@ -258,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6324a8a76382..f6c622e15584 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,6 +68,8 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (msk->sched->init)
 		msk->sched->init(msk);
 
+	msk->sched->last_snd = NULL;
+
 	pr_debug("sched=%s", msk->sched->name);
 
 out:
@@ -81,6 +83,7 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	msk->sched->last_snd = NULL;
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

