Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD533EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eR5kaoe6uqTMPEycUWq4atBPP1wdMDYXlfGZyTBTBC5l3NZpgpexwtKorGCkeT8RzVcJmvAzgP3TvKSZ4xkjTst1snwLA2xNoQ6m3pQHe/EVVf6h2Aedne2hEDa84/RvejFpHZ3JqlE2AwS8uj4zO9Uanz6bCg62BIIBbqG0XmfsepijJsUQQQNU5GxwzgMljNdOe1xm3EdFUSdHYCWa+wNYXhyjn/lO9aefNIVm6homK3m9PpbMq3wnfIt+DlJA/dta5aZ1xkVhYcbUCFScVRGjJRSNR06LhaNXOnO807oa7tQvQKFHbbfBD1Yu3wM5XuompGKTD9IIxI1vrokHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvI6CAVafa8dpbnbLK6RcfJzOLEvzPtg1xIP+2xFxCs=;
 b=fWuAq9QCnO3+YHeTIn0vVL2EIuJWnaXpys7CWwbkv3NEwayImk8M4qd7m/KbotwbRdBcla3Gr46EldjUFMOaUDwZ5pdUxagmyMifBh158MgEwtm0slIpocPDmn5LTxZB3kM7mSKc8dZzBWqdndFCbUsObrHOQytbq/irYt+2jmlnUznI/9EjhCwDAPGpL9wEVWu4B0//Wj8DoSYMfnt95qSX/1Amdy/g+s8v8H95Qucy0BwdmSwJqDia/YyA7S/F9Eyko58LzCX4LdPhPbil/P/0px+2sdNpyG/9170BbUAnZedHi/Ebe11tyqeir5ur4YWNFK4n5GW51vAWdRYzfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvI6CAVafa8dpbnbLK6RcfJzOLEvzPtg1xIP+2xFxCs=;
 b=aazFgsYkSZcpUK4s91vMujI6PJGswAOChisEeTlW8q5u033azYl1pxLqTMdaQ5Jc0GFxczyQ/FF7Y82S9w//tiP1r+apl04U3avrm/JfI79KHxYkXChNi5flslKTnqtczmIi39GPnIdxXyAUFf6kzTTfJ7cfsHC7GkNQOLDRaOftDU3+6HJwf/BiVpIGMZKBoZEBAKOMc7Z7/k2mBdsNbjkMeDybSy8cnbLsgNPPV0wWrsOBiy1Z5TPCXVmKHK+Lo71DJdH/0NLWMWMeEPeOW0ySFFAJojXWMnUcxSk3JfB0rDw/e2jd6S9r47icds/HJkmtj9x0qppBXJEynKwd5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:26:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 3/5] mptcp: redundant subflows retrans support
Date: Tue, 27 Sep 2022 23:27:02 +0800
Message-Id: <9093837dd67627e304f39b136615a162159934a5.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 8233b35d-a038-4a05-57e3-08daa09cae54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wHB6PZKTTHM3wVdR3NxW4uOkzLbZI3d/W9FGmr69+tmsOnaO6XtWk4BJYnymuWpyT+Aerq4kWAW/q15Vx86dw8JMaUq1OP40y0VCd1XBmcRGOTYYIr90Iq7Toh/ZZlKTyMI74IT19WccZ5NO/e6vX48jIxll3vhhhjSAMdSvxLunFCEL6RonGZhCkUECIUQFFjptT0HGsgvzsiRWfMMi8Dp8Yx8N232xiSN9qQqxERNPpPBkrm4bsmmOg8RZbbtx5DSR6Z3P2X6r3JEZ2ICTefYMPQWRzbLg7tPxoTc/n6ezxmvKgZU030hblwYklfSi1OnxRMrVlUZIastDZ7QyMbBvC44DqzBMMgwAPPljdUqdH4hEYWgrYes4Gy7ZVYDBl05PL60tiaAFgM5aSLXCrmtOy+2mFJIcHRpEXqkDUFUxpWpi7I+9/gIiFuhn+rsrCI5RPOkiBFbX8pFy6ntioEYmpVjtY/mFX6iezr9ej+OAGndAooIRu3FitrAHY4+g6dlKrK6rFeTrZFaJ+I6IgntFd9C3EmBZyaeke5d/JkKoL+kjZpZ5Hd6YM4Lm+bxyLO4Uw/gjMwmf9KiZd/epkOONO1vpXTVzH/m3zktKIZByzLA+IzZERMI+IYX2eZE9TBXHaHkJRdL/PySkPKKvG48b0SgUvL2odeudH+C69HuKNZIpuSyFIBw8b/0gYUsD73e+wLlzQpsmv0VFTuN8NVQhQx2fjippRcaMsF77Q2Rkxz+goqPlgT/iHHDGB1af
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(6486002)(6666004)(107886003)(6506007)(316002)(66946007)(66476007)(66556008)(83380400001)(4326008)(8676002)(86362001)(26005)(2906002)(6512007)(44832011)(478600001)(41300700001)(36756003)(186003)(6916009)(2616005)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xe7sZZ0Onk4ukglnFpWXOxusdvZcU2UmZ2MjB4uOK32htjnPHt0BvQs2hdW5?=
 =?us-ascii?Q?auj6B2iJW4fFRpG9ehMgHBtvvujtwSIFQiaelYZtioJamENc+sH3ey6JuHVf?=
 =?us-ascii?Q?ePIy1VawE2dcK2C0ukE01eW8LguqbrprNFPzVm3wcYDXO/ZUj6MH+sZOccZl?=
 =?us-ascii?Q?H3fWwtffZSwknJMy98sxCFTuZFpVcA8T1UmCcT9QMOQ+eqdF7xZ/iKa5k+/m?=
 =?us-ascii?Q?5Kdwbm2Ln4xHhivyn00LBQJEXtjEm7GAKtQiMbxwZD90ypWswBOVuZMjNAbu?=
 =?us-ascii?Q?8o3LrpebyP3YS0zgLz9+Vh1deqTIsMQLfDZyDExJLBw7usfIBGaJjKDrxpFq?=
 =?us-ascii?Q?ntLE2JE7p8C1ZHNRreIgoOKF+Rxq5FVjaF1K5B8boFGFEa7lHUaqrQBoCju7?=
 =?us-ascii?Q?iJp8aVHKjm8on9OzOezsSKCdkPVX4IMW8JTk1RFdKJJvOtc0KRVnljkjJtRV?=
 =?us-ascii?Q?nXiblmG+RvSYj022hL37MxIL9bd8CLZK8EqSXj1ukLQF4f56CyCxuLvkuK+T?=
 =?us-ascii?Q?2xylJ8/2TozgXrhlKHhHd+P6ss6/gcRYUN07mEbLtDHYGSgyio5w7+Z1JIBU?=
 =?us-ascii?Q?WKlNmbY+tvZUxCmc5VYZ+7LrjETLACJgG3sNYyULaQyTzkEZrYqqyq14Phlp?=
 =?us-ascii?Q?GRnrOoTZS6N8tpf80bXYTYEWiFNSC34IVvR3iqWcOCastdHp3rBb1yHDnB7/?=
 =?us-ascii?Q?Xa3aOeedc6kV/qkk1zz5i1jhj5QSjN63W0Fmf9svJx4tc3P7ibgtQErK76MM?=
 =?us-ascii?Q?EKNbUqoJL+E46zAMwj2qZh8EYJzfmjM0JoW/FoZOPmquYpHINga3ylcNPcTL?=
 =?us-ascii?Q?O4JGXvvTl785cjSZeljn6T54pm5M2PzDZjZkaNfSQuRC0JlCvZkF8UI79R4S?=
 =?us-ascii?Q?QhvCFoUHgmPstvWLh9oAzwR2iC6P3EnqnOovlgv2MO6QiA8ynoCa8VNOfCYs?=
 =?us-ascii?Q?uy0s/i+Abc56AEKzswJ1B+CHjbG4W1BZBvr+TnsdRqUrI9oh48ABIamzNq56?=
 =?us-ascii?Q?OvmL9zVF0zQD1pg0vpSqXMA9yQ8sTsPor2lGeq/LFuaWm4ubI87FgZ1ayRwb?=
 =?us-ascii?Q?QOMSyfZf2Z7AqvTIbQuPFjAYxnH/4Wzt+7MktB4QwsM0a4KJcKZvjG4mWspk?=
 =?us-ascii?Q?UstaeCsmtzcnh78GPEZjjKtUqq6V3+mFnfHzhqZ6uVdrsiHVUClJ+Zob4COr?=
 =?us-ascii?Q?I7EuXhyd/zY2J/1mJ7HmhmtRBKLCmFJ1WwxBOfjd8+G4bDVfLRXYL8YC9jTO?=
 =?us-ascii?Q?90k1sxvSt/mLfGNuUECdTdDMS6YI7tE6JtlwDZOPcPCUiKYZOwb3Lbev0Snb?=
 =?us-ascii?Q?ZHNhU+RdFiD6GgrqKNvV6vwqJUyBgCqlS7ILRPGQws+V+OSP1vG4eyqo2uXa?=
 =?us-ascii?Q?t/igOzwh5zFPD4tFH4koX6wFO6RHQ8ItCkUyfIJuzw5NIDSTTe1jrXJtkmuh?=
 =?us-ascii?Q?NhD+glmYghh2ddxmPa1vCzEVxhJ3vNet3QldzqiDWOSdPIOSv34G+9ld2oSN?=
 =?us-ascii?Q?BIBjKzISaR5IgqVIyr+9wC+C2X0ZT+iCF7m5aagelHkkMvAqfj+pVnebJZoZ?=
 =?us-ascii?Q?QAYIgt1BHZ8Upj87VS1M0YnYw19+ThNbiUdSc/Dj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8233b35d-a038-4a05-57e3-08daa09cae54
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:42.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EO+uZ69bOszBrfRAS+TuDAaoGc57x69pZXGoKNT+bTt9kvins9iWSFESV8sPsOrYj9yFssHsyniEd6I8r8D5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a85243be4d29..021123d3ebee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2493,16 +2493,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2521,31 +2522,46 @@ static void __mptcp_retrans(struct sock *sk)
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

