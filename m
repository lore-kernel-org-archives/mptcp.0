Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166ACEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ob/phC29O+ESriCKSx/JCSCr74IKPNdSzggz00rvTkKGxxer/ThBuNZq0j7egRXdi4luFe557IlV1Q+ZFux3iH3LAyaZz1q7d9vwZPr+eYITE3d+5mfUKQG+SVkmwtVq4Pha0krDi5sM1iYZIfo9YltVs2fxNGtCzTYRPEuMBFiaNxFJhv4EU+1PWunFCxsfNdteo+Xmc0UkJoOtO+VDSfLXGnP/wh1xhzqUgBRt7ITrSPV69OVH0zME7tZO550Ol9jwEdx+WR2MH+/9VDapmmL50DsikSX5ShZTjo22Apus35xz7/4fbJ21t6x2uEk+vrp8c3YoqJkvakdAR6sPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXjjtOFfr2J+ajRDOoV76WS8DUa0iEdQ35alSHyFAmQ=;
 b=G5oMH9NcSP0aqxapxTHxteuCsuObxajG/BdJzff318g11izLxARn/03aLbJkshK6SfUL/F3AIr5lmfXIorfNobQjenLDCz8e/jS3rDyMlO9+CBgFkomUBC5foIbtWVrRlxGARwGA4tcYoirnT+e2rh0IWvsW2fgQmnpAbGlUx4709dWjwfhwBre1TsZjeEKeYlSlYfG7SOpENEZxKZPvRJwiOJft04l6BS3Fpnz9Tlmis3TNDT2G7gJmC72lkh+2R3fYPBMJItfRkNrlfnFS3CRGU8go+6undlySgTHzRSY4TbZD1TJqnvPTaJTPEMZVMtqynA7py3fo66UOROWWCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXjjtOFfr2J+ajRDOoV76WS8DUa0iEdQ35alSHyFAmQ=;
 b=E2dFr/jI35bMsfatoFXvj5coG8YzL86eXeOEYduFKc+hJmQK8YX1DlUqrTx60hR3jApEo3RT5/jm/s4whpAybW7LS5o5W5wfrJwebvoyc3UTk28yjcZZ/suqowZwmvhjXIaHACj7uB911HBNpFeIS57H6gToGvSnhopHHCgzGJJmA9+XtJknRfjYAAlNnlDqqBUFWPkIzNKWdMhCR8nUG18ZTf71GKLvOKWkDoBetGvvFb79nYyjk6Td5xaok0TLfdFyznvEMmx48ADLa9Gb8Pg0TjJVHMJk7cy9hQkhpn/LmdYxuVlr4nLU2Yp3ejOJ9H39pYOnZcuZFRV9wssOjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:47:59 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:47:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] mptcp: simplify __mptcp_subflow_push_pending
Date: Wed, 28 Sep 2022 17:48:06 +0800
Message-Id: <bdd374a7b884fa01a68ff0ef854519fbeb4db38c.1664358100.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664358100.git.geliang.tang@suse.com>
References: <cover.1664358100.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f4474c-1201-4ac9-ba01-08daa13686c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nyOg1cf9IS0wbD1XSRskBwEZ5+B6M1fya9Dh89eIme02pCRf7jtqC/r+kdwKKPk2GXnM78uzLo2uSO1hLwFJ8ZgpOp+gJOq4/TA3h2ygiwN02XwooEaAwVCLMYtyP+H2hm9NpgDk9fmGKwVy5ytLLNjXeWJY1GtXxGcEzymnKSptzxmuugxYqnY0PCLb+vngmp9ucWGXwie33OCV5YS0vw3XZxFzB9wUlelCmfM47ygI93pIWDxVfKb6jhInVXOv98ykZ3Zzd7r3M7GlO/vFd6ueXUPvrzEAmX1sGwQ5UNsWV0kr2MfU4H4/ew+LUxYxqTlgd+uFc6atrDcYeP/su7piM8JLK615+67v4qDo40w/e6QoovvYjFrYG4bpLtqfASy0gM+cko+Y3JyZx/SBETy/Eg13oLGR4Xf5LlHnQDplysGdbYMMfHnqcGPU2ZUafixAJ+XgkEZbSW7VLf6l746mJB9HcYV39rk3L8AlBJk+zupfE9MHQQ7i2dEMg5DUj4ZrOgvlo496fGIL5DxwQ0ku0dN6fGpGGklf7LHlahKxv1NFK0GpSYcQbHmPVmc+hpgmiT1co0rcyhebTgfiejIxjim47i/TGhFxPkoWz6gRqQyi+0B2R8tmolBhN8VXolDXCuJaSC+XCZj75VDzdTawwgG3Ky+10tUpPuGTrhQL0zRVsqTLDVClNKH8dhqWus9EaH4gmLdhIhM/VfbFBw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(26005)(6512007)(6506007)(38100700002)(8676002)(6916009)(66556008)(66946007)(66476007)(86362001)(316002)(36756003)(4326008)(478600001)(6666004)(107886003)(2616005)(186003)(8936002)(6486002)(44832011)(83380400001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yrFk2vN4r6X7LF1G9x08QqXOrzHXUplpknjfLVPEW/HJtSBbowAU1Aq3R8A7?=
 =?us-ascii?Q?5+NIeQFjnUb69dyDEgYMhy1H6fH5jz6fQd/Kc6z8Ix2xk1tCfMDehzXGQyOA?=
 =?us-ascii?Q?uAYMEnvQroOeElNwLufeXxvBE0R3RR7KCjbL8tnybJGctJhAl6ogWafV7Z6Q?=
 =?us-ascii?Q?mrMXQnDSHUYLIJBnFJDKV2wJPFQdav8qvIh9pCnNj86XDEQiYmVCPf98miBp?=
 =?us-ascii?Q?jQEFcSnNT3wDbPlE4soDEXbF/z6XCfVmAaueDpPe1afHLquFSY5lPcAR8a6I?=
 =?us-ascii?Q?/44KA2PqYYmUT5qBmPtqWsLdu1HdU+1ZCI0wtqpZS84Lu90ByOU5MzFBb6I0?=
 =?us-ascii?Q?+ZdCODluAuP2qO5DY0EXYDpDk56IQIZVEzoEptZF9z5fbKxHk1qL3h5J9RYK?=
 =?us-ascii?Q?Y4OAqTm+Q9Hn3iBynDuWfAs1wF+IAh9LRwI7370Eg8PmQl55Hy6QsijAQZk8?=
 =?us-ascii?Q?+Ymc4Qed7TwBkBPQOfgl4RBe98Bdxy0hnuUAODllwt/sXBRqx/40CDK1VOY2?=
 =?us-ascii?Q?kS29qOqE0MS/25pqZx7A5w8REpXpSsUJAxko+6AQ71pOmVdfJMugX+Cbs4ye?=
 =?us-ascii?Q?gM9DG1j+X2aHhYX5tjW+80PtM69S09Bt75fQfQeRH4pZbH8wBDc7L84pElVj?=
 =?us-ascii?Q?uqGtwpcZwEZefKOzeJpRsSwJn4LUhhILhD6ZDPhCPBVcwAYPhRkCvG0eqzb8?=
 =?us-ascii?Q?4JJfrBwdrPfCS2PfPQTOIoanopxQuMqijWe3nE63QtFXooLJU3l8MSFxXaVD?=
 =?us-ascii?Q?oFzAgZqztcoBmrtiDApuERW/J7oHX6eUUNw1szi3AHGVX8RcSB7cLgIIRjZo?=
 =?us-ascii?Q?EGjqHHtpuMFrA7JKkrtZv9q+GEQ+uyln1dqJVuSKlloMXZB0R2A/zvKfMF4S?=
 =?us-ascii?Q?oc84VPiVwRPA9M1Vj5/6RTyzJFMzM2O/dclL1Z90DMsGwuMRp6BTar9hgFDH?=
 =?us-ascii?Q?WVLpU0emAVtIUnWEEt/WNGtdZU7VkyqIJKH0Ydh+Oi4jgpulQRr4DlQxTvgw?=
 =?us-ascii?Q?ezbgexXEeFJK7UIvQ5nvej5y7wPhkBTqthKQutrVUGFHA0KyRbBXLjk9tNFl?=
 =?us-ascii?Q?5Ztwje1ZDTSwqf4PUgJpvZbcshwO6Se+OyRh7TgDE/SNAuewNbeTEKGjC+1P?=
 =?us-ascii?Q?SUg9tedqO0Yh2NaMCCPmTl+Qw10NZvalpJgMAqe9sWNSA+ysF2LvF/9WeDUX?=
 =?us-ascii?Q?3co9f6IUERu/+jAqzDW+0wIhPx8922u4NjtYyCdM3MyTZldhFy9v9X22bHQM?=
 =?us-ascii?Q?OltNeQvQjM6EWrbnQL1KOSzuIDlai5Fc2+Hq9bw2DGlmCiMUv81HZ5RT/q85?=
 =?us-ascii?Q?Yaw55nYEimHWp3dwNUU+VWicPEInqHvz2rb3cu5fxwQKS7j6LbiPUa3Br4ct?=
 =?us-ascii?Q?hp5Q9FOqyQzbLO29YFLb0yhZVBfB1gvm6/cE7vvmPWJ7xcVF2AGZ2Q2J3KEc?=
 =?us-ascii?Q?mF+45XfAJBy5/uK94nTdvl9AdU7y4TTgyyk/RuFxcM2SyV7soc0ktfFwstUg?=
 =?us-ascii?Q?qjHwvnXlSE9w/VR96M79NGSvHgc36gZvUccjdDsLDMRVhxPgWCUqEnV4ppEV?=
 =?us-ascii?Q?Bt5mVNC5b0I81krwOtw8883xATYq/mTGiVjW7DWJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f4474c-1201-4ac9-ba01-08daa13686c1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:47:58.8901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bx9cDkPi4brC0a7FSd8tT9E/ciRp+vaBdpjPbNMWqdbNyUGXPnnHnPeaV2DF2Z9puHmm15wX2UHeorBqd7rvAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502

This patch simplifies __mptcp_subflow_push_pending() by invoking
__do_push_pending() helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 550fc375a7a6..779794f42137 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,11 +1593,11 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
+		.flags		= 0,
 		.data_lock_held = true,
 	};
-	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
-	int len, copied = 0;
+	int copied = 0;
 
 	xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk));
 	if (!xmit_ssk)
@@ -1608,34 +1608,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		goto out;
 	}
 
-	info.flags = 0;
-	while ((dfrag = mptcp_send_head(sk))) {
-		info.sent = dfrag->already_sent;
-		info.limit = dfrag->data_len;
-		len = dfrag->data_len - dfrag->already_sent;
-		while (len > 0) {
-			int ret = 0;
-
-			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <= 0)
-				goto out;
-
-			info.sent += ret;
-			copied += ret;
-			len -= ret;
-
-			mptcp_update_post_push(msk, dfrag, ret);
-		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-	}
+	copied = __do_push_pending(sk, ssk, &info);
 
 out:
 	/* __mptcp_alloc_tx_skb could have released some wmem and we are
 	 * not going to flush it via release_sock()
 	 */
 	if (copied) {
-		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
-			 info.size_goal);
 		if (!mptcp_timer_pending(sk))
 			mptcp_reset_timer(sk);
 
-- 
2.35.3

