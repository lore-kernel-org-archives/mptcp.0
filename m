Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10059.outbound.protection.outlook.com [40.107.1.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE133D9
	for <mptcp@lists.linux.dev>; Sun,  2 Oct 2022 14:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FU+TJdnHZg+vMwjcfPaBX5xcPsAd+69OfFQT/ZyZIHrtKlxfPpzNcVmZ3l7+74QIBf5xrfFdAqHnxtQzt+OxpTum57sI41wXICOY7y097cUBQQlxn+CFfoEm5wgYF0L1n+GDFxmx7AOgCbWR6UgSaRNE2O27rmNo7kxftNfLS/mtXUAN6p3+4o9+DvZP7jJBOgeFAljiU4H9m6nSmYsZ11mhWLo88HEW80FeeodV29UPaW+GZM62bSr/V9+ozwGm6TJy1hgHgnCAi33CqXUcF2ldaNhBwLwW4T1l2NgslYSoeHFvbB/t0W7GXj2EtaIswQ2+YlZCtvuWYIm9Ot0ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Op99eGQEfKnc39GRogn6pBWdookKxktCy+LmZeFmWg=;
 b=NwiD/3UIyhs3M3aDbPJsX1qinWlbfxmlOiFVKPG8fSql0hBZpP2JKPnqzoQKYUuQ6rYnMcdFYo7ur5R6Aso5H3hkT7Tqbx+fLt46EOoUpBv5YigT/bt+fDRjDQgpmyRjAngCdkwjR/XE21WzQLSKNK9tQ820dP3Yr5ZAUSoObki4MWg+C/LYXk0sZ4JkeSdlHTt1PCGVdmrKpBV934dHCauFJLQkL8vm+sZbSTDlN5mapvNhxjJGbreDxHwOqrHy8JYtmuB2AQk0+O+QRaKYeyzjUrxjSATxxFnVmZG6OhJ0jcyHPxR/r31shxhN4jisuE1gmo6rX8b1eewALK9MTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Op99eGQEfKnc39GRogn6pBWdookKxktCy+LmZeFmWg=;
 b=Bmw5HXRLcHiHDXeQeS80C/jsBZBU74IFPT8VQdZzm77lShEj2MTcVpz570x7Qa9pj2am9Zcy93yofqi54tKDEGmmG1limOKoSi1BXVDSFE7tpIZr6RfBP/Fi6p5LCRWsxO5PHuYtPFvl7J52CVl0Uo/vF5XgM0Nneta6zCvDeHDhNzXDOQfyta2mnPXiv1gLOrSgBxDOjlyxergkU3segbC6DgUukx7TBHpQXw1mpfH/8vrHGrdGJpd/W7j0qcynoPSV3Xh2SN6Sk2tvAfwjF6Qkk8S5x/JKbxmDsiV7ligXg679PEDdQ5NrdD5XQbffh4VjRmFTXU7oQBEtr0LlYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sun, 2 Oct
 2022 14:25:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.024; Sun, 2 Oct 2022
 14:25:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/11] mptcp: simplify push_pending
Date: Sun,  2 Oct 2022 22:25:13 +0800
Message-Id: <b0c832c5f1b3dfaf20a7ade32968c78eaf228482.1664720538.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664720538.git.geliang.tang@suse.com>
References: <cover.1664720538.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b3eb8d-2aa6-4ecc-5d92-08daa481eee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SDB84qE9Ywi+fZx1GHE3R8wanI0C9sGqgG7BQirxl6QgvX/8z4RNIcv5vY3kOvNqlc64YhPqYNaf5NtArnEhmaeuomMCDs1NcAyLldEf/5iV7VNydfKxTvo4cwpSNxP5xRbrKWQmV8Pk1X+L2Z3MLNfa6vLBMByhquSREYLqzkJXCX0+RrgRNn2X2xkpTAH9/9Bw98fnKHS+eelj6j7ckmnrW252yb2Tp3bVsqKFXjOC5VQvdcd/a9wmrcnK0j6YpNJFO3DU/gkGhftfsj76MXWQwU0n6k1S1eOh7f3K8B0xofQ9kW/GyDnZANON/f8L2tycAgrY0fh3sAmMyjnYSVDl+zxhkrcByt/eOOa+fCYHHGufcpVNh9XbiSqfILHYQ8ceTwRf0VGhtPVecYZ2MUlRXS96+7lruKQQJNEYSK1XIWPSSy36cQusRy761XYW5gn2uy5ODbcTPQQ4EqoVYwpZqUPtuyjuwHKpZ5zJJZKPXwyHCel4a9fwLasCjjV5JnEfvr/hiGu7COPWFMemX5ZpXIaFgESEgT1E/fI6cqDDYvFaxnOxL1Rtul5XTOe7OWNmd7/Ng9KGL/pHApqdFkoEZRe4qtJct7K59rro5topdoxIphu8IQUcRdaDmlZv0HLEnQutcvRjOHo/BVl04JVRgfIiK+smMfIG+of1zbBgxGKWlPdzwCA80YoQvVYlm/sxIyUSRCipYFoUdJ1XoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(366004)(136003)(39850400004)(346002)(451199015)(186003)(86362001)(2616005)(83380400001)(66476007)(38100700002)(66556008)(66946007)(478600001)(5660300002)(8676002)(4326008)(44832011)(2906002)(8936002)(316002)(6486002)(107886003)(26005)(6666004)(6512007)(6506007)(36756003)(41300700001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxGyMa6rHkkjCPZLI7CGxK/K34bbU2NQBJ4PeKwLCeB9KlHbLYSkP/l6szZs?=
 =?us-ascii?Q?IA80YSpoyTosGKFNCZG986FGfvGDCSyyJz4R036xqr8oXwgY5ohs+JY/SN28?=
 =?us-ascii?Q?72RYxa6qjQch43ZxeSUl/TE573wl0G3Rs846i7Qet8qawtz8ibwvmOVNGRNq?=
 =?us-ascii?Q?AIz3eux9GolUJ+kw8ON5M0qQhJu9xsFTz8fJnCqQUAB5oAqkGUv7L5HIJki0?=
 =?us-ascii?Q?7w4NxYb1Y0woSGGqcboSJPYOQA8kck8JZgKIS49HTAiWYsG+gYARMHMk2bav?=
 =?us-ascii?Q?JrlVXcB9V8vuAzBhe44Ot0ldlx+y/oak8n9Qf6a0fg4SOncVrKdtyuMtUtGa?=
 =?us-ascii?Q?6yMMMxBRUmzraQQ5J+YJf2kbef0+XsDcwfXkdY89N80y2z7RLsoM5Wv3ZG5q?=
 =?us-ascii?Q?TvYhsjHv3Dx6B6u18/FLOU0eVIXU11BDtbaRmlutyDLUzn1JJRvhCiVpnjmP?=
 =?us-ascii?Q?6WvjODa1gqvnQXqzHYm9XwpOHjhRgNHO3DikGRekwPbD1FUkkmv9ntG3B7WH?=
 =?us-ascii?Q?/1+ROI+VymvZXMOsgMrbicvx6qvUj98PAuPN68VlHvrXzbMOkuxjloxoA0r2?=
 =?us-ascii?Q?bsWXtDNF1r0QV36efk9OnmBVUS5U6nJDOP+sHjQN/N6IdQ0zXy4D9/6RBUwS?=
 =?us-ascii?Q?U7UqHBXFKDP5GEe00dLJ/Imo6b/AFK3hGAh6dbK5IMKnEpG0OZFY4oASBsUm?=
 =?us-ascii?Q?TlpgBla+Ni/t00LjqVCybLmvTiJzylmpYvl9G5ixvmb0uFKQUvfR9LV75u1g?=
 =?us-ascii?Q?TeaPLngXcenj0iAW2bj6gdSeCMYQaNLEd7rUWAyVa+5TkfGIe7bshU194B0r?=
 =?us-ascii?Q?YQ6Zhnbfuu4X8uKbslHGH6Kasri5PuMgUBoQiJuHCSE2k4hUh+ja9BaC2tN3?=
 =?us-ascii?Q?wDLJFKNrz4GtfV0/H3rLvnPfyzpXfg2+qxoCI5mNG/Ln1zxT8RlXTY3nPs0r?=
 =?us-ascii?Q?e1J7r2xSpZpaDpaap8rJjiBvfGmENQL/u2iBHx2mYvIxOqgUDxgpzwhKbd2C?=
 =?us-ascii?Q?9DKbvJXZmXbm8Q8i17DcyQB5mPNJfhssexuUuJbMtAgiZk76tx99RdionbLr?=
 =?us-ascii?Q?H6MaUlIK+G0VArhaf0yNL8j93vYVTVu9ZmDiuTZKpPwVViCPdyFneMDiAMVQ?=
 =?us-ascii?Q?O9pkTWeQP/dyWRT0MD0WVSJW64kMzyYogjT3p4E0qUoIK8+jfEzuSlA4dLd4?=
 =?us-ascii?Q?RhGP5BSNzDKYGmjhNXP/SXJmRAl8QHIlurAJlMLoFJyVtxpqmHqjrmNDkyqA?=
 =?us-ascii?Q?weXDPy66f2X+n2sYt6mxUv9yk82ebma5Pcs14t1F7DqD222x6Cw/4EvS7n/V?=
 =?us-ascii?Q?y+iYgKSahXptmSeTzxuaoyKpSdiqaDal+Fx8R3g7XdUS0Adl2L2Gfhe4Sgjh?=
 =?us-ascii?Q?UP3kqMAoSrRM6N1B2+5Nw8Owsm2SR4DKLEtoN4H2aawlcyBOPNOBu6IgIlTi?=
 =?us-ascii?Q?WVpHY2W+eP9RtS/JoMOszCUtdO4DAYa1yI6FLNXuT8sffYv7YBN2bZx1EnMd?=
 =?us-ascii?Q?NjVy/SoK3HFzNxooruT06XX5uCGBABRFEMtLy4xAn5tJ66KRM9CNlQpalXO9?=
 =?us-ascii?Q?1xBBogv+6AgwniAP0oIUU5wG2xp56gpCV1YZC5Jk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b3eb8d-2aa6-4ecc-5d92-08daa481eee6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2022 14:25:19.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCEOKDz/G1mN54rkavvkUXpoyLDnugsWcPsc0wS70gfYHbvHy3mGq5ZncE4PgtHSPrqmqjbDLHq8LupQoCjFcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

This patch moves the duplicate code from __mptcp_push_pending() and
__mptcp_subflow_push_pending() into a new helper function, named
__subflow_push_pending(). And simplify __mptcp_push_pending() by
invoking this helper.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 90 +++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 296b7135e9cf..66c97ac06a4e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1480,12 +1480,6 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	return ssk;
 }
 
-static void mptcp_push_release(struct sock *ssk, struct mptcp_sendmsg_info *info)
-{
-	tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle, info->size_goal);
-	release_sock(ssk);
-}
-
 static void mptcp_update_post_push(struct mptcp_sock *msk,
 				   struct mptcp_data_frag *dfrag,
 				   u32 sent)
@@ -1517,6 +1511,52 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
+				  struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0;
+
+			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+			if (ret <= 0) {
+				if (ret == -EAGAIN)
+					continue;
+				goto out;
+			}
+
+			info->sent += ret;
+			copied += ret;
+			len -= ret;
+
+			mptcp_update_post_push(msk, dfrag, ret);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+
+		if (msk->snd_burst <= 0 ||
+		    !sk_stream_memory_free(ssk) ||
+		    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
+			goto out;
+		}
+		mptcp_set_timeout(sk);
+	}
+
+out:
+	if (copied) {
+		tcp_push(ssk, 0, info->mss_now, tcp_sk(ssk)->nonagle,
+			 info->size_goal);
+	}
+
+	return copied;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1524,48 +1564,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				.flags = flags,
 	};
 	bool do_check_data_fin = false;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int len;
 
 	while (mptcp_send_head(sk) && (ssk = mptcp_subflow_get_send(msk))) {
 		lock_sock(ssk);
-
-		while ((dfrag = mptcp_send_head(sk))) {
-			info.sent = dfrag->already_sent;
-			info.limit = dfrag->data_len;
-			len = dfrag->data_len - dfrag->already_sent;
-			while (len > 0) {
-				int ret = 0;
-
-				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-				if (ret <= 0) {
-					if (ret == -EAGAIN)
-						continue;
-					mptcp_push_release(ssk, &info);
-					goto out;
-				}
-
-				do_check_data_fin = true;
-				info.sent += ret;
-				len -= ret;
-
-				mptcp_update_post_push(msk, dfrag, ret);
-			}
-			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
-
-			if (msk->snd_burst <= 0 ||
-			    !sk_stream_memory_free(ssk) ||
-			    !mptcp_subflow_active(mptcp_subflow_ctx(ssk))) {
-				goto out;
-			}
-			mptcp_set_timeout(sk);
-		}
-
-		mptcp_push_release(ssk, &info);
+		do_check_data_fin = __subflow_push_pending(sk, ssk, &info);
+		release_sock(ssk);
 	}
 
-out:
 	/* ensure the rtx timer is running */
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
-- 
2.35.3

