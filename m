Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60040.outbound.protection.outlook.com [40.107.6.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B47B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYDr/YQBh+RFfFKS+azc610n0aUsXD6MXI0N8c9BI3RL5t9GyxUm8WNxeHu7OTLQWuB6BXAkomPdIdLYROoDGwT2Kxo2oO1t6MMTiROFw07ol7t3nU+MaLu+bUBA4Pia1gEUyP69stP2YFlidpxFCKpPe1efwhgdCQR0K1LEuPi/VXeK/iZyipaw14QQfYIhKss6063BdbhQ5IWipw69ypTFXSuMthtz3J7Pqs18aEGfGo+Emiyr/BU9SKq630OaApZi7FkjMSyZAoEWdCh2xlMOg0YuPdqB/aqLyGbzcXT+5/PUrDL90lGS7t/DBSEYVG+Hbd/lPu4ARCojt94XuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/FArWlz71xqmit67L6LC5+GSyJj9Up5h9y+kOu+gyQ=;
 b=nXwtIQv/9RjB9TCDdugrdeYEArnKUYO9d2r2+4DttIc3FBcxHojlq162lieKrkfsEjtr2Yy6/+e7lJpWXWlJIzBFhu+0e0DlFSh8y88V/gUUXT6fnZH4ueJomZ+allQISwjyy3SpeIRJnfIaVi5AdmtG/pBUAJNXnr769fpHeQdv232E45I3ZnmjHx7urYWcaPJO0FDNvxdCf+M5usKJD8XJvqNPoqfflJ1mHzO0H+Z1+V/OP3sIEWM/g4PvZhtxNU4sA771CGS+BQ1uJKrtkVCXa2H53j4U5HKr5ABXv2nZMVfNrwCRySavFt7EQ8B2nnLPDduq7gifmziuUsPq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/FArWlz71xqmit67L6LC5+GSyJj9Up5h9y+kOu+gyQ=;
 b=ah0Or3S5OPbj8Ikcald1ciVuoV29SPn+tk6gp5zLF3ZG1bnE+FFcsqpWGWiHevmpm1n1JJ4Yuwo+Tw7aLLKmOj6IIvvAdmVzvK4VsPS74gXD8nxfItyzSK3w/wP/QordpXYte3pJ/HqITRx0YYrrgKMTZp0X/kQ5NoG7KBgPT3jSpUAObLFyIKPuqfJSHkhagZOyCBUt3kLTqcIYi1HgUfmUbgWJUOuJlkpwpfXF648ss93OrNWE4mVxZPqwqEpsxgIAnCCvTNPkImBKvpZJi7vzSvEPkc0jfR+yGtTwYCOoVJ3+Yz5EVJT10CXiVGTgIrHlgMat4A7Cy9wx6hd+FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 11:03:05 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:03:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 15/19] mptcp: use get_retrans wrapper in mptcp_retrans
Date: Fri, 21 Oct 2022 19:00:07 +0800
Message-Id: <9add136b66cb44341e6c125ce518cc5df1262ecd.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::6) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c65536-3ed0-4ba3-4619-08dab353d43c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OtgcnixqhadNkJQNJuDldI0rahxMM2YtBZn2qjpvS4zFuXFxuWqFTzrdZ1zd7MYJAqyY+gH0fq7sUuG6XFrqRVUs8oCOwVKyauUVIvmPOpV75YvNF+DGyn83bavM1XWefMqdATOZiCCpI5B+vTRPjM/mDF3CKZFVjb+zGvJ2QmFy3E5Uf66P39EnMI8rDT/eCMLV+q6phbe/rRRvLuHh/G6wOUeDFD0vyDpD5Ekm+Jn52rdkNcAeGJrgJvypRx+GFeGbUkovwxnU/rLfY4j3sYWf3IySKB6qCNF1OFSz9ZgJOLe00htxuP35iiePhQJ7xJBMmeFeYwXGOGqtExmn4o5fAjZ7GCER1xxmP/ieN7pywQ+A0jMkalvMGNdQIpH030d2s9xRnFL9hws0+oHZUkbTV0vlfX1Aac+o7Nq7vWAf6P8SSIfmJH0I0eM9sUFdGFVcCGbYGXQwUxe2Pk4efpms/L27Hk26HKWXetQrqEF4VLSGST8ixw/swmW0FsPhbJFeSejwai9ttetimJocLvUHORcyzMTfs9gmOD/ThtTY5Wo0O6aO7mBwjpX8k1n21zdKtU9F5l34hSTg/1L811IdeMUSKNadU9CSAyvdvks59PZ5omifeSi3hAZCLvHy+lBf0Twg5UIkvklhywUswnxPl9/MpGsG8IkXEU3ZN7iZ4GxF+b16/gdNZtrixHzIPIVJK84KAjj3jarM9FphNruLYAjKat/meX8Sx1dGw8ENIKzL4hemkzmKEZCFi7A9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(478600001)(41300700001)(66556008)(66476007)(36756003)(66946007)(44832011)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(83380400001)(26005)(6512007)(38100700002)(86362001)(6506007)(107886003)(186003)(2616005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xsKO7flgz8ZhvNK9NfrG9vUfVh3JC0IRwrmlsmtxWDWX+wp1keV/99dpk0yd?=
 =?us-ascii?Q?WmIh7nKK9uNtP4oPmXlSuz99Xapkxl5GIZ7yj1y80Ap1arW7P4x1KwQf+vo6?=
 =?us-ascii?Q?/E/uP55IDVZRxb2Y7WoM5dHjW4HKTcfM6qlHLuzLauAJUsKhFMvDGwi42r3e?=
 =?us-ascii?Q?lGWORvTpu9RX75QAtTU3e4ievrGl15xPWwoVFsKU9+efzH/K78xqjUvZRvO5?=
 =?us-ascii?Q?OkIsYuFMWu8nKmvl/LLP70RCYYQ/GKXOBrB6YaClBBWvioV9lVyikbEcRON3?=
 =?us-ascii?Q?6OHRwYc4ZmGYCJbv5i7KEErWGchmkZYc73xihtqH2YH8c9zW8Px2w0y+mhIS?=
 =?us-ascii?Q?dslPgPYbrkqNTBr1p9oCBnYnlq/ra4LznuEerOSrzz3ikTrDnMzFJsfB5iLM?=
 =?us-ascii?Q?OxH5cjp2dSvbqsN8N1qH2lXHeH2/mMhtO5c97V0C28K2BJRs8ssTsPIt+XF1?=
 =?us-ascii?Q?3LOrWo8EjSh2b9aaVp0nWzm66/YCRhQOmyu2bGgTb0xMcgAcAziZbcMi5QXV?=
 =?us-ascii?Q?L8wxtpJtRp1oW0bV/neg0VpsHUcz7jtJAp2w+ADniT9JyCdoskPfQA8kSHf0?=
 =?us-ascii?Q?rzkaBhVzIMHjjQuUhTCn0TVFod1dJGRA/8mBB5yH0Uz9Na+pPIgMWRBZG1NR?=
 =?us-ascii?Q?vBDb2dmjQIA6Teg5zDKAcFutuVBcQQ4QjHeGu9sckYk81E7/4jXCjA1slEUH?=
 =?us-ascii?Q?pCD9h24cBKjUTjgz7QufzzsT05AUp+jklhLeaNPjckvBlxID5ERNi6xrSkTA?=
 =?us-ascii?Q?4ztzZMjDRtU/8J9kPkKb6yIHW0AitEQC+QcfG2d9wMXqx7af1mpg/j4dQ0Jj?=
 =?us-ascii?Q?21oPeW/OVRzkeedRKRZtTuv907FF37Sk3OrzORI8cely+/V8C3Ep2SM1mr65?=
 =?us-ascii?Q?ar5e+wyvVvNfV7QNSnYMGhhcCDWn2IIDAcn+Zdqb2bSq61075nuugoYirwjG?=
 =?us-ascii?Q?cr729LTSRnGdGAHCljIoNZ1bCGADfeUTCLUAoskV9BEZqxxRmVpmDJMvLfTF?=
 =?us-ascii?Q?alZe1aCS2cLhnnpv1alXsm9dHUujnmO5PfzBDqWqsQM3gfckgUqV7DVLxEC6?=
 =?us-ascii?Q?F8KW4+GWxGkv0nxvfO96w37+0ecv4PoOsc2/2LohGwl5CiWhfSWk8N0KdVjX?=
 =?us-ascii?Q?N00ORpc7ZEZXctXupvbQGY0wFnCA/gNHR/zd4AWhtXXK+oh4UxN/5DHseZpo?=
 =?us-ascii?Q?zONmLRO2V5MxAlJe0zoqAYc/5/ueK6PTidShuxLKom9OIBUlGOpkH9EUhsE0?=
 =?us-ascii?Q?nnanWdCIjO476+sCVhcvzyPk1zN68o4vDCWWYF/Sc85X1itiTKl5WV4xBKVK?=
 =?us-ascii?Q?A7rg5n97z1onjS1v2CuSkulz9ntSUf8WPbaKBpAB4cscBLJ4ur9k1SkekKbY?=
 =?us-ascii?Q?4cohAvWSNygPb/DeGycn+aSnU3JkLFtVwVmfCOAd3gG2WV9XgR/qlVhUrhSB?=
 =?us-ascii?Q?koC3D3D27x1Qey+i9SDJrlJ9nLpI3cr84fsxt0anDBFoK84r/3jBPI2jQdZL?=
 =?us-ascii?Q?E170ql53l+SCgJ6KBQvyXq8r7j6VZj4M6T21211Eok+3dyrvk2RbHytTUEQp?=
 =?us-ascii?Q?rvIkfyUF1EMT08YPuKgQBbrgn2wMlM+KGNGPjjnz8LKE6AFzUTc6oLPATlWf?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c65536-3ed0-4ba3-4619-08dab353d43c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:03:05.3848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Z5YetORBd41KJBgAm149gt/ku0Y6gfELZ5vRURPiaGKOxCAiUlr94MsxuX7stnaXdKp8j/hQa2Cnv1mJICD2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 62 ++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0dfe78c0856f..3e8e06448261 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2545,16 +2545,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2573,31 +2574,46 @@ static void __mptcp_retrans(struct sock *sk)
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
+			msk->sched->last_snd = ssk;
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

