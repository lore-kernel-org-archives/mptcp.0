Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30088.outbound.protection.outlook.com [40.107.3.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6BEA6
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 08:51:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKR+G2SBduuFV/HfGXx//RpxBPFETms/XKZ4BmKg5aCC65tAtsTKa0jaH9lenH4Sh49kvRH+MvRPWAYh9STbcYHZYaGa+JkzGLBEEwvWAtUpHsnkKK7kxZHekKTGoKPHTkJBxwwOI/889eq3+QNhPm49T3TZYfRIacFmVSk3m3g8N9ILSAAy6MrbgY+0rIhW4A8M8dwKjZprRh4T0KhUmRNaDLs1I4mb/q+TzHIA9rtmJ5kKl9KvoHQwnMiWegDndL2ESnNbCrsh+cQdPVE3nqERS7lmKzI+8/BlFEqF/t2edN9Jxz/R58bQbeGsg6CE/brK152yNR3zoNw4lR1VBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jovhntmTzU4gmIzTJTnqKNfUjz1ltHShObt82ozRWb8=;
 b=NfbyoIKhMcSZF01AVMZifLVoeiqDgYYlHtkyFrLhbrZLosdNmZwmuhwrK1fKSih9FXrvEmhP26oTBdmhLeyX/ObafHpj9Cvl3CxOKy09VlBOcyxGiydy3za+Of/wJDa9S4SROUh9eH2sTQLbKKF5bzbZmjlIyk3mu3MUNJDfD6PUpeslZUallFGPk7ATom39lCNQtAK59iOjy6+RYT0Dc21tV7e3foHeywBQIABvW2P12wUtxiafTp+EivhjWXUPByihRwKb7pPvVYoi/dtPSMOPv8ocRxncHPjC8VvHB7+ns75ihUlaa9/xqzT2eWeglU205LWKmTR9LD1cCitsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jovhntmTzU4gmIzTJTnqKNfUjz1ltHShObt82ozRWb8=;
 b=0e0bXHkR4yHOkFdAovno2PgIKaoj+wBLYIcmUXvYATq7j3Cf4W3P6Mgr7XNKZBh1/QM4Ik+hhEE9/VbgjBODFTWkwsOBrBiRjmJghYxYbIholGBNEVM1y2kSqarQ5b3mAqbTQuBBX1l0GjyuKC2DGcioeq6AJq61tTmD/JfOOXM+wddDwaTH8VCY3YFOTkV827MRjc8NrrYHExOKGlUNtbqv17JLg/XFQG+XGKa4yzvMqniL4qgarkEkSC+dtPygnvZn9nDilklq7N940vGeYmzFmS8VaVdBrDSk866XBH5WVvXZS7f1bR2B5qQDuuDM2yCiSdczuB/IlHzKX6HvWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4381.eurprd04.prod.outlook.com (2603:10a6:803:6d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:51:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 08:51:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 3/5] mptcp: redundant subflows retrans support
Date: Thu, 30 Jun 2022 16:50:52 +0800
Message-Id: <59812cc1ba657fd6b4a2d1e499809cf3c3917e1d.1656578856.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1656578856.git.geliang.tang@suse.com>
References: <cover.1656578856.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddf5ed5e-8cd3-4323-3fc7-08da5a75a9a9
X-MS-TrafficTypeDiagnostic: VI1PR04MB4381:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4ZhTdqPrQy1jYxyBas5QtevVWMrPLrqRZnJoJaSh9+BG3HKBxZj4GdlvZY4/0Bcfa1hvk5m4ucHjgMAk2lmPsIG/n/GEs/0hLBRMxzhOXUqEYav657Q8DluqWuQrV2XeO5Ox27+2IeF6nAPExDiiW+S2/pUtQMg+tCGtgD2j+MndjEdMrnc3blGbhzGSfiTw/zukcJoWSUa/EpfG1WDJBZT+pgHXB9Qz3YgYIIkcneaYquluoKiaAWsj0+umJdhl2QgfVKM3hhur8PwbhesFmHp5Z/gkqsw/DE2gT+Kr/R5Gb1YoMDCPc0cBCdrlLsAMNgbqnxIlOFWXPvypIPYnbQ9HhBY+AQuheukUSC6JLKmai5B/X73rV4eOBelTeSeJ8m7V+9248MCHIg6ccrGaEX7HfpSRz6veRxXWQQsXG/8C3KY5SPpCIK/6clT1tqwxM3/LNY5BRhz2gdjc5gK7CpX/PceBuah69dOes5yHJliyDHx4kFkHqPnGg1rz9FwYIIv2v+SS9nkDC0W6ekD0p4L+BI/V/GjzYioVedWdiqm4I3LsEiQVnNKTFQ+hhpQXIzmcFpDubIDiNc+6947+JWrtUZuHqCp2j2MweI/ieo6wxK2570dvNSHk0lgeKjBiS4PJfOJ1OETeCw5Wte0iao+2d5VxVxsHhsLgqim1LbM+rKqpHIeyywhbi8q4ZkKVD/AG72CbNMQizjgRz6HFSG6vibJZf6N8IjS4oe//GMMtuzO4ayf32+ki/zFE1OTZXo17d922ZVMLdDIsqq6rdjEFEPY/+NAO6zFJud/rosRlsVZzjJWxvP2GNedyHsrD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(136003)(39860400002)(66946007)(44832011)(26005)(83380400001)(5660300002)(8676002)(6512007)(4326008)(6486002)(66476007)(41300700001)(2906002)(86362001)(66556008)(478600001)(36756003)(186003)(38100700002)(8936002)(2616005)(107886003)(316002)(6916009)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vGAThHwzkyQkDZxwLA3BXOa96JYIApxCUfJUlZQm6bB12XlJvpQARPiaGfC?=
 =?us-ascii?Q?5Fkd9RNyqPoxBGe4Nw7mAVlZTjxPaBZuZWWPXr88Aiey6g/kCsepHFdMlQpr?=
 =?us-ascii?Q?ZSGZUX8w855jYT8iNvW6KdYGw9poaB50JmmKsShvi9A4+tjfvXsd8FEfZFbE?=
 =?us-ascii?Q?h3jMxyqqjfGBNRUP31i9lA/W8sfc+PuG187t4zEPH1/f/xM45Dbehs0kHjeb?=
 =?us-ascii?Q?DCgKeeO988JlwwJHy8YD6/s6oTFLUecam92703SqC28vYBoYXA6B+oz1ykZC?=
 =?us-ascii?Q?rhucwMVx/uEOkh1OyITjRd74yEevmYQgdlCBfibSVjoQpE3AkT6rI61cmSs/?=
 =?us-ascii?Q?HPOM8t9HaDfAXGFm2HYDSEa9PMi1T0ioFXlHSoHdng+ApfjrS+zgqLPSb+gD?=
 =?us-ascii?Q?ndACuGwPoDkjlP1ZqsShCpjjgKhXmJFi4c7ysS6zPaZUuWCgWAhUkNzEQw2O?=
 =?us-ascii?Q?RNu8ri2I9ygSq7mQu4dhf4fGBwMcw6KZbJXEnKT0oJY41vd2lzZt93+XP5sZ?=
 =?us-ascii?Q?sI1kZ7IBumdU96YT+QQzREoxLc7xg6NvOOsqcP1SZQUxOJEPmGKF5u1wF+ZM?=
 =?us-ascii?Q?aCnrXzpaVind4JNlUIEl0TxWW2/zXErZsmEc9S1MMPv1FpOl2teP/m4Ao3mP?=
 =?us-ascii?Q?50Tcn39/zx2VQBOKwDV08Fxx5Vz28RsnxqilOLV4pny87yL1U/63CUenZzjo?=
 =?us-ascii?Q?0WkoLWRabM8OQkNfrKyJVMRmvFjhFj3DNCbbalSv8bALCzRhZxskWQ06BCrZ?=
 =?us-ascii?Q?IQd6hjzdTESz4YyAee8f1j900a1FkUnQUMOHqDw9lZwnSy074PKIjYHSAx2t?=
 =?us-ascii?Q?NVFYDKe4aCs6EGjikGXPKsioE1lHCLIi0dURsWkOZOX3IBIToF/PVJRnd3CM?=
 =?us-ascii?Q?CT1OWAvcEurPEwm8EXPFSmx5rcCswM7r2dqLR5Kp74etplMbEL9Ea7w/z+6K?=
 =?us-ascii?Q?V7t8SkGLi1vstGecOiYuNYb7p2PjvmjOvu3wHhLR5N6PLczNsIfff/sQe4gz?=
 =?us-ascii?Q?kHhfm7hkX7h68qa4QnTw9tlh3eNcFGRX6mN6UFXRB/w+ztm3OYxJafbKpvpu?=
 =?us-ascii?Q?j1S4W91GhlanaaLThZRYYqCLIFulWIIQEneSB7ZWQSGt6xwdwbqIR8eu+Rsz?=
 =?us-ascii?Q?Da+YZNBoyi/nxcytmIrxuxRUISmQlVK6RnwAU1JHazgwtVQcXJjxWSwJTR5/?=
 =?us-ascii?Q?/nLgLR93/4e7iS7fzzKDUP8y3FsvGUDCzBPm7NYNvUoT+I+6BofL8jR+++ru?=
 =?us-ascii?Q?4Bv8jFvSOUKSbqeUPcaswqAmbqZTwhiQxRvGSVae+UCrIeVCF3IGfdrhfKxi?=
 =?us-ascii?Q?Radnxwo0KLYS+BGZZRtcahF0Xgx+cdBivsaL+Fz5DzLpXlH9IHy/ctIchBPv?=
 =?us-ascii?Q?KYGb1klUANgIYlqdyCLA6Y51pVDty2WEZ1lmSLe9LM0BzMmGgiWY8kFE55g8?=
 =?us-ascii?Q?vRLFz/AXB6gSlWpI4aNYC1cLLk4ih4ZmHzB3LTWrwqciUq/pxL2T1e+iftfb?=
 =?us-ascii?Q?IKkd/+hH5vybU3omVy8fWVIhfXkXcCSNd4l4AnQ1bJv1GzuCUkw3gVVh9eZf?=
 =?us-ascii?Q?+o7cr2v1BHdvHHc0g942de7Ay5A6quD0ZQGaRhGpukQibX/Lg3ROK/aLWI3c?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf5ed5e-8cd3-4323-3fc7-08da5a75a9a9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:51:03.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYE616jyniUCM+gjwbIxcdC9NciaQgqv/gJ5fWi+7TaMSIjWCDpFOsTfAXfj7alXPNHpt1QyRTz5Bl1MpTKASw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4381

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f97e6c318c0b..3046b01c140c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2415,16 +2415,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2443,31 +2444,46 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
+	if (err)
 		goto reset_timer;
 
-	lock_sock(ssk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			u16 copied = 0;
+
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
+
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
 
-	/* limit retransmission to the bytes already sent on some subflows */
-	info.sent = 0;
-	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
-	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+			release_sock(ssk);
 
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
-	}
-	if (copied) {
-		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
-		WRITE_ONCE(msk->allow_infinite_fallback, false);
+			msk->last_snd = ssk;
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
 	}
-
-	release_sock(ssk);
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
-- 
2.35.3

