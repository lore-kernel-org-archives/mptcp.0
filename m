Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE117CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL7RPo418UTuOUXR5X5kq7rL0XPiAQLFVQdgrorboIH0XruFYYRyGzcPFj+Y7rUK2F9SYcYPdveQh96TzZ/crKvi/VCcae+ANkXPTIIplw0vtZYiYpPIlsHXCGR+0vRuC4IKpFF0JZKF9VVyKQtOhNgO/7hDJEg6PUNdCx5WV7bKNGRYbctaSSduFjoPqhlhaWBLvyriDCk76hVlHWsHDE7dHBCgYTDwUhd88VnRRVlez8fZGWp2G2tHYywlnYIZE0Ik6j40SD93hbL75qIgk56qQJxyJRmZhr/kz6ONZ0fszGQGjLJFQ9oDVm65comUCdInetLvjhjLrdH9lhWSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQlHVlX4OvThMBh5rZNiRm/XEboXcO14+SGXRp333Hw=;
 b=cG9Ksf2fURbut6l29nSiVfRPLR5a6G8fabS7C4WGGD0iQmwuTkcizSv3guT5QAhg2J00o+h4NQ97941pLu1l80UqB2SU0rC0FwXzdgrvan3NJCFpCvh1NqNiUW4cyM24bMCuU+dKwhAUQNp9SjXCs+agRkg4Szl5F9Vuz/Yxb4koYG/5BbKBeeKRA535pG6v/o9bB2oT6zyvRzFCA+8cmTQUB48RWKZbs9PVkWDiRq8JIzSHyQrZEswnhUKXexAdNMuPT29D6GJ7vnfttEo59b76LmIQfhtBiWIKulYipExG8ep/uQKNgXNarjTHXIeOHIjsNHQeFL46PdxzryPJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQlHVlX4OvThMBh5rZNiRm/XEboXcO14+SGXRp333Hw=;
 b=Xa3BI6LlIUHvz7OudUZynmn2wIKxLaT9YbCNbYUWnCTV0YYaSU3r21e1xhJjuX09tFtQ1DVIE/CfVUgRRu6Clmy0Y/CbqIX7NVadnxlUO75bDzRIFyr68HccSMitN/wg4ZaFPXe5H18TM4DR2R4vlfHTBIF+sYQgOOc4RH1BrQY+wrlyMgIpmqioYS5cmRJfAulLOSJFdOVu9AzsPhNJeu8c3G7wqbHSGrYb5RpT+KTRfsQNFUu/ZG3TlFwlKzVl3YYFAlrdrSdYvSsJaGM7ujP4YkiYnU/2xhIdspBcnYEQcKyePDLhdhodIN31EGYTwhXgTvE0ewOGOovgMDDTOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:41:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:41:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 11/12] mptcp: multi subflows retrans support
Date: Wed, 12 Oct 2022 12:40:06 +0800
Message-Id: <c9f806cf1ee785f8d3dda33abadf3f6a4f0b4516.1665549148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549148.git.geliang.tang@suse.com>
References: <cover.1665549148.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8814:EE_
X-MS-Office365-Filtering-Correlation-Id: 721d39ed-d79c-4f08-9fda-08daac0c06a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rm4ccWnRlNdn1bEV/nuvFiD+E486/ceD3Lhur4oHIV9pNui3R3bNRCNACoQFVaZ6WxAk0qpLJD0KRi1J/rZpcNWJHNOcTyX+GGtPvRfQz2DXzLz2cnv671+7sWnR6P5uRDVmlPjKVorasljy/4fBKeGbL5YFkAenbaG9g+0piXX0+LVFgZtvplcqHevpFbvMA6O+O8cdkvnGuSw97gXbnvhG91uywfg1fqLtgAYPrZjOAe7DaKahES0M44I7/3sg4F4hbUvNBGsH5AI+xTZX6rlOBzN2AbP4mCUUdj2yIYNR9iXs5/FHfYycz+Si0SunwRm6LxCsOdjDlCFGdR16iryMej18B+YuydsNDUSYKa1/KCZr/yBYhOLJz0lkMjyB6OanyZhNzUW6Xje4pdbHbEusHy6zkwc5iVj3GdPxybLpZAKOxKRD+NplSuItoEN+56OcW8YQHB3g2y5bdKwvmNiLuJnhAgdLoGf6DsuQY5iHTrprGEqWhkTp9ZOPrkTqSqA6eyhJo6dLZiRq4tptZDmg0WpjkD2cZDUIkQSiTTMOI/jCmXNyYoW/tOK4izdod8zLaKiGgU4me1bkMso9ix5+8i/zW4tDfxMZUU3lcyhscpL3nuzCxvRaDM0QwY73Q+ZSPZ4luEPgJ81aSMxMrDZG5MO0XUGhGo5kl1XvLjXO58BGVSX+so5m7GWn6G2+GOhXScH/UqeUfXz1TR6XBBqQafxCVX6mKstCg1j0r/ByOBlxl5PTXkyc1749ry0b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(107886003)(83380400001)(8936002)(2906002)(36756003)(8676002)(5660300002)(86362001)(41300700001)(66556008)(66946007)(316002)(44832011)(6916009)(4326008)(66476007)(26005)(6486002)(478600001)(38100700002)(186003)(2616005)(6512007)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nUV8zOg6tAnY8tUVkFgZ6Wn/XaWTjzjzVVhyWi/8Jjfn80wj4brr5niCEV7X?=
 =?us-ascii?Q?KV9PseOqRAdA9IKNm3O+pcFmWkRPAdDLHOBoFmPi3Zks0mBLS1l/ZMqlhFDA?=
 =?us-ascii?Q?t+fpyiikuYfwTJb8b9PTCw+o3zQ285Zo1tq09obyTkSaIcUpIiZYtWa/CZzx?=
 =?us-ascii?Q?rD9bKRbkSZh4UO8opAZoNdGb+xRgQsmrxVZl/3PSi/mYXgqVBCNULQhDuXIg?=
 =?us-ascii?Q?BTkzPea0/9CULfg1/KFxt45mwpZwqBxHoiwXWdo+BzdOqG00h09Ky98s6XSl?=
 =?us-ascii?Q?ZaAX6n5KTNB6c9gmkSpXoLXviZjtX7Qqkftxkk4Q8D+H9RC8DQ7nGaoETx7o?=
 =?us-ascii?Q?WKEBwG+QQKvNq6RGb+GMGmWJFnTNnYDDTqme/ZBi1Lrn/iE5ULrHtC40M25q?=
 =?us-ascii?Q?yWi0XsjiraYjSZtUPern8NChz3WtRITAbRZLQpHx8MDPhRUIiXKbO4JMm6Sq?=
 =?us-ascii?Q?JtnsWyuGBLPGvHcMI+u1n4t0/BHMliuUK0mEqTP49IgapuimzGa3hsmYtoYW?=
 =?us-ascii?Q?mL6jfIVkpW7/HhtO1jiNRoOWNIxezA1WHJPCBWrb4a6BeP4DaDVC7YZ3ZNJb?=
 =?us-ascii?Q?MriKiZjHaIq0Iq3HQfnYXXFl0watYJBdCo1DxNP8y+V8P2VxyduzM7ouYisN?=
 =?us-ascii?Q?wZQxNVaYjjwQgsFecBSFa6iAt1fRxnwV/9ajM6EXJ8taGV3oQj/am/XvYwsT?=
 =?us-ascii?Q?zZlYnDtaTbS3JbcTpuoBf9Kkvlf3mjAruSnspmarEyDFlyLVTaeP0a9mRfQc?=
 =?us-ascii?Q?DYS1CybKYoBBWN/9N/cj7sMXX1zwZDzTYX65I+fZ5ermhYw4QG4tVRQdvDuc?=
 =?us-ascii?Q?XoYf3R6JjDea6PdInOiYr5zxN0Nh97CYbGbhlCaSGfXXvscYBKCD5rH59WAq?=
 =?us-ascii?Q?3h/vD1rvJoy+/ehG4V3ZQNRD6LtJVXvOVUTxdzQSa395mQm04QDYewaSeEVQ?=
 =?us-ascii?Q?NEOoCa1DbS95rxoBHu4PV1zoMoCVqT7EeM64s3P3o7ZCtsevL6RHIFHHXuVa?=
 =?us-ascii?Q?qm5jAmb5KXWplKbtFqHH3o74tja+EZPwnDQ5rEjyIjChYdCIlpbVVPxeBvCn?=
 =?us-ascii?Q?F27+NkSjf3zpXyWE2sa+z84EjinyMr3uiN9Xct++R5mgdN/Dop/W6NV42gMd?=
 =?us-ascii?Q?uNXtTK39xX1da6alcBstzQdNw+88zlp3dk4FlYYodN1P8cRmBNQUq/q7EDC9?=
 =?us-ascii?Q?0wehGyP9yYMQswvLFbnwrOdrZ/YlKdwmLnRVnTMx0HFHJoRE9Yh3prmyGeQx?=
 =?us-ascii?Q?F6eX0SYeVBgpvQhshiDA+rzzjKej53TehvO07wEyU3Gs9K1GxNU+kADJQQIs?=
 =?us-ascii?Q?Uo5aN4AqTRRkE2W6xO1No2FJx6FkaQaIHzSsvu0Vpa4uR69pXgCLE49jE2ig?=
 =?us-ascii?Q?Ntl/Ye9lT6jZuWEVW9bZV8Kj5NDpauAzPCAPYjmflzUyt08fqYbArsDuY+Q8?=
 =?us-ascii?Q?pwmFGlvwKWxM0nKCjS/eIyhQnkXvQDhilwInxvQhGfiPfVNAXWa54uRoxl+5?=
 =?us-ascii?Q?O7da+vDOwvTKHyEWhk3hR61McHidHhaGrveT67booJPNdDUwQFf9C7U+1HhK?=
 =?us-ascii?Q?k+9XRRQuyI096Ix4wGtPH/iEGNHjQUulYIo0F9oOk7dJYFXlocqckJ6jLvqH?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721d39ed-d79c-4f08-9fda-08daac0c06a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:41:28.0064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4iROtx57h/VL/PGTlU0GvYVlJTlyMh1TeDrWohW0gtmCN1zyZDdHr9o1d5NoApZcKGwCoFgKU0EMljj0PwseA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 61 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4c9c2c6dfbe5..5ddceeb1d334 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2483,16 +2483,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2511,31 +2512,45 @@ static void __mptcp_retrans(struct sock *sk)
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

