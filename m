Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638CD7F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKtKNaO2e2Kx95b0s95DzV80v0BSxnv0uUpXTRdMKmcwz0rQ66Ukgr2hzsdH6wm8FKU/TN++3rarlebVfOOvhca+OgUbjhhta1aE/VGTT72+tQVV45uXEHqTAa2VEIkmJ2aevo4mkwxrkf6wYU+/1TGRd32oR2Ng+jthlyKdBACUqXDhxh6RGuF89yIBBmKiVlsc0FyqnN44dcpoqvFL/6cenG3EiHPRE5E3bgRmIoq49xTFVhFOtf8YjM14TxLO3l3ohchXLU+IMXgxdA+slOut1s5P4MgvxBsPKAtBQghBkkm3207UDRQU8CAMQ0kPh+DWQ7GFb+xNzwuTmL1Tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udbz/0KRHD2Yx0zPilhcBMX8c0qPMZgV/h6nFNsMx+I=;
 b=KvnSJz/vN/MjCGw4ARazxv2o3Kskh/aw4I8WC43XbPiM3Xv2NYApwXIDonW9fhGBqajCf36QPlNpSwDfbWu7jwE4o/Iz3964Nn9+pRI+L5WsO+WxcVxI5GkN7Hj7rnIuLbTuElvbR9T3Cp3guR0foPjYX/mppigWYjNMb2ADAYsayM1S2JRNaoDOJGReEJCV/Wt85y7xPirWK/y+fIOzNfm5+JzH1LX3W7h+6e6iYMWNqkXH1jk13ItmpaVdiGBhFvYbnSY0Rry6fqQV9eEyQu7f9KPEaUXSAD/CtG6Jplhcr9j11R/trtCXnPNACHotgnZQXrS60Y5bWwssTE+ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udbz/0KRHD2Yx0zPilhcBMX8c0qPMZgV/h6nFNsMx+I=;
 b=eLcmq6idBHz2i0sqfgHTztThVZ6YEERLG9FbQAt6QLnHvHlEhruhXpTEabQBI0xtCjCdi22B1BSZ7QfvU3Ij1E87Me0v8hNeFKhhWTimQRR4J7YTLrqKpV6LXVF7344xrYGy//J9l3zq+K7gNw9oGrFYZydf0GJVR4C10oQAOjetUkUgcWmJZWoMCY1B8xne0vzruOyxNYzknFq3+wujTSON4qGcwPY71ssZDHhjISJZyNnN6GL/klojM2RjPPuCnUY4GUAKvxf+GDgLpCz9LL7JT2ZaAmMmY9hK7LVsgbeK+fdjiCmV4fBxoktXzJI6CXd0ruD65bYse/qkm0HwzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 09/11] mptcp: simplify subflow_push_pending
Date: Thu,  6 Oct 2022 20:17:57 +0800
Message-Id: <20ac796b98f46678a8027b1bb9eb33169ee96618.1665058389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 82816a7e-90b1-4377-aff5-08daa794e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s2UZm0uWsDLo/yYlsYhU0ABk/f5hGnD1olfu0hZTN+YBaeboh5cCE8CeJR2gsAmSBSaAbiGRPCCSVYx+8HmIVfSLI025TU3pIDd8uJeSnXHGpuTUt+GS4BmClo+KkM+4T9mCEkPxNxnI+wjbhL5pKL8w37mnoAGZUpyDRmEwYWPwV2vJe0Aa/FshU0GO6mKRysQ8o/zAPrlCDfAEn43YIQuol0CdENMJZoOV2Y2ypUZ7A+t8zoJslwNJyvcZT9OXMsVnUme4YAzuJhsrabxjK2I1JlX9c9IY1tUXWE7r0v6I9iYVaMgsScO9ZX6byCLj/Dp8KZhjKd/1LZ+36j53qPzzsYg+AMSLwiJXPbJ3IcCD9Y/A3vSFkiH6Bt81eeCEj1b4muwmg4ZqJu9bY1D+KObhsEhMiE3QFkXcfiVUzOP0hPVqWr/lBl7fROnZCxccvjiJbLs9GHtsgE6DFHP9OoUlq3mFsKeCJOhI9FkqBLGRwgIaRayuWSZdSEEeEMSrAi9C8+AaSZKQRD0YqBL4zQhC0XBNKyjhJFnqOMQY1nCTLKIa7YNGVczJ0MBj9lJYnA87r21qjShkQIDUmSY6smjH4y4ZARwsIPcOiMPjqSb5eYkQGpDVI/4Mmp02HgmmlxU+BbpHLbvnnuJcSEMcr+5WhfjoySIWRIKSZHH8TIyK4eOVLblY9HK/g2Wk1R0kHV+DIdnp8urMFw5aVp/QVx010y1xR50gtVqV4CJ+f87LU01t3+AHLzQo2tq3TbeU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCZx3VwE+owlu1k+ZVH5EPCkaffKv5Z8g20hlXU+QIRHqvQajdPhC8Fbq2JF?=
 =?us-ascii?Q?gr3i2wjtLcYhBF/Lmzay35mzU/cpxeN/L1B5OPdXq0zrRVnKRMxyagK0yjNR?=
 =?us-ascii?Q?e687XK55L2rk1JkInF9/URy/1jrJc5zqll4GcIne3ZBDSGbjC3Wz+xGlx+IU?=
 =?us-ascii?Q?hLAgaXryyn6V56k8ffzVx9V400BjJN4D00K0f4q7UBdejfoDDswKo0Qo9U2i?=
 =?us-ascii?Q?36uXLHElxa9HhFp1cZsXpaIF4GWiXhrau1+249DBJJa9ev5Z++GNd40YkdNq?=
 =?us-ascii?Q?S1A7Q7AEU75sGzI/nuoPXAGpMFDJ3SIEZ691pkSUbQN5/KmC7/7xa2Qbs4F4?=
 =?us-ascii?Q?vJapoVYr7X1cf7k6FjJ129/0uGZNLLxbYE+fgUisl6FoLO3+BxyfJXZSwakD?=
 =?us-ascii?Q?x1HvGQr1IJlnp92GOLiKZlYG2ZYXhH+4wvMNfd72zubp6yRwZHL+79fW58O8?=
 =?us-ascii?Q?o2mykuKkMmuGpnDH8qbk++mkLR0czorKZkYnAdAak05LCSgZcMr6Gc3OdlFH?=
 =?us-ascii?Q?gZZ7StR2ikrZCL5G5iZbNfLqAK0+Pwd1WvZ13EvPHdn96OqH5pHgoVsM0I1J?=
 =?us-ascii?Q?HjbklFcQKh7UkGiYMNg+vaNv/3FYSaxWM7MziNCXhkhGoIhoGNUEkxiHhBmp?=
 =?us-ascii?Q?EpqrASiOHYvmBOEGf9FiVv3jAvF0J6syBZx6eUI8TjR4by+YqxGff+qPcQO2?=
 =?us-ascii?Q?QGglpci83SiFoXWNWwZQE+QxBHZEgj1/VsU0iHuvUZOip38gNsF88w4cHJW/?=
 =?us-ascii?Q?kmaR129FCac4a4bItejwHPGgJUmSbkpVVUw2dVCupmAoCa3HEDv/z5dHYQZd?=
 =?us-ascii?Q?w+O8UHTpRB23mEcibcbFsB5+J0WRf+lsvPsv/9uByOVb4cXXRuyI6KKJaNJ3?=
 =?us-ascii?Q?wl4MWfVHHAPpf5cW4Avadx8nphMKeI3bvVHG428+5v1hHOCvPI8NpV/1DtRr?=
 =?us-ascii?Q?z3OZRgjsxlJ3WYoAGkArj4DPwNyWiNQ6JxpG6CQK1RYd0wCYoyON8wAHIE3y?=
 =?us-ascii?Q?Q+YQLs4D0YJO8v1/rHL9yjPJ5vsm6k95u2huNzjEljlGJDlW+OqIl+lUQ526?=
 =?us-ascii?Q?pW5P0nZ/9fDSoX5RuxYksAsqxWyEEVQ9CYkDLnSN8cZ4LP9XOevy0eaAi23d?=
 =?us-ascii?Q?OOJbu3Oug/AsT7rg1zyTm9xu6J15YxaZQCd5/+dBqeoghmUHf56w/ux5ADRE?=
 =?us-ascii?Q?NoAh1+sHhz8gQgxomFMNDbsh9I7iX0ICceEKPB1aaHgFamyxT2xKF/jk/CX/?=
 =?us-ascii?Q?irQbK+j/dk9gyJN+lFmZJoOOwlmHBZmYcWASoQ1Dp2ckzP9tYvYIVRmbHlzP?=
 =?us-ascii?Q?4f89tW6iNqCj54i+gX5b3CU0JXbhLdIln97B5q0PK5UVsR5cdZD6mkCdzgBv?=
 =?us-ascii?Q?Mu/YxX663uyCQo/HGcdvA/z515debZw8Z1EXl0EfqfDM9BlzMAzsuoYQ2o/V?=
 =?us-ascii?Q?sT28Hs8MeQXDBQEnlpZ/Jw4wj+WXqlP+75VjKwClygOYz6z69a/NuTZbmvXd?=
 =?us-ascii?Q?llqiHg7sZiOiUkSh6IqijPWgH700O1+s0IGLtGdFnhjZzFTxNHzjA8BGGhCS?=
 =?us-ascii?Q?M2S0eFzRUm+xqTLtbXjOf7+3cnxoFTeIKMPQNJL/GCnb9Nb1WRMtxR2YT4WC?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82816a7e-90b1-4377-aff5-08daa794e7c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:41.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJjr1J1nNWFxzXydjUH1urB/WK/6kxULM+8pCfrSe3I+d8su4g99vv6s25HoTq9JRWbib2/36atx0RAzqHSksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

This patch simplifies __mptcp_subflow_push_pending() by invoking
__subflow_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 39 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e2f47e8ca63e..66436885b749 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1604,10 +1604,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	struct mptcp_sendmsg_info info = {
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int ret = 0;
 
+again:
 	info.flags = 0;
 	while (mptcp_send_head(sk)) {
 		/* check for a different subflow usage only after
@@ -1622,32 +1622,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			goto out;
 		}
 
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0)
-					goto out;
-
-				info.sent += ret;
-				copied += ret;
-				len -= ret;
-				first = false;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				goto out;
-			}
-			mptcp_set_timeout(sk);
+		ret = __subflow_push_pending(sk, ssk, &info);
+		if (ret <= 0) {
+			if (ret == -EAGAIN)
+				goto again;
+			break;
 		}
 	}
 
@@ -1655,9 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
-	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
+	if (ret > 0) {
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

