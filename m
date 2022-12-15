Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F6194
	for <mptcp@lists.linux.dev>; Thu, 15 Dec 2022 12:33:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4ezn9/JVUVy8yEpdqjxE6MgvpXbT3DNpv9t9txrup1HJhmSYHkMXUTbT5kGLmNTp5twI8ngZIIVTXyvuw8T8unZLsCCsSG21Zsw8Ihwyf1h3xO7qjWJhyR3LZOoSacy4bIeXh9arGCKsMoxu/jjnPF8uTgo0pgMIkU9xeRudwZOBhvT16+wSnqNKjrH4dmqgrmH9lNAK/QDkxDreMOGqJSVE6S9QDen75fQBWoltcsqNw95yUvC5TX/r7PZ6w186PW7D6mx3YLORz2BUYRyMJjSD3OgwJ0guN1yujh7BQYMBZBzbqxpY2YK7MvT6LL8OSqP+mHjnvWSwNkCKudFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwLZz92+Uz9lgR9TBv5P73MdsPnJKC2rE6IR4Q31Tvw=;
 b=C1qnATSxJhH82NCKKsZ6d8BY6f7b7M6XH0d4++Y2w4Gd3AR9K8InQsRVvI2eue7V4cAq8Qqb3N5JD0ZKQACJ14C7sd63GtEj+LIiyRUVi1XYFP8Q6oXwBMAbA1Q6422lx/BB5ttjqaVIc5g1ksYvKriudyLlw+iUhL7Sy9lEpt2NPcpQMDnfkhwYbvcwnHsL1cd0ZsWLCJyqNC0ajxsdqorae2LTN0IoCriCGTt1VKv9CbbLHjHPCnJPJwWleNeQfkYRY8KdaE/mEwX417AMQf6ms1X2OfZkNkPQQXQzgQdK3E5Vtogk69RXU7rNmiCeXdhPNzEvNdH7oHOtB9WIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwLZz92+Uz9lgR9TBv5P73MdsPnJKC2rE6IR4Q31Tvw=;
 b=UzsNPjES22JOaaYe09/k687akF14+t2NaK1Mux2puW4QzT6fdKsM550Ed6bENplPofU6lMRunBp7tPxLz7e3/zupClO93h4WMNGlU8NUEwAdqyW18Cje7VP6XRC+v0cDU9q4d6yXI87dS4spmA2T1gKlKhkO4bEFHk6i/oO4Bvk+iJKIlBruzsF69cgZmUB0eLbfchRTHP/76LvL9s0smbm6B1AzBvD9o9K/P8zh9AD2bad95mhICDAF9KLynjHZLKe/DSBTlnMY8vjlZjNI3zmxheNVuuntyo+EzVRucxCeKUj+8nQUE010MbU0aETg6OZNKJZwZVzoqAYj9fRb5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Thu, 15 Dec
 2022 12:32:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 12:32:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v25 3/5] mptcp: use get_retrans wrapper
Date: Thu, 15 Dec 2022 20:32:41 +0800
Message-Id: <ac9bdfa8b6f450f9a654d92c59cdaaedd23cb86b.1671107241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1671107241.git.geliang.tang@suse.com>
References: <cover.1671107241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b966318-2c15-4b3f-0c9f-08dade988025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LaSQM5YaghEjJvTlT+j6KzH1Bq9wa6UuCWXP6mo70O9xFWlfjIPBXuagsPt2lkm4GU4GcjzyaBB671QfCW6q7KBr2pdXAxaw8Ui2WJZ04RtLrP0AwvdUhz4B7ZY4auVgGFCvd1DYYDQfWz84Qm4s6IFT4xr00pJnzGVuKzqQgf3W9vj1LjKaGtnkYmTH8A/OLftUV5DcdHEhR8s1jXhGGeAfvPSxMPpurfaEXbCvSLeH8bgardUy6zu4Mz53kdcGF3EY7jG9I0DSNNhvBQNeglH3ksQHaqhW/iVD3cReuL/YKWZwYmT/Y+SCs0V/TkcrzIkkvSMwYt6tcXBis+F0UYb1bhkRsA4I8F1qG4uN1wv8veFNZxRPiMlWdDuLQU3rDpBfY7rrXeKySHotNT5xOic4+T8GAU6c3RopWaiNUMA2+aPOJEyBqxSeRoNC5SnF1tD5FWqZUDeDv0up9FjfZyXS3o+N0puQkrbbn0WmQiwJClECOC/w0x+072qdWT+KTCOpvuqMcRBOClJ4oM2h1sCmO4RadrT0P8sggabeg/c0JZTl9UV/WiCKae4kQ8SGwOzhz0RTJNuoVIVtnWX1n8eW38C4igS/ILXXv6UxAgPQz3q9io4FCrC2Yt2CHc0Qrj+197G+Zw7bUkFGfyF2UQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(26005)(478600001)(5660300002)(6486002)(6506007)(6666004)(107886003)(38100700002)(6512007)(66946007)(6916009)(83380400001)(316002)(66476007)(4326008)(8676002)(186003)(44832011)(2616005)(36756003)(2906002)(8936002)(66556008)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NpF7QHmzSExP1l3k/kTylO/SJNK8+zo3aAsvqR/0I9QellO4GuMBpv70F6zp?=
 =?us-ascii?Q?I3tkroLjGTcUuL/9Js5DPaQrVRjFpDF0nqYmSXi50EnGoACQOXR6huffGkzN?=
 =?us-ascii?Q?D92l8sUj8gOm5M1/o3CtykLqBU0QyvtPvqlzzvgzNoD5+k3gqD4/wUTEXRLp?=
 =?us-ascii?Q?Crh6NKSnqEGocZ5AZELPOWmXDMVJtRJnAOXHD/CJYRtUUCktFw2xd3cdz0pT?=
 =?us-ascii?Q?naaW9qw0Cvna6S9HFnhUpKeKg2hNSO4G/s69Gc82bJMshXRWCXKhxDLR6//S?=
 =?us-ascii?Q?ArdbtfynfOG1l7zu0GEJZAWDhD5f4IdaNxBB2S/PFSKAXPXrym7bTkEJ+8Qj?=
 =?us-ascii?Q?vAkRGo1zpZ7f+B27F8y8T9p//EQRrxWYkMd4lu8jAH47OK41ZYOnBfonecyA?=
 =?us-ascii?Q?21JCskp8ImpBlK61EZPNqY3IRyYaN1VxASgufpW88KvYOi2hqBtrsJ4tyYJs?=
 =?us-ascii?Q?0jKiP/ZUJE/0p6tHeCHcgI71QUKo8ZF86hsZPg5ub8G+SOU5p/QncZWOu2++?=
 =?us-ascii?Q?qC/uMMMW5xnncWyQ/HXdynoPwJbrIS0dO/Ukclvt1gVW86lupft3qdhLjBKW?=
 =?us-ascii?Q?KKiv0kaQeR2PBEUllcukdj9MsK/ISkH01sPLQkRudMMjngJl0YnxnMH82kg+?=
 =?us-ascii?Q?nI6AHvoLyP/A660myAzvLojnt/MK8GTVjTV/uSlydYV4dFq1H/TkTMT62qQf?=
 =?us-ascii?Q?xm7nHBoDTjZNTe9jg7hV9lsUVQQEa9GvoEIO33ajsNp3Nh8MPP+OL7BJ7qwd?=
 =?us-ascii?Q?VjRlGyEbmErvH2G1NjuGMn6aJ0dXLzKZmtd9Dshr91HMvLe+QiEszl0LZhPF?=
 =?us-ascii?Q?cya94OHgYJHgr30nNrNe+yhKJGLkWVVPLdH8BHjm00UJURQcSrrXMpeFoY90?=
 =?us-ascii?Q?cGN8sAQ6CsddjO4Q7kEZkHMO6XY4ioTd8IBfuZ2i86gI8L8CKAgSxYRQoQ7a?=
 =?us-ascii?Q?Wc2XzjnQEzZrlU9VJUkSXH3EMcbySXC4KOdhdo0kKQRlmhb4DmJJwwVrJNEK?=
 =?us-ascii?Q?l3UBjY7AevZFFj9KbhTAkkIv0g9+wkykJAmaDCj1NuJB293XFNbZamNAyhhp?=
 =?us-ascii?Q?CtYCCGi2DqAW5H6RvcFPxf1ICbRD4+jTS6As8EQw76HZ9uni0mf5dGGcP8eL?=
 =?us-ascii?Q?IYgr5UOzo02N7dq0338r4AI42SODhHtBqtP64Q8OdYkFPoTnIBpWqY3qp4i/?=
 =?us-ascii?Q?RG1Llr6taD6O+a4u1ODC2SLYoI7r5ZS+BQZ+K1RYYo9v+A8LQ0zE5Zl1qQO+?=
 =?us-ascii?Q?oR3oruNtxjCjkNnVamU3nbajvKbpHcPPEiQlRhsr8lule+DDFL4QQy8mtSUh?=
 =?us-ascii?Q?s6JO+2Mum4qySc2sa8d99JEOCiEGea3pk8BYfyZOZHPBzp6x7ZkGdrvams5G?=
 =?us-ascii?Q?vuV0FPI3CJUfPNL6O81xD47quPKZ7rSVDxna0+U7z8IaRmmITy/X025udowh?=
 =?us-ascii?Q?iWOMgR9mCRXzAXAYn0NGdUUTN5cvFdYabBiGUcJKSLrYe/5qXaA9aXUjruZw?=
 =?us-ascii?Q?fx56h0zaM2msN1acGdSrDWL1Yu1suF9WFgdvEEgeQLfOO2O9L9crJdZ7sBC9?=
 =?us-ascii?Q?ud/kONL0SnEWZN9U6cqtgcvkj9I3uo/7NwHk7a3sDYJxu1k63aI6joguN1VG?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b966318-2c15-4b3f-0c9f-08dade988025
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 12:32:59.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/UZfQZ0AwIYoXz+49Z6dorlYFJlupFb4ICeRn7ox5cPuM/wzpSW9sLjMEtzjO2dFutfJ70VmrlGwPmWzr0DBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 66 +++++++++++++++++++++++++-------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 57967438e70f..91b84321885c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2249,11 +2249,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	msk_owned_by_me(msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2523,16 +2518,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
-	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
+	int ret, err;
+	u16 len = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2551,31 +2547,45 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			mptcp_subflow_set_scheduled(subflow, false);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
-	}
+			ssk = mptcp_subflow_tcp_sock(subflow);
 
-	release_sock(ssk);
+			lock_sock(ssk);
+
+			/* limit retransmission to the bytes already sent on some subflows */
+			info.sent = 0;
+			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
+								    dfrag->already_sent;
+			while (info.sent < info.limit) {
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
+				copied += ret;
+				info.sent += ret;
+			}
+			if (copied) {
+				len = max(copied, len);
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+				WRITE_ONCE(msk->allow_infinite_fallback, false);
+			}
+
+			release_sock(ssk);
+
+			msk->last_snd = ssk;
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6428323d8c7f..c7c167e48d72 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	msk_owned_by_me(msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

