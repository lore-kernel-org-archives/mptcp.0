Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4F37E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSdL1LfryTaJOW43ZscwQQcmlmQAYg+lRaG3cUuUaRLTVXxsXCnGy2vSA7Mc1XCP4c24QzqEM0FzXjCUlHzWQv0sudQYrhTVdtrLxKnFDDlbKSnRWbYYqUyATDKbWaux4IY9kLKx1PNKVT9WOB1JpFfXC+a92HLQXD9vr9ZFy7aGPbfcpI+YZAHVEnpP9iBTU3GT67gI8o3doqGR9G5lxD8J5VOMFtjpSdEnnIpv6j0dw459NJnTizpF08/ttQDcx7BmdyjbhnVIbrz9uEUCibjhsjIwUIIguGg2rExRE9l5Z11+7sIMn5keGJrUFmwarlPRH2DTxN7Sf0Wd2G2Jeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiMAKpxeiVGk+okQGPHSc58TH3XvIRAtS5rAGhilfnw=;
 b=H4dNY84wMxcqMYZpHqpi6s34znpEQf6aqQ1m7S2DBn+m3/URJ0wIvjf7F7PyOzLB9y/HmCsygpq3qXx4uhABqmPYTkUU6EVxjLNGG4Yd5jmdKyJ8Fgq0o9xLtLxlGUtHo4DW3SIWPs/j8EcV+G11qHZPihZtJqwkgbI7+/8+yDOmofQ6KKMu4KHK9RMZmhMHKMcjYrUiHIih9WIk7Z0MJnvuDlWXkZmcFW0kyS7e9ejy0EhpmWEkuQeqGdLDlWdqIGTHzDSHKsj3PjebzmJU876/kEzlAoE6jnVRfi2sTXtbLpEFFRJevZ1i1NxV7dDeR667oKswmW0roqr4gVtuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiMAKpxeiVGk+okQGPHSc58TH3XvIRAtS5rAGhilfnw=;
 b=v1XHDabG5odd93JJdUyoF5FhsSeuJp2FIfp8Qpckc+UQSeH2lyR36GE3aw9HcSrnN6TaGb4tfvHhNmTjV8ytz5S7WmWPEIZkEU27r4lphik1JyXSKfOJD8b9xyQ14JV5iIBFifGrjG952gPA0SzmA4DdCrSBxI2JuVZ5XckDP/ewGXYEXG1KWBpxxYfUQ2CbcVXNY7QVXUYXCYEHV+eKHxpyNDiJTwLQ4xM/YQpYdqb7VK/4Vpg/kjFZuzpxRBH3QTd5CGweeDvXhf6hYEMd1+oChbr5ly0lEouQmSsaN2xXgvkyfNTypoR/07MNZn7d6VL/RGa7Q7gzoplcJPOWrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7542.eurprd04.prod.outlook.com (2603:10a6:20b:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 09:11:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 3/5] mptcp: redundant subflows retrans support
Date: Fri,  9 Sep 2022 17:11:34 +0800
Message-Id: <5b959eec45fab970a5b168fccd7f17fdee843ee4.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d89cc13-f481-447e-8a85-08da92434b51
X-MS-TrafficTypeDiagnostic: AS8PR04MB7542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X3ss2Wcs0t9ou/oQ6w9cmD0ahxI3GC475lgBTxE+O+xn3M+e8w/xH6qktgB63R7H0JOWlPFMtSL5VU1saIZ6hJUq2LYB66NTYXVBiga6wOsOCD8xJKUfYmzvPjZyzaJSlU4tlYw5PZuvfn2hz7LzOKIf2DbvgSE/7fW7FtjRioCkj2y7BpSYDXwm50ro7G8/3xb+iiyZsQdj5l6KSIGggimUxDLHK53B51NldBXo8/JgpI4ne3BfQdnh6P9j+V7ZcXBujjJAHUDCYwl4SJmPeI2558iOcuqGLAK3RNz0gfAaKtS2xMyHtb0aouyKSpFdQwjagpmWNrhdsuBper/t2lbxjHN1zJE9ugKjtuN2lwcVhkFg1h3Tc49cJvAwgnaGFZgPJZipsWApnwosd/tOguw5fJV1KsSoCcj6ZpDB+OferMx7MouFU7pZlVzX9GGV/6D5xKgWtEfkWVKEhwegW/6+d14vVqvuekFF6cX6cgmwclznQj78OFAv958woBT3eOv7ELFmfu4ycQxn2rGq3uNpNE4DI9ch1gPVHyniChR9tlYS76fy2JNhQK4c4hSx3l3KJfJ0TKsGqKycXpq7RjjBu47XqwNRUmofgoBikhqkQKMXBegYLfpu2aNRUFn/e2ZxZdjV417PX/pvDNZuK+w6WepgsKVIi2oNgpet08+G7US3NS/rG/XbNUrJFtRAZi/xCKt6oTolNyJJXGLW9nrDuMK/0H0hCDmXGZCW4AQPEZCgcfqgdWcRk5F55qrG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(38100700002)(4326008)(66946007)(8676002)(66476007)(66556008)(36756003)(478600001)(6512007)(26005)(83380400001)(2616005)(6506007)(107886003)(6486002)(316002)(8936002)(6916009)(41300700001)(186003)(44832011)(5660300002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z6YpguXkaBwf6k090lwYsdvsSyONZ7LnLmkH1sJtOG9ln/3DDJWbnqEUj08v?=
 =?us-ascii?Q?M6LzKljDyRWSKd3EZnO6L+smKjd1fv2ivQ8wlNUBhyNF9kxbJltFYqwE//sQ?=
 =?us-ascii?Q?CPd10MHaEIxbIKx3smCXx76mLdu5zHfvy8XWLvcxcsF1F0aXE77swI6cCqdu?=
 =?us-ascii?Q?PIub64hzKm2Ot3G5WevhPVGPVTpW5Ul13MvuJYJCmEBCvpfUa5fkWxMp58Qc?=
 =?us-ascii?Q?p349SavXYoYIQ0XzE0rc3Vc9T67ofica7b+IKxqSGameEVpAYlvdAjL4nKuo?=
 =?us-ascii?Q?tW0dWddbEHxStLXB3jA0iGDQ+m+ERqnt0Noq6Net/UpwHUmXGPBGm79nCv8U?=
 =?us-ascii?Q?yhhOBqt/109VcX5MnOZZcsTdg2o7VH8a+FMgMR8Y/IMOWVPrCbvCC/xlRlxX?=
 =?us-ascii?Q?OCqDG6k2QqhoBylmS4E4hqXF+KEAupwfBrePMQ1wCiV+pRDE4+X6z5d7DVaa?=
 =?us-ascii?Q?yuTRweqXBiUr9Fw+f/f9QJgA1LysCdHWVMvM+Llz1HG+LZPIDIuDcCCEXCeX?=
 =?us-ascii?Q?L46wJ6Sy/uG2RlVniHiwOqgLVVe4gIBiecYTNBok+mDuCTveJsRz6u9/XBO5?=
 =?us-ascii?Q?4IIDuQVMG3tF5rl0zghxzyheCauwL6k1+I9hbhiFcR4jtfF7HswITclK/AvL?=
 =?us-ascii?Q?GQe161EroAz6WqgmG1Ov/Bhie536H5O7Ed5popjOVmPjVW0t7GulzJz4xPFL?=
 =?us-ascii?Q?boiDa5UxBUG/xAq4cGMOaD8uvZ/WK7RazmC6qvoB2pm3Un64cWCdN5k+uj85?=
 =?us-ascii?Q?K7wazr36vKjFGHTWeZuBJb9FkNBRkRpdb7OG5e76doPaLnr0r1naruz5s5Gj?=
 =?us-ascii?Q?xI6DPrU4hmwyeWXuqq8Z7z0EStxdeSCHpOS/vLd5Yb8QjjfKAXQ/qvw4XDQK?=
 =?us-ascii?Q?9T7bjvKLTRyuyTI7MAshnUyd9HO4bHymqNbxF1igph3xJD80px5rYJ561X61?=
 =?us-ascii?Q?HTWHoI3P2UZgV2O5vUyQve3t5jYRWcImVIMmxUrE/7OeUlPt146GnubRlEm4?=
 =?us-ascii?Q?ah1tzfKyOzSequHqpeQg0p3RPtPpOl/O7dvJ8c2bwmowFtD8a97C25O/J+7B?=
 =?us-ascii?Q?G0YT/jGE60WOFmL34ZbLZM/oP41sTxdLEZurbA1Ir+Uev3pJqr+cY8cWAiwS?=
 =?us-ascii?Q?UeJghQubuKfAWPBEb19nuLPcvomplf+2WuyHq9PZ44M94lA9X+bHWgfQzeVp?=
 =?us-ascii?Q?IWoNQFQyP1/hxgRF8ccLN4/KFD1eSUERWpFsOht2jFxqDHJpp0lpBx67Y2wm?=
 =?us-ascii?Q?YVwzoBincMorlAbJfczflVQKKEa/pgHaIBpwvSmo5eESeor23yWOnc1rt0pT?=
 =?us-ascii?Q?Dn1RWhqfrlZEwbzE4aZTZckQAyVigzSrjU6ztsygeityAwTDt32uzgg9LTNJ?=
 =?us-ascii?Q?gwQs9TtX0L9oXya55N82jYgg0Iulm2+eWDUfDfxrpzjqZKauIFEaqEZRte6K?=
 =?us-ascii?Q?vF8NJdJS5cm/0FctyDo2H9lwvyGewWrqzIFLwMdGqM58Ulqc8I2IJZ2x+Sq9?=
 =?us-ascii?Q?YQPyYbo+0SSF1s5MDXRBD7FGzlDe6+LTgJrq0TEClQha4Bss9qS8UnDoqFKH?=
 =?us-ascii?Q?kRc+kU2dGnxXS9SSv+sr2YN0Uyy7lM2AIIjw1QeI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d89cc13-f481-447e-8a85-08da92434b51
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:35.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QexrkKYb1WGwBGDb7V3RnaFGeQvZFnMDgNxrnTyD3PMbz7yFhVh61teFV0yV4V3lw9+YJPq7Kuu5acy/flicfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7542

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index be62126d7c63..bbf55a0fe314 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2430,16 +2430,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2458,31 +2459,46 @@ static void __mptcp_retrans(struct sock *sk)
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
+			ssk = mptcp_subflow_tcp_sock(subflow);
+			if (!ssk)
+				goto reset_timer;
 
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
+			lock_sock(ssk);
 
-	release_sock(ssk);
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
+			mptcp_subflow_set_scheduled(subflow, false);
+		}
+	}
+	dfrag->already_sent = max(dfrag->already_sent, len);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
-- 
2.35.3

