Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6717CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYnLoSb9scWExfT6HKczHnZ0wT2K7bx2dgBgN8Ot88TzLH6PCQjSjclxrILX56VCLMw2Dswtt/T5qqfO70WU7uDTtt32FnBdyb/VKYvswCXRPID+bcLI6AIpqrgyyoEwJleRIEy1gszevBrzk0TGLlMzFWLaXZGjvfFlDyR7taiB+LN8493Qz0DGU3MGFrzg+SAiZwwvgvgDc/ZBhbig00YozDBGQaEzPPXwMYwdeJWRwmdSyEkya2xsA7lPxKdYL76STPjWA+u/fcl2/MwrrbjxnlHXjE+Vx1e8zwuyXxOHo9bDzIwG0Rq2dhl5LghuG09EaeMzWCzrY/HtcnrUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vAjbZn4WFWplMBDnrhrBd8HaVgEAkKqZBD4pJwNvkk=;
 b=A+KqsOcwWDgUprkbYdfcC5G14MUhws0BBCrFjOoRwbG20hA2M+v2BeGd0sxuNDSZzFB/1nQQ1u/eZeAigIAvj+iX/8NrW/eP3Ar6Rf8BOlGqpfKRcrfhyKMPOXSnC5l+OA0zCuoTnJlRQ124LjNbOA+l6GuECg3RMadq3b41qG9KTMMVua1gKUym9fw9DHPTvJoJY1sGLBq8ARA0dVmTlh9pF/2J2+fLSH+KJyMi5KADZkxWjFq8lq9byk3Ui6eP2VHf1oEMNUXFfKGaSIurRbD1DgI4ejeFMzjKlJ3RzUnugEBwa9ikA3cVvJM5hqnodEEYriRexPXMcfINzcjqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vAjbZn4WFWplMBDnrhrBd8HaVgEAkKqZBD4pJwNvkk=;
 b=4yknukbTrkn+2r3W7d369vWRdcMrjBB1V0YYtQLfymEDpjjGW1UqOAYeLnbMHuboTrD4AH9AuCUHcO4uXBSF26F3Kr20AVRyWMLgGtPvr84nspGao5vWZdfwmxkk2gIGO5nx5z3/qIRMzBO9JRXP3yAXTXwGsTvrvZr2W5R0iQ9fdVyfkzUqTxxJb8Zum8nm94zPhlVzKFTnQ/zvnESjxMY0QGgeR4DWmzBtLc1glz5t1fI6qtuqmnEbuXKUCv0jXtavTlqqNZ+HhhkXX4YA848gLKFjWfMTAUdhbE9Weps9xiB4z2F7IxrsUOvdpWDqz7fpOf60GLa2dxXC818FjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 03/16] Squash to "mptcp: simplify push_pending"
Date: Wed, 12 Oct 2022 12:50:24 +0800
Message-Id: <b58d8d0891af6d4eb7b92f09569e8b855875ad62.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0205.apcprd06.prod.outlook.com
 (2603:1096:4:68::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: f27e0a91-d735-4952-4273-08daac0d5e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AxrZpTwoBT45hsGu5fjO2wPysUoW6+/6x/c+rHUrGKLr8v1LD+jPANziOskqlc2HW6NbSih+Nsd/t00K5vN51XE7puoVjv9D6TJnthGhK/ThorgU8/enFivDMRRANSYq1dSSiMUX3b07o0VSnoKwnNo2e21/v09h5xSIdNZUQnvIoylpO3fXiFEaAfmUopKmy1XIItDcDZyLofl2KfGop+ZRhcZ8XAwl8IiXLy68oHKKQll77/0y/GapZZfpo22/tNX9+uBD4smHD7tigiPuMmNmPnUp3uL9kO49r+yorXtPrpNu6SAIgoWMU3xk1xLXA8bQHQirTMk4IS7P9xCyf8SeBPGEmXstqjdFwsHvbejANriIdnjwnj7eKzstbhczXy1PAW9gB7jVMKbG0CmQPmuPXY++xI+TYEieGPZNBQqqnZgKZavB2J093RZNs/j45+NOx1aEdFaekSQZ7S3AsHROZwfx+H9P+C8qdlvLtcLwswsTeloSmdapA66DbVR1bPLKBVTemv5Fy+ZI1YfjvzjRnm+m6ScdN+CePhDfg14NNAxeMwoN4pwkTKI8O8x7plRPEfzB0U+6ELKRM6fDuWlIglYyFJ03z0LKPso0dQNRgOoW0e06gsnOJW1R/1x46EoRS+ev0VtL3OzS7v3ESh/B6r0vJ7s34VVfxzyAYiZtVuJNQPiayuysvC3F4uy67fzk6C9U09sOwWrqfRzwR5jX9s44iHz4cVjuaM3B70rSJnvVYE4t1pjyxhRFLuYQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Plfp9ruq5PBGcR+K/blQkEtKjXLlr7dDRlhQ+IehF+qWCIo+OdV43e+SWj5?=
 =?us-ascii?Q?/QWvQ6o+m1IP+nt0fYCwxp87rWFKj4R5g24/lWOqX8cFnbzHT8NjVlyrJOI7?=
 =?us-ascii?Q?KfQBvrodY6sROfHGetjN1mvqwZVQsHDr1gH03ZNJIUCRGvkFWMXXf22F2Bj4?=
 =?us-ascii?Q?NQHFQp/UQV1xHe5kXsqU6tQobzAYeSZCkjPUDx4RJMXFFBWEroZVvlYgdOD7?=
 =?us-ascii?Q?ETl4tvaHy8et4ovqw2VYhlJp+YcVIxqctntqrjEp5w6FMiFo8WZZuGfSUgIN?=
 =?us-ascii?Q?H8cQSqpuND6Zi4c1qptXWyoNZtjJ29iZpFOnoNq/edr3zEstKNrwLmH/j8iN?=
 =?us-ascii?Q?ZtcOz8zavH1ZGghXoMj0D9rqattbv2S6pLkFuul3LgOBMjsxF2s9J3OKAgmF?=
 =?us-ascii?Q?+yGnfs544Lo+26FKiaklCvMFcV72j4LofE/ECFc1XoTUjHGSMGhs5EFA8VEB?=
 =?us-ascii?Q?cnn+vndLsn4mQeZ020nG9ZRo0ldNCf1Qj1zDNE81teCZV3/ebKON0Z50wnAX?=
 =?us-ascii?Q?m7sIyf64QxCE0T+HCBlcRcfGO7Kq7/ESVNmqEFOYdFZqdF9Zuq/LLJwr/IVi?=
 =?us-ascii?Q?9SMenmZQHWIjWCoZzpuSW8l1EFViq23iDgRRWVumGb/vpV7fTRPbOdf8mG4m?=
 =?us-ascii?Q?6nFFsqlNPfTzkwq+pVBiIRpFCcHsiws6ZCAOWz0/RcnniOJRY1IJKL6d8Vnz?=
 =?us-ascii?Q?8eUU8LiM/kRgSfr04kiA8nXwLSuK7hnmDEKwNLS/Fe5Wg9siqqdNIZQ46U9O?=
 =?us-ascii?Q?9AYRcN7CHcRL1eyfE2l1GpuHckZCPxSTH07GkXYBZYdHKENIYN1lLJeSZrLD?=
 =?us-ascii?Q?nTlRxHeoXOU9V8970/GDlplumESOW6Ueqr2cPCI+Pimn1AGyE0RMwzPUoQ1E?=
 =?us-ascii?Q?l0Z8mT4t4vQ3ht0pZIPGviXe+NNQ8THmsf3D0izE/5931H/n+SMnfg/knAqE?=
 =?us-ascii?Q?MC/eFdWC5+AQuJLWLWCYABv/cknmfv9w4K2C1y470oOrYU8glY4ujRQ0Vnyu?=
 =?us-ascii?Q?HVzyH6WhADGHztxfOJJkpknk0vRYvNoahSMyyeEopmjKpaUHP5guMZw67suT?=
 =?us-ascii?Q?3K6Wm6nzMKHA5UpW8swinInZMC9otVY5psXt3DAsQgr8s+GoWRGcSOAUJIbe?=
 =?us-ascii?Q?7u6pTazb+xcZsvrbfrGX0AOXCplVdPIGdrXQK9YdpQBj+mGnL8nlkePxhoRa?=
 =?us-ascii?Q?Ez5i3Q3/27Rx3KLn7HaGQwwclUyhlTjcb48eJWQ+SBjMb/dOMfbQn4Eh+sRy?=
 =?us-ascii?Q?RsynT8FEFliKL247DwhOIufwmBVSu1IpYDbH33xgVWFpB6JXPUoeCMmbJrNQ?=
 =?us-ascii?Q?Xu/Nh1tR2BWSMDObI9RRAYWi1jnUK6XyFqBUteFsg08+JXKPk1hrOS/yoeY/?=
 =?us-ascii?Q?KWKSzsxVafgdnFp9ikbdUkk6bTL5prwk4Cw11VvBzUAuYf8ShjOiBkOtASa9?=
 =?us-ascii?Q?1KgqqAe/6Y+yv594l7gBugUIE4pAWhEAqHi1Bn9VAynb19Z6a0z+Ho0mSxw3?=
 =?us-ascii?Q?3PC1eyn8vuEhfEA2QHOEyA8ZLsqXU+jM0ys3IJcThGRxmoP1BnMISkFYOMJr?=
 =?us-ascii?Q?YIS9Br1BGLsXj3lQxWBHmvmdZIMQlUY7/i//wFOUMowfSpo7UNeqKuK7UVy7?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27e0a91-d735-4952-4273-08daac0d5e0d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:04.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wCrX2XPpAp4G5KbKv5MLAjYL1Ct+sHhhjcsYn53b8XAqfquI7S6XLBP6uBln1JfLIOqfmlDwg6iGnto5npII2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Add a parameter data for __subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 5ddceeb1d334..2cd8e18d917c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1512,7 +1512,8 @@ void mptcp_check_and_set_pending(struct sock *sk)
 }
 
 static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
-				  struct mptcp_sendmsg_info *info)
+				  struct mptcp_sendmsg_info *info,
+				  struct mptcp_sched_data *data)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_data_frag *dfrag;
@@ -1561,6 +1562,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_sched_data data;
 	int ret = 0;
 
 again:
@@ -1575,7 +1577,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 				lock_sock(ssk);
-				ret = __subflow_push_pending(sk, ssk, &info);
+				ret = __subflow_push_pending(sk, ssk, &info, &data);
 				release_sock(ssk);
 
 				if (ret <= 0) {
-- 
2.35.3

