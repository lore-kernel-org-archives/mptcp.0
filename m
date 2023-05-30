Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C2134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTWfSmCAW/pafa+N87+bWJasN75tiNI8MIK5jQHffXh54+1aa7xCz2zAj85Pmjl7kxVkS7X+c/+jYHWW8WVBgsgrebYNRUopzGDRNp6aAy8jvsHz6PQxnKVpznH9+9bYU5gyTTOV6sEbOF7q7TQCJ0DfUh9aISfgWr2ZTlLxzw2j50Qr24nIh425/ZovDLA09DuJquvohAGl7KzPqGCWR+GCJRyfJoTYP1LI5FpBvY8HUmcpXbWw932sKXiaO36KFRjozudvWjO7S7g2ddBGHMODgNdt6x1MS4Qd69rnOSo78YN2ykk0j6r5CUbIwGE+x79K0Y2vOcN2Vdbn43QtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6p8NTATB2b77MxCpgOmTpwqKVXQZAKANaKaItPp9LI=;
 b=AYqy6tMrc1b/z2zo5ZFWF8wCaN0L2JMug3wflAIYl3SFVmfd6ZwFOJkGdht5hBMOAyUM7y6U4tfKoCex4Nh52+0oB20S3UAb7yETxTyzFc3cM1Y1NAnRTYUwUmRnu7TEC0s74Yj/zD9jEp2mH8+APNhriPkTelky+KxkwY5LYeKYueEM/PsH/d71V5EzK5lsysFB8gOOwZ7XxAdHKrKu62ElgFKCJssHUer89XMKOu015kVm6SMFhRhPb4/zohyZ3H0Eww+QUZsn56aW4QYfIWHolTDnUqU2AyFxGHI0CflR3XbLuc0uiG2EnWU6vL7eRrIii30APtwI+Wf56n/PlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6p8NTATB2b77MxCpgOmTpwqKVXQZAKANaKaItPp9LI=;
 b=Yn2Yu0Y46Co6EfdXe3ofHbBGkzhKZDfoRBPpYhon5OIv1xGD5vzp4cuqvJZWUhfuYGE7Dl8fTNOzmGwVUlQ7l+StyQnD7ZAjNwL/y5/VKpsrSAjaDDNkvrx08ZQsRCVgdinBBPAIrFXnEVzDwxkGRaYYHZGNuudIJBJ7TXdiUV8SHz36CR4amF/2DguiT3oJsJitjU9VFtX9W/vg41pxnMOkFdsRdyJbZd2em2Dpw6Czn/35lFXzxdfYHTTMAwl+fiMcgtuDzkZbVRcis99OXzD+DqWBpau4efAK+Mo8OZhU6eIuK5DiEWLp+WsIa3rcnXUuUd8Grncl9IPXimToMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/15] mptcp: add last_snd in sched_data
Date: Tue, 30 May 2023 21:17:24 +0800
Message-Id: <5257d7ff291cd9a336c976967643b0041050d66c.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 918700b6-563c-4e2f-e2aa-08db61105673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	36TwfsaTcOiw4Z3kw0/f1OTp9wLz8PH0UC5QrckwFM7QPRD/frrPpaJBaDJ9AqE5zI9B20N33wm6NnrAENu9UDOt42cdh8Rg8h91O1WR/Ymnvkrg0zkQVrtdaoNpWC8LPjoPZLd8T7n6G5UX8bGBBxjcqkGuAtHxX7pwcwKkoRbPrmaO0PIHAHBxnZicuCrDYciMb95qaDT6+mpAZHPUfk6/uEWrFZxxoJMEuN6yZmwfjqDAmEF+Iq/32hWPoi6OHq0bVa3G8UYTfZpC/ZDq7/1D9lBo5jeGjL5Z2AciOQOoc8COnuiyy/s3F1k68y1euLEClUZzVhg14fBT9GTIvWLhVG3T3oHB616uklUNdCDnlaTBHX4tiKJIo8mXnA6LLDU6seCd9kKs5RCqNy8C3N8nEIjoDPFmpi+mO9pvslaouP/T0nDFfKQ9zgJvJ06glhVJLo/8Nf8vfnuawcnWGhgWBNDohf9cbDjrvDf9PkKMYN5BClZdR+DBuQCsgWpajtQT+czF4dHSCIA1ziiVVOsbmwMoSpyIIS2g3Qi3W8GMynwv/AuR0N4sul2GEEM2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39850400004)(376002)(451199021)(186003)(107886003)(2616005)(38100700002)(41300700001)(83380400001)(6506007)(6512007)(26005)(6486002)(478600001)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kDsofJhyvGz536Rzuv8YJ64jj23SdO1NJX+q5vkPnx+hMpuioqZOZ0WT3jO9?=
 =?us-ascii?Q?uAARVgf0kTUtQRcNzXwb5jugNnl9walVVypirApg4ERc/vVIgRe0wXcRHl4T?=
 =?us-ascii?Q?doYKSZNH6SEaiCydcN9OYlhfsT8BIETEvaMRxh85Ig3jHDvcW8yEiKwlqSr7?=
 =?us-ascii?Q?JkA+bO+Fdi7zxTqSX4BFjl1b4px3qNq6viJwMQcfJzz7uyW/pEBtw1nV15ji?=
 =?us-ascii?Q?RtT8LoTnuRMTkM3246Z7kbHK6K11dJRaaq3vNajxv1E8GsZt+R3kFO0+glZA?=
 =?us-ascii?Q?pXuc4cmWpZiVWNDXPXfaal2GJIlnLTC4vhw+usYjJDoxcEWNPZtaRi+r/oWS?=
 =?us-ascii?Q?qSG4MxOpTpPGotXHHo400VreQUEtpOxZnvAdghZaEkQY6Qv6xIDA7hOkaO1u?=
 =?us-ascii?Q?LkPSDnhkZsFb2dlDQnZiNuPn7mC75pOW41tVlik2svdmi68CXhkPmtkVbCze?=
 =?us-ascii?Q?kIG35dxguqp/K/1JZNYPpidMga2KDQKsBYCvoh6j7JrQOs3Nk0WJwez0qC7k?=
 =?us-ascii?Q?0HGFNsBy4Hz/UY9LYOzjobXaqON+s8JICHs9FGtzFODWJzeeiIFGzYq02Xor?=
 =?us-ascii?Q?Qr4HxqyJQLeLWlji0gQDC3Yj6V6t/DzeHJNOLJUNaw4a2ofQfHN649bm3Vwq?=
 =?us-ascii?Q?C0ptspvZvs/v2Wf7KnYOiqeYBj0iOFaTWPu8rGSaSaNhnZY18pNDRrSIbSE+?=
 =?us-ascii?Q?iFEfqxWY1F0K4kKGuH5P2zxB2hlwr6+pFcgMEATLyNDgpRbCft7X4/uRptYI?=
 =?us-ascii?Q?P1rAOKFbgWTK/oEpXOSUQ6sPOOK7lsx8d9LSsuTFZ+VuhYRJ2yaA8n+8xndd?=
 =?us-ascii?Q?6HHYNvjvRFaUsK//bOtXms2FgzTbaHbo3uWluucD4Qonhs4z4WJ8pTLHbDKc?=
 =?us-ascii?Q?LFTHf/jmoYcBQwnmC7BqlHTlGe0Lgj377FDHlI+szTX/qEM6p6D+/Uhghyl8?=
 =?us-ascii?Q?u8ifryY4Kazy62XOG4ATlpIL0/er8Uf5f26gcI4lQqT1lbWBeg1Dt+tzB/zU?=
 =?us-ascii?Q?ub1M04vOQUxI0f8O/Kohs8ZnPlgf0T8Oy/PJXG/0BC4x85CNXXM6ZO2Ztv/E?=
 =?us-ascii?Q?udm1ymOnQ4Mjwrm6d8mUZa/eRw91h2Vw0cnB0eHrxhGZ8ZjGXVLe2fSYctu0?=
 =?us-ascii?Q?ZovYp+NhO1zscE1iyqHH5V2GD6Yh/HZR4BH1hyjnpPTU5J7zQo1eQ5TYgy5p?=
 =?us-ascii?Q?0+3vGbi9fwltKR8qsnD7u+vIyfSifLvWIRdYLYAMlxCmOB580KDMcTxNe8fD?=
 =?us-ascii?Q?wsy1IIJ+lLGQpQ6W1+AWKtVLS9U6qHbFqKwwSTwK6LoNTZs7OLbGp6PDAuVm?=
 =?us-ascii?Q?vz3928c+BajwAiYmwaFB8uIJvmdUnzJTeo54O1FaReelwDxN11t56plJCn2v?=
 =?us-ascii?Q?3yeaOfdDbUfdlZ0pK4D5CZHykJOg0tPAJq0aWQvHhBeqDrvWXu2u8bHbuf6v?=
 =?us-ascii?Q?ir1I1NbZK86Cr8F8j9Zw9OZM6Shg0wEpdnwGJAQiu90QBh0zphh2PzkhYibN?=
 =?us-ascii?Q?ptf1QWySHk0SErQYTevdQh5iI56pdxAyM3+0gsRAM1gJpzplKYipLIRBFegm?=
 =?us-ascii?Q?k7Wdmd6hf1KYexYjJuQ2yuAQo6qpIyVlRRnkkxyn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918700b6-563c-4e2f-e2aa-08db61105673
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:20.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdjAJIRDok6+v+A9IXY2Ma36U1g/Q5eOrGABagLN1XTq3D5BxpHSv04YSQYU1MfTvGNqBJYFXOH/a388ApzIcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

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
index a2560813bfb5..05a98ae09226 100644
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
@@ -2457,8 +2457,8 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		WRITE_ONCE(msk->first, NULL);
 
 out:
-	if (ssk == msk->last_snd)
-		msk->last_snd = NULL;
+	if (msk->sched_data && ssk == msk->sched_data->last_snd)
+		msk->sched_data->last_snd = NULL;
 
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
@@ -2640,7 +2640,7 @@ static void __mptcp_retrans(struct sock *sk)
 
 			release_sock(ssk);
 
-			msk->last_snd = ssk;
+			msk->sched_data->last_snd = ssk;
 		}
 	}
 	dfrag->already_sent = max(dfrag->already_sent, len);
@@ -3143,7 +3143,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	 * subflow
 	 */
 	mptcp_destroy_common(msk, MPTCP_CF_FASTCLOSE);
-	msk->last_snd = NULL;
+	msk->sched_data->last_snd = NULL;
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88469590eb32..ce3be8eb68d6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -266,7 +266,6 @@ struct mptcp_sock {
 	atomic64_t	rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
 	int		rmem_fwd_alloc;
-	struct sock	*last_snd;
 	int		snd_burst;
 	int		old_wspace;
 	u64		recovery_snd_nxt;	/* in recovery mode accept up to this seq;
-- 
2.35.3

