Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499D28C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzFeQoZfVVboL/x+dCkRamnMBD0muJ2HAaHlgymHgjFntlFTJ645FB2kXIfNEP1dxTbOiL/g9tpLXw2i48en48FZG+WIh6II3oMSt6jj5Wxz97B2B+2OVQugb44egWB5z79rD4EqJUyOH+2Sdq2rtlEQrl9000zpPS0OCnKVg6bLbvkfE0N49CaC/5oVaDI9UckRFJ1OVJBhkGFXOjVuc9lwkDA9Q/jGVbibWiFYkJ2L2OAuQUvpLtcjfD4jhzbpK7HV5qwxP0qrhitNBEIewD6Ds8J0cVKeGm5CR8trCvSbbhCZ/kvJEH+2csue82iwvmdmFLN3S8m8V7A8/XNoTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=S4I38EjCBX5gB3ODFPaHqb7vbu2f/81ImIcw0EnKxxcepptcAUSiazIabLpdfCnt186rTb8Hwne9dhFZRv5/l4vOkkI57wHvo7FxWvOZnaZeXiWsu4mUSx6paA6ua9E9YSeIkbTK9D+jsSytgJk9IL4pvPd/Nn9J24Jx25bRUrG5W8Zz+f6zu77iLDaZ+/IchfNdqB2205hJ8/xiZG4h/YVkSjjgl7san0jIW4AKGXeJE4WRcW7e9FC58GM+il9ATNqijE+uQ4FM2sa71a2rfGaBr8W7ginGYnbz8vpJ/oJBtx/QyrMWpEhJQ5rk/75cPHfKold5rXAw7PdYwI8wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUPII91VbbbH5WnNXqpLx5RZRasL80tk7pFYPDg0jNk=;
 b=ecIqTq1JLHCeZNY2H9zQdBL99fda6QVjX1uqPvnR/1ngLTuiKChODA2BMLPwb2OaSMXs/MRhO/MijxmG60uwB0Wi624DJoa3i+xV1ouRcwvvXE1SQh3zPkqKMTJmphcXBIsi5Pom3FMoQRVM7MNV4fOlw3cSTs7kyzorn59XLwVKkZVw8NNfnlXNNLpnyyTn+sVcVswclVRT9XR+T0gmHPCQD9GiDDQIB5S2WqCb9N6bY2SXCBU0igQies+pq0xzqhgou364iYkll95EgY1cv7TPItH6k+3dOWxmJKRKdWadlMQvSmb7PvGo5TlXU2vfkoIeSwdaME/fqCYRChA6NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:00:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:00:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 04/18] mptcp: add last_snd in sched_data
Date: Tue,  6 Jun 2023 16:59:18 +0800
Message-Id: <6083739fd4916a0e8480e896beeff0fa02d2665a.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:404:f6::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 5715e9bb-ebcf-4e79-8722-08db666c8041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YT0grzx5htgUo1yBtxVUdGyPS3QjZXghKM48NorV7/XMhunkdq8z5Hh3Eg6qtutWsyBdRJ8aPz6IneL4C/m/4WRv6RDHuFjO/NA5UsnTr5/vNviNr89RqN8tAbfW681iIB0ROXLghkqYpY1O3Rjqa+3lzJEDAnbkz58e99Unh/8QWK12LKitTEq8c6ABVxiBKUl/jTTeqYBxbBoA3IuvoIGy3rJjtOAJdfg83k+Wlg61Z3RrAXfAeJrA8E6u6ynmzn9um/AvlteCl+ffiRixtA9uzjQk9u22EGEyPWSycENuv92WNeZ/k15eRh5M+H71HeXqjDlhC5l9CTpYu38bRhWbNSrTYF/vP8lBP7XjaPyd79AiQn6CrJQocAIA8OTBpkYxxRkrXBXkN+qsLs/F8pxU8JAEwlLVkO/PIAtulX6KdG2Xt9aU+ABSuX0ol9CZrwjPtGjDMq9bgpYcyGMRv5zfuezxKOeM4kXwccm4jORPKDvuoQWJqeKoNJ6Vn4E3MjO2zF3XpiycysiTgRz7+fsaKDWOcFKnFGfpsNbNfb3f1Ak8nLJos5kK8zB2240n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2ja3naXKjyyl8URP/6brirzECvtXdb/5q/jLEQi0SOVOrtZTx2ExgxehO4s?=
 =?us-ascii?Q?QzvY+8DhKnP99VO0gToyX0evwCiTWVatTxZ4yFLUYTOGxw6zfPW2niEDYgUI?=
 =?us-ascii?Q?7kyKfMZFpiBD6QjAR9te2zg1OOm5Lvs+KmwmJKTyHT/GMPSBB6Fb6aLvBg6f?=
 =?us-ascii?Q?ce/ryJdcZO0R8OvarhhNuVBrgF41J4D3xcOS2FrQIr5gw1tpc5oMXJ1nt3/z?=
 =?us-ascii?Q?2eN35n3l/gX0N3MycXx5ZCDK6L2Uu/1TsmCqYsphwBQvN4CrPu5y4BLY6n5M?=
 =?us-ascii?Q?m20VLXIF5KA+hmb3z1Bk0Yzv1+WfF+GDq2qWA1/WloJ6fwLKvk2qr1tukE0f?=
 =?us-ascii?Q?EQZgEY8mREckmJpxR6CGy/fw/OldzXuf5TT554qktmApHZNhW1kD8g1ZSVZl?=
 =?us-ascii?Q?DGx4TgahS8sSUT1EwEw2lcYWJsc4yb7YL0BlR8yDdEidot49H82ED+9FRsXm?=
 =?us-ascii?Q?i3C/+4nzCUTUWlqdS84p7uAL1ZQ6EiUi0YahLwhI0ewDAaRIL4QVTVUAz3RH?=
 =?us-ascii?Q?sfYzXiqQtXEFPP1q8Bcp97wSg4j+m6Tp8N5O2qGCmAQ5+72AAhEPNOJs9nKp?=
 =?us-ascii?Q?s2tgP704HBVdHoF5UpFaCmxuZYaJr1sNTumq54izWzPRDne1glDoApZhkT+f?=
 =?us-ascii?Q?yT8l9qLaLR6YPkZL9vonzHM0oNMyJiyk7PJoga+9NgXqrm0OwmKlXVUCf63/?=
 =?us-ascii?Q?WCaWDqyHK1YTlr81wiuK/ix+daL3xUyBWNX3iaFt4+ikB15ZBtaBTSNpNzkL?=
 =?us-ascii?Q?zObbioSU/iXNfgcUEiojfTarQh3JCsANtqOwiVbkOQ8ypkglpTvmuB7540hC?=
 =?us-ascii?Q?nFx0f4V1JvOjFT2VH2s1aDueRLjWCBset1Zaa9fmlgMei93pF0KWCLt+7D5j?=
 =?us-ascii?Q?9Wogl0Y4KGoj4ObSBQalqeVEKI5JgX8XaYrkiMVQMmrEPrhsZXZsGdGWKVB0?=
 =?us-ascii?Q?2xXfLa/EboR7eolitZR0RWOIREGlVRIZBOzmvdEhkcZ7aLeKryKIFy6Fa0wO?=
 =?us-ascii?Q?SvP673urXSPe22gQyuqQRceurt+761d1fE4wvZmkpwKImt2yt1eVoiQYIiNS?=
 =?us-ascii?Q?7PMBMZd1KIkNVNd/N7aGDuGgyHqQaU1ZSlCz0KZt1Byn0kC1s7F1FE48Okdi?=
 =?us-ascii?Q?D4eDo7x4pJijwIzUz97Sant9fz+zEJD7abZiLh8PZmDGOHAK6Os4So0AkWb1?=
 =?us-ascii?Q?O4G0Micigiq1r9IutTi/eQymueedlES14KxVV2TFmrZzF1JrHOx8ImFBuZax?=
 =?us-ascii?Q?4QWJ4dPbezxFfFWhbpH1hU189PWkm8DvdfatCQjxVezjSnYzB/qHNiZ3UhBj?=
 =?us-ascii?Q?exq62SePd0FWMwiv6w8mm6joD8l4ecCnYbbdJywCdHuWKxbUGDe2EyTAsevx?=
 =?us-ascii?Q?xqdwcNxqYWK5xL3PSggSLC5Ht7GJaS0gpJhU5ugq0SykYNS+LSa/IWW0PCj1?=
 =?us-ascii?Q?U0l7BAs+Uz+GujorAppzglCOgjic2DksHgNvq5TxpW0vGF/oXPwrJ/Xiikk0?=
 =?us-ascii?Q?7bkGCMcmxcuAfJsrEiac0DPYaMVOgS0l4d3CHO86rRXOR9a5AbE64VQETUKd?=
 =?us-ascii?Q?5WcwjO4ARInS3yU9htvPDlXJCct++pyB6DZHvg8p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5715e9bb-ebcf-4e79-8722-08db666c8041
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:00:40.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljQ25em/pzNXVy1gsSfw8DVd+jLSrj2eRTkGiLl5MxyTdmG77Wl+2Axxh1FIyKLbe13PH8KQ/Gmoz54jA7bRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

This patch moves the member last_snd from struct mptcp_sock to
struct mptcp_sched_data to make it accessible to bpf schedulers.

With this change, msk->last_snd should be replaced by
msk->sched_data->last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/protocol.h |  1 -
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 4bba29c99172..d52aeb8b4485 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,6 +100,7 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
+	struct sock	*last_snd;
 	bool		reinject;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 380b7335618c..42adc14a073e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
+				msk->sched_data->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1660,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1673,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2466,8 +2466,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (msk->sched_data && ssk == msk->sched_data->last_snd)
+		msk->sched_data->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2649,7 +2649,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 			release_sock(ssk);
 
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 		}
 	}
 
@@ -3160,7 +3160,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->sched_data->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac05fc317689..949f46d4c710 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -269,7 +269,6 @@ struct mptcp_sock {
 	u64		rcv_data_fin_seq;
 	u64		bytes_retrans;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

