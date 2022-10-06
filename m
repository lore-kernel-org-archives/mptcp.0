Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B77F6
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 12:18:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC2vH2wqUchZuYtvZqO8Wyn7OtefEPMD05U8NuTfbkLCP1LJ2O1Db6EFAlP8ESuIo7THi7uXGFCfUsZJiHOnzcIQOlKLg1i8Igfy4gxKjQ9FKr8abPInN2debXnOtKKH6tKlbPbHZzzrsh0pZKGhQFlOZrHoS8P5xrKCi8MIGcoagoDz6+vDY83RQfohuwz7izqvzfSWRjCxZPU2HcD3FrquqoBu3tKXoqNlLr2xE/9CrhmAnROqeARk/G3tFhDpZVRf40uayJneZpylNW2AKv8amEKDSUpeUFEF+9StoZxu3VQVgehwFxuaPw5q7lQQ0Z++iQgepEHYw9VDrO7GIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJGoFgRrMAu0/evmiR+5LPf/MU7pHwCPhwLtgBQ7Mzw=;
 b=isrN7Fpf8+8WQhP++ReWaDtfnLGlj9IxC/kU1eGKiQZFbnovCXATTHu2n9G01bGSkJM6nSP93OsLKr/TDpVxFpjFxtQ/urhuUyCKwvS5mx5R+tL7oZQy3/938+zq5gyFBVuZDrZ+aimlxGgS8oDMSCCQfha0BYT9TSbXD1HEmvjjwljSt0Qjo6aN2Q/oOmgPTWKeqrUwuXOgk/iqt+EE9YhPVbhd0mSVp5K4XAXXkOjCiJ7aRiH4g1XSjIh2ACUqwVrqm+L3y+nEVftJ+VkfsnhH5iO+/5wTM2ERpbxVS3OdOxUUGOUm9D60o0aJeKpsX0+lFvU6dUZ9RdYATk5QKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJGoFgRrMAu0/evmiR+5LPf/MU7pHwCPhwLtgBQ7Mzw=;
 b=4zwGvKCNYbj5PuIoR7JKBHusvaViM/P6HIY22neo+HY6oekyyyY+2xGMpp5kHyxITnCayN0gI+VmPo/hi/6HXn0n6KvekVZqNgHG/xwCuRwcKyODUfiG8Ar1ETqji469cEkKdQsm9qA6qVF9qhp2DftPLbf24Dqd+WjcYfB1DgwdsKu9cm3/AeQ6kxk+n8DiAN6KTaJMtFHlY8TH1G6+HWoT5FxVn+ifFYRr4VuprjNjhYQYj/79HVhi35J1moREqY1D1MZMRcPI0wEuaxQ/42vCnq44xAxXmEH2e7QDn5kGJSKeGIry9ycB+4sBjcOKqstGBl+DvTs9FCHWF9srNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 12:18:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 12:18:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 07/11] mptcp: use msk instead of mptcp_sk
Date: Thu,  6 Oct 2022 20:17:55 +0800
Message-Id: <63907ddc55403a8dfbce8976fcdb419c9f3bc3c7.1665058389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665058388.git.geliang.tang@suse.com>
References: <cover.1665058388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e84a88-2fbe-463d-3b0d-08daa794df8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kpf9417tdyJ2DFacYMJOo2BFgUXwYldXbWB/2fkhIPGuPo3bVFhfJoILOznBN9hSAH0RrggurSerdb6/3Y3PlJuPtADWspyo9kkXZebeIEcXbbREgM6PzBFOCUka9mPzSWlwmlJORtVnKvqtLxaxv5kp1IvP6tEKpEjFCTIVInQCRgCmH8ABmHp2QOfu6PxMxz9UpgKiIWZSImpE81ZcLDWk0lhGiEc2l7nWajEpWrt3wKKKk5mIpk4SvniLcrOQB1kaPcCcwvZWBVpWb7DKpSeVRxTQwqlVSuSDKxFS5+UdnXs10EG8gGUGk2+xwaDFQfMUPUi97WqpS81o4st4xO4hay85TwF52AkSsW48s4ja4Kdygj9BQ3N90XFbKS8C6+gN4cwvBbCAJQUAl+1yoYmatNUU3dWiTyk2ArT/z3N/Ztye3Vo6gB91WnqYW8dLHCk3zRVt1Ng7I97l+E2Jfi0mJXM78U9m2m+FBmPvQBIzjjNJiNSHBNvXIZ0/HVVLN/qop+bnrdlT7mMwcQSZWlWbhHI1FaKJwB1/ZbdbY3uacHgY7T/Pa1pTGJUz1eCWlx5+idPIQtXeaHa4EFaYD6j+3MY2M8rYqqWaTbq8yerOHEM029NAP4F3fPBAJ3KdCDOwe6bB67nZZvmp/yam15ZBdMO5nn/iGaRyuiJnBo9SnVdjCjjaetHPzFyUmvJU3wpCtpgP7L+PMi2dAdJnUIeFFhdCtJLNP2NKe3D+fdaN5unO5JAGB4z0eAI+TLQL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(6916009)(41300700001)(316002)(478600001)(6486002)(38100700002)(36756003)(2906002)(8936002)(5660300002)(66946007)(8676002)(66556008)(4326008)(66476007)(44832011)(6512007)(83380400001)(6506007)(26005)(6666004)(2616005)(107886003)(86362001)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGtl5gLazPQwEkPbjKf03fbV5a+DEAQ8UvO+oHoN66XATE5O4EHkw/NKHoHc?=
 =?us-ascii?Q?IZUcF1Rlx9jsdbmPSGzyGi/bITdy2GvJKBziGq25WIY0ecQyyGtx2ZqlGm7M?=
 =?us-ascii?Q?pYLry+XbxbDH+5MeEsLDaIWEX+FSNLtCHQILyGfgNZjcpHoA/Xe4Q/Rc+xyh?=
 =?us-ascii?Q?otD/oKWa1wgn84f/E/lfDHnrzGKdFPJlTO4X7CL6otLW0g1g9aQXDX5Lk3v5?=
 =?us-ascii?Q?QGHzU1xdy/Rw7SnZR4zRsUviNWiYuODh6TTA/7TTKxBsjzhVzzXevT5GLbUQ?=
 =?us-ascii?Q?77SADSUoHMClwQfqI9S9g47nWyd38AbjmgBQ9dPus78/2Rv3XFoTwIHEWub2?=
 =?us-ascii?Q?LVUks/NeJd9IQHeRzYr+Bl0lWOiwxj8FpTiwNSxb+Ga+u+/Inj8De0rk5egj?=
 =?us-ascii?Q?LqgflPaOKzu7EhWkxVl5IlZGPkKZq3Db7ax9wpZ/AxxyMldXm62B/hi7bmF1?=
 =?us-ascii?Q?z2F2C4aQv8h06/nj6jT0i6P3dR2tGspkFa10Hs0/O3J7jVwGcgb4JPven4LF?=
 =?us-ascii?Q?YAnRbxoA5p/ls69A2ACNbY1wGH6IFkBjuf//hmFNeDfm17WbU5hjfgwUnOjw?=
 =?us-ascii?Q?inORb31/sV04p7arBgMrVmEhSsSvlb3JoccqqEMkeHFPOQeDwv6mNI+ZEgH0?=
 =?us-ascii?Q?1/xyhVieGKvZQ3bySCYJAKhTkc9IQMH3ZZOxuTCK5voK/adPANydaL8L8vsh?=
 =?us-ascii?Q?T1w/O113tU2pa5sc6UzKhTCNM4JYcD6SAb/42GkdEqfl5wWZBa+nZa1slZIC?=
 =?us-ascii?Q?HFVCeSg19KWzvM6nUMsdMZW8iQxpxWu3QekOlKXUbtGnNK1+Gspx8ObLH+o9?=
 =?us-ascii?Q?W0+CJ/lxYLu7ovwn/6p4yr5ZNmV7dLaLHZKvHo91yg2eN6HUjIbcjwMOlM4P?=
 =?us-ascii?Q?zMu0n7/a4luFYqeWxbylt1Fq9/4loSpGF4wsVrJqf+mAFywPTREMJBhKUHjf?=
 =?us-ascii?Q?pHoFd+eh79A6MJkFuMaup88H+7QVYplvl5gQgLjUn2FZgQh8f8TqcFHyI27l?=
 =?us-ascii?Q?nDn/IXxLOs/0elGQR/n8aMuPXMhLCXkG4o7mueCD+tcUxNP0a9/Jt2W11mFZ?=
 =?us-ascii?Q?RW1GpaLBKVlQnEPIm7bFSeoRGSDRjY9AUq8DSEws30YkI5uVfAADof2hjhry?=
 =?us-ascii?Q?AMt2msKSvRVJuOHKTzgzIEijMS/AN/NNEL37k825FtwLmhzsnfwK9S/Btz+0?=
 =?us-ascii?Q?kVyZraMZpVH/uFwnTJx7eY2U1GcyTyY6lC1bgOLXSfGY3gZKxiAUOuMbvQVk?=
 =?us-ascii?Q?eADpkyDUnpNMTzzuCvmy0GWJyDGisBFBnACoT2LDI+6V2ybqrJQqAO4fNmky?=
 =?us-ascii?Q?zfdz0LvKxMdGsyT6I18gDJHDqgeMIfYlq2YW2WI5AGT5Zyuo83Ac/x+bBtaC?=
 =?us-ascii?Q?srEDskBL+k4ayFVCUAcPZITTAuY/8WB07DeatzgwybCOFHWy6U1mycheU+Je?=
 =?us-ascii?Q?Y7AT9nQqyysLnx9HIA6H6ZgBTxKNULmocKLu7CLhnKSvxaLkYLI1CJBAd549?=
 =?us-ascii?Q?QzYP7oMRietOhXv1NzQDXQCCBNrsHhHfy0uArajYJTkbWD4qdtAtTGvepuYV?=
 =?us-ascii?Q?YPzdangNEes5x1d1aNTfOa6mpyRgK85pEvu09Tn/Q0es9FzK+GjGFdXR06kB?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e84a88-2fbe-463d-3b0d-08daa794df8c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 12:18:27.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JIOBPuItKYwi+BwD0FDvn4Jd2jGOvyJzfP6qBDo8zFyngEQYh9bqVFtvPEYNQujZhzY4YDF5uxMUgjTZ36b8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8450

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fdb879e09a32..b15b97e8cbf7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2249,7 +2249,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2928,7 +2928,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2987,8 +2987,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.35.3

