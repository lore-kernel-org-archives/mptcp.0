Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658A46B6
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lu8XxbMbbJCjGZFvhWYohlvJueL4jQRJpPHswc7vPqzs/jmA+tkHBJfQxVx+Ii/qvJ33a2AeD7bJ/QBMODZ09PSibL90DWWRSv5jJT+PiTm1zdgn0JXkGqDKQHnmlZBWgOWyld1MzWjeA8UvTTbyEg41cd54Y45zEJH1A9w2E8JpcNVNGU/qqO1ZSU9SKbO6FLUkLswimTY3v9zAxDeBWNRRDdXQLs9EiexV5ErsEfqCPL7MYcyX7T+uAPEPsAw8ofxf2v7WYzXv1E6u0sNAMrnLmeFQZHtZQyhznPt5NE2PN/PESKcyy3oF67lvGqI166lp15m/2fR4kJKUU7i6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlaJ0BLKLrjcEsyv3i/S7fsokN1XOPQX/mupF5lUveQ=;
 b=WaLumat8JuxTfYwbU7uHlfhsoyoJnwTYcVQDIzxJP58RxSX1ceaK8iE3KnT6aAl3mVLwGGAD2EPgU+i+BlmePLAxy6m9cNKstmGuD4CwViU68dmPENMtHEM2PJYOpzFFpIv36f0Z1lxXSIRAwAgvYPmt6sTiOIbcjP0scgPnddLIbQN6sT3sqNnw3Q5v9aly/51YJl4uJqeXKfgIR23SZebCUFXD1VpkgM0xkg2XHqqaQWhngNZdMByN8oClO+G9WhEuvL7ClfJhQ2VHnkNpqT4zFeKjTqOU851BsyJAI4fMZlo+lrcPGH15jb2Lq0Gzlr5M0fjYlIiDWdRz0unBxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlaJ0BLKLrjcEsyv3i/S7fsokN1XOPQX/mupF5lUveQ=;
 b=zVa8t+fK++WI+OGyYyQg6l6bi7nmBUUJ04k0N+UXvkXXCVZnK6OPoxGAJCxZmlRRgDDQ5mPcMJAjvrj83YOSppD8fCK6TTJjlP4FShhLpciUx7piMFTBS9ecfC7mmgUHCA5WaY81Da0cHKobpngYH02Ts1iHo0unw6xZ599G6JLNlgvn9K3qbX+Af8jMSKySeH93XGepzNjc5rQSaVHy7ugdoFTmmjQGOZRIzKysjmvxVnBVSTRiinMGpObsItODI6IhQCp+OTeB5pt8unQRYsOYxqZj7MStUoL4VxgHsbEdrL2+MbJAdA1nibxcQ8lWWCK83T52pnCyMTUHmpCPrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8609.eurprd04.prod.outlook.com (2603:10a6:20b:424::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 05:47:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:47:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 01/17] Squash to "mptcp: drop last_snd and MPTCP_RESET_SCHEDULER"
Date: Thu,  8 Jun 2023 13:46:39 +0800
Message-Id: <c0cd0d913a6faddc707d2d3d7586bb577cf0b41d.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0126.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c687ac-e909-47b8-3fee-08db67e3e488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QoPZZrdUSR4JjsrJZlPYNQ1BTWFZU8gctbK5a2pCUhw1QZdsGEJiScrqAgB6uXOmXaWqBvPpi/MfRbUMAwmdnFSmOC5PQ+ISQ0U7B1nuqqMkfpSOM+nNNCgceZE7meJqPfJpY7aRPox89xM3sY8yNEHsQ8quCGFQqAUiESm3IBNx/lxrQ0gYWw6/IWeUCbCNtZa6KKD9HpS526OKxj61NKzDzxJCRlum3qSp4I6wedDDAcrZdx0t5iCEGb/Z7pBoAoAPQP8Fw4dUunNq11hFtkvcmbsd8iTp1FKoKyxRzwpg1YrDkPh1yOo3obOlD6SMwB3nE0fuXwLEvmldZdJHivDFnXinyMOlVAArUoTsIHexO6+ny828hCioYQQZbo4mHqycX0ECZxEOZIrXUn78oO2j5DpqQtwAIIM9fDrGq4+ZRhWorAy84H8wIMsnlALYUTFfUyt5IQH25mVhh5UKdEV9qibMp8PVs0hQwT4QS6uyjGcnwvqWgWvQ8+zXPKKz7B/UYzEBSpEL+pewU3vr6aR05PUNBH1uciRKUuJRWHUZ6MiddJfOXhMtVr9SHCaX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199021)(66476007)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(6916009)(478600001)(41300700001)(316002)(6486002)(38100700002)(186003)(26005)(44832011)(107886003)(6512007)(6506007)(83380400001)(2616005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6JLu7EgMGoKYwfj6BCe4F3f7YrkVTfGGPanWJGmodLmCub0FyOmB0a6tZs5b?=
 =?us-ascii?Q?Vnjv6u/FFAnXZ+IbfPgtctJOYIEbJBugqI+ErUL3jVJXbj6M5uWAz9f9gSsz?=
 =?us-ascii?Q?GIXr862+fIQAQwTTaUKlZf80+xRQbQh/o70Uv3Q9KGV7IqUBRL172DomTU0o?=
 =?us-ascii?Q?p+TKu29LkA2ENG6oetKGQQXiQy3sK4Y6I8wGrCAU3vqxBQhj6vsDSQPoGe1+?=
 =?us-ascii?Q?Oi2xWbcdwuFdc4jVld4JtgfXlxMmMkgz1OcaZ7iiLRN+OCO2r/4523RFAA3w?=
 =?us-ascii?Q?4nxQzwHxESywYomL+J8DiNhjyMb31atMwEsnCiay7vgiCQCb8DutosNkSRMQ?=
 =?us-ascii?Q?7doLxo/ffmp7d9uCJhbWH3VvRR3UAiXB5W9gWxKwGot/tNymI9521bh6gBkO?=
 =?us-ascii?Q?PRBur6aQJjZYbXFeow0Pg5Se/YR3C2Fbk+Bxy83x7v+KZ44cH2z29Lc/bNQm?=
 =?us-ascii?Q?eQT+GzV7uRqJaz/Wa1SsI3JN9I1In5+X9YtzEqYBG9/snfp8ZEXOfcFofHi9?=
 =?us-ascii?Q?shYJuouhT7Cw5x0MFE21L57FoeJFAZmCVSH95Kr0r4nwEJn5owZ48DLC8G6P?=
 =?us-ascii?Q?y/OC6/woxIKDUCncDl2r0/bqvhm/H4Te1Te5gjOowwFo/teV1+DzX8IP+RsH?=
 =?us-ascii?Q?EsQl6UJ8p7X0txCxvtvGE0eTX1ZtzUb81UMOa2QYgdQZ+bKtxN21dCt6ONai?=
 =?us-ascii?Q?cReC8z3E0mWcgJAqu3weFM+9fw+Xt3YEybJNKYCt5Yy6jR2c12i1gSwt4kgA?=
 =?us-ascii?Q?uZlY1/hNUuH9VJoWQbc4vX6dRTLLbE9Vl3+FfrKsMaKtzBNstr/tINbR96p5?=
 =?us-ascii?Q?TG5z//TZmFF8saMrxLxHWkNbPBm3QbLJ1thfx6ellXojzhBXiQMFtEW+EeQo?=
 =?us-ascii?Q?lxfPnURGbZwXaYmTl84IrqRAG6RTIPK8DmWOe6CZUbSqQp8jeIDRs0NVMmZ7?=
 =?us-ascii?Q?3U3YSvP16SbfdVTvkRwGydg6mV2kGOr0D8nEFTJTQzcFYy5gMuqfH8YUhkyU?=
 =?us-ascii?Q?bm2gbuwSuTQbiyt6LPyHmohTM9ySzT6UYH3ZWqr6qgHIpuyHS4gOy8bNifIR?=
 =?us-ascii?Q?dn3HLTpZIWclrnybkAk2IUoBS8gDSMjqulHTq+SK8Jf/z5dlufapC0FuM4uF?=
 =?us-ascii?Q?bkcXNndIm9ieF4YJcI7gyM9N4yf599Ug76Hdi42VyHa8uP5JXnarNrLzB+4W?=
 =?us-ascii?Q?IbwJxWDYO8mKw7SRpVJQKCPfAZGaqBotSR0SZonrk8jh7EcziYPSGVUQ+Vm+?=
 =?us-ascii?Q?mAMxxn4WGnVC5LJeprsn7aR5cl31CHdY7GpS4TQ8HjgCWEQpMK5Yws4xTY29?=
 =?us-ascii?Q?BkWzVBgTttzgSEy0CdDEPryDJWmRCe1PYfexwiFpgDsTyIoTqhEpR/CQwCml?=
 =?us-ascii?Q?EBrEVH8F3tk7s2PZFkJ89q9B099whXjMED2hpA4/qG0IInOrizO36mT1qPMO?=
 =?us-ascii?Q?+2dSJROFJF1jKi327EhVFF5uK2q+pWnqwXSYpAcUm7Ng4XSzYjcYl3DZdlQj?=
 =?us-ascii?Q?cp2XItQkvuWCqY9OkE8Ou0cUpv1+zX1n0W6p4EAy5ASQ3/pg4RhzJ9hmHVxO?=
 =?us-ascii?Q?JuhheoTKWAbP0fTUQ/NLQIVCOEuKj3T6fhKMs+8U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c687ac-e909-47b8-3fee-08db67e3e488
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:47:49.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrYkpCKzYSdNXVPyxiM64lXKDJ77whWAhSRg1heTUAY2iTwbNJqzD0rXU6DG3YNHj3maFt2UHfnlHkOU5gVTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8609

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

