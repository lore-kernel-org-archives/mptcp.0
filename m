Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4D1FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwNlPpRqc+GIH1L3/VifuPwZFjPXzwtsSPq7xdDXL739YtSLoCAHvz1nvJ/DkDOGy0zBZ85a32no934mBMhOpsuI44u9WEEBMkMp3HtNYNi4Xvsj2D8LyFIi6nMfkCoc+ODbS1U6AW5LucVrkCRouMrj9DxS+px1/Hea9yrAxJXKuZk/Sw32i5iN9SSxdmm7q8rJl41uz5xBTUX3H444vw4PXg1AfpO+1WDwSotUtr4UxZUSqiTbYL4+ySkKkpi/GmGO8GNR88Nv7pWfJ1K0N+Oj867BjzByYt63U8720abJM5ttr78EdOmNtcVuKmVqJYadNxjx4E+PHAblOhHW2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hBf4u3g1ZoMVunEVwziilOUKOwUlliu/m1DsvKtvms=;
 b=m1JhRhKdmHcsNcG1+wNyJkMNnIGufWOREshY3zf248omxY5EaQgtjeQtcH2FfH+w9YvMtq10aNDw12EQRx9U6rs3QjeCjBo5Ot7axKyt+RoqPlPYq6yDDM9KzRmyORv1JyH/oKXML3qRdTv39aNlp8zi8iba0+0x1ACTVOpfKZu2cOuoBxuVuRRcGvA5lR0ZEAR2VCi9MNauNb8a6TE1BgswETwsQP7KVgFHBhuz2I8ruClQJ1bN4dTz2KyYfCFQ31kdCSs60TeSPHa3v6t2lp8lzJUesMCtaA5xQByl0dxDO5t8JJ1OLi4z3k1PDVdh5WyS2uMEjksp2mFvkTyVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hBf4u3g1ZoMVunEVwziilOUKOwUlliu/m1DsvKtvms=;
 b=HSV9SDWdQ7SfN+D/jocrdmObp8D595iW8YLDTtyflubimSFTrl47iIRQNRi0Yj3Cb6thZ6929nb8nssczjm3fhZIXDGYbRtxQTtmMldN69rkfc9IaYPe8dF3vWRoVyGnW/+riIs562I7YSj03UJKXshrAnGDxl2Dxd2LXZzqZjAzCiplTR9608DXlAZ/fwOATpepE4hiJcChacptJYZwW1AcGGYqGFCiINuLIBjeEp9zdUbhYSYFHv7F7GP3zWihqfnZdBWhOL9HBh+yr8C+MJ8l4foyfU9/KwPGe9Hqjn2IAHNtuZQG4g6cK8qtTXqY3hE3/GwFMK8EYjWVCblFtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:54:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:54:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/6] mptcp: redundant subflows push pending
Date: Thu, 23 Jun 2022 22:54:19 +0800
Message-Id: <7845ef0db19df1d87225b22911dea3947792c711.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0186.apcprd06.prod.outlook.com (2603:1096:4:1::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9cd16d-0b7a-41ed-d981-08da55284e17
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299598BBB2E07EDDAAE9DD0F8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NyB2xRe/WGObNmMSExq8Hh0s+quSwvJ15pzVq3IWyuTly0IsPVxEmN9cZcfu7A0ww4pNEz06GbnKOY4NhNwE9m2J44DrnWTm6zOQzO/TWhk/oE/9we6R5y/8Ssa3tCKlUKXWEdP14Vi6rQE5MrK3ckKxQOI4EUDoACKtBVqUm86Nb8C2308k962lMqDTgiKNBfq4NwkODZKth+5B/duhps9qlg8nzR2U1U099PJb4YmiN+hBpBGWR0B3Wfy08aX6XDW3xzOLVXsxCdpExgrCClxhMZ7bqkEbzslwWGF6C5Re4k0oP9WmxnWh136swMx1dPNzGpWv4zZKySTiA0RFVcAiYRIERCUaZM8gAIwIqAkz/9Xf6+a+F40IHl64Va9B492PVUfq0DUFjqubsRUXCaHTDSDWC4uFgDy1h/20D4iYf7gmjQ+1KMyTN5WZWJPbMWvgmfgiLDPjLyixV8r7nobZjIcRGz8WRF/yZOxrE7g7WQ94nJLODFFTSP1S2JlfURnZ9WXPgMBbWmlMjp7sTyTm/GZXFsWSJ/Cu89xkM4apZBYSKuJJTAkXEn6hsB1ogujIMn9YhmLb8lZvvZ/ZhBYtUi+xFc/vmLPYujgECka7bV7E1Xa34B02DFpQyQ2DL05qSBHX27z2gLcwXqh4UCnDNFbFh0kqJG0jiFPgSs7XLIZeSs0Y/xW4M5Ie6OIi7QsrVQkW02UZnGVciOXu4/dva76kdwiGR6/mgJaZKoWUNxEZewOcRzm9dptELrbh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7YtJO9slbuR1ey8TAInBBUYmZP12YW/9I3TdZFW27C6/RE8+/x4lFF3RmzuB?=
 =?us-ascii?Q?WMbbNCHMVEbqbvQ6DDai2NOrRKpgkSUU8k8JbFGI9A4PTQQSFaymcHdIOPZg?=
 =?us-ascii?Q?Qx5ow2ZnCdYSWrkUMz4zAOXkBYgx9urStWycKsVkYLeXD0/fLHSHGttPvOhZ?=
 =?us-ascii?Q?QyLoDBFEMX6cfge6kSSXxPqy9CY0YIJQeoCkHbx95DhngsmFjzwOZe28tqbw?=
 =?us-ascii?Q?bcspOV8CLJIsRblJJweS1h/vPl3pIZFxijTkbZHADsRt1lSzXjTeOD9Yqwru?=
 =?us-ascii?Q?wSu7t+hyRfuqcqTYoHE14KFWrKhMxmTGEO35mcgBhLzAi0Yn/N+GOGKAWTjy?=
 =?us-ascii?Q?t7cmbxPsBRsqRhbipwaPN0FIW8Xx2qN3zKIfNjXkcq8ddjmVZtV8MgoxREEF?=
 =?us-ascii?Q?yCSj+zSrL0N8BrxNXGKU1sFqOiElOfb156jT6pIO7Q976K3Q1DJrds07vM95?=
 =?us-ascii?Q?xu0UzpubIX28x/jwnHvbAEZfME2z0EzBYe6zBzKphO72VcrTsMfUV6R3/LzS?=
 =?us-ascii?Q?oijmQfUEKbNt75jJ7Fy1slvKfl1ZQRstiKSJzNYx7JUUaEs42+eL7bf5si3d?=
 =?us-ascii?Q?E2F/3zKbxTsJD2p9pyq22pKDzClamak44M0hhDAHP9q8jvS+NtqQc6Y9lFHK?=
 =?us-ascii?Q?h/sX0XH3BVtMFiJ1A+xJa3YR5PDpSZ2CTbcUA9BeQCNlgPcHPIP1FQ2O35+Y?=
 =?us-ascii?Q?4nJz67vbEcCwwEfL0uPM/OO/ZHH9acPOeC1bylUZnODqeVg1oFMGl/mjXssF?=
 =?us-ascii?Q?PdCzGC65u3cfb8ie9kJB3neJzgJg2C3AYqqU96Sr56Pn18lsyeZ6Zj2nksiD?=
 =?us-ascii?Q?/vIAWr36gUEAmrxbpMVZWq1jgH+ClZEpGpL9MDkQrZHRhnwVf4IuRNJ6hn+K?=
 =?us-ascii?Q?WG8sPO/ASVOZzrCZGdzK4opbWBkLXVulEh+3+/kBWYXst3H9juTk/uFQhyRW?=
 =?us-ascii?Q?4v0D7j3HziTqMCyUIPXCTesxG7rTpg3a0l6rN2Hd4uAap4rwNQ4OxiEu4Qv3?=
 =?us-ascii?Q?57VUTCBlqLgKuxDAcYwJ33jEFFUEcW/yHGFpP0OAZU71DqINLeGDd0eNIIWw?=
 =?us-ascii?Q?P6f+HQ+bPzPs4wl93dPyx9UGreeVw/KHvhImSEbn/OYXvJbSgaQCwKq8P6MM?=
 =?us-ascii?Q?LH7YLTVREfRSH8Zr+l5Gpp69N97SLakzdg2YWKpRX4iFq9l35LBFyzEcKBP6?=
 =?us-ascii?Q?/12SXhCuUHqd7k3+95YL/VYPY8VYCjor59Yw/fa93i3IKknhxylcpo0xLuGi?=
 =?us-ascii?Q?cf74IGrVWRhpFww+I+uTWfeMOOjUg8H8QcGeePNi1RoHB1qSFCxtRf80cYuV?=
 =?us-ascii?Q?h8WUFgLNs185OMFpQ4L4TmURSe11c0v0C9ysHaNxkvd+D+pafXq+AOzmm+cf?=
 =?us-ascii?Q?pt7Mre6+tNjM3bEhZpHNN5DxBLtoefUxaCUlnudkiz7yvVkeievJLlVn4ge7?=
 =?us-ascii?Q?G3Kfd1CSeKifhNwOCBRYdMtSjgAkXPMJgHMsgJlYwZsUFnxhoKD+KbSmNGWo?=
 =?us-ascii?Q?qmEmZ+n+qnuwLvSHZ2vUUK+hwGinEtKa1Q7bx+3xGRXFb7hHbzQJIS0iFhKv?=
 =?us-ascii?Q?7AiZYy9Eqo6Rhx5a+M02Xc6x7pCK3BxbdDOir217jMWghUlONtfbbLiEWViG?=
 =?us-ascii?Q?HKRJONAP+mK6RVpno8+sXFQqf6llLAZHAqD44sHsJKrZYC5TqVjQYD2ZlsG6?=
 =?us-ascii?Q?DBPTwDVnR9Hpm84N2CzWXd1/0lc5gr3zNmJ/Tlstjm1jS2x1rZsNiVI9R3ag?=
 =?us-ascii?Q?bHobZoCeMS0Llz7d2G9AfSEkDGn2Vxc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9cd16d-0b7a-41ed-d981-08da55284e17
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:54:42.5147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnphD+vo3q3UxuVIgE+9utT3coL5tYbfa2VDzRsK8a2EA8bT6QsyxNYCxEFZZlx21YK2V/+KdkecP80Yx5wULQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 98 ++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 41 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6e44786e01fd..d09b01f1dc29 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1516,63 +1516,79 @@ void mptcp_check_and_set_pending(struct sock *sk)
 
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
-	struct sock *prev_ssk = NULL, *ssk = NULL;
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct mptcp_sendmsg_info info = {
-				.flags = flags,
-	};
+	struct mptcp_subflow_context *subflow;
 	struct mptcp_data_frag *dfrag;
-	int len, copied = 0;
+	int len, max = 0;
 
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
+	if (!mptcp_sched_get_send(msk))
+		goto out;
 
-			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+	dfrag = mptcp_send_head(sk);
+	if (!dfrag)
+		goto out;
 
-			/* First check. If the ssk has changed since
-			 * the last round, release prev_ssk
-			 */
-			if (ssk != prev_ssk && prev_ssk)
-				mptcp_push_release(prev_ssk, &info);
-			if (!ssk)
-				goto out;
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled)) {
+			struct sock *prev_ssk = NULL, *ssk = NULL;
+			struct mptcp_sendmsg_info info = {
+				.flags = flags,
+			};
+			int copied = 0;
 
-			/* Need to lock the new subflow only if different
-			 * from the previous one, otherwise we are still
-			 * helding the relevant lock
-			 */
-			if (ssk != prev_ssk)
-				lock_sock(ssk);
+			info.sent = dfrag->already_sent;
+			info.limit = dfrag->data_len;
+			len = dfrag->data_len - dfrag->already_sent;
+			while (len > 0) {
+				int ret = 0;
 
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0) {
-				mptcp_push_release(ssk, &info);
-				goto out;
-			}
+				prev_ssk = ssk;
+				ssk = mptcp_subflow_tcp_sock(subflow);
 
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
+				/* First check. If the ssk has changed since
+				 * the last round, release prev_ssk
+				 */
+				if (ssk != prev_ssk && prev_ssk)
+					mptcp_push_release(prev_ssk, &info);
+				if (!ssk)
+					goto out;
+
+				/* Need to lock the new subflow only if different
+				 * from the previous one, otherwise we are still
+				 * helding the relevant lock
+				 */
+				if (ssk != prev_ssk)
+					lock_sock(ssk);
+
+				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <= 0) {
+					mptcp_push_release(ssk, &info);
+					goto out;
+				}
+
+				info.sent += ret;
+				copied += ret;
+				len -= ret;
+			}
+			max = max(copied, max);
 
-			mptcp_update_post_push(msk, dfrag, ret);
+			/* at this point we held the socket lock for the last subflow we used */
+			if (ssk) {
+				mptcp_push_release(ssk, &info);
+				msk->last_snd = ssk;
+				mptcp_subflow_set_scheduled(subflow, false);
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
-
-	/* at this point we held the socket lock for the last subflow we used */
-	if (ssk)
-		mptcp_push_release(ssk, &info);
+	if (max)
+		mptcp_update_post_push(msk, dfrag, max);
+	WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 
 out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-	if (copied)
+	if (max)
 		__mptcp_check_send_data_fin(sk);
 }
 
-- 
2.35.3

