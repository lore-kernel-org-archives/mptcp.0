Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00048.outbound.protection.outlook.com [40.107.0.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EB47B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/o6wiRQ8dGbQrs37ZE/nX/fniNUmleIemxdMCeKrXp41No1+M95gFWNeCrod43Fb6XY7sf1dk+n90AzHxscGL4W693PolsO1pL0TXrDf5GQXY/PxpZ+ILP0/5a2rC2b0hUiExKajivMlqVS9/GohApJh9hWZMGnKwshvF9G+IyYaszVWYwsMEQbObk1htKmhAoMAh4t5KqMolA9RCUWxbIFtlSbcv49OyrJZG+ZSIXgi0AZCgY1LilJKmuI9LLfjnjIgOad6zSsNvcKJR/Yl924rWJB5DOCrJd1LWgqaAqIH3y+H0A1ty1mJOo3MVQfTEKjnh6/027v7e6yYmodig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boy99iNTYOGEolv8Xa3CF6Lzhhpg7VbE5nJ64sazsg8=;
 b=Ft1k0c4/4uAPY+I7BKRrQkiDGpUhAy+b7xkqOzGNJdJlvohmLFACjdtbHrHxBtBMt6X1zK7NyMmlxH34yHRXbX5SYqo/eUMt/OTYb4QKNO7wBckM5t0/Oxn2u9K4WUgFsVlD2cTxda3gmfZCn+iR9MsTqkAVDe/xpmimjjHmMW2RcfcLdppoElhsk0iZ35PUwXP94W2PndrRZ7CVsPqlJglqAUeUmmu0znKdo+xSS51IwAoOWHCUhO6x7xyTPxVSiAp1e0GRjzPaVZfTxIMs/YZi0M8X7Lk87AyXd+xM4+P0QQa2Yx7gHXl9UxKOIOTifP0acBIVXXx61c3rWG+Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boy99iNTYOGEolv8Xa3CF6Lzhhpg7VbE5nJ64sazsg8=;
 b=kiDXmv0mo8AWkx7EK9oVRzFLVBjrg7vpc+5NMwWynMEiJ6sFlhwSZQmSLfmF2Cg7qzwhCTBGVjgPainc9vZ7Np/6WCtT7+iKHL0IJqrSlAm6iuiAarIInn/Gp4dtgVxIzvh2w0ymoODcEAPIkeWu4ZGDE10JELIkkXDXQepla7xINXZuNJn9HQczy9zsyerrQDBfVvhYZVn1SqPVmyRsfksuIa+BDe+szWCJnrQ3U3liu0JUcOmEL/pMhbxB5+Lk+B2HimdVoZJXQw0IErf+KRPH9sIChHZLZT2Lf6hwwQduAizOkyfyO14BFqPBI83m5JzP9Y1mzeSZn28+vRY+ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:17 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 04/19] mptcp: move snd_burst into mptcp_sched_ops
Date: Fri, 21 Oct 2022 18:59:56 +0800
Message-Id: <14220e2e48a619afff73d8935901024fee37a710.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5e3fd4-5021-400d-d872-08dab353939f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ss4s8sKH/Aymfh3SEMvCsb9QdkTSjWg7mg1a6yazQalL5AoB/+DaC5zAnM/aVk2NMMp/+E9IyM7oyCJ91ckxVBn6farC2pDjxtox8YXAQm5hDLPjJDrV1t1tnp+LBjXgLhM6FKRJkl9+dY9cdubAdmAHe65jlUvN8vL7CcbwiPIzbtrinr5JQZOaeLyr8bMW2ah9Gzj2ZEOdNU8Wz/JIpa5/yAmSeIu12McjcHqj2lOEv8czwNrX5NOPmGYBim6OxNlhVJV0wuzidHZQdWvQHfk8Iu2gh7EQIO+KuL7gD7x/9zrJIaqnHSnHmFVBuv0uwczt1hRTPmkZ3jhA1ArpkvjWUhoAGgWUmh2OYsDx82oTIqtbhO7TpVjwmOoHo4A8V7+ZzOsEVNfbqZ77JBcRuHENBC8S+RDZQYOVtj4EzMuUbHdMWtJqH8JxBp1XOyfcLygElpF1VDF9hsGHX60usPOQ1ZstFux8w2r3xZXKAsQgo+6nwYXfuBOXgQdnNjnNi0dJ6O/IDeb19nbUqZ+hKcoy3KjIb9ndXuV76qkffF6oGGlpL5Q9+AqfKr+HYLETgfYyLEus70P92R//+qqRvljiVP09+CCDjPvwYtT43xqf22gPcrRsIRosMsNDSe3ubT9CEolG/bAwJwZliJy7XgyGOSWo8xt/N7RXiUxaJxD6v1s+vSwzML81vznvF5hVp7rrG0q+o9SdkanSQJ3OQDT+qrVl5XAQQVfUl4ItBkzQxaF3/rQ6KEFRMfFGbieK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(83380400001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DtNJpl6yArPulZL4guQ8mYYAhUYJnXhpKzKRrKVXFpeu6Iw/tJrlmM9O9MqB?=
 =?us-ascii?Q?iUT67ZeG2MxZ1AW0byZe3PKoDsHTtqiQRdz/n+QfQArt9z9CCywCsEQx0bHq?=
 =?us-ascii?Q?2+obfh4t6E95Eg71Qg/Q7m25rS8kR9x7M6uKB/tj/lFO5NMgRyIhuOU2q+aD?=
 =?us-ascii?Q?+eweId67n6g5Dt92uKWJ3NBV7XqjfrhyYVSY33NUNkzW/PMz+GgaoyntC1+J?=
 =?us-ascii?Q?BO0352D3JczJuPwMxTA/jPJRFPi0HmBbUzGTFo32Nt8bBWhKcQVtTrC2wlwV?=
 =?us-ascii?Q?Zq6iDFlTcQCcORrjpgKmiucNvG9ameNhUfBGgGKLNUyGkFIE9Aip6wNFZXrS?=
 =?us-ascii?Q?oOWz15uI5SNI/PXeIYGSCHvrqLe8iBAVJTxZDEKqTwmk8twRxzAjSlMrdJiD?=
 =?us-ascii?Q?VWOkqtTCyThkPoa4SwKdfg7llvDp7vFwSdM85QSdMccyCrvSU4f3UHeKZ1tP?=
 =?us-ascii?Q?mHo3g6QpSeGAXtNHX4m1rXlAWthxkQSBV9NZXUfYd0w7RB9Q9YcbhFLWop2x?=
 =?us-ascii?Q?6RcB3PK4aO0SQx13nk704DW1Zt5fCfIhSKRYsaULZvZnKBXwrzKPXGA29570?=
 =?us-ascii?Q?ppa8GyuDy49eBCx/JY1dV8Bst7iQe3uT4b+wttvbrxSxn90w0xIdjurxQblA?=
 =?us-ascii?Q?2T26kaJiESDN11iTEEfqSx5XzWJMwQpqr+naYoqhArsT/INT7ghG9nSsKUJc?=
 =?us-ascii?Q?2ctyF+NTLIAQU6NGYmliqVHijp8DDuDcZFj398Yr3iw9vzA7a43F2SwZkCxm?=
 =?us-ascii?Q?l0YBeP+sxsjWQhpno4LwuhaY9Ed0FEYVlOL0GWPPkE3Hb0RuqM0l5UlfiEut?=
 =?us-ascii?Q?EHc4ozSeq2XbQEDElXQ7oQlfKGa4TadzyQBglFiE/CcyzrP/gx00b3kEPg/4?=
 =?us-ascii?Q?J8LMV/W6Jlnqypz+72VT1l0mDi7ooPpnLMOPU2/5DFV00T5Bo6OzIGPUyZQ6?=
 =?us-ascii?Q?wCaVjgT0l2ZXXcZhl/xSApduHfXYjBr0Wt5IAQ/B39X/iNJ2kmpDXTfV/MHs?=
 =?us-ascii?Q?ANCO0xFEDqQYh3hcFUmCWJ64Dmh514CsswJWqhSPx9sK8lgrL5x0gvbNt50g?=
 =?us-ascii?Q?uxV2DEBE+jEHwbxxZpgH6UkEK7OJa/xnjmHmdHZeoJj6AoL8JI3+51iuAZau?=
 =?us-ascii?Q?XFGGZ0XMHI+wfBBocilB3TRo8tFGXyp0KW3BQYD3+yPKp/5IObmhI3uh/B8X?=
 =?us-ascii?Q?l0zHmfhGMsmZEHxmmm+3zHd8HlGpk0GjF5X6LbR5kJ35oQGNvPlEitDkJw8C?=
 =?us-ascii?Q?fXh15raT1zhog4wkuYvWkld7LO9KdYYkICqT9ilV86cZx9rFAiaNm97ym0vW?=
 =?us-ascii?Q?o1BCFzCQCWpecQbDH3px15sQFgqGrllTUFTZKoWEF+zJPRNmfZOf3acVW18C?=
 =?us-ascii?Q?YgnyEjxOzAzGK4Ba98U4mR1jX5ka1LumY0snMFuhoG5HQmoxKQoKCLc2f8ue?=
 =?us-ascii?Q?6GeYdQRDDAfGcrK20BOyAf8hIToMYNQVJx+hlagf3CrXnuU6zk2X44f/A1d2?=
 =?us-ascii?Q?vZqbspW6+8Br3l8FPLUHgAlZMhLP1V8DIXCWwq0OIbHBTEC0sovyuWhkFYKE?=
 =?us-ascii?Q?3kYzEQ5tXJ9qLt2p49t5ueXT9VNu4HN+0RAotKyb1k5D6WAJq7B/I26rYL3Y?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5e3fd4-5021-400d-d872-08dab353939f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:17.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbl4IZFZvIi6sWgfUDq+Us8gIQQje1d86OuvuJ2fyPuUqGJHU6JOicC+MVEdkhCR1qUuw4VxBdrDy/PPuNwv3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Move snd_burst from struct mptcp_sock into struct mptcp_sched_ops, use
msk->sched->snd_burst instead of msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  | 2 ++
 net/mptcp/protocol.c | 7 +++----
 net/mptcp/protocol.h | 1 -
 net/mptcp/sched.c    | 1 +
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a45e00bf2f3e..a0c01bf153b2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -110,6 +110,8 @@ struct mptcp_sched_ops {
 	int (*get_subflow)(const struct mptcp_sock *msk,
 			   struct mptcp_sched_data *data);
 
+	/* burst scheduler */
+	int		snd_burst;
 	/* round-robin scheduler */
 	struct sock	*last_snd;
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a9d33dea2a8a..594206bfe9a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1476,7 +1476,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
 					   READ_ONCE(ssk->sk_pacing_rate) * burst,
 					   burst + wmem);
-	msk->snd_burst = burst;
+	msk->sched->snd_burst = burst;
 	return ssk;
 }
 
@@ -1494,7 +1494,7 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 
 	dfrag->already_sent += sent;
 
-	msk->snd_burst -= sent;
+	msk->sched->snd_burst -= sent;
 
 	snd_nxt_new += dfrag->already_sent;
 
@@ -1545,7 +1545,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		}
 		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
-		if (msk->snd_burst <= 0 ||
+		if (msk->sched->snd_burst <= 0 ||
 		    !sk_stream_memory_free(ssk) ||
 		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
 			err = copied ? : -EAGAIN;
@@ -2285,7 +2285,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	mptcp_data_unlock(sk);
 
 	msk->first_pending = rtx_head;
-	msk->snd_burst = 0;
 
 	/* be sure to clear the "sent status" on all re-injected fragments */
 	list_for_each_entry(cur, &msk->rtx_queue, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a58fa261f487..9b4f4443fda3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -257,7 +257,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
 						 * recovery related fields are under data_lock
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f6c622e15584..0487206bb832 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -68,6 +68,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (msk->sched->init)
 		msk->sched->init(msk);
 
+	msk->sched->snd_burst = 0;
 	msk->sched->last_snd = NULL;
 
 	pr_debug("sched=%s", msk->sched->name);
-- 
2.35.3

