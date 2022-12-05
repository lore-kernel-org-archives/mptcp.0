Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB07E7C
	for <mptcp@lists.linux.dev>; Mon,  5 Dec 2022 12:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OzqPUsc9C4JKY80MtAMrFLfLbaGs00F0XuY1yKTK+N0uNbByjJnPYnCnmaOsEgPhqkQXdvTIYhg8QBR9D3RferiH1hr8h7O8yBIkCB/CaSTkO6vxCY3PonU3v5WkkWoAcAXNRzv1YOnzQen8fYLcfmVt4RUmpd0Ue0ijuunQXO8mYz20vmckOBBf+/M0IOtRb2++lmq0PJ9tnxGq4nmG2SWslMgD1UV1GpIfMBll3u3cLq1f8IAbUz+2/xA35jOjrz41VYoyV+pQ37w/ChPcqFtOgE276FhQWEGTXhhuyduZVMNFnmXqFjVY/rK4sIE3xVw8F81kVJx0VHl+IgOd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuWm9L60AYs4RMfPOjYA/rXRCbGjqgv3Bh8StkJ0tU8=;
 b=C5kOXsZ5qIzDYZCJ/iT4Uw0l+Qwg1JqneWBl9G804Y6sIryR7RgK8loV1v/Bprubq8/q3rEpjE3gfIzfKl+ZQXV/OkopTyYpVE51UB9tIw1yIrcUR7zM8S6mignE9ufbxK1MhU4za0eX48Un6TznEq5yHoO3kQuEFVnrro8XzYAu1Ou+sYjmdwTQvheyV51dzfkVP6puuH6OitLDVXkU0ZblqtodVKf1z1sC0AKbTjweg1LInABsnX+V4eS+qgueXpFpJqa/fjsVLzQyZ+SKOyW+5rWjRxRn+pC8i8ticoxiBFyV5awdBBwVppwqIX0p4tjINM5MRL0Odb6JA0zKaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuWm9L60AYs4RMfPOjYA/rXRCbGjqgv3Bh8StkJ0tU8=;
 b=Uaj1m1svihz8LjxVBlH8IrN0MYjamHojzQ8IvZAkDl7llETN3QSfRjG6gFT2qMdtDiEk24JkWlF5hSSDl3oA1zuEALRmEOGAKED0AF+mALr9JPj8Y+fDb2WvdXOEt4al4g0eK5NAX1YopdEg/BYwArXDJzS0Ve7NB51YWtz6zQ92ZdmpEltgoV+Ep4R599o742zJUQtyId1HKDGLkjJS3CeiP8i2vvA2/QiRp+14c6nYKR5R9q1ZmXAySniiEAWNAvOhSfRVZoII+aivitDZqyWGjv96fJ7AtxVieDLkkgkUBKDXgtjHWnJMjhCta1e2RyZ9DzV2Q4E2D8Nw2yMgzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBAPR04MB7224.eurprd04.prod.outlook.com (2603:10a6:10:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Mon, 5 Dec
 2022 12:35:43 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 12:35:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: retrans for redundant sends
Date: Mon,  5 Dec 2022 20:35:22 +0800
Message-Id: <b302a1c5caefc522b8721d099c6a353487fa5c40.1670243225.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670243225.git.geliang.tang@suse.com>
References: <cover.1670243225.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBAPR04MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ba9df4-cd5d-4cf5-5537-08dad6bd39cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DerxQqEYtlwuAUHBqpx22xIibPcF6c9lLYUxuxZKt4GV5cX3D5ofFtnhvTmW7eclsQihX1+jXxTKijLAasza6BGKUxTd7Uk8sNqTi5yCbHCOCQbuRTXmhwAm2sXISCfi1/Q7HIJGNZFoNu1U9C6Dad39nQtpUJkweT43Wci2+0YyKWDBpFMcZB7Fy7W+mKULR/VArrAOIvmKbdWjRyGnNf8Rx2AmpnsUpsBbtHjAPdZDZ6qibtjDEEsXk/YujhMlGqXTKiQqQRyXG7Omkhb83GDCyAKR/csyxthxMGG3wVSvHNSGhIqDxocleKloqqQ6Hdxzc/SAMal/iUlabo4DTUlVNbOqQMb1G1yrr1itPrOY0B6NijjXA5m0wqNFzQvUgOA9ohls8aZ+K6R7moyVa2hGZHhwmHbxcipEoPwh1abk73EQ4gFNAsqAAJ0lAtG30GstcKOkpCZQq4I+JzIiqfYHad8w1RvjMY+cxTuD/Y6rkFdMY3z9hkqFFuzxoIH6Ycqj6epYsXDP0PWVZVPadMwk5LtgycJdINDyZNuV1CS7eu9m8Knql/rDzX/ld0mKcps8VNin06BUQh/i7ENO3i8dkjjnKp93+1QUpvzeUiBgWlL0K+2ETFiqfWqEynyH4L90gSG+1wHJXH8wFkeJKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(376002)(396003)(366004)(136003)(451199015)(107886003)(6486002)(66946007)(6666004)(66476007)(66556008)(8676002)(38100700002)(478600001)(26005)(6512007)(44832011)(2616005)(6506007)(186003)(41300700001)(6916009)(86362001)(83380400001)(4326008)(36756003)(5660300002)(8936002)(316002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7X338lJ6+USWr3p0P5gY3xmrg44Pk0BN6N718yiMGVuq2GgDTRU8LbZPeyAn?=
 =?us-ascii?Q?OAmkdgCfdfJYnhhS9U0jzCuAJupxGIuXezqdWAQnlxQ5gTzP1ucn30jjeqn3?=
 =?us-ascii?Q?D0fD2+LNw+Jx2qoKdvF5MOjO0ogljRJv+sG0kzfZpvljh5fueMkeu4p7++m1?=
 =?us-ascii?Q?ExttdIZAGgAB53dc4U3m5N0CqigKMnKSgWJiLmqTYyC0orMqy2nRZQfObtTD?=
 =?us-ascii?Q?IQrgjDXpb3eHwxZbBJ1bZrTLwYk68OL5X5Fu5U4IKEgsgehHIySTuwwr5MJ0?=
 =?us-ascii?Q?a5HBt6NmdJRRC51Dxa0vplETIkPB2z1BfViJAVKWzXmbGNtxSOGQrade1nhE?=
 =?us-ascii?Q?MYoKNRDatOEE/KDqriahoLt1kzxhtseNHUs1Qle/Yx+f1i3GyK0FFSj0wzDH?=
 =?us-ascii?Q?59ZIiP97IR+pF6XyupmtiYoIx4VNBxM90Itf75fsb7EX4CH/JsfXDi5069ON?=
 =?us-ascii?Q?uCeA2aOxOJ4HoQN8BjWO4rZ7BR+Jj71ldPW2wSPhy4snOCv5g8gmCtBglYZ5?=
 =?us-ascii?Q?D3ZP5nJ7B12vKkVKnsaix2GO4PwV8TZ/9/MDa0c82Q+ONAR51JFWvnLIBIjB?=
 =?us-ascii?Q?dOkwCfd0M0Jt8I7hLiSuZPBx3+kpmlJmWOTPlWLdMqGsXO064F/T13js07E4?=
 =?us-ascii?Q?AyxAcCZgKkwZs28H/zWrjKAGJKBfrnLebTiswPoReetIoIkIW2VRrXjgyoqk?=
 =?us-ascii?Q?qG6lFzFJdjvDVtKTjcbookdv2EY2yQjiCh98V8t0ZWK1mRN76quwkoQ1RU2n?=
 =?us-ascii?Q?2JMD3PXQzk9OsaeX15k/OUq4i9274NnT+2vLAuo+z5cNazsHkPTccpXKux+a?=
 =?us-ascii?Q?GMKQS3K5LcLqI7BB3jDqsJDF7f9tIBHGfgoMUYIxrm2YCqp1Nk9kV69lL8XY?=
 =?us-ascii?Q?PFcWj5x9quzZA185arwLsVem53GMBTsLMytW/NcjDV1+8QNk2qOPgp6sOL4J?=
 =?us-ascii?Q?dFwqzgDMELxEFZ7moWEgD5+PEw6yPLCF+wwM8Zz+5U3Whfc6J/uw5yumb8MM?=
 =?us-ascii?Q?VJuWglA8I7uUls6pp42DHwM07E7rL8/iQMoIv9FhmBmlH+w7IUusxTf+/JiK?=
 =?us-ascii?Q?cJ4T1yYJY09tsC2KRUfqzXX5C237IPPS/Ly9IGn8TWHrvjl4Q6TDk+ZVQnT/?=
 =?us-ascii?Q?BM1MAhjtWlbFRXv90vG3ga8ustWFl7enqNTdjho4dMex84bhyRCXl1DrFrRR?=
 =?us-ascii?Q?In+2HAUO+Z3UweNV3MmxTsu4tGNhnOvf43zLTB1R61vS0svtnEBr6W4uSjK1?=
 =?us-ascii?Q?vzrIcwtY3Pu/hElXsypWpms0fVH1KgLf86/qekWDmA3iXSc0yTlVxNHi5R0C?=
 =?us-ascii?Q?VWrKSIbnplUP2jpA2OfJ3WhPMmh9uWj5moj8okwzjpfvVODB6o59w0JKWG6V?=
 =?us-ascii?Q?eyvJw+8DK5ke9ctewrbhGzlJsFHYkzx/Uk3s9qooAYBFAdSCLPhagFlbFEUS?=
 =?us-ascii?Q?Y6P3YoVxSddn+8nZcrX3jJZdRPoPDj8iN1yDx3CaXJ8XDnu1UlLRVg34QNgg?=
 =?us-ascii?Q?xAj/LjXEtl+s2Z2tBXgWUcfoi8dTaJer9W2RCMmArDwFIa84wjNMEi+x2wsV?=
 =?us-ascii?Q?aaLhNKaXD2eJBK8SRBNMesKq6el3jArxIGPTXO3UWrL2qa1eh8QtuQ3tZ1k/?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba9df4-cd5d-4cf5-5537-08dad6bd39cb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:35:43.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxUWxyX871GPkPun+tIL6U8fTxJecRv+tncb1UuEN026/AumZaCYuOnfDF5NGbU8CUEXPNYQF4hxVRbGo6fOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7224

Redundant sends need to work more like the MPTCP retransmit code path.
When the scheduler selects multiple subflows, the first subflow to send
is a "normal" transmit, and any other subflows would act like a retransmit
when accessing the dfrags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 42 +++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  1 +
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ea2e48a74772..545b29c0e01c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -997,6 +997,8 @@ static void __mptcp_clean_una(struct sock *sk)
 			break;
 
 		if (unlikely(dfrag == msk->first_pending)) {
+			if (msk->retrans_redundant)
+				break;
 			/* in recovery mode can see ack after the current snd head */
 			if (WARN_ON_ONCE(!msk->recovery))
 				break;
@@ -1013,6 +1015,8 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		/* prevent wrap around in recovery mode */
 		if (unlikely(delta > dfrag->already_sent)) {
+			if (msk->retrans_redundant)
+				goto out;
 			if (WARN_ON_ONCE(!msk->recovery))
 				goto out;
 			if (WARN_ON_ONCE(delta > dfrag->data_len))
@@ -1473,7 +1477,8 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
 {
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
+	if (info->mss_now)
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
 	release_sock(ssk);
 }
 
@@ -1555,14 +1560,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *head = NULL;
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
 	int push_count = 1;
 
+	head = mptcp_send_head(sk);
+	if (!head)
+		goto out;
+
 	while (mptcp_send_head(sk) && (push_count > 0)) {
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		if (mptcp_sched_get_send(msk))
 			goto out;
@@ -1571,6 +1581,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					WRITE_ONCE(msk->first_pending, head);
+					msk->retrans_redundant = true;
+					goto out;
+				}
+
 				prev_ssk = ssk;
 				ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -1598,6 +1616,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
+				i++;
 				do_check_data_fin = true;
 				msk->last_snd = ssk;
 				mptcp_subflow_set_scheduled(subflow, false);
@@ -1621,16 +1640,21 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *head = NULL;
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
 	bool push = true;
 	int copied = 0;
 
+	head = mptcp_send_head(sk);
+	if (!head)
+		goto out;
+
 	info.flags = 0;
 	while (mptcp_send_head(sk) && push) {
 		bool delegate = false;
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1652,6 +1676,14 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (READ_ONCE(subflow->scheduled)) {
 				struct sock *xmit_ssk = mptcp_subflow_tcp_sock(subflow);
 
+				if (i > 0) {
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					WRITE_ONCE(msk->first_pending, head);
+					msk->retrans_redundant = true;
+					goto out;
+				}
+
 				if (xmit_ssk != ssk) {
 					/* Only delegate to one subflow recently,
 					 * TODO: chain delegated calls for more subflows.
@@ -1660,6 +1692,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 						goto out;
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
+					i++;
 					msk->last_snd = ssk;
 					mptcp_subflow_set_scheduled(subflow, false);
 					delegate = true;
@@ -1672,6 +1705,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 					push = false;
 					continue;
 				}
+				i++;
 				copied += ret;
 				msk->last_snd = ssk;
 				mptcp_subflow_set_scheduled(subflow, false);
@@ -2593,6 +2627,7 @@ static void __mptcp_retrans(struct sock *sk)
 		}
 	}
 	dfrag->already_sent = max(dfrag->already_sent, len);
+	msk->retrans_redundant = false;
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
@@ -2724,6 +2759,7 @@ static int __mptcp_init_sock(struct sock *sk)
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	WRITE_ONCE(msk->allow_infinite_fallback, true);
 	msk->recovery = false;
+	msk->retrans_redundant = false;
 
 	mptcp_pm_data_init(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index adfb758a842f..e6bebde2f3ab 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -290,6 +290,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		allow_infinite_fallback;
+	bool		retrans_redundant;
 	u8		mpc_endpoint_id;
 	u8		recvmsg_inq:1,
 			cork:1,
-- 
2.35.3

