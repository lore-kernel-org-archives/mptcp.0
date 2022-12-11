Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2087.outbound.protection.outlook.com [40.107.103.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362D10E5
	for <mptcp@lists.linux.dev>; Sun, 11 Dec 2022 02:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii1RuKdrf3uxlyzq3eX61Hlup9O1hgUu0MDyt2R9GvlF0DcuWw4LjNVupPEWJbJM4X+1zWOaoZ5BjU/MyutzNVHKYcREsnyV34TyjSSkD1xug73KXlVkb9ZPPpNYnPZJySvqu9rfnoRK5M3Ty2A9Vs79fI9FSIgIXvm/EHzismZ9qFdPvPzkXoopoAya1Ru9qg3LvToodXLne9y2tGOtAsBxcVzKJWCpuQPAYdRCFHRIgO7nKmCwgwNyPeTHVqUGRgnQ5Bsut6IaLV6UcK4T03qWNpTXNpTZzR8aekt/gVX1BOUsAiqG/YErub2G1ZksXWy8FCaZ9NhKkq4+VkvC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TI1wIlz9Ev/M5zzBYhBEB2+q7VZuz+8xHTB+zP4TyQk=;
 b=EPfF1/yVQAlB58Hpe1n3cVhT7hT4cAwt0woqDIWg0k9jNtk7iLFZgSaFcC2UQEUZZyu60r7doTBaOy6AIeKSYfjF+dMd5jTh4S2xCVpjTOqgUqlVMltN3it2vZSYXufOD7fJ5fPQmXWqfLzhjEdpa5UHEWKFZrXcVuJ6s900Wcue/iWSwj6f6Wn6MjS/J6h99p1N+qIqqVlWiGH9cKR0iOhp8tA0CQzH0HwCL7lF85a7yX+I4tJF6I14jreXuyd5f4vXslUUIkgM0nV+zziA9qY6c1jhDww6pJTQCqIiCESjLpo3RhMZ20g7iJyO1BX2qi61hKywVfH2NhohOP4PNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI1wIlz9Ev/M5zzBYhBEB2+q7VZuz+8xHTB+zP4TyQk=;
 b=PcI5cUrdwxGfBAzjP7GTnexUyQKLG9VbU2mtAUCfXqnydJfArH6oA1yAi5ccKaEQbyC8vxbl18Ww9nLPUyDTmu7Zjsw0OMF8fo5gQHRqToQUuCC7slN8ZswIvLwDyEPLTbublTCeQiY6Kl+XVS64YJrCt9KiRVdIJlboDxw19BimOfuJIM9J4Snw4+VMU98yKvpEwcQMAzIw7hcB1UzuV2A+EbPv3WuvWkvV8Crs/DXd0AWHdY1BQQbq7IyBTPu14RyJUb/ynj0Nf/rdeWBmkz1peZP4FTgrHKrPBw/h8Q4WSA33DDGXatApQNr9zsiApHABkE0JNfpltMkg1EerNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 11 Dec
 2022 02:03:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.019; Sun, 11 Dec 2022
 02:03:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/2] mptcp: retrans for redundant sends
Date: Sun, 11 Dec 2022 10:03:03 +0800
Message-Id: <aa989fcaf2c6471ce82d59fffd0d09c78191ba2e.1670724098.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670724098.git.geliang.tang@suse.com>
References: <cover.1670724098.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 8477fe5d-c9d4-4cd7-f833-08dadb1bdadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RhNkC/+lscgad5tzVsbTe/uG5FjyDHbzpKp4SM6jC5zCnYC/znwI47bxTMVZp1tjUDgk5/WGPC0T6Y5rCTrOWNxn/I5ozTY4BUAgJS6u8bj3zsYow9qvYS2/lazK2VLoLNFofMZml3E74x6LpniYtYCDarxqpmYU1NBx8w4FZ8RKD6sdKas9xzf7gHG2oyyZHBPKOG6lzBMcPw5HSDj4ZKioViKZ/AX2ht3Fd1oL1lON56/x4OxRuoxiXchusYMe9HbbZhAQdG4HjuV81HtEFCzEr6gW52DteXl8+5fwlrDOye7Cg8QmNr0tRB3imazBiN8j0UrqS/jgAeuYPfm5tkVYi38K+lQysVdVk9fr2XGmsex12Mg3NzRUxP/Nlh8vvDnuqCjg0d+kL+Ctk7We3AGNOwlAeTtUctU+qjG9Ew81vb1gsYmTGdcEqKWOKxMKblqiOUKSm2mtR3hsCUFD9hE59ogJ062VGLrylks2F5UFBWuFj3NZ5/QeZUANDdirfKjq1s6/lwY/FJtenuF+2ZcmvKVkPhj1/lYf9GiT/WxMidxHNVGFAWr93Q83uoB1PfEP1xULtHhqV7/nOX4D7t7AdYYw1KIn+8fButts48+Wh0nAkYgNPYU4MNoQJ1x6hoEoKxp8owItnBBix44vBg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39850400004)(136003)(396003)(451199015)(8936002)(36756003)(66556008)(66476007)(66946007)(6512007)(26005)(6486002)(2906002)(186003)(2616005)(38100700002)(83380400001)(44832011)(5660300002)(6916009)(316002)(478600001)(8676002)(6506007)(4326008)(41300700001)(6666004)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTC04BxkbUbHHxYigqFY/QTpP1v+pP++TBmy1K994Ia8Ho5bThBALgxRsB+0?=
 =?us-ascii?Q?SxVsmDx2eZKaikbqsvQQaWA0nLiUtPsnuEAOIA/ydSR5hcoIgpGeb5SFF9Yh?=
 =?us-ascii?Q?RrhcKmzC/FtNNBrZQij1CkIxMrBeKFrAzLuceaPIoiqAC13YOayHJqmpKXxD?=
 =?us-ascii?Q?IoIeoC5gPt/tmZueCY9v/5k8iMYJNnvMsW5JZR6yBX85qC56XoTz65Bj94y1?=
 =?us-ascii?Q?2FHQBuDSHTEcb/Kuiqy/82w87OS101qAsdw9vZag3c2ohacO70AP8MWd6yXC?=
 =?us-ascii?Q?bIGox+Gg8pfSMqqhDXaHDidhWh23qesE9bK1gSo89b4bNMA1KaxopiK0mr2I?=
 =?us-ascii?Q?pNgZKd4/RoPCIpC0CCY6QicudQsJ+nBxtBUfohUMwwW0LYhUnvFfGupUrP3m?=
 =?us-ascii?Q?CCk8hl6qHk69RW6axQPeEnu3AFkyauVLqAU7VWm7z/+1eEqpIpKXFF/1lpAj?=
 =?us-ascii?Q?xa9pAg7bJZSz+lrjmQWkOeaKy/0ZXzSzSQvjmTpgvQPnNR8dNsYB0u5dMS9I?=
 =?us-ascii?Q?3L+TBPmMNzdLcly7g9Nc8wNmX49rBKJu8f/KpbNwGJ1/2D3F/yZVGYkfLpUq?=
 =?us-ascii?Q?173UPoxylM1QTJfM5sl/SOQKvCxlq2HjNvFbqS4K9nhgIWbqWdjL0BBFv55T?=
 =?us-ascii?Q?QnEVZzC8Z6DRUJdNKcvyA4WLso6GtbFBxceG68AVN7o/JBje5nYSvhM+yddb?=
 =?us-ascii?Q?wSAtfxrTREJFM6GACfTxC7ePTw/Cn8nqbMPG/9Y5d1DPoMOrUGomSxrdmj/Y?=
 =?us-ascii?Q?x4i8AEmkD155zxCbr+FYbKc0juBBLKR94PP6A8ddRNeaqkeNCNUHzvToefJP?=
 =?us-ascii?Q?HTmLO01xjloLFBgHNBPpc/Qm0Df4qrUNhm3l1cT97Xms0TqcO09AjXvn6PJP?=
 =?us-ascii?Q?OQSFforBDVLjdCqy57tv6A0bQYovZlZujpyEpDHz4IoFqut0hvUKEAo3tp0Z?=
 =?us-ascii?Q?XUq2EsZsGu6rpcY2+A/qGYnec/Xty2pTA2BjZ3A6Hn+8uF+eqnGO07Z30TLD?=
 =?us-ascii?Q?zEXJFHWBadggUycMOfV02YLtluiNzO08Gh55AwWVoTD796whVqKkGjNeJiDy?=
 =?us-ascii?Q?iTVXAl2mKQIa0AgUOkW0lj9mQwnAICMi/60K4RmZ7Kdqa9LJaYmwBehTqaIM?=
 =?us-ascii?Q?KplaD+aocKZlhg4b3Y2tUSkdQ/DZaHDh2iz87XAVD9aFyTY2GfAJRXTp6r/m?=
 =?us-ascii?Q?EEex+iRcN7aCf0EnPwL0kNSi1OA5wOP4t8LJhKtoYbY2EFP3iQXuLUwkpdGV?=
 =?us-ascii?Q?iPbCC1f80Pn7Mb710ktN3GsZzTVcgHEXV2HlIhdwdSBX9T/oeSOMiV+O6izG?=
 =?us-ascii?Q?d6xHH4vrgyeen7G5MJRgfN56QSM9LwpD/Ib2UqUJ50zi4J9Y49Gs58VHdGK/?=
 =?us-ascii?Q?y/bIgLutJWyIIeDKuP6RPcnJzGJRH1oXHQnhGSPby9ceeXL2/v06M40+sUIG?=
 =?us-ascii?Q?wJ3edNiexlguiH1itpBVbfe9v+vyYtdP9hbvV57pc8xz8wcu6Xs6C5gWwlnx?=
 =?us-ascii?Q?TbsqZzwDaW34Mg2ZtGbD/PTJslXKOiLjNmgJvCUy1UmqNEbZ0i9b39a/mKVo?=
 =?us-ascii?Q?YcKWT5ykg9TNcOX8RYw9WBP8fxf0j+qIievSLv+DO/8d/CkCE5uiL9Fov3bk?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8477fe5d-c9d4-4cd7-f833-08dadb1bdadf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2022 02:03:11.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfcRNB2ZeSYgyWlYzGwFxj7LKurw7k+ncX0nrpdydXKmXsbuUuMbWQ7Dh3bbePhppIVSiEYda3HHTPu2L5Eh0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

Redundant sends need to work more like the MPTCP retransmit code path.
When the scheduler selects multiple subflows, the first subflow to send
is a "normal" transmit, and any other subflows would act like a retransmit
when accessing the dfrags.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2342b9469181..4c07add44b02 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -45,6 +45,7 @@ static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_sm
 
 static void __mptcp_destroy_sock(struct sock *sk);
 static void __mptcp_check_send_data_fin(struct sock *sk);
+static void __mptcp_retrans(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -997,7 +998,7 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		if (unlikely(dfrag == msk->first_pending)) {
 			/* in recovery mode can see ack after the current snd head */
-			if (WARN_ON_ONCE(!msk->recovery))
+			if (!msk->recovery)
 				break;
 
 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
@@ -1012,7 +1013,7 @@ static void __mptcp_clean_una(struct sock *sk)
 
 		/* prevent wrap around in recovery mode */
 		if (unlikely(delta > dfrag->already_sent)) {
-			if (WARN_ON_ONCE(!msk->recovery))
+			if (!msk->recovery)
 				goto out;
 			if (WARN_ON_ONCE(delta > dfrag->data_len))
 				goto out;
@@ -1111,6 +1112,7 @@ struct mptcp_sendmsg_info {
 	u16 sent;
 	unsigned int flags;
 	bool data_lock_held;
+	struct mptcp_data_frag *last;
 };
 
 static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
@@ -1526,6 +1528,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		info->last = dfrag;
 		while (len > 0) {
 			int ret = 0;
 
@@ -1562,14 +1565,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *head, *dfrag;
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
 			break;
@@ -1578,6 +1586,19 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					mptcp_push_release(ssk, &info, do_check_data_fin);
+
+					while ((dfrag = mptcp_send_head(sk))) {
+						__mptcp_retrans(sk);
+						if (dfrag == info.last)
+							break;
+						WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+					}
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				prev_ssk = ssk;
@@ -1605,6 +1626,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
+				i++;
 				do_check_data_fin = true;
 				msk->last_snd = ssk;
 			}
@@ -1614,6 +1636,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	/* at this point we held the socket lock for the last subflow we used */
 	mptcp_push_release(ssk, &info, do_check_data_fin);
 
+out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
@@ -1628,13 +1651,18 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
+	struct mptcp_data_frag *head;
 	bool keep_pushing = true;
 	struct sock *xmit_ssk;
 	int copied = 0;
 
+	head = mptcp_send_head(sk);
+	if (!head)
+		goto out;
+
 	info.flags = 0;
 	while (mptcp_send_head(sk) && keep_pushing) {
-		int ret = 0;
+		int ret = 0, i = 0;
 
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
@@ -1659,18 +1687,27 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			ret = __subflow_push_pending(sk, ssk, &info);
 			if (ret <= 0)
 				keep_pushing = false;
+			i++;
 			copied += ret;
 			msk->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
 			if (READ_ONCE(subflow->scheduled)) {
+				if (i > 0) {
+					WRITE_ONCE(msk->first_pending, head);
+					if (!test_and_set_bit(MPTCP_WORK_RTX, &msk->flags))
+						mptcp_schedule_work(sk);
+					goto out;
+				}
+
 				mptcp_subflow_set_scheduled(subflow, false);
 
 				xmit_ssk = mptcp_subflow_tcp_sock(subflow);
 				if (xmit_ssk != ssk) {
 					mptcp_subflow_delegate(subflow,
 							       MPTCP_DELEGATE_SEND);
+					i++;
 					msk->last_snd = xmit_ssk;
 					keep_pushing = false;
 				}
-- 
2.35.3

