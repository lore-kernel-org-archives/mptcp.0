Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2070.outbound.protection.outlook.com [40.107.247.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF71A58F
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="3Zkh0F5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyuULxAdiIOzugYIkn0wuQmkzIzlCEjyjPVN4JzjyPJOVqkNV4Kn0/zAKcFbTNCVCJpwRtY3u9Vv0dwMGxz9XKZNSe/zVLvza3r+0jjhn05U0FMoITi2jdp994FPU0dwFP6aSV8gy8G1ael15WX7F6xr7ZkvXFEknuKVQ1/Hv996yYY17zez4mTMJPKJJRfzZ0PjgFPW102yOhjnKeOt/TqfK2n78pVItlC6oRA5izxrDwD//GvAxQ/ZD9a3BMvosDWTYg37YXF6KbaK4W+DbFbM0RN+U/vDbahfzEiQbpcv2XcCpVFUQVHTLTsFVsoLerV/pbrkd3nnjGDshHy+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vReZACddXLMbMaskUnWwXjR6MncW7/kCiiIEdU023zA=;
 b=jJ1ot9APyp5+8qRhAcnSbfCfT+rBBQ67rVDAh2xSEZbZCI+vp3cA2u5JFZw/3d8Vh2qF3PAM3ZRoLETnPQMtHNKVBRLEkVq8HYjmkRLtXf7AUBqhuVIayV2c2mW4dC0kDxXrDZaYsw5lcUp/xE1lDrVm8pc/jGBJdqRiBEyMvq1+IPaIatqy9uP8r3g7dwDi0cOxqXEMuihOZ1hritvysdXHdfbE6AJ7om5PlH2ECjQR3tk8PQGcY4zipRwwFx2Ado9V4yRaSu35302mXTxtTVFEzx0StfeVzgC7jbApQlcWP6HY+P3hRu+R7bJJc2sjnC0D8HFkalLnQ5prZ3WyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vReZACddXLMbMaskUnWwXjR6MncW7/kCiiIEdU023zA=;
 b=3Zkh0F5vSiT1Z0PkWvt57oPLo4EmPjEVDh875H41aonP19AhelLbfXxC4U9BMs0udlOiH82MrSeDL7wSX+Cje24XyAIaCY7UuCMAF7TYfg0uZmX2Em/wMotx0BEILY3kADJ2oVUG+jVWm48SHqCTUaLO+hyLgmM/2c9dQXndZtrBc2e3jpTJ3AmnmU2HpoUHuuet1RorB+628v52b8POifjCW3MR2d2vJ55RO8tNKSwK7X9SUvN9GsPok9VD/F2zJLsPVS3LD27NRd/0XsXTEMJpnAF7YeZYup09ZaKBCEtq9p4n0E7JYJguRcs5zEX85KJbHeLrgU+NOt/PRFySHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:16:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:16:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/12] mptcp: export pm_nl_get_pernet_from_msk
Date: Sat,  4 Nov 2023 22:16:15 +0800
Message-Id: <b42e662c372dfd153a13c1fe451799f0ba1169c6.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 901e0ccb-258e-4e9a-4330-08dbdd40acce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Npm3KFi8gPclFG34qqv6c16I1hDPmjEJREMn4Ls+0IJIINN+0xzSW5bCeIydhTdzWl8rcKAfSLDl+ryCB3GzkIsY96721ThuiEstmY6h+ziamz5fUfSN5DrZMq+GxqnKkJQBdxYrhqLOGtd4GbDGrLvgg0xfDaF8CvdT6n3tG+yzDpDqTyQeOjBN42rn3BnC8TRZ26OY3f9o3nPFdOLI5+VjTSkCwalQ2qaJprzOYC9hRvCQVh7eg1AMKJZotw8yfNz1yRoV0lceGvu3/jvPpS7z918c7Hphk7mQPQszM7D/JzJqnCb7sM/IhXsbg30n9YLwt3oju0nTDfjYUS8jN1DC4W8756/FHeZ/StGeammmxQTmhKwBgLEX+fMCplNDeusUybcKZ+GPvqAiADteZMqawnSLFkw0RcfGXozu+5VAXwVv2QH1lshuvlo4A8JOAsrHQmQZEIg8gHsa39ncYhSjHe4s/PcIejEO+/BeR0nKs8pkvU2pElUXIdae77CimiHYjpmqIpz5Ld0axw4wZS/yWtD18u/QIgQhbp148QoMtQLe2Ljkdrog1MmPoSci20adKDao171U96X5A21LcT6Xx+SoD6f3RJTRdzUyZ5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a7P+9jZEgxeU17o6dRx7AI/7da339gBdhkFSQgZeoirs9tCkz5EltwGgTKHh?=
 =?us-ascii?Q?hyeRM5xmOUIqXLDXQyxbsMQfFLVtdX0nKY51/DHMRupzkVRSoqyoeAH0gRan?=
 =?us-ascii?Q?bcTLFKS76Cj/Jj04moa/vkmF8Cp3sh+TBGGFiEinapTwC7Zq5KuTXG4z/B8w?=
 =?us-ascii?Q?/YK1jwJLOrBbcTcXCz8kTrRICkrRRMuov7EqVTzYG8etT7ohTt8JiFvi6V+4?=
 =?us-ascii?Q?vTkfOjZ59pMwUfONpSW1iUFvF9TLHGMVA2rf90hBctbN8xUDThfU70ai1TxK?=
 =?us-ascii?Q?j4lATHIAtVnAki3Xz2tHHah/rgwzNxG1dDBQ1RV5koMz6/wEg3z2pW8OlPlG?=
 =?us-ascii?Q?PESAIqZLqxwgxhlD/g9CzoqLDduKGP3hpzBjc2gRh0Ac20qSg5MR7xp2lLIU?=
 =?us-ascii?Q?+tuOwB9k66p8+SSjbhfkjoxWxMCw+jlb3Ze1IJUlTqJxQG4p7GrfX1rJ39ib?=
 =?us-ascii?Q?t5s8UAFh0bxcmwloX6H63W5gs0sXe15KbB0X2I1E29VcQFV/o+zzS1aY72Sn?=
 =?us-ascii?Q?/Ig/4+nRqgt00c2B3P7TAGK+IXGHVs2ybagyrO/oubY9Lmq0XyKSCcl3kjHr?=
 =?us-ascii?Q?DXB1x3U7bG0B7NdfjjrL+brL+RhJhYhZo01Mx6/mD8DMfQz6Eq/qs8Ens9X2?=
 =?us-ascii?Q?G4whk65+TO7FhK9C0oSgOzv7FF4KibU3jaE1MLPcrIU+efTPlW9WdHx1NQVN?=
 =?us-ascii?Q?zRegt7147R+yn3LHKkyjG8zXrfhsQ6kd0RTUh/OgMgKlGdgKMg5uw/stT6Q4?=
 =?us-ascii?Q?buIiIr9NTw5/h8uTCV7S0Wccn3pMs4Mhbo3mqELeTonqlERWX1oPSGYbMF3m?=
 =?us-ascii?Q?KZ4WVzaIzj9N4hG4I/I6HeWT1OdJNCgpAUe63AQ2vebd1gnjNhD6xkyd0RiZ?=
 =?us-ascii?Q?xOPo3vAgfwew03J9QGBQycKfFwpqdY8DCcVR+yVxVbIkcOv0T+ZJJ2SPSPEh?=
 =?us-ascii?Q?ndEQ7VQrG1ParI+z+Sm20oM+6ymTSKb1rjl+T73t8xn8q2ek5Lmk+aXSsnhi?=
 =?us-ascii?Q?AJmqMuZ3mxKta8wZdJ7jJDFTCSi629rlLnURwqhejUuy/QvXLBGNp3884AaI?=
 =?us-ascii?Q?3VsDHrFtPUr2JVi/Dfued3uMnG5YeNNKxM1FNdOppey06zxOSw1F0jgyc+l/?=
 =?us-ascii?Q?FqLRkzXZ1V3hE9x0QCVG21qUzYGTNDRz4oUZF78l2DM4MO2ISyKE+M6cSwMl?=
 =?us-ascii?Q?ZR/RJLNsMyAidUDBQxOw87XltuuEvO2vTbhllWClBfZ/B8I/RbMPB0cFrI73?=
 =?us-ascii?Q?3f2FyxxH46z4d3bEEMgHExjdakjV5duJ6YuFRBvrI6PeS+VNv2/jD1sl4wNB?=
 =?us-ascii?Q?+PkqzOLKLZwLjLWJ0HkibQ7rUFmqbADBeanLhCdqBAb+YTHipJM6sJOksi43?=
 =?us-ascii?Q?npTAxAYEzh9zFrcOem0C+LeB+wJdIHlmjBJhcJhp9XVOeUOmkuLOKBnIkr+9?=
 =?us-ascii?Q?ZjqMMwIrJ2lf1r3iMcqIR88l0Vf9aoZu00KqsAijOkSNGgXdKE2aHrGIQM2u?=
 =?us-ascii?Q?hLS+9Qb4TtdlmVv+SnNmqrmHxx5KrwGH33wug5n+rqDH0V65H/JMotMXbIjI?=
 =?us-ascii?Q?SAqb/tZL0dmTrSwDBJgFMMYCnWNykbUYLQp5nGP67Xii7YNdn75lZ1KNFn0a?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e0ccb-258e-4e9a-4330-08dbdd40acce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:16:45.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gg0zlC/GEA/Vid0LIWgZDB/Kxq2brxeShHQLDhFPnOswWASRT0Y1OEfZbQsT/uYUa+rv+7Y6fvMd3zJHY7vqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++---------------
 net/mptcp/protocol.h   | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index bf4d96f6f99a..1dcf104d7a01 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -31,20 +31,6 @@ struct mptcp_pm_add_entry {
 	struct mptcp_sock	*sock;
 };
 
-struct pm_nl_pernet {
-	/* protects pernet updates */
-	spinlock_t		lock;
-	struct list_head	local_addr_list;
-	unsigned int		addrs;
-	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
-	unsigned int		add_addr_accept_max;
-	unsigned int		local_addr_max;
-	unsigned int		subflows_max;
-	unsigned int		next_id;
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-};
-
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -53,11 +39,12 @@ static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
 	return net_generic(net, pm_nl_pernet_id);
 }
 
-static struct pm_nl_pernet *
+struct pm_nl_pernet *
 pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 {
 	return pm_nl_get_pernet(sock_net((struct sock *)msk));
 }
+EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..c38a2126071b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1026,6 +1026,23 @@ void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
+
+struct pm_nl_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	local_addr_list;
+	unsigned int		addrs;
+	unsigned int		stale_loss_cnt;
+	unsigned int		add_addr_signal_max;
+	unsigned int		add_addr_accept_max;
+	unsigned int		local_addr_max;
+	unsigned int		subflows_max;
+	unsigned int		next_id;
+	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+};
+
+struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
-- 
2.35.3

