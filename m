Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9B1653
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF8HBmNFwEd660rnuBWvHngupVHqhrKXKG1Y3vf8CiAI4ekZFF69oNX5Iik80AnMEp52BPd5yMvKrd2/gvM3czgJsWfeVBJbZg3P8aseDtY9QdwjPDE09/jVI5rC/AVs33v4QcbGBpPWWbqU6aGaNCPDIumBSzuOS36zq+GXQVkP6M3n2nJHfynryDERTieettmfq1T5+7KYsFVcF+DIZRhVb08yCp5xxHukkwNEkTFUczlzg3u0NJHpX0cFJJg85V5lkLbHyOp9fN+gd6EZD4nv3YYEZChXNdsBNMOEerPIFTyn4dsa9ihrQtD3maiWZD1rWlkLAAJE6BKK2Kq4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlaJ0BLKLrjcEsyv3i/S7fsokN1XOPQX/mupF5lUveQ=;
 b=MBkfimnDlvAIwSddlPlGcOA63MJZXGu+xWisIZwBslpbjnE5oO6Yo3iVwb8Lctm3qAIb7s2Vp05ythJZf0HciTbJCfqqi+h6ppoZGqaqcmWujiQqd1iq1VS2W+/la8mBgpCeGGn2kUENt/uDpo4VlmlxMvDZGa5sVP8rmFGlbReYIpvZwY5SCpJfOSl6asu9ZcIfY52pvIZLIRzX64MecnNypmqMiHXYZGr3lZC0vDHNqHknQZM8zJyZIe4ENMJRJpTXiOJ0mIZl8+qtaRIilT+Fvgm/NvCBXz4QbzAtHQox2qUia3t82+LQrrM8SZ7meHh+anDbARo92YM/pquiGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlaJ0BLKLrjcEsyv3i/S7fsokN1XOPQX/mupF5lUveQ=;
 b=JpuLMyru5NZsrxPbvny7xmrgXkdHCVnPlBjYyeaehXQrPtDO1OIbVIvo3NN6OxqKvPEs8I91gA67NqVivnQwSVm03ittcnE1fgupIhyk/+aBF978N6h1WdG+QrwWGLcGT7CPu7QATmstjW0QIFp4Dv5bsaz8BfXVZHlncwsXM0s6c4t/RE10OsuCny+zyVxrfXSEfxtF8XNulNYOzBAr0qfmZ00J8t++QfeY33YmcAeu4BFGYQ1hdAKZNh2Ai2qZvyFHa7gl5FP0zTeX76XtynNFJUMGKcsy0/dzEKaeE8wBlCZMVjVZXrq3z/4YjQy/o8+yrl1cHd4br32zQkDWdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:39:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:39:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 01/19] Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
Date: Wed,  7 Jun 2023 16:38:16 +0800
Message-Id: <e2f1be45908330a2cebbde417144ef2880e810fb.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: a636d558-2e7f-4b44-9d18-08db6732ac22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Oq8luqEv662Leu06V5NQtc/cubT8Z8IuEmq934hkpHA5tr4Hr/pADhlU+269sHobMhbA2ykEneVKePyzEJYo/B/p2ZGv18B49CEo+S8g8Sip5q1LlEKovXhNTwbJAMOYJ5M8Hz6haj7GEBf+sOukzuVylfYjRwjOX8mbBPnODQfyT556CgeSFGTQheoS9cBUnD2GPC9GQ8V2myv0IIoYlGV1tI2Yk/URxyaxisWj/7x4MnVhXXE9wNnPa/5/beVEbKMkDopk0689bRHLChh2yr8tjTibk+MPzB/CyLo1ecllsN18mc86WmJ4TaQLalZYpI5qfCau98izDPArB99CHOGJjUlNvWs188OrQCOLzUC05jSIC+B/jkH5c1RS6pGtfhRhy0JtfpDOLOC2gdYlBUFMEzxCVMxK4BdXuhXiKY+sz08TwbdTDnlDLknXrGpp7RaQe4dZVMxMKQSEKghuyeCYTPYWxBIX+FCE8oEka9Z/a+w3zra3YXZ1LlUd9IRtkaXjBIj3zVfm1KS9/tvEXgm/MgsMzpGn2sdmVjjKYVwQkkJ3l2bhkokKe7lCyD1S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(44832011)(86362001)(6916009)(4326008)(2906002)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(38100700002)(8676002)(8936002)(478600001)(6486002)(186003)(6512007)(26005)(6506007)(2616005)(36756003)(107886003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nX7SS+sn34WzA0dm6wxSDtlj2COuqcqMekrVoyb50zlQHNC/pP0EYhq7hEq1?=
 =?us-ascii?Q?+oWRTwfMM8jXg9ugl4gDSbIzzGiVkf9gdqVwXYVB9CM1huzxKVciiUyXkiUU?=
 =?us-ascii?Q?8NYzLc2Crz/SZn8LuMjE2IH4HEpnhZcXVeXt0ceiLgAPmCrfHK7VrzLWugPF?=
 =?us-ascii?Q?xnqlLzxhpByD+IGzryXR8FuvsOFDtN48jM/Kf/qkOUoQxNF3U8PCyAKJgvwd?=
 =?us-ascii?Q?qXpLkKEONQUYZ0HlfV5VPtQSdEDstCX8WROH+b35eH1p2M3lXkGGka7azrQE?=
 =?us-ascii?Q?Jj99e8yl2EJIGyjyGXv9RzT9cfmKnHj33QuKNPkYhs6Un16n/xlVDWexoXDU?=
 =?us-ascii?Q?F/AGjDTIXGKpsUE5htnCjHpi5zdg+zWq3DyRMXxozidrU5cS5L1lYc13C4yo?=
 =?us-ascii?Q?2ZHPaiUkIs6Wg2nHsqeUd5XOwK7HRERaRaXHm3jJVmdazVyzUJAJTfwlWPeb?=
 =?us-ascii?Q?xLW1XepFKK6OfSvKYN3zREPvzRwaRfZ6gZqDUjpixUdzF4WHywEVqCK7NfSE?=
 =?us-ascii?Q?R+7wBMOIoSWlzuhumgcPLHTlsiIsF/8lM6UlBwLNOWCKG3+syK1qcx2fkh7F?=
 =?us-ascii?Q?1JiLoAruDaAKYj5R2g9rUvL5RnWmjWa3/k9ZNbTT9HArJvD3pRrRJ6T90gZ4?=
 =?us-ascii?Q?AIaRXWUILbwuyvEmp4lA70ujqUx4/IYxz7VjluNV0pRbA4X3M2m8pDY5Vn/O?=
 =?us-ascii?Q?JIYN3DJvbxEDL+jId+fAX61oNDofB3xrUVFIWAFNDuLddtDEw8qwEB/fVcTw?=
 =?us-ascii?Q?fwcVBE2Po4YbvQg+X9RjAXcEN6hUyIP5RgTnr1CRa78X2UlrsIAm64/KPQKH?=
 =?us-ascii?Q?uGg/uMCsog7JF3786RMk+iDcCU6PRzmG3N6syCw5TthHTa8sIySzvZPTrhWa?=
 =?us-ascii?Q?KMPO4CgATZ8R4+QU1SA/6KWdmjUKi8MLUdflkTBBOrKQDKFBw9lRRSYJM5GK?=
 =?us-ascii?Q?NAYrJI0yvMwkN0Uzpl8AAgtdUgkNgOUVLH+ArP3U60/jeHljt6cHxBgMy3rp?=
 =?us-ascii?Q?xp8vXXX+WIuZtKiot6cqetQdB483JlnE3ttLCbEKArLfMkwyBdyRLIqcJCnh?=
 =?us-ascii?Q?kiJKlQJEbm9qTGIswRrkM+Q5Y0l8xY9G6bdiwPOs39BDx7misOqKsmYAqXmi?=
 =?us-ascii?Q?zbFND1yZtK/GgOCSMq1+5VSytx5UeMEEIgHoxejL5YOHfF8SihqMc+vkYVMi?=
 =?us-ascii?Q?fskmFoELCmwR2pXqqeJlxGYgMf/dnnhrEcYwRwV59mcomcjkHLRHiIiTjYIM?=
 =?us-ascii?Q?SlzT6N3chh4JGhM4j4IdbN1QotxWik4sgDm/jF6ErAUQuuWuIw9TVW3aguFV?=
 =?us-ascii?Q?dYwQNmIp0YSqL8LkmWHhqflogRbNEvPQUY3EWHat+Ve2fZxwpqfpV1uizn+P?=
 =?us-ascii?Q?IM51uXscTW4UhXgeE6cu+lCC321WnXmp0yU/sHTaux6WucfYYhhDwaP5mzsi?=
 =?us-ascii?Q?Urejg8cIkxeq3B3obIw1V8eIyQgoox0QQHESoSrTqQQdqceBLRFEvwq6tqHr?=
 =?us-ascii?Q?y9l+6ZQogoQts34KZBRT3Tp8M9dXUX+U8UpQIzT4Ks4AftX+l92Z5a6NNOEe?=
 =?us-ascii?Q?TNB20anlSE4nZ/W095sh/j917P5Ef6tFfzKS5OVR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a636d558-2e7f-4b44-9d18-08db6732ac22
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:39:13.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/QipnOYAejA+CZto2GNGMpOvi/mZmqB4HNcf5nNTOXc/nDb+qeuSv9+29FxUxD1X+UplTnzKE2tZvzmwziO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777

Drop all last_snd.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 9 ---------
 net/mptcp/protocol.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2e9f72c1c9a..c52f0eb8c261 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,6 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 					continue;
 				}
 				do_check_data_fin = true;
-				msk->last_snd = ssk;
 			}
 		}
 	}
@@ -1660,7 +1659,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				break;
 			copied += ret;
-			msk->last_snd = ssk;
 			continue;
 		}
 
@@ -1673,7 +1671,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 			if (ret <= 0)
 				keep_pushing = false;
 			copied += ret;
-			msk->last_snd = ssk;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -2466,9 +2463,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
-
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
 }
@@ -2648,8 +2642,6 @@ static void __mptcp_retrans(struct sock *sk)
 			}
 
 			release_sock(ssk);
-
-			msk->last_snd = ssk;
 		}
 	}
 
@@ -3159,7 +3151,6 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..35dd3683f735 100644
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

