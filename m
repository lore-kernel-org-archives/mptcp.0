Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20085.outbound.protection.outlook.com [40.107.2.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E9E7C
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 07:54:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5bpK/UWed9/Ls82UcYPq9YA0wMgnd9UtBMS3AFuVtAFDYL8Z3vGNp1xO9dRNQSABgBE2ogWT6weGtkQzJZLy0K3LWWPjf+R5OGSY5FwRH/JBA1f8AT3Ye3h3lBmJj/Rpeulql01EzCP6WFnhMcm6OtRtbIYE1U1Bw1Sf8/V1PXcFOJOlsxVSijGZDezX0TRRoU4qIN0SBHC8guYGjFw/ola2VRY4GYMoPv+DATrsGXDMnBHXv5ssQnbKCvSeU/ildmAQq9HDH81Vc6NgI2+E1GOA6Ihm9DHhgDk3gzX70dtpu/bPjI5s7mCiZVvMDp4yLpztQ610mCgaxXRbFLBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFUbHqO/Q2muHDkCPU22oE3haLhsaa4ZTbm068AZBxI=;
 b=c2vG82SzOObdsjTiLfAVri4O1/qJKS4h1JqaF0Wet99Gy8pyC4o5FwRsaepTJDfA70yr/QyU6kDnkaNnG9q8Koh1c0komf59TufcFc58RwNAGjJJ4+Q6bsga5aq+XUa4CPgcc3uN72wiJtBUw6ru3fwG1XEcbFNBUUCa96wk9pC0jdEMhrUOtpTOuXxYY1c84jtjW15CGGAoHK9/+WZZFUchlmLQC2l8mEzzkuPhxhiyJC2CFZHy4+pXvyVBp1oMB5SBGpN+skp8I9ISRewIBLYxSCeHAs1FxlRib71ToWkEdN0K4jUWmJlZVtyVjY1Cwq1+h6pGgEn0R3ZbbHOBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFUbHqO/Q2muHDkCPU22oE3haLhsaa4ZTbm068AZBxI=;
 b=Cb3udiqcrfSt68hIrLdPkQlZ91903NHS3MOdvWhzehjeNca/9xhRrC2NrHBG87Q2V/Osj9hCluxyE7b5Ck/VcVDeyklHWdqhgVGvb/Bj3m+TgZf073Kmtlrk9VGrtQsTlWRRpuloJBofupoJHSa5q04PcytDOy5MfYuJ2vd4GLQ2+fcC0He3tcZ0tNLWl7OCahVJZR3wCXKmmjkKgDyFOZPL55vFNnhahLPp6qJsuns47TaG4QPZOMiU7+wdivf048r26bnNCGGzfcQzWens1sd3NpXaTfBK1nJ/qxgAstt9JGss/1as+/DSNPMBOJoGDJlJS8BznrArZsn4nz7cWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sat, 22 Oct
 2022 07:54:26 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Sat, 22 Oct 2022
 07:54:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: delay updating already_sent"
Date: Sat, 22 Oct 2022 15:54:12 +0800
Message-Id: <20221022075412.471-2-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221022075412.471-1-geliang.tang@suse.com>
References: <20221022075412.471-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PAXPR04MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 5670010a-008d-4539-c016-08dab402a41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZZzM3AXNaJ1YtgnREvKkwUHu5shLYiawo1FMgEGZYGyO2g4KPThXCfoxkkBVX8/vaXwbOHqfT0pnWhl1zAkieIQgdIgyTy/UBom68j0T7R+uj8VeNp54OaXAPTQnk8tOe34+xdJHo3bElDWkfArLyJorTzZUGo84ABV0vibaKF2j10IqzcvGJZzQ06+tp+8pZN9dMgBLIC9eFA8M/dFdBlxmc5KZWB4P3REodEJCSWvFvg4949G0/DkL7FKp1TJBzmn/QKsPXfMVEM3hNcttnX9aKjSUcM/o1K+LNPCHCksuMMips4aY0KaMijnzUKoGvTNtZrdBxJKfzEUVEN6FYCeRYa3ZbduaR5cWaN2dmvnfgMgbG7G41KtuFgbkt57eWgdcG+tKZ58ypr7PnYTQwSXDmcK/ld259vznBQ5cmmqH2HakNrzrCkmtdKjcZhgveGJYU95e0EwhOV59NRKPOz80M+Ax62mWVhJZL5Kp7qF4Zg6NMas0DGGJq9BIZHkiBZ3YwVC2vnLI+qXDzDlVlWOCtfS66VFKj0gYGxsahgCQGnp82KI9jzjza25Z+ub/n3cb0ftbG1wnonevO2uxIn+wWsW3m0BQkZ1sktCgDiHnHDDlvcoyHk09BH9ImhffQVaLg/pkUlpqALIEI2nGAw6QTTx7Z4GUXEQYTCiHxYhgX0udm72f0jvSP5Q5XUEexoGzPpSAEDgYTlFnLQSNRLAcLOBI60e88K5j09vDz/KAJPSr+O+04zgj+KHlUQhK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(6916009)(4744005)(316002)(6506007)(66476007)(36756003)(41300700001)(4326008)(66946007)(107886003)(44832011)(6666004)(8936002)(5660300002)(38100700002)(2906002)(2616005)(186003)(1076003)(8676002)(66556008)(86362001)(83380400001)(26005)(478600001)(6512007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JjFq67GuGiCTY7ey0zUp+THXroBHyT04vB6UuCzA4kfRQQDfW9mJ6+FcPRzy?=
 =?us-ascii?Q?fUbxzLHGoarHGgTt/Wj8oGfdNSpQlKqztxZjohMUJ6iLG5/LyiDBLKHBJlQ3?=
 =?us-ascii?Q?ufa60+4I/pRBYajv0CEUCckzLcPvnIjqOf8/uERpYz0xUw7sOn8NziNbx04U?=
 =?us-ascii?Q?nZtV4/oRS7pffcVL5js42NpMWiLh9qGle2JO5CtuqSxzGX1GI04Eo390nNeT?=
 =?us-ascii?Q?GikbLeFt4bVgoh0EUfs3SLVoI0CtuZogdmwp6PSuVPM1o+n+xGcrzCfiSeMg?=
 =?us-ascii?Q?JPS0iGIkNFqGeO6lAw4tk5hOCrJ8GQsH7orwvlg/G2o/w9gk8s8HYNvf70yQ?=
 =?us-ascii?Q?vr88OqrHhm+kx5HtBSsFRgtn45jzlG6cKWnlDMz/Z8LX4bInhqp/hZpiEeJc?=
 =?us-ascii?Q?cLFSuqh7WyS+n26rzC+sbIi7FYoJ/64uBDuS4wxPj5AWKpsFqN7M7J5h5w5X?=
 =?us-ascii?Q?MKw5pjXeUtWndHBFZHwPj5kS8wtYnuYjO6I5bJwTNT7xyKGQrc77seKnuSzX?=
 =?us-ascii?Q?xMfLOR5Q3I2+R2Y+R2E+7wSe6P7fYO/4Jp5Ic823KUg27Zfz2tV5LJJzyHdS?=
 =?us-ascii?Q?BeO+Kw3BwB3ut3T27Lz7NPpCBiSGQA8Sj9dWg3r4lwq1GwytvAYPxkFnjkDb?=
 =?us-ascii?Q?mfaiEvbRZ2ziOGIzlHWA9ykRnymckRQzJUKsT5PqI+/CGeWg0M7eTL9w1DDM?=
 =?us-ascii?Q?p+93MKNWyLYn4m4sN1YH+s8HRHEYIgu7bMpLCmkF55LjcC52ViN7MM9FMw+h?=
 =?us-ascii?Q?Bj0hO0gfEfLP2+yqCni2bDyBuOAS6o95oP2dM6X5i0xDIsqkmP05zB/DVLGU?=
 =?us-ascii?Q?ctwedZYPVkwEbqzxwwuvGIY7ZHfie7/8XlqJIRBSQhyEHBHLltxKPy0wbbwx?=
 =?us-ascii?Q?LisCTN1Mp6noP7CB3HFg+h9yE3emT6OSerMjaJSTLS0JPFOCfR832ClgSYxP?=
 =?us-ascii?Q?JIN3zwIHrn40bWXtYI4p4oHLKLmL6YdLYH14okxD21F/xXmVKaK3Mf9BE1RF?=
 =?us-ascii?Q?ytf+BEzjBx+j5SXTVbfbJ6qdlf6uq26nDkZpZSyjB3bGCtPGTjdAsMZKdT2O?=
 =?us-ascii?Q?OFycP1WGcdvTQE5Cqzi9TWY5da/hUZ6Getz7+EIp8Y2wcMp7t/Iyw0nA4iiv?=
 =?us-ascii?Q?Y/tPhuAijgVbK9J/c+J4v6MKte5WUJ5v7hTYTuxsaJVcFDt4fE/ba6B2J+Oo?=
 =?us-ascii?Q?ImtKg3zNTufUBRwCeOkrSQ/doTdubZCkGNYZiYrRqbCI+4Ze41Iq/A8DMn+r?=
 =?us-ascii?Q?rhgwvys6ToVGQNuVaVVJWs7ylvYtcpDPy49kJ/IW7nPPxlZ0UesigHY408ty?=
 =?us-ascii?Q?xN5yd5Z/IHa8FigxuL9GrBclrwJv9KMo0fvHajdnKKID6uv6h9i5k2r2SgZ+?=
 =?us-ascii?Q?YtdC74zbiisVN/24FLx3/ZMuuelLr29+vS7L3Cn6hGgkQr9Da7/hKNG9Tvhf?=
 =?us-ascii?Q?+duO8zfcBTdIijxeQRWTtCIVfoeNell9wxc3cRGjth3mFhmmcPuQZ3Y+UKbV?=
 =?us-ascii?Q?Q2G0qABK23pC+UqkfUH2bz3ntjrCSxD6IIwRCwZJCtooQNxFkS0l9M6V6YoA?=
 =?us-ascii?Q?MBL0UFf8zaP2Pc3zjDCIyQpawJF3T7Pv56bl9gvZyPmi8N/Du6dlP31ITFeH?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5670010a-008d-4539-c016-08dab402a41e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 07:54:26.4321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lNOEDba6hmtaX7qIO9VKIIQh/g5KyjxPXpJ4RnnMsE/NCkqnraNeXKKGNwbNpok0t6a+3qDQeH+WhReZT3W+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9423

No need to update info->limit, drop it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 958c7fd6da2b..a21bf43472f6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1244,8 +1244,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
 		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
 
-	if (info->sent > info->limit ||
-	    info->limit > dfrag->data_len)
+	if (WARN_ON_ONCE(info->sent > info->limit ||
+			 info->limit > dfrag->data_len))
 		return 0;
 
 	if (unlikely(!__tcp_can_send(ssk)))
@@ -1573,7 +1573,6 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 			}
 
 			info->sent += ret;
-			info->limit -= ret;
 			copied += ret;
 			len -= ret;
 
-- 
2.35.3

