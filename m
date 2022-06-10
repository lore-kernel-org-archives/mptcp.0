Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D817A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmEV9lU2586T3Pu59b2pjmhb0WPeUXpTJWuTCsIrJ3d/G8R0ZmDXyfzXH2MlCYEt/jQQH9wRQdO2Jm65G1/K6mbTLaR0nPrCUiAPBjPM4+rIZXkItabmsMigLvg/nCjltJkCftIe2OoYURx1w9yTuuIEKnuymFdA3e6A1OyQsYIEl+0zfK3O4hipiKV+0af+xLmuixo7Y19mEUjBmstG4w9wMBWhFv+m5CyQ3mpKAV9k5VzDp850lm8Fg4BWEvMnrnSf3J69Fdd6IZi82mPNkhIyU6djIu7IHDDptqRSjYg+A1BfWVpAIBrOYMeIiY6Ut4Ue28HCAR40rY2gQAxXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmfye/CJQFLFHzRYvTxcqvA/UX8WP5N8nxfO7DwCy4A=;
 b=Xe90dIbfxYTA9xqPfd3KbpnwwkTkCm30hz4b+QXeCwkAw38oom9yG53LaAPwLNd9vVXEgsB4xiXmNw1cQ4yqhH7tuRUqU3b0+WIT7qc8fvCCuGSFakqJi24ou9BzOagqt4e0Ly3l8xWD+l/SoCMpUUrlx6XN6wOnlc4gg+tK2h30XBouEy3DQMbl7oxXqWVYMN36nFGYF7BnNMmAyGuWAAGNA4ghIZqxL4EDnk6VB/smv7GKRYhTNH2RLyqQIJxu6AsUOFqtd4ArFuc83gLDUdod7QCc5WIO7ltTxx8Rki7N9Oo+zD1xVX9Cz6LuoS0elSvHyqcEwWooXEr3vyRUcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmfye/CJQFLFHzRYvTxcqvA/UX8WP5N8nxfO7DwCy4A=;
 b=2xzwPxo2H3YtruskEkossYMKcMyqMpF6ULW1+3/5W8I4LczihnEzRbUJSjHfVSxYkStZPnmJ4AbMK6uoG2ouoOdpHENKsVC2sXiyG5x1iXrrgVBK4/+v+XacYVSuzRVNLV3qLskGMZaWSRHoVleCJkfau9fT9dOnprOPWYJmD4tdjyr/SeYVe2MLhNAzCDr6mMVrg2ZepnvDGJLHFpXsN5sfY1ZzAEuwF8z6Ouy1o6lNd6Z9gOpSBc33Mu3DxBpXzh1x78jUfmj+wPZ1eaxUfY8f8RtJChY5wUz97x6rSUVsr/gZIL3wIRugZsBmHxkx4VccD5QLnh7ZvvStKo1pjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 5/9] mptcp: redundant subflows retrans support
Date: Fri, 10 Jun 2022 21:05:30 +0800
Message-Id: <6dbc73c8c56b540167488f9fd3f58e6417ab5620.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95de72a9-257d-4394-a384-08da4ae20250
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB272504741E454AD33609D427F8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TXiWELaeFy+cjjns2DGvzmHLvu2ViLtEcuoMzUUd21Ss3U5/bZ3Lw6e0Mm/cgrIZv4uQ6QE9QrG94MUm0U7+FsJlzgU4mwyh4ny8JuuednH+OVEv7ZaJs7llZm4uJvKN2DWp5kVByDLAz/mFLC1Q9WQmSQQUGVScyU/UlQc0yEgtVBD6Om88JXwbuwe1AreNcPx0v5aWoOgOwmij4YAojQd0xUYhEPJmDKm2hEDFOf8g0zqvYBlTSIjQexug5SFLkbrBXmLEfwRn9NEHExCYSTWRe7qLV0MMddaEzxbht6AviLPJ//5uwH5wdWW2mLibwlh72lMfnXO2qM6Qfd4n+dWqOtgDnawZlqZAhAYHYZjl7ME29gvAnyfIjruDXtZDyzHI3Eho/ac3MPoeyCyIyFAvmzLxjBU2tlAJWxUUOUdcg7bHsDPOE1ri4Kr2f545uaISesQGNcMkw4EP0SkSH/kq/afDoWhKYQvWXm46AK4neMLSUN9rZhXUs1HbkMu0LsD+EitC0+OTNI7LnzpVKmG92AHMIPxd6AzwsX6bzII3F+c4nwfFlXDge2VhLADPMnnHooqebmujTs5+cBMe9+lzSPM3/YSYDyHe0kyeAiZOLY977VX7hYp26De/vEXQ+UCrTmPe04ZjhZ05PdgTcgdkSXI9f+rz24h6zd5kbs6LIC/zX6Fvf/6zvJIiMnxhRc6HAV+PSb9liy3sfx1IsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(44832011)(86362001)(6486002)(508600001)(6506007)(83380400001)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRky8Tx6HIb7kehakRLlfzDtJiEeJC8bRe5cV8mEbysHCYwmWYYFgEUfr+ns?=
 =?us-ascii?Q?MDAQ/enbbD6uu+hvE6EMtkP7a4SyQQt6RTmuZBIDbiSbEuMG54GmN6od9seS?=
 =?us-ascii?Q?chjA7Q7CC0bv2mFs/6s/LkRxRZzBlH/ptYjITwzziQhtX+H8eS6Lqu+zSFKd?=
 =?us-ascii?Q?3qS3b9j0+HE/lTTqqK+dL1e3++qUcCb28wlkhnPjQh7MJUKnubKGHfnJdS2d?=
 =?us-ascii?Q?BTMPFFTzVSO4xwaOP237mTvXVTIjDHu/S9XpyTxVT/lwYje7D+PDLbDFY7st?=
 =?us-ascii?Q?TIy/+8DhPPkEaFb6LJ6nOP0hI6lOYJ/BAEyHSOmAhPtrwVpj4luCJyL2kgma?=
 =?us-ascii?Q?acjw/+ogplYKTb2ZfTzHdsQUvoyOQ/gAc9JZov8U8P+iIWUXzqFceYCHsYVo?=
 =?us-ascii?Q?8CJeC0If/PapKDWyficvsuvNnHK3YllaAF1Z9zW6Ys1gzu/aahIlsZOk1rRC?=
 =?us-ascii?Q?Vq5z5tDkuRNYszv7PqaCEqDF2LTiem9Obt7BgaWLeWEZ5+Y9G5vqvEaSi0Yn?=
 =?us-ascii?Q?Kkj1XIbtTGBlBoYMmFZ1TlIUbtf41jJGG0wX4jlAEo6H52LRG1FAHc9TUO1q?=
 =?us-ascii?Q?gP4xAMpZIsxbOiev3r9nJLOz6d/0rFfZZj/TJf/YJ3bm17uFKPgEJ8IHsR/R?=
 =?us-ascii?Q?DfbSAGOwV37i5CzoOmmzYrIHnF6X3agrOvTbgR1pc0XTaIWqHTfaOb+SAjPM?=
 =?us-ascii?Q?IfgRppRWMWGanurcCyPWYRaCBCats4GwYiIWNFPibhBt4SYGXZOSmIE/SP84?=
 =?us-ascii?Q?00HKGDQbYRL3wAiV5lgDBKyy8aFpKGZzGr4OWr0nOjnpZT8ELcPlnEyUvcUz?=
 =?us-ascii?Q?C/IFeb8nrdOeEpQlXTXkx8kAwSfcs0PUl+wYYyAVzwZRqwaHfqQ8MAI6Cbm8?=
 =?us-ascii?Q?SklCYSlLXFjp8ZT307yCpbQ2OoH+RtY8Gro5l2tIHSnn50bzPiFuU4IRBpRZ?=
 =?us-ascii?Q?7oBJWIOwsnQchAz9g8twIoOWGGqMOzcNDTW97raP3Idg+BS+6KVtg7azp41y?=
 =?us-ascii?Q?biD65byoo4eOmaP+cRaiEn7Rs7aX5lD08heIihJp8iW2O4yDVzxzRM36Yvyo?=
 =?us-ascii?Q?hSUEpfWBb2Qnq6EQ6Gp1G9q0MApDnd6JgZPwjkrbL6c3gBzIoJJbGkT6zd35?=
 =?us-ascii?Q?5kRdjDSlwMQaufbBsqtdu1QgTzGa77nT2w1gno+RO4Ip+aBYIu1iIlgqiaNW?=
 =?us-ascii?Q?92Tzv/LfU3NebdF6+rez1Oz7GqNHEMTtQXENiPA3c5VGHXxA2IkF8gXvd8HC?=
 =?us-ascii?Q?+Oge+s/h+ioOOtcTh+d0zb6qyMNqkfl4gt3qPHGzJgwyQOK9uTBc5UFsaG0L?=
 =?us-ascii?Q?IWR8ijZlS+2wP2+W7Ty3EqkfJNi9z5/T9MnVhSpO9PsDp3sYjludOQUHSFS+?=
 =?us-ascii?Q?34drQth9+osNpE3HoQa6i00gSMPwx5Ks0NEr2Gahl2uFHB6ZZIqlgze4F3tj?=
 =?us-ascii?Q?M6Yj3qXH+uA7imAuoaOUEg9yKInchqI4CQkOyS6Te+gzb/CiSav+IvXWGXKT?=
 =?us-ascii?Q?3TJ9Zf+R8X7b2RvlRqtdPBpqy094yYEBHpQzvwSFlY8OrP0ucBEzCtE+eY61?=
 =?us-ascii?Q?TAVJeO70Xk4pNPmfc9QpPx66yWABhQR6LBNhD3J3vbJqQD7VsDp3H8y9Y55X?=
 =?us-ascii?Q?c0zVaW6XZ+hSc9Z9OFWyqMAD9zlQS5fbN6eJcor3Fyawle9Z/1am3lrgJHgw?=
 =?us-ascii?Q?mJZBBMq7SD9OoUrEWQTO32SwG55UrdBMiiJTKYOtYA09kRyjPuakA9gv4U+D?=
 =?us-ascii?Q?X6tL/+KQlVs1h58P5HsGSPM1UUpwZOo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95de72a9-257d-4394-a384-08da4ae20250
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:19.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQR2E/xeQk9wSQiIq56fpdBZEwOh5rwHndp0L+I+xN5We0jEZ7EB8VSy9jJpNBRt4Fnzkurgiws6Zn0/ND2kQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

This patch adds the redundant subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 49 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3bb3445c1eaf..14d3637d1e88 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2490,16 +2490,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 static void __mptcp_retrans(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	size_t copied = 0;
 	struct sock *ssk;
-	int ret;
 
 	mptcp_clean_una_wakeup(sk);
 
-	/* first check ssk: need to kick "stale" logic */
-	ssk = mptcp_subflow_get_retrans(msk);
 	dfrag = mptcp_rtx_head(sk);
 	if (!dfrag) {
 		if (mptcp_data_fin_enabled(msk)) {
@@ -2518,32 +2516,49 @@ static void __mptcp_retrans(struct sock *sk)
 		goto reset_timer;
 	}
 
-	if (!ssk)
-		goto reset_timer;
-
-	lock_sock(ssk);
-
 	/* limit retransmission to the bytes already sent on some subflows */
 	info.sent = 0;
 	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len : dfrag->already_sent;
 	while (info.sent < info.limit) {
-		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-		if (ret <= 0)
-			break;
+		int ret = 0, max = 0, err;
+
+		err = mptcp_sched_get_retrans(msk);
+		if (err)
+			goto reset_timer;
+
+		mptcp_for_each_subflow(msk, subflow) {
+			if (READ_ONCE(subflow->scheduled)) {
+				ssk = mptcp_subflow_tcp_sock(subflow);
+				if (!ssk)
+					goto reset_timer;
 
+				lock_sock(ssk);
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0)
+					break;
+
+				if (ret > max)
+					max = ret;
+
+				tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
+					 info.size_goal);
+
+				release_sock(ssk);
+
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
+		}
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RETRANSSEGS);
-		copied += ret;
-		info.sent += ret;
+		copied += max;
+		info.sent += max;
 	}
 	if (copied) {
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
 	}
 
-	release_sock(ssk);
-
 reset_timer:
 	mptcp_check_and_set_pending(sk);
 
-- 
2.35.3

