Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472933EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhRZ6C3Tu2UQXsoNCRjWyw0j0TIEhCRVjw/RnFPsJNUWH4JUV2Le7kHA5FWcPDYQXfmuJhWnvHg2RuV/o6pxHcu3Yf5mfi9WbCSXS/63kid5/K7+N3LZeTsz6gopT7XO1zRg5FG3lq+wMOE6UHRx9FHDIqP8XTuvO1cNsRwmiJGeCd6QrbbfbmyW/8Hbs8MgQakPrccvH2MhPeeWC8mNiwI5h1ajsAMw91twRFAWldXLNzlx8G8NpyVbSHKyorW8d4tRPwtKPj/5Th0SD7reuxJOmoRkBOk0fIv/IYJb6RsYYGb7YXIoWiZcZcSgRrlus3ryl/+gwSQiWw9W0ic28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpqtCF/NWVruJpxOaX/+kgQIA6n6GCji4Bt/iusnCI4=;
 b=cpUx6V8K/wrPngyzFmwLHA4tgnzofB+2zIq5ovo1sHGUnKX5WqX4RSWrF49IbSc0qVVYHmufzaz61BeWldgGHb0uHiwuLmH5WQA7jS8Mxr/mwvbgsu9wFni+LJFU2u9rzfCPTLTEghA6iYdGkzIk0IMlor6LW5LO1V8VXgwZQ2Cg3wLfpckF+FczDQRb3+cbtBXqKtLAsiS7PJCBM5uUnnucDqtWzJp0TUVribrq7NJCLrYEdVZw55DHIUYqEm8PMyV//FCYJ0Azw69pzZOFwRfTwOd0Kl9J/NtcD60+3SuOFvSJ2IQkW7qd5Lv259ugAVoBIwEWLY0yN2rCDDXJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpqtCF/NWVruJpxOaX/+kgQIA6n6GCji4Bt/iusnCI4=;
 b=KDkTdPhqrVW8FUMa4myOXKlFOVnRuPm9yYjk39mVsM0m/hKrs8fiGrT3OOOs8Z4oSqJpXPTMyOGax1RA3GJbpeoG8ABqFdFPKB3XuNuePt1qe+nqV/6cKDdNK0sVVZ2d0gsfcTxiA7bVD/m1UMr3jjhoCuS2sHR/FMNjiT1BVtiIpGe3Mn+0dJ9562hOoiJk16r0WUmOpCh/2uFGZmO1ReWw2xTnjg8OPXIRH81OYChnINRb4WiHa9yas/eqEL00QwxbwbovyaPjPgX/2OEnRkuTKK+CkwwU8mYaZF3WCjls7vWPJ40nd84d9Chh9+kO5UFFmRQx3mUi58h/kgEwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:26:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 2/5] mptcp: redundant subflows push pending
Date: Tue, 27 Sep 2022 23:27:01 +0800
Message-Id: <e507819bfbcf36a3e0e7b1541b5fc74a7f7be74c.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a26fcd3-8e13-4c30-68be-08daa09ca9de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w91R39ESI/tTPfJ3q0Bp0vmLZ/4j6m46Ejm0DdjeKt6jDf4s9yyp/oSe0sdTw5j78TcTvy4ONP0+T8rAOC81b6Ec/BrYY98qrsdY2iUxmjX6g9G2qlQ0fE+ga/Hd7jYrwqr0jS5AGbAgCibax7cBLdWMl37fVIeUXPBsw/PrJOh+d3SWWDcZ7OynUi61MDEGSmCKyY5EyNNCYUfobVWUpjO47Y6E3U4EfxZTl7g/BoRkSHHSqTeQYZ1svr8+K0JzTph60pgN72u74cP79uMR36pbf9aJCpjkMA1e89761Kc0l9Xb9QtFNTDy7hS5DAb+eQJQ2PXdBaFQ26SB+vEZ3uhIdrl4rfGl40kDbqmuVGITn6WDA4KsY9jnBEEz8fZ4XQOhrYDrDPXuLPalwNNsSSd72Zhda84L9xHCRtfi0XqZqVMH0UI9Gu69zuNDNuPr6ENd8e+UV7MoBOoXRCXGR1K8U0OA0M3LCmEaPPkQtM5uU/Z7kDENAtnj/pXn+MgN1hi6/oLJCxYjaCAin5B9KwblXwGnwyx4VSY5+fJ/+zH00oRcKaHKEsXFW/s/PQJW8IzctD0KWd+ZMItzjtuW6yDvu2kGF490mmlSoHE1bFvaOfh47q+40LJue6I8YpSrtRA+JWEVXmEQVeTEiZFiwgo3u7w1ms8nNJ1bp7ZE8k4JQRFW9ms7ex9HsoNRj5eK5eAsPH8ZvkOBQfchY29ohTnLHa2VaXuiOWqsaNazjvQoRQlgSsbiZT/iMHD9xJg3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(6486002)(6666004)(107886003)(6506007)(316002)(66946007)(66476007)(66556008)(83380400001)(4326008)(8676002)(86362001)(26005)(2906002)(6512007)(44832011)(478600001)(41300700001)(36756003)(186003)(6916009)(2616005)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYERH7TXvVXSZB+F5IJI14rkFmDpw5FWe+be+YW47VzgDS4vnfRwT1O3Js1o?=
 =?us-ascii?Q?fET/+S0xPG2OkIUhWnLU4BZJurmXL6qUm6jTVu+eL7JS4uGSxZJBdCTgm3Vl?=
 =?us-ascii?Q?lftD60do+heGjN+RieIfHh0QdVTwuVTJpBCYj0pJiB1SyYyXK6efq0cxQsi+?=
 =?us-ascii?Q?xCdPwMQKlHGxKn7Q/6gczL1ZqMyoLhabpy0kFrDM9Mg7HwBursbjOPlEL0W5?=
 =?us-ascii?Q?lj8PGxP/v5hEML2T6eFzJzOIXOMQ0SayXf5OZKT5ewEgUFalHBCEkCNvmkEQ?=
 =?us-ascii?Q?2rI2EBLaEbOOCXXBPyQ8kWjrJVavjfn2oiQ/aqlmawsMdkzcovEug0ax8Cpf?=
 =?us-ascii?Q?cn44xXJ4wxkf1clqYRL7QDca4uEgBrww6M/Mzm+X4TmbAzmZC/Zsf0pSovij?=
 =?us-ascii?Q?/MUp5bxqfev58y65baoKIwvS5e2Mhu7NM+fR+W2sT1e9n6ettMriGj7haT1O?=
 =?us-ascii?Q?rQMhtajpLdv47pcZX3Tci8p28B/UebMsUC6VEYHe1jlQUWaTAxzaQqqvilJK?=
 =?us-ascii?Q?Fm7u9XnodRin+jITM6z8vMaeakDh/bj8ii87OEUCcfpWs663R3AqE4lnjPCa?=
 =?us-ascii?Q?0Dy3PYVVW/b1+jef9x/XC3hl8PYxsMCRnTfm1K0Eb0X4MEyh4Nbf7uFOyLJm?=
 =?us-ascii?Q?6M+LVS+x7KVLFpFPgDTVC0eDylLPQ93zB92BrgNL1iOAStbn2rkMG+0/W23M?=
 =?us-ascii?Q?JvospZHwp1ykJ6Pqf0/xdhI4saz59/LsaDuXc5fdpDsToNGYmDpnBdV9NPyi?=
 =?us-ascii?Q?HMoCTNdnkBIPQoUCDMV8VdzBh/aj3TBk7lqwtLHaOrNo1YPvwmqPFgDZob0h?=
 =?us-ascii?Q?4fHPoDMH5Z8zDxaUVfWkTFZgPwHqVWJT5KAkvC/IywFMSh89PdW44/qcJOr9?=
 =?us-ascii?Q?dQiU8H1JEHEmaC9+t47FjGCtYQyAkd+ZM8uiT2nhRZLIA5Fn5vR+c8tBBFRB?=
 =?us-ascii?Q?yzDSCZ78Fpa6CQn+YT9W9sHIL1Pk1TIi/g7rvP3E9xJO54yw0oyOeymniIPe?=
 =?us-ascii?Q?Q8tAKTdj4ki62R2VlvDKxK6IU3iR/w+lh5NAK+Vp6eCqh6W95ld/1dDNVVO+?=
 =?us-ascii?Q?gP0Ie44wt3PTjZJK8kvdtL+/iqH3gvB0saXCnpUapcmA2uGwWRKWLyUc6GEr?=
 =?us-ascii?Q?nzn8Ck0eUtjNg7R8Gy1FGsDXaRlwzF0Sb2lgysVJGF12dR9icLdCgd+ykTva?=
 =?us-ascii?Q?YbFrxQffzhJKXt6cQhFcXFg03ERHOX7tl38uWVEFd0/NqU9+P/EnOZWWM7UK?=
 =?us-ascii?Q?82LBSwtNsfOgOHcuvLC4VxDjrXi7bFB+YtpSFsug/lVGAWxngBaXNOc4o9Yv?=
 =?us-ascii?Q?L4LX7EAjnkDZU8wk02q4+6KAHaHcv0aYOUi7ywtwE0PmDPf8Pj5FCnkjP6wA?=
 =?us-ascii?Q?aocirzcCL3nOEYKVyuD0y1P0uBkjcKtaSUmRRbdZ5PfDZKNr8nUeivzzY+BE?=
 =?us-ascii?Q?jwFuUwlR5yZ7mWkeR3cO/ul/Pg7G2fW9RfkcYRjXPoeyM0QCy67N79OFRz0e?=
 =?us-ascii?Q?nvn/O9t2+2tDAWUrmeREWSAIiSfzX8QQbTEOPED3HljCgWQy8lCR/lo4vNMu?=
 =?us-ascii?Q?cUGyyRdrDrLGv3rcShdHPXACcHZeShBUzBJhqiaI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a26fcd3-8e13-4c30-68be-08daa09ca9de
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:35.3176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1g3DBRdOzKKpvSR00ucG76wuwjPmiddwjy3zotL60c/7ridCcejDN4rs1BvF3WYFMbcyeObnz96A1SV2sUWM1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 128 +++++++++++++++++++++++++------------------
 net/mptcp/protocol.h |  11 ++++
 2 files changed, 87 insertions(+), 52 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5c5173108e4..a85243be4d29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1005,6 +1005,9 @@ static void __mptcp_clean_una(struct sock *sk)
 		if (after64(dfrag->data_seq + dfrag->data_len, snd_una))
 			break;
 
+		if (msk->first_pending)
+			break;
+
 		if (unlikely(dfrag == msk->first_pending)) {
 			/* in recovery mode can see ack after the current snd head */
 			if (WARN_ON_ONCE(!msk->recovery))
@@ -1020,6 +1023,9 @@ static void __mptcp_clean_una(struct sock *sk)
 	if (dfrag && after64(snd_una, dfrag->data_seq)) {
 		u64 delta = snd_una - dfrag->data_seq;
 
+		if (msk->first_pending)
+			goto out;
+
 		/* prevent wrap around in recovery mode */
 		if (unlikely(delta > dfrag->already_sent)) {
 			if (WARN_ON_ONCE(!msk->recovery))
@@ -1497,18 +1503,14 @@ static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info
 	release_sock(ssk);
 }
 
-static void mptcp_update_post_push(struct mptcp_sock *msk,
-				   struct mptcp_data_frag *dfrag,
-				   u32 sent)
+static void __mptcp_update_post_push(struct mptcp_sock *msk,
+				     const struct mptcp_data_frag *dfrag,
+				     u32 sent)
 {
-	u64 snd_nxt_new = dfrag->data_seq;
-
-	dfrag->already_sent += sent;
+	u64 snd_nxt_new = dfrag->data_seq + dfrag->already_sent + sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
-
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
 	 * old segments.
@@ -1522,6 +1524,26 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 		msk->snd_nxt = snd_nxt_new;
 }
 
+static void mptcp_update_post_push(struct mptcp_sock *msk,
+				   struct mptcp_data_frag *dfrag,
+				   u32 sent)
+{
+	__mptcp_update_post_push(msk, dfrag, sent);
+	dfrag->already_sent += sent;
+}
+
+static void mptcp_update_dfrags(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		if (dfrag->info_sent > dfrag->already_sent)
+			dfrag->already_sent = dfrag->info_sent;
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+	}
+}
+
 void mptcp_check_and_set_pending(struct sock *sk)
 {
 	if (mptcp_send_head(sk))
@@ -1530,60 +1552,62 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
+	struct mptcp_subflow_context *subflow;
 	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	int len;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
-
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	if (!mptcp_sched_get_send(msk))
+		goto out;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
+			struct mptcp_data_frag *dfrag;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					continue;
-				mptcp_push_release(ssk, &info);
+			dfrag = mptcp_send_head(sk);
+			if (!dfrag)
 				goto out;
-			}
 
-			do_check_data_fin = true;
-			info.sent += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
+			lock_sock(ssk);
+
+			do {
+				info.sent = dfrag->already_sent;
+				info.limit = dfrag->data_len;
+				len = dfrag->data_len - dfrag->already_sent;
+				while (len > 0) {
+					int ret = 0;
+
+					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+					if (ret <= 0) {
+						if (ret == -EAGAIN)
+							continue;
+						if (info.sent > dfrag->already_sent) {
+							dfrag->info_sent = info.sent;
+							dfrag->already_sent = dfrag->info_sent;
+						}
+						mptcp_push_release(ssk, &info);
+						goto out;
+					}
+
+					do_check_data_fin = true;
+					info.sent += ret;
+					len -= ret;
+
+					__mptcp_update_post_push(msk, dfrag, ret);
+				}
+				dfrag->info_sent = info.sent;
+			} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
+			mptcp_push_release(ssk, &info);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
-
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	mptcp_update_dfrags(sk);
 
 out:
 	/* ensure the rtx timer is running */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 79313476ac59..e84d2cd42ff5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,6 +243,7 @@ struct mptcp_data_frag {
 	u16 offset;
 	u16 overhead;
 	u16 already_sent;
+	u16 info_sent;
 	struct page *page;
 };
 
@@ -358,6 +359,16 @@ static inline struct mptcp_data_frag *mptcp_send_next(struct sock *sk)
 						     list_next_entry(cur, list);
 }
 
+static inline struct mptcp_data_frag *mptcp_next_frag(struct sock *sk,
+						      struct mptcp_data_frag *cur)
+{
+	if (!cur)
+		return NULL;
+
+	return list_is_last(&cur->list, &mptcp_sk(sk)->rtx_queue) ? NULL :
+						     list_next_entry(cur, list);
+}
+
 static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.35.3

