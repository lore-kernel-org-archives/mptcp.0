Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7FC1876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLdPD8SY7yGHDpG2QW/PQ70bRD4XPz4DJu9u1apIrQbidSrvshtHpdBTNRrjDpAECD4gX7S84cGdmkFXhv4/sqzEfKMeFaqkCIP1+/RN3i+5LZVeGNw0oRlNE90J3yoz5q12jr4zyT5xHBJ7SWFYNqfHWIp3Cwob43We3lc6Q1ftk6s5SnRlIEbL6MWvljt2mpL7PUXtWY07ksbtFUzL84C6gsLLgxNRuAD/pl2mUie1KB1GX/YgtigyZtIN7yGLFCZgswNKPU53v6o7s+jykdVY2iMVMqOZ9XF1T/D7H0BmleOsdZhbTdUz8zNw7AUqnLjHq3HqOGcQ+Z9FsdYTsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5X1fTO+vYJZp80VJpLljx6NMe5AgXzroUxLOI1ndnc=;
 b=RPt9InoWTnm7NwdxpdA/dc7vBDJZ8nF088g+X255KNsWndez9MIjecFEWhzKXKR2GZcp3PpQ5ARf7HEPFOuWvfgPiCqvtzxlaztkVWbyme+6rrNSYZUWe2w+PrJTit2FpqWbiuCA1IHS1vlWTae7DFq8Z4To5nLus8z6KATaz1H4iubKKST8sb+b9kcwgbDxzm/AAyiOCl2YANQZeDFdHjWvXCNWPiLa/l9hXy5olBSjuaoGe6smrYVLDhuLx3B0wx4riC/o8MByL6ESJ3dkkJ4bfgRM8MXEyvYXF062YgWFZfHDWw6aiz0j2sE4DwCtsjw1JVHhpO6UcZ9RBP5Rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5X1fTO+vYJZp80VJpLljx6NMe5AgXzroUxLOI1ndnc=;
 b=De+GRo0Si7koq+8Y0L7phqQ9vY/cN3vFlanldYH1Xne+Sk+iXwhajEP/ETuG/YYnyAWvtFiOyILLs9ouATv0E72NMo3j91e/FgLmrU+N/EAgw8qqHMG4CMw8z6qV18mNjk5xCVH5ocVM81vJYLTqIhw5gua2MHfTWs09YjoYUT+A9eelbU0lonjjzgTrOXTyS/HOBw1v4kEDnAU9EI+K6tYPaoKlYhsHjaB0VwaeL9zRuwFh9rtsTWOYPLGgmeruOc6t78aiCW4TCIRpPEffsc6xUfKwYhk3xYB5mz3OAjnEwrEn/w0k4E2/jj93MjZ5RSyWFYTpSyc4mui1t08bKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 10:50:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 4/6] mptcp: redundant subflows retrans support
Date: Thu, 23 Jun 2022 18:50:26 +0800
Message-Id: <57f9e302fd2dd3273571d25adedae755f4fb8a30.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0136.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54544ccc-c9a2-4b7c-2eb1-08da55063b2b
X-MS-TrafficTypeDiagnostic: DBBPR04MB7659:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB765928304A02A504F78C7EC9F8B59@DBBPR04MB7659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zvvCllzEF/UrgPeINzM/CJ1djToOkpFmgFi1te/8fY/ebLViyvyDRDDdP4uZ2eFLSMWbEf+g81MNAyMXHvXZs+LMxsC0AKHm0igoLHkUTJAMMSiKCRYf7yTCf4X46gjZIC4hFiKvICv6WkTRFFwRVuqedgEOKvKkar8cFMadNkbpheccgants9YrfeaHjbopXuCMMzbC88Qg4kRqHHL5sYIrE0UlODR9u1fqbz4ndA3EB+fnVIU3aDAdklmvLbqr8YD2XuJRAnxISWT336e3cn/teqG2p8pfW7IrbdOYXiu0ig3RXc/wIFiq5yWF8u88xeWStTsUJ8XdQPyRfDSiZiAHjdPbbWLs1mLTnTmbtnAuQdHZOa9iQMuejbOhpdVF1tkYDjxVS0aSbmeZtOnK5Sunt9ML9PGjqSLFddM5u0tGtu13xElfoYNUnsPMHAuNGY8zJsKH1KMppNdQ0PMlV5xgojCUIz9Wg9VINrNMjsxKbal1WQ8cPCyAUsN7iqAfvWFjCpHlpMWTM87JE1kih+I6Fu2TQEJr+rK5EwfRxMOPVzkWN496c843es9GXrb8atM4YrQbgi/WNrOVKB4L0fmLXAQXZur4Ptrtx1E9GQeWKwii2MaQyQ7qdgHkX5zWdvoW45/z+sUu/WZG+FsgcuyxcMc/B8AAxHhiA4QZaAFngod9cxNj4tII24y5mm9kdIDGxceLWqwB/29X0ZBeYUfK2neDM7EA4tOSUL5XGINpk4xTtk2qVOj2UyiFnI8x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(8936002)(186003)(6486002)(6666004)(66946007)(478600001)(36756003)(66476007)(4326008)(8676002)(41300700001)(6916009)(66556008)(6512007)(2906002)(316002)(26005)(2616005)(38100700002)(5660300002)(44832011)(86362001)(107886003)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5S/sQGMTXobDeHzb/7Gm0/9PWCCr0khKkyy30Ln8ZV6wTZV738GHfXJFeAgA?=
 =?us-ascii?Q?mj5UF6bcaeWkb4IzKlyzf21EhUcj7U0QydjrrRJryf+T1HLzKTvPDVYanRXB?=
 =?us-ascii?Q?Z+D97LlstSP+OVETd/9Sd9i4Z05kYNFybEnSFIlJLYz2CP4/Kpt/xkmPmcO6?=
 =?us-ascii?Q?TAiHRCf2yWO6Gz0Wn1NdMtw5NGX8BM2S1kVYhoVN0tTkbOmE8SDj6A6GDiN1?=
 =?us-ascii?Q?ap5oP1yqhRJoZu9x/pL0qEcZSdwLSq96Dbo6AUQkcRpgOlisVnbttZRQZMtK?=
 =?us-ascii?Q?BZM1kWF3n6sNRPeKWo36GzSDTictBgWHlIReVX36DZADQ8dKOiDXfQERs76v?=
 =?us-ascii?Q?lR4yR1gUlFHKljLfpt03XXkhS9nkFGZw8lWqwsSItn0WuzxRf87Wn5NjMjzB?=
 =?us-ascii?Q?tp2VpWfLmCX5jN3/Q9ixCrBI9xx+VzYNIBTr2NIgmvF39jJ/2TjjjeRfJhDm?=
 =?us-ascii?Q?kN4ZfEB5pcu1JsYZebgU2kJwI2lyPwYM/5a3E4Lck3OM9mlz53yl2UMNvUi1?=
 =?us-ascii?Q?eFiCo4g5USsfHvpjBC6mjQ2grj9Z16+l03szMDiFzBb9zrEGHdkhOK+ZL3J8?=
 =?us-ascii?Q?9pWVbg0ux604vjR5urdtNT3u/D0bBGrMXGZ0fW3uTbvNQ6urBaXt+lH+fiM6?=
 =?us-ascii?Q?XQAtWqXGXwa4k/o0oQ36EVssnPqS83YL8QXb7x3ROlTtoIWtx4NNJvNKwTeg?=
 =?us-ascii?Q?GY2RasUCO45/gbzTn/EVyDuEZ33S5PJJ7iO2nKszI6RZxjQhLWPlT+SJQkQA?=
 =?us-ascii?Q?+2OXSKr6mOy5PvTFJ/LuZwcZOjs59ISPAv353pHgdm7yes9k+Z5J7lq/ZVcv?=
 =?us-ascii?Q?DJvJmFA+tYHckfOtx+ycuAvZAdNctARbqgSmXgBy7QMih7RWi6A+q8fgwGV5?=
 =?us-ascii?Q?Q/zR0W7LzUij8lJG19ggbfrWeB1Sk8UutbIZNr5cUSVn2KbKJJehc2WF+kVC?=
 =?us-ascii?Q?bZj0eJ6eREph50Dxv57uT+54MFXrF2nCLcq+mSGqEh9+R/ZcUXeXNvfRm9ho?=
 =?us-ascii?Q?X/+vMU5mWLUWyuPKHCBIVvJwqH3A5xJsQALxEuBNh9Qn6Q+iZVeuryU6K126?=
 =?us-ascii?Q?S0xl6HaEu0dnKTie/9wLrxRnR1yD37z6xtJLYBFNi09/F3xM9A30wUx8Rtca?=
 =?us-ascii?Q?uc5PtAKA9k6SBPZ/xvsMvMRyPmjq6nBBCifWvazpGFJesO4G9IExyzpCjcN9?=
 =?us-ascii?Q?OxZOQTBeOQIL+pEbKp30v8IiSJRrPQwSwVdJOkc3Yn4bzPUgdNbZ9OK+9aKM?=
 =?us-ascii?Q?FaB17nCphI76dydiMbW7rkjDlQNtFTsJSA0PpkpMkX8bJ8AotUv+Z85cVKhW?=
 =?us-ascii?Q?oywlauwgch4L2r5CpKfsh2JsawEHHCpx5U85tMwvQpl+Qb31+znzyXyfeIIP?=
 =?us-ascii?Q?9u/5InhunXwmOiKyDSUwrplTK9FBpxlKVPlMXPEHnelQWpOeAqZu7WsvwJF9?=
 =?us-ascii?Q?q+KbNH0/ycCI+FNUnipF9Kzjo8ig0ts7cBze2pQ0S5fAs4cFrzB7LBcuOlj4?=
 =?us-ascii?Q?w338SjHQXVX7WCOGp+QCYeqei0LWDEriUrSaDPLTFRJ1XOayVlbtaD898Eql?=
 =?us-ascii?Q?NjL8P0Mgq/jTdu71lq2nq+1yUwSRU6qaH1ZLaQTbrGOLL6fNvxyo/Rh9X0cB?=
 =?us-ascii?Q?jrs+V+h0JTb6mY+Mon5yE7/xqHH+NqKCI8TYxEOz9/Zkvj2QYQ3uDzFfC/Op?=
 =?us-ascii?Q?6PWlNy+Zg7L+yxOpm+n58gyAPOPmBZhPr2zLKSB/1HHu2zZz14l1c+NXHzmU?=
 =?us-ascii?Q?gYLQLasGZE9w/vSySGiNYKH/fFyuDqY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54544ccc-c9a2-4b7c-2eb1-08da55063b2b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:47.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXzW/6t8g1sSqyawxSvdJLNFiiQ6QZg4BlSNScKmgBePSBicDG13SmV83OMukhadz9s8b/MJEsTdAHg6VC7ZVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0be43107170c..c7455b3787a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2416,16 +2416,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
+	u16 max = 0;
 
 	mptcp_clean_una_wakeup(sk);
 
 	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
+	err = mptcp_sched_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2444,31 +2445,46 @@ static void __mptcp_retrans(struct sock *sk)
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
+				max = max(copied, max);
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
+	dfrag->already_sent = max(dfrag->already_sent, max);
 
 reset_timer:
 	mptcp_check_and_set_pending(sk);
-- 
2.35.3

