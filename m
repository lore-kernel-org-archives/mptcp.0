Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2079.outbound.protection.outlook.com [40.107.15.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A86257A
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 13:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnayvx5ICkoyncRkXFaFUdYpwpVx6ZZY4c/uDKusQf/8RTY0Ki3W6AKADySbd5gMUD+kLdvChqc41XrLX6gOYf4TSEy7TKmqky6KTEon8CFIKqG+HG/Y34E349OIhxxM/th03jKDr+vDU2/x1EqTgAXwfbi1CR0NzdW4Jm3leTB9GhjLS4TNLfN30eKvBmrdMQN73lOaHUcXfudhRk8KVgSvIKDVUW2ClJYjJH3J7tjPvwndSaXul8LfdtMOpVsFGIJddMokfwK5uig1T4+gWQ9Jcqv1nhXhzKte37L4Ddg2ZgA7vcyEpq0CSvYd2cchwComZEVkoDw1k0yWWWJlUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNdkSf04xJooTcmleaia12OtFegwG0+BCWISpCKfs/A=;
 b=iSF4VM4gjANfI/gR/v3PNW7nxNuXjMxcymiX1l54TZItbCRHZ08qElUtOjbM+BBCAI/iwrCUKI8tWLEjvi2g8SwnoKLGTZENLCnzmUuz0Zrfr8byWkDPTiJTOg1R1GqbBGQ83ctSGVDXN125nXjKOSrUo28XmpehF4xbhgwgY6UdX8woRHiHPdXbUOu35oF5hQhmXVvenwXikL2gZogs8uIXgUqh3sRPRJ8sAaWlvgSFHQLHAqE2RvxXHkaxY7u6xBe/LaYbpSOAs1HvQ5Z5P23Pi+pgWweME416moPpKqo6Gs76zuJW7E55wcR1n/IjAmxxN4LxczTBKmxCQM3cag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNdkSf04xJooTcmleaia12OtFegwG0+BCWISpCKfs/A=;
 b=SRZOBPvvWb8IXmB19243KLg96BhJ/AtB8SO7/1bMXsB0Lsc8RlSr12AyBU+xpE4E4uADbqrzfznW3xxN5cqDsEWsZOdSUlUzpTJtqF130PJn7yXjcrbJaNO05yk/UCXsVptLUmo0bDYLg3nQGQfO6v4EpnjU/eglET8Aw5/UZ5eUa09iS2pfRsezyYMnyH1h4OI2KcfDSiZ9z8khJktYa4gf8Ff5l5KEbs1ZYROHgxURsfgyzn3zqTyCUbn10bLxPsXCXKRzQMAwV10pHTR5bs0DzU1nfqczWvmnRxxnscbmqRFPDr+gFSGO29LvAq3AuZLrPFaUyhy6UOWRm81c5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7509.eurprd04.prod.outlook.com (2603:10a6:20b:23e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 2 Dec
 2022 13:30:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 13:30:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v22 3/5] mptcp: use get_retrans wrapper
Date: Fri,  2 Dec 2022 21:30:15 +0800
Message-Id: <9aabc1cc8a9bbdbcdd887904f1ebbdcc5161bdab.1669987293.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669987293.git.geliang.tang@suse.com>
References: <cover.1669987293.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 5221f7ba-f515-4bfa-0d81-08dad4696b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8RWO+fhhNJxd97rlhvCUVu3WQ5tBihcr/I0OXS6B2Mb3bGOIIVfk09Nz3JDR2ySigPXOjHldzS5bq3EVXmeYESdG05gPx7GT+JwL2UUviXjb+bVCmJcp5nRdDPdgla8MVyjPxVQRTHbRKv/GrJC1vkHGP+HeYFqtihVxcWm7xD9eMTkAkLQoi37qF/T+EhGMDICYziqCwmNpCv1wKN9kM8iP6ZN3CzpnwAZ5eQjcYry0e6ea32LR36iJykZX3dNt9ey6quW8As80mQfNf7CJMQDQxsb3PtIGkmEfdbFMsayQcYoYS3x9wkNia0P2WcfxLO3anLwV2iU7jRxS5XeVqeYlw4Vw5qS9LFgbKs0vlVlrAwf79QFWXeHvWlOjLGDMxNSrDOUQ0Uh0FsAqQj24FpiQgnU7CapvQfJ406+7GNeWO4ouR7PONHC821/VOi/FVHQsMbKIyL0f4LsXFbGHJCOiPc+TrqaS+m8h5BsmVjJDoeaofpf0QNgAxDVcbtCbdZhfpZWtAq6roVIaALFsePMMuSvguY+GBL6o/1v0+jORBEncoKSAdjHLaltPEApS3m2DS4qZelWq5ian8ncyG1DyJrpcQEO9JMbe1520F/b5ObhrDlIMRbgAHieMWnyt/bwD0ZrZuL+equqs6fCSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(44832011)(2906002)(36756003)(316002)(83380400001)(6916009)(6486002)(8936002)(478600001)(6666004)(107886003)(66476007)(66946007)(5660300002)(2616005)(4326008)(41300700001)(8676002)(66556008)(6506007)(86362001)(38100700002)(26005)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aM4/Nje3gVbtk7W4BdEBFHIIktEIe8tkg7PRbvqOd5Tb/TJ7yNFj4x5bPxsH?=
 =?us-ascii?Q?v2uvxcE+aYzY890hCOXrnrueOYsNnC/l7tYdzSG4Q6plHLgh3jbTXcuFQ6wy?=
 =?us-ascii?Q?g9q3M4Pez+xfPvG+cjhbxX8C2JFv7ZdHm8M4OxFTnyqNdwBn4PK9lPIUJRYg?=
 =?us-ascii?Q?eDzvNW/1muPonFwHp2AgyxmV6TjaR5drKGEIT/kXxzU4MzrV5bNNOQoKeRHK?=
 =?us-ascii?Q?8oTbGso3yGIEEQEFFNlgIeV4OdsD1h8f7Qo7I23gWGAyBMCNIWX7fceS1+LE?=
 =?us-ascii?Q?W6NhnZASi6xOmJwyiLTKU1Ds8OcFtEicVYqcYl7atfi4Dcg+mkYZDgHuIkn1?=
 =?us-ascii?Q?EBBm+FZgUA+NT6tcemtA4r9/RT88VZdgDhLgDfoekFegGvhV6shcrMnz4GvY?=
 =?us-ascii?Q?XzQOWzmUHUryRckiKPSKUlsKt3l3BpyaWMgV5C34V+rPDL5ZDfWD4EbjFvUl?=
 =?us-ascii?Q?NJnjKvr6Z+4+DvDx+rCBmZU8rlATjG00fpvoE2UOqkNHpI3/seUVMJQk9tds?=
 =?us-ascii?Q?x98aYxtj4/mK/nfKSGVyHWJjteaBAs4B9iatdVWTiKvtkn3G5L8rxhXxwJWA?=
 =?us-ascii?Q?nWbtb5+zxttpE2Je/gWTY+VSws+cPCFK9RavwlAN/Dg+Ev7C+AqUrgpAgvCe?=
 =?us-ascii?Q?2j0XrE8/idRRiZljQiJ844PUJSwt7O+HtE5O6l6e66BZzkwwND3GGbCx41mE?=
 =?us-ascii?Q?quQfaOliklXvWk70mcisbT126w+9GJmJhAa3Na07DlB3CtJgRl45iGK2r9kw?=
 =?us-ascii?Q?c6ccfaC3vcVG9kabcs3C+8B8fHUg4WuLDOQAvK8MDfYqRxHjIqfHh85UDKJc?=
 =?us-ascii?Q?fmA6eYYV7H7jG7DGpYJZOtdY66lRKWVyHsAwC/9e12ncwwA9/p58XQz2qF7f?=
 =?us-ascii?Q?3/NUTPB3oJEn75V+PgI5j2u7hWlxfgGa64FAducAEzmzEJECHyVc6u5BD41V?=
 =?us-ascii?Q?UBgAPviiDsWGgsxydpq8ixlP57xYaz2WKR4yiKzZt3B3jlkOdOTgm3pg2S5u?=
 =?us-ascii?Q?YdUNDKA8xwMSTNoZFQG9aXvjbqaqIVKMtiLncZs5DOYjJMJAaYuHLdiVMC4L?=
 =?us-ascii?Q?S7FTvWaE2TfACb/cuhbV2UEY+m+ECXKS2PEb2yUfLbvcH4IbmSHM2o64suTr?=
 =?us-ascii?Q?fDM9ipCeS8JvWnJ0LgbY/3ipi9oVGruSsaZXVc6a1ePZxMQG0QyZXOaHhl06?=
 =?us-ascii?Q?FTXcMMZUTqSTgDMO+Qp9aDKUOs93DKq3DhAjMXG2jgSiDBN0JMJUPiYY+XSM?=
 =?us-ascii?Q?41dwXDFUvQeomHAuFMcVAq+ksAJKMaHUYKSyGPtbz80I+ZvmCahWqj85I82C?=
 =?us-ascii?Q?GngWcwg8BxPiRRRXh+k1w8d1BkO361oPrOlU1S07YdB9dFvmxEseLk9Na+RO?=
 =?us-ascii?Q?R2E80ce3tDWmCnLSA/cSlZ4btnGGBZz1WqYXUX/zE1PY0pKv0MelQSTSQR/w?=
 =?us-ascii?Q?fkWgIOQjNI2nbnEn8xlhC66Pl2ej5OEMZ0an1C4XyJrDM2b/wUbkhvp/T/X5?=
 =?us-ascii?Q?vHcGUFzCHVO9NQIwzKPhRIVrNlBEaDoFfrWq0TcgpdvkkYrCmyur3U1XJNSn?=
 =?us-ascii?Q?M9HGuxIhms3fnSQngqyvEkCRvfcRh0ss03/Sf0b5EZufC8YULcjXWo4UB3gw?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5221f7ba-f515-4bfa-0d81-08dad4696b6e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 13:30:46.7875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MoMiwF4Gg5ybji4FJA4anYa6HouF/5LKgpKagNZc4vrCsT6IfD+wE1+JLs2869tbcWACxz6LShD9w4V1piL2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7509

This patch adds the multiple subflows support for __mptcp_retrans(). Use
get_retrans() wrapper instead of mptcp_subflow_get_retrans() in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Move sock_owned_by_me() check and fallback check into get_retrans()
wrapper from mptcp_subflow_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 67 ++++++++++++++++++++++++++------------------
 net/mptcp/sched.c    |  6 ++++
 2 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cef6086c7f40..7d7048b0774f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2254,11 +2254,6 @@ struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 
-	sock_owned_by_me((const struct sock *)msk);
-
-	if (__mptcp_check_fallback(msk))
-		return NULL;
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2528,16 +2523,17 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
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
@@ -2556,31 +2552,46 @@ static void __mptcp_retrans(struct sock *sk)
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
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 18518a81afb3..c55f2f1cb7ac 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -156,6 +156,12 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sched_data data;
 
+	sock_owned_by_me((const struct sock *)msk);
+
+	/* the following check is moved out of mptcp_subflow_get_retrans */
+	if (__mptcp_check_fallback(msk))
+		return -EINVAL;
+
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled))
 			return 0;
-- 
2.35.3

