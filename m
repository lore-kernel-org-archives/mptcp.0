Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D904A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPR/YXKEHnYnrH1BAcMcMihbI/bH1e0zAFLSV759mnB7Y9GFVyuNguiXbG0MMj/sifz3txaFVa8uFYJShLCJih9J3FT1pRtS9bCvF40bv7cHicCrXy5fr2SYEJJjpw4U3QwrE07rgwHr6TaOyrciOjVB5HTtkTo7wkIqy6YqCzfyHmaQKuP+vCF1411ivlKbus+RinDYUGXuOnGtCEJgDVdtV1tQT/s9hlaXfGySfFuLTDlIK7XV2ek6gtXAYxyqqckboC1GV9IDHyi+y9+saDPswJYGZziOZq9nadxA8LHu9OLFWKOJBLAvYqsOkzxBYCItI5vbwWGbAZWNsKfRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5WP6glZaWFpyTRZgS+hCbuGqLJwSnhIt9/sWozvMKk=;
 b=kMFYgJrsp1VwYNEfuiKY5M83k7xdFo8tOXlc4nzxqD4c3fMIXiScGVVlV6Ugqx6mumFQUMF2T7ww6SSEL29eYvsfh+njS27QEPtnbCNDjLkfMyFXheUpnW7EPKCveiFf8BubjKp+Xgndidh7ZeD2KGsdnqfvEuGNkggSCSPGKUCWXfVJgc6xgKxrKbLVVj7fpzBO1cpHDJjJXbUcJNuqsZ8JgleLzQvTuXqw0DgkDvrBRwRjeWqu2ROKs1fqwY/m08Ffb5UaEwKzmnzuAOh6tpXPp5rFRnABP4vC7B5W1OgofTbqTQa1gqqrfJU4I7HDGGi7NCRfSVBeV4+YC5e48g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5WP6glZaWFpyTRZgS+hCbuGqLJwSnhIt9/sWozvMKk=;
 b=IRN2kFpH8DRHdqZFZ8Xt6vltB07GSh06vVoqdE2TrjUpa07w+WqjB47r8rUhdQICtt4uJWQXBUA4TSGZmJObV+G97BSuwfmcnBNzldvGR1pFzTHqQ/kGEb9TS4T2QQjwfjPuqGYmQFGO+SjCAwcQmgD8c8sO2MPc8JWQE6hOLCU+wdh5msIjZ0/dD4vbO+vzxp1IPSCvgudBogNwV2e2S8xV7+q1b8/VzxO75bYU20b/I8IlPdp4uzGD8YKVhTFaSguBnOn2wZ2Zwz7gerGbm2cQURHcbbKYyjJmG3MC9UvMBjEexnJ+JukYcY7mP8r/GYAIx9UDYf2zFwEoLG0vJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:43:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:43:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 2/6] mptcp: use get_retrans wrapper
Date: Tue, 18 Oct 2022 19:43:14 +0800
Message-Id: <20221018114318.23627-3-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ad500789-73b2-4b6f-855e-08dab0fe022b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oLQWNxYT9y6PHtN7jR7Pq2rGFzhXHp8eLvgaQcQ/zokLDS7KP4WPVbuJzjxxP1s/PnDsraA/dWzHrEW7kJeZoB5VcYvEvk0nrPO7ga03zfJIq51gTpKu5Cmk/bYOysG481NiumlutEHR1PZ7zRnkZxCUQSbHvSx3Gkw/oV5Q7JpkbIdG7r37ZOPLKH2ppk59X61KDTuN85Ubds/tJmbeBn7q/rL7y/QV+xzKc9xhzS0e0GHK09IjkJlp0dX7Mj9CpO2p5WmqL+VSnVi2qYd1hikWifBpl3D+q4qwLvRIiBe68GMH0EUUCd+j8s/PtobIB9GNoEaXHnUXjuyU+pX5+zXuquNjKNdS8r2a8p+r2UTUjncOPZ+3GpPBrgdkL8nGtnnzLuEQHJkn0McZsVGgYDWc2QsfxbSI7sMwtqHnt0RmuosdTGD6eRRmhJZlp0gMhGMPIsgIFbtb+n2fMDqVfmDAYxsLy41t+7atsFRRXqz2rWZUJfiEGjzSlivUt6YnmT/2+P3pM059x1DCFms36R1NdSbOLwPp3DViT35qrIGYMumD1Cf6JMquFJ3wOH5kwXIyiQkF4Tq4VtJMJ7NW/KJd6mIIzYmY6BS3FdJ5ydwiZJeGtejqi0+6PK0wPPoM4r9gFm43jovKiZyAVinYKFQd0dDFtDOJ2RUwKWezCmXCy7kH0ztoFP03wRcqjOv2+gnftsS8+4pvRYJwJ0WKuAe1SODFpLP1mWPBgdG3ZvjKLQ+O+NRA7KjNupFh/OPe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(8936002)(5660300002)(44832011)(66476007)(4326008)(66946007)(38100700002)(8676002)(41300700001)(66556008)(86362001)(36756003)(186003)(2906002)(2616005)(1076003)(6666004)(478600001)(26005)(6512007)(107886003)(6506007)(6486002)(83380400001)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eHACXBp8SUUHN6ENEE0wbAFKlIbyCDsUN6z6sSeieqMFuKKhzUPAOSfQR75R?=
 =?us-ascii?Q?SqkNajm7JWNm3FWG1goOdy4J8D+mjRFXew0DzlUraVOhDzevA5jr/AQ/3ZfZ?=
 =?us-ascii?Q?GfhhtJXl2i7Wn2JLTY+4ZSg1fDIgOMFE7zS7RUo+QWj8xM3m8Jsvu/Cn6+3G?=
 =?us-ascii?Q?ztBi8HY3W5kDpKY2Rrp/uDvFwqQflafB9+1F1SH/hI1kUMWvTmJfReVL9GP+?=
 =?us-ascii?Q?836xA1RDxhn5jV35ggsNCUbvTQHjkOXZuoH6nGv9g4PPJbCEG0wKJeOnu0Y3?=
 =?us-ascii?Q?svHjMS47Mc3igAUOxq1RabrJWxtaOY2Lp/wcW/xhHwUSFVlAOLXxMFHULMYv?=
 =?us-ascii?Q?rC3PiyxZBZY565K1uT/tZDrlmgwUhrReCeZFpQEjcH+lLHm/YfOvkgw+gXyo?=
 =?us-ascii?Q?jNwTqwkhp6zF/9bsFlFxP2eHtXhD6xMFSZbVhqqvgoo+emqwNsh+TWCBerex?=
 =?us-ascii?Q?KAuhpWCIZcAcIwQly0TF30MCWkFIe7216pVg8fG7JOqaHXWltDjgCWhQ8kud?=
 =?us-ascii?Q?4uc6hIzoOack5kZwd7NplkqiHGuJxyzRQ8xAx2auX+gnPgfq+7Wq33SDpfpg?=
 =?us-ascii?Q?wcqMzgp2FpEkR8PdIXDT0jdJxkNO/GI8Q6Cuc4QjUaI4FAQcMpIBlG7LEwGt?=
 =?us-ascii?Q?d4jMGFT5TdG0v8e42BO0H1zDzquBXwMPxXmQ5zGHxmVtKhS/YqYbaz0LNXRJ?=
 =?us-ascii?Q?Nsl8prA5N5nyH1xtmOoHT/2c9G8MbJYdnPS+4/iK7XeH418leCtDqzjDf5WC?=
 =?us-ascii?Q?pi4Nq/tmLK1hPMnMafWa8DG4wfYKsVL2QcI/w5FCJA4D4DaDG5GSodpOOZ9q?=
 =?us-ascii?Q?tAnPkGFm/M5TAKwmQ4TchByhvJhICv0Fs45ASrdfpPRgOWB349V4YpTJedpi?=
 =?us-ascii?Q?yqFmoff2SOoGTZpm7sTBXn4qLHDt2kxbDFbb+AP8370deoVlkhhiOPVt5TEU?=
 =?us-ascii?Q?LT/b91j8lzHxmI/QQhqGRhG+lWvqZ4nRrsA6xJOzXLv1XZoYBqrNI7gxbian?=
 =?us-ascii?Q?B7UPNEa0pu5VGoMEycDIgWXkxRGPp+IVoGmw7NMuo1H+uq81Rnt27qsFKBVY?=
 =?us-ascii?Q?jolUMMQHOC2B22Wc8Yv59BGbgpZPIeJwesst9nR77InSfbhatFSTbcJVlx/Z?=
 =?us-ascii?Q?ACoq5cQ/0MwbjgMxm80UbBQJVTx3vRix1S16FApWVJZM+5ewMXM6Ox4VCTlV?=
 =?us-ascii?Q?Av93QshenSnYXZaiInsOUrhFNTVEKlHhXQ+5Lj44t4VlbfdusUS2j9sQSdR0?=
 =?us-ascii?Q?CsaYpUEuWWFeuiIhJizdQGYiX8Mc6clj5OgSEBDwRVnYBGciG3NJh9kKl0SA?=
 =?us-ascii?Q?8pLpWERbt6yQ4CLB4HaQmg96Tb+BU1Kx3I3sj+CvIEI/mb4+TLFZ3lRTbPGO?=
 =?us-ascii?Q?7gwz81uv3noVc0PtMYvOHWgcBCn0g7l0tzgbCAxmtNDV3ZUbMfmeBr5SDYpY?=
 =?us-ascii?Q?adtOhkRw1RDlrzlOCnVEMHjtVJDOdW0ZyLV17MD+2J8G6+r7EZYiz919W8q0?=
 =?us-ascii?Q?70m05AMTxKR6UnRqVzLrLdrrWZQSRDmL8jaOm91+TAAYzlpUiDEn1ecA79QZ?=
 =?us-ascii?Q?7CP0S4WRcwBU3ZSCF+9xKhwDbjBj4HnjVWdT9ku3Djt2G8yfT8Ir2mnPSX6H?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad500789-73b2-4b6f-855e-08dab0fe022b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:43:43.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIJ5teZ9dq1Y0G0sri4pZQk3/6lc3AZj6vUTqAdv7bvcEOvUAMi3l9ThDP5h1gBU+rdfa8Kek6S3xl8O/rSm4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

This patch adds the multiple subflows support for __mptcp_retrans(). In
it, use sched_get_retrans() wrapper instead of mptcp_subflow_get_retrans().

Iterate each subflow of msk, check the scheduled flag to test if it is
picked by the scheduler. If so, use it to retrans data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 61 +++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e3def2cd5660..23184513489f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2500,16 +2500,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2528,31 +2529,45 @@ static void __mptcp_retrans(struct sock *sk)
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

