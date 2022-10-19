Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20073.outbound.protection.outlook.com [40.107.2.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6F2F47
	for <mptcp@lists.linux.dev>; Wed, 19 Oct 2022 13:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azmqajEthFcMB1JixtRyCesnXg8oVPE+7CP385TsfGcVIDbRPo7/AZymnspyAG0cTkr0qFEP1iVVXkeg9VAOylW/Ojfkdkd9PaHL/tdOMMvzX2cq6UoPXuW9RCiYPy48Zdp2RRScX17m5rtWp4I5qF5BEsiune7pm2lBNDlI+OMDBYdoCTtFeQ+PQPE9Kss/y/Cqsy0/NDFEZdZf9lsB5GJlVS9FSD+OYHqAmowlqEFZ/aOBVU2VujuxqoFHK6oWmO0+Ir3HS1Cb0rT0Aw7xrscJJx1AeJOEifWEeVD7k1LNAelRexeiuwrVO8FXDq/WcvIo6SH2LFuLw+aNGG9cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJRlzZnmLsIvLtv5Wy7MR6eh6z/SYPVfKcxNWF4uDAw=;
 b=QPar1X+WCXqu6PzpRxi7aByk5iUkL5DuaJ51mqICacpoGaGlvYV7j/SUXvWa4BJcKu4vtBo+Ll1MyYLqUQKsXKQvi/JX/Jy89LQoDLZdOgddUFK51XYfNvyADVuqUr6gVjYqe3xwU87ut9z/tIWMHh6AkthLNq0gq+97X1zGk+r1Og4XsEyfJp/rrHvcuYyE8Mnd+uOmVRMcDbkp7VTWcD8/0bLDNiczTaDjSC3EAqN+GLj7fcJtT2gFXivvisPZyKO3AM7LMbVtG8smBkgDn9Wc0ZEcci6ZCh4t9AbFrzpK5WhOVX5AnFeLOhQIwiZdd2CQ1hUxwEqOCG8k2SEmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJRlzZnmLsIvLtv5Wy7MR6eh6z/SYPVfKcxNWF4uDAw=;
 b=cBV6/r9v3zzvcLsBUZ6GU++5d7xCThJq4vvpRobxaGlZrnWQsVWVWtEIzkSxSXwjtk4/gxZWNhaKH/joOhCU1/exn8/MVn32q44dTLSznII457+g5nhBWotiw/D3iyyrH/72zBt2DhgzGC9WVDElv7zHvJyA8/4vi6cEauSG0OM5vGlgiGpCYPOxpZ/rwF0+6qi80K1yfGOUYGsZqRLg9owLG/N/w+ucQTZQ/U03zp0WCeHwLQFbpPzECLNn8NW3oGud6aRKcihO71SkLISaz42YJEewyKL5vgJuW82McC3eym2hACWxmhGaqIwr1phSRiv643J1rMEuuk4E5dzQQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7251.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 13:36:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Wed, 19 Oct 2022
 13:36:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 3/7] mptcp: use get_retrans wrapper
Date: Wed, 19 Oct 2022 21:36:01 +0800
Message-Id: <877611411d7973c2b7bebe36ccc2b9c23e7c32fc.1666185947.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666185947.git.geliang.tang@suse.com>
References: <cover.1666185947.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: c03be5c6-2875-4d82-8a2b-08dab1d6f3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0frJUso1PTQcKPTtbejMXOlOxR+GiMapZPcbS6J4FRQ/7jyH91XGtSDZglP9MT2c23pUdSiHDvhiJyQIYOzDmJVJoVt56jmAF0K8jWVwhI54xjTr8Gp2qq+mduNfFU58Thxz6Mtv5ORHiHmQWBn5rxKibihdPYc9LU9WJkLV8H1aseKvVehZ0zJViZeB4cBqSfot1GXalutuGjZM0NGcLCbG+9T2BaV1rLRIFlrdhRhm3djuwEAc9liibsF3gXcwaKzJttQkDpNNpkdakpFt06Tct/N9YRiPTCaxSa9qlKTEBoDdKp8i3fYG/W70T+K2yhpP+r22bwetSQHiw85cJxef3z5R5gtXaZ3i1l5hpI0wqqrsaAPC7bVgrfYNP+z3l+36Np4nGW3HLloXDEHOQ8sua6zEQYWG6Fpvd//TgCmlfOexolhedLVwn0vUmOQcGMC4+7tiUO6BWWDP/pjl5i/fIEaZNn8ENhpyHFWHXY98Z2gUATLmcgUDvnFEXREIo8YKSF1RG1JxAdJQIwKaGLCjRES9KcFvBB7vkSHJ7xsiMSzfhqMJLDr1xPllgPJrPLVJ6USbEJ4V5+Qzp91E/9cwNMjrXItiEDOIgqOqlt7mBrJV+nNBFic/hDnZxH/Fqkb306i6fjxNlSSPNHPLbB4bBlHseB/bV6LCFvphSjTNpWmdr9IsDLY1WZIabU5hNCY8EE5eMx1Fs4q9Hc3OyOBN/uuvXGXtMrwbDcDKnq0vUPJ7xa+JPdbKD92Qzj1g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199015)(86362001)(36756003)(38100700002)(2906002)(83380400001)(5660300002)(44832011)(6506007)(26005)(107886003)(6666004)(6512007)(2616005)(186003)(6486002)(316002)(478600001)(6916009)(66476007)(66946007)(66556008)(8676002)(4326008)(41300700001)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNBuRnSxWgWIVbIRxTQ9aDSPxJSt6WZ8HkS608WXARZmFzMHrmTwoOvmgW4L?=
 =?us-ascii?Q?kRcDIASLK2oNcdGbasofpQQCUNyUZ6k3cyAmKmhm617jHCiDlWEuAwt1T7TY?=
 =?us-ascii?Q?pRPf0nfuEHFu63P3/xxefGiD/MH4OPfLXLAUbNQK1l7RZ5DmJtBgtV7lolq8?=
 =?us-ascii?Q?09xFtzXGOTcuFrF9hKwoc278rJYOmuHU/VNQcISgdpfgRde/don3NukEQ3ie?=
 =?us-ascii?Q?PaHU0iuFmxPbHdaDrI3I7tEJYh5evWUl/51rZAaZL+PMpDIeZyy+Fz0y0NlY?=
 =?us-ascii?Q?UBIaTWk+KGuMmfTav3Moi4ajFQ9XY4QYFiOtbbJeYoMgiVI9iyZtKFpcA1Xb?=
 =?us-ascii?Q?ctyHd9yeLo/jnFYPGKw0hdeRFMzbtCtktc1t94niBOOge2aDT1enw7Xz6LG0?=
 =?us-ascii?Q?m3hMjLM1QrelpFXiimTIssT40OS4y0/Ki11Gk/8kR1fxI1D/sVbTaWo7NnhF?=
 =?us-ascii?Q?zduK00WGFUSYP9FwD9slN+YrjT8hn2bxGzqiBkImllltBSW+8k/SX2L2JnhT?=
 =?us-ascii?Q?ha6fhLv1Z6zyK2IQAEkn1Ydk7UZQwvt1BfLZkHGSlkprH8uNG8jmx8e3yPpa?=
 =?us-ascii?Q?PkyMp+3UZx+VcEtiASblJBd5fdkBMV09mSghAcltGktLuIaVvfsn2QAglHOP?=
 =?us-ascii?Q?QwfGjj6LJWvuL1BW1E5DinkjS6uHmKhToX3yVhDAJyPm0suI0M3lt22UbuMv?=
 =?us-ascii?Q?d7mVDrCsqyV7AtQUqZyTsYhUdFj0hwraxfE6Fg8GP4yUkxDR5aHa2JLV8lsq?=
 =?us-ascii?Q?9fEskZZ5q0ujVQSWGEhHFL447Y3Z7m6TDEmo8aQvEEyao/7r61xygxbTEGio?=
 =?us-ascii?Q?IaawU2CcXJM5mjHp7rEmGMUV+iUpD83E2w2ulWRuyKm8eerYjRjjKh+bY8KT?=
 =?us-ascii?Q?RJ1IRjb9k3x4D6cSkO9pQwNuJvwBSszq9HErjl4BjwPapkDDJjRkh4WVt/sb?=
 =?us-ascii?Q?VPG+l7IBdiOl/sfFHQAHnKyag5BkiXM5rFwEWl687Hc14th1crIr/0KDJwEq?=
 =?us-ascii?Q?eRpCPBJ4Yqwdj0wxomkuPkck4xV9noVKt1PHOTjzuNnY1NlbiASGcynhpnXo?=
 =?us-ascii?Q?lKI7m1xC/9ij+baAgl8GzME/jsgs3FFj5RMzB7+6Sj2w99eYYqxcRfkQXacv?=
 =?us-ascii?Q?NupSI/WF1o9sPbojhWy8xQsgElSRCpfxKfRtB2UfAEr2D2JK2kD7+kv1k4Fi?=
 =?us-ascii?Q?vx0SQp8PLQVilqwWQCEN1TERF8ttnnBijlNCYtMrdnig+wawpVh98sfWRrBf?=
 =?us-ascii?Q?LWMvdxcxnDPoA7T1mUUtxVueFjS/Ux82oWaAO8OfFzMGnbszgbEGZTLyTwZ+?=
 =?us-ascii?Q?5G299s0CQXKcpur4shh7AoNSmPH+8FPhUsghtwDwJbJoZg0uJI4EG3Ng3/+u?=
 =?us-ascii?Q?04EgK4VU3Ebu/G2eITfo+o9JlfMJZUc+ivZoEZvPjNZx23qfoU1ZIf9MfwgT?=
 =?us-ascii?Q?1oOYXMEuAUP+L9gj9OchmS6sB4zOFxthSyww0ouCqrWQjObfnXdxlT9ZDxsh?=
 =?us-ascii?Q?cER5AlrD0UhoRx1b+u9hKPWcdU8CyQYPDEkk2lEhSSmrtv8cmZq6XGrZk3fa?=
 =?us-ascii?Q?/FkGvANFNTc5B+2fHtF+o74GmPRzLyoP5CnGbv2tJUuNg47cLRSn7M5AEMD6?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03be5c6-2875-4d82-8a2b-08dab1d6f3dc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 13:36:40.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeQ4KHW95dY021A6DWu8hXm5BHIUzrCsuwZtDz/0NCKici2lVDWssodFxfpymgSc/SHVcZjYnVfKTWBqEEWbLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7251

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 61 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 05238a0313f6..7c0d81c6dfe8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2519,16 +2519,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2547,31 +2548,45 @@ static void __mptcp_retrans(struct sock *sk)
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

