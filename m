Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2563207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNfBC5VpY2emFVuzIjlYMQ3bI3UthQw5RBPQecD9OyGG2nECXvSIQ2jPFnrZfm1hcIQkQ3VJVkF1iC0BWp9y6y7sP1HIbKhf8LRUBdOYoqPHm7QeP3lb1hBc+A8R/yerOz0XNKlLIbgIluaKYysRofgJh+dkJEykN8Z0pm7w77JxAqbPFvMibNtKNs8G4CBXKauE0iluTPA/qPbT3OkGhJx0UH9V+g4FVr+eUzT0auvojBzhwd7s6kcjKwvBR1zEROrbbvbevJpCechOD1D2QpsDVTRZoJ/xdJQONB1u6CDb2B6Wp2tNAMCDMz1yc+utOZy/qJo6xE/j9K3bny7nJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k14KGB1Jv19RPe3mVlgIjdOWI3/nV1f8As31QgehBFY=;
 b=CofYf0aIr34kIEdc97DjAw0ZoSDW8B4gNzWe0//FX20IU0MgOqJu8cZ6wslSUtghAoEhb3m0BFK7OjXD+WzfjSFv2OxLx6Aqedb9cme5w6Rd32yQfUjrQ4B40+RD+pa4AE89irXfLQHB30XO+dFOgNHMmJmM0F2fS3ijVWcLwYQ+lCZIIjyXJyiSgKC8gxRqQJKaokoI5v2kti5a8TAsELOBaDi+ucTGsDxaOV7Vnz6Mv98N9Ds2f0zC9njuA9W7IrdEfA8OtRexV21ULTmovqSB0c9CQJEIDyLqDwRx7qt4ShaDNqKTpc1zEiE8jwO/HhDEWy9GXAAj31BxDkrPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k14KGB1Jv19RPe3mVlgIjdOWI3/nV1f8As31QgehBFY=;
 b=H686K34pXJU//UmeMB6sVpOUQb1gBBp8rq7ctzYTTIoJXpGOihzRlah99EWTW0wo7bvlJbmFqJ5LdWm9sRXCxxU71jOBAlutaWFxaArqLanCs6SBHmYtM7VpmHzjSorH3Njod2VFpKaot1k+ue2SxN5n3Z/UU3GRJ0YQ6bwr9ls/vUiu7tY/vTgMu2muc2y7H4bLX43ESL2I5OCmkLkrmTWDRZxTB7YPfHGCfFEmRSDocx/JWljDZM6WpJHrUE1wDVQkYt+jxQHjY+6cG/Su4Xpt3bcxLGKfXPNt99b7mF1dBLQygdF6Y/uQtfhY5fN6NTf+a5usIvHf7pR9KK51bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 12:02:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 12/13] mptcp: multi subflows retrans support
Date: Tue, 11 Oct 2022 20:01:36 +0800
Message-Id: <20221011120137.5475-13-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0037.apcprd06.prod.outlook.com
 (2603:1096:404:2e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be53f9e-1511-4245-83da-08daab8085f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OFWHc9rsRKrIfE8eDomr5nzAxiL1hMMR3hGtAk6d3GMzrg/Q784avSjUyCQnpCaVMF28e65G2e2slp7YRpupGwsQDJ5VC6tJ8z7OgUfffQqZDNb8C7R1K2OcODOuGX3xj3FtLT+vIbJQsms8EKY0TJeWwTVAVcLpNpGiR9n8BfoTq1wOfPCOVB0mtbtAAnJplYtYtwIzFH06jW35IMULOxCBtQpTzxnjLooMYZNkOx4z1qJ73MmKtX9YOuYpE6QHJ2azI975t2y6DvunoFfXmEnLo6JsXw/y+/eWAGPrS5GsFiYiGHd4HkN8ynE91FA/OfKmvWSHNrU6WZzpW8UUQsDTU2cLfwM3/7JYHp9Izte1JORnYb6wAgTAKZ3WQY7yMK09ONwLs/Rv67Rd7/tVFkdA6CDMvKVdT9tXC4JHOa8TK2XUjKbVGxexL2HomGwiBHXh2Cjy4RT93sQHxnRk8o8ad9IjNuzsX7P9NeD07TQi0EjdNlMxgDAvZ+hPeAuQ3synT7zsoBUlxAKlDtENTCkQzh/adr/23USAYNnmiDFBPWaMzdgrqNugSPNMJpWjP9cwRKRRpcKTx0r+E5Fp6ysTTVe1PbX2kGyGZHhcJ2Pryo6iWrADZ9/2t4cWLltlsf0W9QWUkooSL9rzjugItI/ymsXKRXfuICy6CdiH4D9g1QYQJg7YnJ7b0FpcZnghhYAZFNMegWoeYFeQSZHkQcthQ8wsumN41dxrhDRmcz9/K9LE6eMTPTRVQ4DqF9Qn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39850400004)(376002)(346002)(451199015)(5660300002)(41300700001)(8936002)(2906002)(86362001)(44832011)(6666004)(6506007)(107886003)(2616005)(186003)(1076003)(26005)(83380400001)(6512007)(6916009)(66946007)(4326008)(8676002)(66476007)(66556008)(316002)(6486002)(38100700002)(478600001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zeMPbdLK0uKHhclQ7bCP7U2as3uQuRSW+/J76v+riktaC9t1DPIXUNpKRjlJ?=
 =?us-ascii?Q?2FKQh5pEROWCIFcTeRDk8LFvR+vozxlBTtvlTgYQm+WDuBSZimU075LgRBLq?=
 =?us-ascii?Q?pOyinx1J1/3ELKZQmAZUigpsIIYuDf1rj48pyptzLJzcjUZqej84cdass3UI?=
 =?us-ascii?Q?97MsS+sfpLi3JYSNyvvBZ9kBGHOB1++HoSVkwb6FzFCZoXDt1zQhAXXaIhqe?=
 =?us-ascii?Q?f0VwySqyC30nByBSPrItLlVv7G10U6kBIJeRJAXuGi+8S9LjxvmaCrxn51Ff?=
 =?us-ascii?Q?Eg2+7CskrD2S2b+QjojXrMlU+iPzaKBI9CsYmmj1q7bdusZPdkJ1VHxNgZIM?=
 =?us-ascii?Q?6T+hGHv7dSAKY1Odef46dPA5w0t1o6GWByzXYt/PpaTat3/FDgivw2pOBI6g?=
 =?us-ascii?Q?DbR0txXgsw6x5BCKEoXfiJWOr1S6tZvqWH9uLCdzoq/4Unh7VI20dKM/H1dd?=
 =?us-ascii?Q?8eMof0BsIdk86gNcjQ+59R2sqNRZvVt/IyiNHg6vxEXRSwfEYZA53E6hI4L9?=
 =?us-ascii?Q?e/0hSYa6ucqo/t0FNG8pxWOzz7qnoYbAyLz/o/pC6R6ctC49xwSNtax3s/L6?=
 =?us-ascii?Q?kYWtJ3oSzQZa2prX8lWOj79D6sklKz274WeWRIsuIoNtQVJE7ZrB1Y1Mds9f?=
 =?us-ascii?Q?D66v2D7SImrVq6fgeiER4Pqf8xwRQtIt50ltaLkPSGeC7qyTca2/RMuNtGJI?=
 =?us-ascii?Q?MNW7T6kHRFeWnEy10ILhdD66sYMFO4rjfdMrt7Gxf7SWvR0ayY6RMxqIpF0s?=
 =?us-ascii?Q?lS0g+HxQydVIOwnNRDq7cwPoqmMfu106IU6qdDNIE9KIbbV6zarXSXPAASL2?=
 =?us-ascii?Q?6rWGqbw/1j7dX6Z7o1Ggg+9cZmNTyRxynf27bj6s/Tu6L+3RxcCt92l7Bm3g?=
 =?us-ascii?Q?T4q8TNi9KxamWU+AOYeeNng5+wqOpowKz2DmcQdjgaO/B/T5a5ff7rIdtVqk?=
 =?us-ascii?Q?4rMe6YE6K58+syqqfsv/9YyEI/qTvnBhnQr+3VHUHEeEiZg3+aVcyL+SmU2P?=
 =?us-ascii?Q?FsgC+vMPIK2JYncethCYT5ofnMd6RU86GtLf0gCJznLKyJSvrYpChrxWJ/oZ?=
 =?us-ascii?Q?94ldakyBtSdVwxgDaADJAcaEX7wSw5F1N/qGbJfOd7qWJnmqiPdEb+bAWc/E?=
 =?us-ascii?Q?l0quo9Nt0Sm01gxGGG6htCMCrAk7Nut3ABII8n1xhvmdb2CiaLzSHD5h6DC9?=
 =?us-ascii?Q?duqTX3ymGGa9P0SoEEYdteMYg1MoZ24TOJSUGkopwUotCJhFatmA+qKJESzh?=
 =?us-ascii?Q?BGWKU6pO0Cz+yVly3Zn87gioEvWMH4GHuVKvI6VGB++mowm4jO+NncbzEi5v?=
 =?us-ascii?Q?4JxiKiBuVVvW1pMcra99YB12BGvU2KlNLqHdm9252yFIn+ec6WMr5eG8Lepf?=
 =?us-ascii?Q?Yq/gtbwlOOHOYlA3w3xSQFdQt065XFzHUgZW4n2ELb1WI2AE3Oxt6IGJ5r2/?=
 =?us-ascii?Q?yQNOaoWLSt16hL3AO2pDX0qIWRRVdyV4LlheIk7TBHtV2ZCo6RrIIvgg6Qlm?=
 =?us-ascii?Q?EPvc+C4N1TlQ75PUzoEhkkjaTZO6paFxtrdOfyjZO9KkxBm9xe9TBybBVYu+?=
 =?us-ascii?Q?kINACRsxULgkTdljySN9XjW2wEnvwSBwJqDMzM+Gv5o1u8fpZgKdj93rdIYp?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be53f9e-1511-4245-83da-08daab8085f4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:52.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNli/VlEJjWs1BOD+kILcB2ldsaekVphDkrUvXgxyY3K3CFfIRcU2or9O6xY+qvhYKetkGWxR1wclJqmGrAbKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 61 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6a2d9972dec1..33ae11ca6c3c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2478,16 +2478,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2506,31 +2507,45 @@ static void __mptcp_retrans(struct sock *sk)
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

