Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6391A33D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLvA4t/e7ExnwzoHdWANhC64MvK/n9CWW2uYFIy2VcRkzo3fVOeNIYxNrvEpMEPLJIdfi6HanVfuy9SoCwzljUBG6FQfsVktzaLpVOL08/hpKy2NwOAC5JMQYNjboyyCs/MMTGS0CzFQFEF7s3IlXYNlVM7PkryZbIZYFm8DNyBX9VPd1MjM14tbDgEaKRbEFZd3B0fgWS6/dgkDY9mbMlO1GtqlBMGm60K4bJChFUwL28JU0VJXH4luyCX9SR007I7xy+xnd0bVECjj96MgHFn2e9S01rxvoNIPN6N1yEi4NV3cOKD6Eyykmmf4ZyqWk9CNLLyBXlGx9GWi5qWkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlF3IwrBPjtRNdYoykgDViNUqjPyquCPzvN4olnC2KM=;
 b=fTqGJ06HwdROu7X6KwvVGX5tXil6ymAUKTL3vi4A7bQ0LAK2Lw9sA8RYBv8OWXwwZHo6XdSzFXqhgNLszAgodbPu/1vWah/hsRndQJdODLnPRbP0xFwpuSS3jyJYKcRn4+khPDqgMHIlqx6CCyCufYLZ+u5WRsCoSyOaySsp2jrNSQopGIUMQ40jLOxje66eMXuAeZMGySxoXHurcVAxgyfcHGDqynQuZeaiMSN5axYoWbDIQhu8uvDwycIyQ6E4adSN1ZjSWjdUXIDN6/JIUCHV8UXfcywz1z4T4whySYQ30mDIHIGNsZKsxUtQqolT8imSStbhn+4lhAJfYRyluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlF3IwrBPjtRNdYoykgDViNUqjPyquCPzvN4olnC2KM=;
 b=alG3HEP9L2bOfwPIAXu1FVD3vwlwNZjC21gxPp64C14XmDyVok73P20Rzi/+5KRZzKSfNi9TeBH4JUKOsd14HxO2wpGejUhvFpFVPRW4elZ19x2sIoeAngN/9dR625VAtE2lPyT9EICgLlymUqAsHAURTNQlFDva6QTBCT87kxJKCWG6kuGJaQ865PCSBlTrdl9S8ExMHT5UHl2yN9LqT4tYPWWMQYGRVReAGJi0ufW2HDrIS7XJyUeQr8BsIOg6iUkGVTaF+ZNtbldqQs6Z7ofMOqJiP7FiwTc33nCiTuMJw9UAaDxAEA3RZnjlVsft/MRMSZq4eItbYjbsTa7pag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:26:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:26:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 11/11] mptcp: multi subflows retrans support
Date: Sun,  2 Oct 2022 22:25:19 +0800
Message-Id: <98389b79ee3e35b87bdba1b82ba409d6f921aa72.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: aac8f4e2-2519-473a-d26e-08daa4820bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EiYyLi3pnG9uIklk/xmP9AL3kflECyhHGJacUvNXvceQ5DjdFSfybKvn8OTWsi3GFwXzWqkPUPK62NeyBJ/FBozKNqXaYnHskqMnoBaCNKus60Bk4SzFu1VajFJv/ugqjDcDIRHYloVzgHV1yE4tG6sLs2Pb57CaZ6egyJY8gtwV2ySa+7HRPDT+Cf2CkRH5wlQgYmLiazb9B2X4r5O7jG30eC5J8DRecMd3iW7ZZQ1JJ208I9Z86I0Fs75RT6vV9bNcR+lg4Gbrow7pxy7o64JK5DxnmGtPLNEB2JSKtfYs3T7in/xpLfaVzBgDGUBZw9+Ru4Ky+Ah8TP0LmOuGEnjkJVMPK6+e5fj9cYzgiEmb+x5NGcE6g/703Q8rt8AV+zeDZpoeV25dh7ziEHBwZ7dcIn1fO9rsWbWvfBqqQ55sTnxYDOXfszaSktFSwYRS1ful9WbpkRhEINy+Qvba0kGFSV1m0sypHWzevpy1spq1PRo9ABmrg4wfYBsoMie/UwZSRd91wOkEs4+UTyDx8j0PUKPrwrq3oNOvleO9yzYzvz5FvJ0GQSADKG5xhxBCR6z0boXnVXNa4OsBqtgS03s+lQR0pNLG2aT3/a5vjB1X9ju7DneuMcAr59sK2x89ecVaFVRCs/KuolX8W3Caa2yKDNqTJUh2tnLlafLMdaLwfhTEmQLXO2rSnzXWwkip6QjjXXYmfI0QFf4ilPscAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HwRGyyHymR78DSQ746CI83UTGz31vlvLC056Cwo2S89nDuCGleDLi9EMgb4?=
 =?us-ascii?Q?pRjvKs1OQFaEP9b1hDmFMGHfuv/hpz25FEz93V6cWgzsYPWoN5oB0LWcoqyq?=
 =?us-ascii?Q?P6BC5R3rY8k9IZ4SJbiV/HjtuWj5lODztBXId5KCnB61KZjHpwI2uh/wEWX1?=
 =?us-ascii?Q?bq/1VL8MVnFB6DDNPJwHbLkqaxQ1dwutHWC7Or9BmPx3kRvnh3OMWnKGMZEV?=
 =?us-ascii?Q?LizylwGwHzepEq6b5ylgDoI9l2P4GS/ZNenic+8N45+ISNqFAPNuZcP/NQmS?=
 =?us-ascii?Q?qoNKkTHp1E0UFrq0JE0R8AGsIylZOaBjqM57iymktkAUrotm8RSWL0uNNySO?=
 =?us-ascii?Q?P2vK3lMIBQjfK+3lJWR7Q3LLELU6jn9lSWNTu5HAQUdok3x8mPtExuyJgVOm?=
 =?us-ascii?Q?ruCTRZYhp1YMh49VUCM4gl+109sYc8xT8X6MPNXRww4mnzefhu4kSuM7Doxo?=
 =?us-ascii?Q?8MKiycos33KTWVWdrjmjQjn07GVAWrz3GKjvXfGV5Ltp89d9JSfmTnH5ot7Y?=
 =?us-ascii?Q?d4uv0kbmskBWLz3d3N9MZOwZznwNHP9D2jXEO0llbhvj276FHz872Ty0XiLT?=
 =?us-ascii?Q?3cByqdIRxTj1UOhQX8o3Wncr6DFPOfrgDEjH7mhVuWnYf16dkXOslf6x8/TR?=
 =?us-ascii?Q?WnCUnywwrLjlMZv/tng+qwZuxVe7LqaX9ke+dOECA7QC7zOZTJeRkrOcWv7M?=
 =?us-ascii?Q?ojR/e5DRR1MW7PmbXn1/ke7hxNEXpkVLcsXtwPWO7zytTCulSAhByKmxJKfk?=
 =?us-ascii?Q?J/GeQU37ijvtoH5loK4Ig26WxnwHVK/7kmHP/8bOGImp6MShpjhpTrUJE8sb?=
 =?us-ascii?Q?zL731M9ddz4HPc2bA5/QvHt/Vhv1VO6y+2SjLdwFv+VIN9C6RBK/x3XxxpRM?=
 =?us-ascii?Q?P6LbSxIVZjMQ/8op3/ZZb6SN6Vl4B+DO95p4I+d2IxYFdXGnt/PsFjld+25R?=
 =?us-ascii?Q?N6h/eL7qVnmJYOGDW1deNgkL4nHxzCkt8sQQht/rUcIHOVqVcJez27MinDwq?=
 =?us-ascii?Q?Enc2DbLNeDa0cn97L/D12euKxHmc/93aOROhuQgzJ0MuIVrvxqafNhNAWGRI?=
 =?us-ascii?Q?wic3Mw1gTsHq6BXCGU25Ex+Mu/L3jbimRqrsJXyhjbYkH39qveVdiNeJIk5V?=
 =?us-ascii?Q?6RRBfVqx2g4klPL9PVPb9kEavpJFemvtiBoVWUCTkrsqDRfh0pVWJ0C6BcbN?=
 =?us-ascii?Q?RT6G2hrS5uDm5MK4XYoECDWxHPjwJvVP+rWtNvfDB1K95w575Z2OHVchVh5C?=
 =?us-ascii?Q?/jsvMPVs0cVuVdJO/KoH5Qff9ohfycMsbweMJKh54UNFJxSrcsxkiour9XF+?=
 =?us-ascii?Q?E46N76YNO2O33jmbEnd36cNHst028NUr64MT5sXEgKRv9Z0GkRueIzHxM7xT?=
 =?us-ascii?Q?vmvX8BHNgqeagKKBhlWceqMtTlvt8YkyiuMUa+fkxxIGKd3pHHrnlHQE8K3g?=
 =?us-ascii?Q?HhMbwBfn/i7aWFSYlBPFFoFp59wzlbMy2eg8q20SBCjuriJtLyo8PZDvAgYh?=
 =?us-ascii?Q?unulf9XAMXat3iy2bsuuNx55osmedtILzlsg5wnLe7SrCl9foNcWRbqn3ruK?=
 =?us-ascii?Q?fHpQYQ8zo5g/GCHO01qEhmw9DD1NMbTbMEyVWYZ3dIVUe5BgnVgfuPsPjdLa?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac8f4e2-2519-473a-d26e-08daa4820bd7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:26:08.0243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTLPlWkbyBwhPa1+ZDzwS2asxi4iA9gCxNPL8KrWU0mKd57wU7AZaUvSY7i00AMcXEC2J+uCvYc3zUzYAGEeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 85f72cdfa2c4..b90b4bb70ec4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2468,16 +2468,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2496,31 +2497,46 @@ static void __mptcp_retrans(struct sock *sk)
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

