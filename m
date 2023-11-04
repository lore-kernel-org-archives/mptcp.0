Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA0846B
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EF0w/4bi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWJMit/eoIKkBorSRgsuWOWWG8FnR5dqxUu8BxB8jVG+0gu2d1kI+eO3TOzY/iGFT0uq5tM/Xo3yyuA6N9jBIEzXu2vUOrQ6zuOBQrm7sJxvtgu6jNbL/IPW59g1e/uBQ3JZCQABL6ZznZRHElbwA5Nw6b4YCmbhEeQT5cig0kFzrv21RHAARP1WYznZ0vwUR/Kcs/TDmdl36zR0pqJmRAfy9075/13Q0LkaWETGfg5JsSTKzEMkQsx/Su5GrHo5BF3N+pmbKa2WrftfxDkDiSQXfoL5CVKhDLqZJf9RF8PWIWc1qEbLZ8bDnuv0h3AaV/tlm2HdCn3wdbvfcZHBDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vReZACddXLMbMaskUnWwXjR6MncW7/kCiiIEdU023zA=;
 b=nRwYssWmF6/qVu/vwkovIOLc8cda2pJAL8xOWw/iBzBswBidmYpJIN+zSmRjFAtqZqg2Hqo4aTjv3ulgbhI8+W+uX8meW5WOFBJVwveLCderbtagLeTqnspIqy34BRotF2Qt4iCSAwg4ed0S4u77wjBr2kuZTc/wblYLkiNqWghHk4/EuomZoqgkXJ7/UlCyzb5X76E3X4SI1SA0jvpl5t0Gm8FuVNdHX95PGosUre0RH3lNstBVv+VfVND3K3admk6kJycw/TVMBlLiKDYFcJVVP33xnHvUPNbGspU2D6jTb/fY/wOwDDFE/uqG+YYyoIQIEejI2wPXnKppnA5g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vReZACddXLMbMaskUnWwXjR6MncW7/kCiiIEdU023zA=;
 b=EF0w/4biqgzNY6Pvl5NtMJFbvuDVvZMtxCs4GHP90L/aAlo7H9Zryl+4kTEddMHQmzq277u7eA8k/psbDoQTBvB8kkUk4YFhVWp+YIcwm7kBtM5bMWQrfPAqs5p4KYrMyCSAVYuiP+/9ACIpnpd6upUYzPDBeUAbVbFWKnY3JTKzRPvHYqvPmBVbp8UKHG2qzSdABV+IWGsML0kZuo3lAJCG+JXSLNVtOzwfeimdYhdL1h97imKkxrzaNSOXLPJrzgVdg6c3zIZGZ9vOP8g+D+y41+Vn/CFb0pyn+yzAF59ycD4pHT1+5Urvlc8MUO/ogH67InRPBrMeTNe+gVTbBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/12] mptcp: export pm_nl_get_pernet_from_msk
Date: Sat,  4 Nov 2023 16:35:36 +0800
Message-Id: <b42e662c372dfd153a13c1fe451799f0ba1169c6.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 578a3908-9450-47c8-2a53-08dbdd1112e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jCWjYQcTXhMFzgcfnFM53eS+wRzTAZ5KYj8mmRP3e86SI9jNUF1Mg2A0tSskxnwtpSBy90eAmJLpCi86avlqPqepSBjLZP+tJ8n92p6mhWZW6u3rPo1tON1enXpZ+frIS9vjTdQEJguZLgXD2evLAEwg09fs3fr0P2txSmTQLYFACCQUrIhLrheuLeJR7hLOEhPmB5BdMwl6vlNADSJagImEJ6erqbWKIgGak0hLc/SjZlzokKwvV/kbpJpWax0quzQEXISVNSxfzeKyfpRrSRmzaCGiFnSzSCES4grTL2lQr2lCfmp51EvaQZLDiZHg5LA3CN3iFixYOu3zogq3kF3Ln8lzMQFr9PmJ0QgrE+gFmqthbISVA1RgDt5K3Wrv0wgM/gV1BgLdZopOSH4pl932ZhjPKFKPV6KJeFAejTMdKzX4JXkBF+wUqQ1oo82Z3ijTumGxIC5eci4Or7IZUcy70umIp7RIhNIn3bdLRmLQtxMHknEGXcjgIULcJMigLhtM8BzZkQzIsP1X7zYITJLcmh4i3NeBMhFQyZhjTyUagrygHWsRZA5nbFQXPEFZ7gZ9xE2s5R87544/Fey9qryRa+Bs5s2t7veMHtt1SIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(83380400001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfSlUSosuTncjCsb253qmZgLsMs/ebmemHfhTvPmh/fqYFufeyhEYcvHmmwO?=
 =?us-ascii?Q?VWJdplC3fCE5chuOx1z3smuvPuNmZXKjX8CHbJsFsUvM4lXbaSxYg4Y8VvnO?=
 =?us-ascii?Q?z6aVLN8NNJ8Sdh6Df281rFoPVx3rFcuBxmOms6htpFkMulpuprf9MDFQtWPB?=
 =?us-ascii?Q?IkIWoAFe1OXy5n1fN8vbIKWkgF+Q2eZD5URyM1vBtBq+103W3GADown1Ye92?=
 =?us-ascii?Q?3o1U9k76XaZ52Cw2cv+FAGVn6O3M4aUtoG5IdyXPYCqh2oR/EMJNAOjNAcVt?=
 =?us-ascii?Q?3V7aEA9JsHSry7q7pYqS9/gXMpwv1nzd6cpvAv7B6v13sBZDN3HGQKEsNNRY?=
 =?us-ascii?Q?sN1+oPngv0YMfAp/jewTmMd5YE2L7JaZ+eN7SnytXqAZw/fFZFkVV+SubJyA?=
 =?us-ascii?Q?RLwPlpafxADFv17tfzv69S8ari9VYabieS0VUeoCMYEKtJ7og7ou/qjd+O+C?=
 =?us-ascii?Q?49xVWe30+Tw2O20QCbqTYIbg+pPs2uJ9mR9nMLhuSn51xklM+Ie07y5mdtBC?=
 =?us-ascii?Q?sEc8Yp+2H13/p0QPH55MaVhUnn/wzsC4I86smJp6CfgmJl2r58Ebwrg+h49/?=
 =?us-ascii?Q?aaIw0xko3R1/6ev90Cm7ybgmmkg1H7zedH7A6kEStOVfMyiECls7K3kSf4eI?=
 =?us-ascii?Q?PVecSkyEiT/qY+nM3EoPn5UsvNVuekPF+Po9Le2dcRxMKWWHp8cJ7nsODtbH?=
 =?us-ascii?Q?I05LXVrOymzE6Z4AsJ9DMGpm/NMWvRvJKLpUDZHXOsClrwi8+h8dV/prllBd?=
 =?us-ascii?Q?0UmnOPflTID+SFq85K+APeWFvRWc0NKRpt02FqqPrpzeNADNXUPGeAYmKZz2?=
 =?us-ascii?Q?3Kb+yCy4MYacXzNH4UIzDmA9Ar7L+01/OaNmx//5fsOC1AexgGjAIRRVdbZO?=
 =?us-ascii?Q?7Q1DJmM+zA6BfIdY0dGiSSKEH8reuae4s1mu3lY4iqrBpzviXB95ZSbEKdt8?=
 =?us-ascii?Q?a3isNAKRgj1t5/fXxJt7itUzvrdKpUgt5AqZtAV0a20h7YX60CulP4qnKS78?=
 =?us-ascii?Q?ChyVDshygz9MqMCUwxnzzyDoPu6lBGf5MZjvJl1ifTG6JVu3pTjgTWFgxadd?=
 =?us-ascii?Q?a85P7x+ciYK0omX+qIsRg7oM8FKVO0Voidw+lW5LqYJwzjg6gJ7rD0XUa75d?=
 =?us-ascii?Q?r/oj3UgsbNe3oBvU27pR1Wx4z3v66H2+usLZek03ydvu9WHqKzRKGMyjH5Qn?=
 =?us-ascii?Q?gTRbjhwVN04kDTZyyRR0/AOGon4jj20oxnYzN/DEgMgQDfXbuphhcXmhBTpg?=
 =?us-ascii?Q?laK+bqWUTPr268qandVMklWs4lRD7n25mlTqwnK3rRrO86JtOkj+rcS3H3t1?=
 =?us-ascii?Q?xWjziHrX6/Py8dxdrV/+PQK675UpRmv5XV93MMGVd2ePHkFiwz7VFc8gKlaI?=
 =?us-ascii?Q?hmEtdTZgFFgN4JL3FDcwr5QgWEtein6xNP91jfh8P5explWnMemsa37r3xQ/?=
 =?us-ascii?Q?zZQf8EwFaBzpv52UatZWFsu+Rwp6ghrvBzAxm7GZvK0jxHQiQCVodU10OoZz?=
 =?us-ascii?Q?J6doVGDvQeAy0OwXojEjSO7681IevtFZ94s2Sh/pfXpYMMBZ2os42I9EeNln?=
 =?us-ascii?Q?22bfoU/Nrsjejn72AHyp1SDGSkXdE5oVhQwbN1fSlCxt79uy945Y++FHFtMj?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578a3908-9450-47c8-2a53-08dbdd1112e2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:00.5977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxyFb42Qo77OdQhY9q3ED306RDYjSSTDK6b6UIHvUgGZM5F9s9rMWBCKZfnHK7zfPewyHK00cO4De4rTN0d+qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

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

