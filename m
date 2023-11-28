Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F75ABB7
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wv16PjBP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXexXA/yxJw/3x0e54UMqqCc1rLgYTwhlUL5/U0bh+0cK9j8B8md3tiZmzC/RuoME9pb4T6ywuWGmAMH77OWOiTapQfpZ57oHIbvASsrcVUxHkJtYwDaappXpJg9TdIsmLRZrr5kzKWco54Qj+ZM7GRnRz3mavKQp4aS4ClVhs3Z3t7d9KCfkItCOjhKp7u272ckumBpIAG8u0Nhr7a99Ed7tY/Ti1YAQHQ7nTaFeRGGMtZM/+ptHJpPIo4RPiAKpqIpxV4V5b/nh6mAQVH6v3bMvoVDa6gNncZEbdxdi6CnDTUpQQrUhrS2WG64Ibr/ebFzjHAZpMOpHyiFjLN42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=P6SGF5SlLt4ZMPpUtfMdeCYog3U18xoiGxoG9w6bUNfBCjkWovQJATWUC8bbvA+HJD+D31cRRlIrjKKAVF3kUJVbdi4ga3O/E2SkuJRCFjA5+k2qGKhh36g4VWVMt0LCAaBRVsj0MuQjgndQ/Jbc+OkY/vbdITq4MvMFq3WZZr2JYmJyFNgGYVuzXHl9F7zSPOSi4OR3kRhDYPPIfGQt+BBsEcC+WcHj0MBXpMffikFK2tBj4HtOkaTgAbh1otgSExYlh/eaWA7M8dEB3Cd5pSiXE9dGSkhS0vS0Tt6J+2uUGcolCzDt9HTNfTtmG9o/GDp1iiuGFX5MX9M9DxWpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=wv16PjBPfJltV06scrfsoIuWg3iWO/Pylr/k+fS+kcHNHJjiFmN2HUc9RrLxeD4kG0cF84E6E/UjZ8ILNJPlIizk+gI55kt/QffyF6dcgTFcqb4m0seVnnfZKfVMTVIVLeQD0ef05L0xwPVqHU/I1LqWxOgAARcS6cJNrhtgyjILBAGR5XyR89iOq/wSnWAlILkPhnvFjLVotmQMlONe+Ntq7Fvr9+fqSRYic5R7JnqpizRNLWIypZus3Auxt3nhkFLO+iVfE67pfkX1q4rztxil7yI0gJHirZ5PIU4tS/tvzAO2lrYed0p4fwlj9cNR+rM+RClpAQuwKM28qRg8ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 01/32] mptcp: export pm_nl_get_pernet_from_msk
Date: Tue, 28 Nov 2023 22:21:54 +0800
Message-Id: <fa7be17f49456c4456c7d45cb0da7342f7c777c3.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 244ca4ce-94bb-42a3-4537-08dbf01d62bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fg4ojEp5dvs+5zG4VcWqUL7b2/ohld4rbI3m+KsjglHrzp6IX/gENu2MEaEaSeXQ+GK55SAFmSON8yVzIRVNM2+8IZPFenzAWnzJ4bOzCkeZgxTAVTj6Zwb+JX/2vJu3qNTO3cq7DVLubEpah+KRiXbvBhNyCMbeHjv0S/N+9b5akALRYeE+F+JFs+ZEpSIQobGtUAG9IzLwocjkOo1BQ4K0CCLo5QIFul7RSkUeNCLMQofhz5CNEdh4DmAqzoXhHpgL0vxqj8Lqq/XNeCWCj3FES1pdpm01kgoJx/v65B9O3F6Fo52pn/Z2Sv4UE0tveO3CAGlo7SUVw0vnR4ivq1Jl3oqVUxnjfhNxcNhlO78GjTg/MQHW1f8k/veBCReScD9f+SopmlAP4UWKwI5IkOSRlBRzy+2zeMFwPTUkur1QTGYye8caoNfpE5znkykDGzbUmlMLQG2iM6PnZAmaW58KLZVe9YWy+C+j3WKpopOLh75k8f/UBxikM93jEjmzhHoFkyVoRkI1DERLu6yUwQC6P8hQakxtusJTLvngIpl6acE9Mg4q0JJ1SBgSP2ai
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x9D1G3rjIVZ6bBvGYLnNSJWby7GLtkOq5Dbj9+g97LazXJcXI/lW7PNat4JN?=
 =?us-ascii?Q?f815HfVnsGq+oJKZm4HuuS9mcYLZ/08D7FK5jfEk0LurtRp6EO/xsMNCK7bL?=
 =?us-ascii?Q?VUXLFEHsGZIux+0y4XQm6+ujiM46Bhs5LhSyZeJVxTEQUG1PfkKJQoxvmQIV?=
 =?us-ascii?Q?AvJ/COY6igt/CWThE3Ifo0jDYXr5WpEDNRNELdrqpFdIPxMox3fuJoWl58YQ?=
 =?us-ascii?Q?Z9KkAV95IbTuGfyj//uRDgwcAJLRsffWmZapFli0BG3OcPQnz7GC7FMEPDTo?=
 =?us-ascii?Q?dfqXocyC3dT/lxYNQWwUpUPeEV0y2kYNxNjURJy4CnTFzg7rWFgSiNliQ+hi?=
 =?us-ascii?Q?GnEQ1daKKf1UjAFTzxiuLCcolOorMW5d6u3V32dw56uMhxkzbLNKXLdlo/Mg?=
 =?us-ascii?Q?JouQ5sPRGYQL1+bIlpSduV1fhhB+pS/glss8dvBxVGmCfJF44RlsPaem68IM?=
 =?us-ascii?Q?A0DPpHtZCIqUhroTHZa333QPdltmE44yJzQMFJbXgQKvXc5IDPBlXnIQ1ngm?=
 =?us-ascii?Q?5rJIuKY5A/pmaZo7q+oUX6+L1BjhFIJ9I917qC2EOp4WYdLb77MDIpDNrC/b?=
 =?us-ascii?Q?RW/SJvIgWjhu1k+pRDCFUd/CkX9hyEZJ3iMU9wAcBEKQ0cENTORVj6G2u/MQ?=
 =?us-ascii?Q?F6ovfdyzCliejR37ByuJ5qr4W/+ec7tiXcVmUAf0fY1BoaSSaF97z2pccXBZ?=
 =?us-ascii?Q?Ir7uyfwNmj3IIw/iaLvzQTYMTVDck6RM/CK9/HH46Dkowebtmvtemajv0AhZ?=
 =?us-ascii?Q?dcCbWP1tvIDOwVM19nXowaniBUSB1PMtVs/imrPxu6l+tQXd7ZVpjF2DLKTg?=
 =?us-ascii?Q?jwnrAtryULAG2Fiw5S0yjU9LTjGDnSMRyJSPwWc3kLmyU/D+hQSygYLcY8LZ?=
 =?us-ascii?Q?6PoZr9BIRNNlZTgj89TGBQUixIQ8utBiktlswTcnstZMq+rOow0YyBf6z5ce?=
 =?us-ascii?Q?Uou/StzWG1EyMbFwI1cfk8HnZNuG0vdAOaiSOOYNglXdIsns1s8kZGM5/7EZ?=
 =?us-ascii?Q?zVLuY+pERY3AZyefZea+ngRX4f3PymE1c3mM2SD86SoZs1Xx0JOjCOlgI8ZH?=
 =?us-ascii?Q?2bpjdbIBezYzhVQhefppbvexURSdbeB8MMASdV+LS+JwA5CEJO00MDAkgg3D?=
 =?us-ascii?Q?REydA86HRhrGh/i/72jr+gP+a1TQLjIo9U5RoiZiV9DH6MfJE2lWqNX3oaoN?=
 =?us-ascii?Q?Mnlufw3Xlp+/TFlbCxeRGs1caNK5Z8xeygJncnv8kqbtEDTBosJep6Of061t?=
 =?us-ascii?Q?dXwNdp6u69RW1jwZeUclJzYjb2nW0WG456Te5XaWl7irRqzDcsPxPQ5k8117?=
 =?us-ascii?Q?ie4Mv6sb6HqGAnnM5wF6lJr44nGgffLPiF9PDRvBoUnpUvDAMWxqhkOGUjvc?=
 =?us-ascii?Q?U0ZJIUiSaOSjhqq5jofQYX/rBWuoEoD66JINuKMkNMMiBKZr3mFWz+ZQEdCC?=
 =?us-ascii?Q?FoEZM+T4mE4Uusz46tEWuLukokSDjSTTIK/Sb90uRcYdYzKSjx7FaSuv4hNw?=
 =?us-ascii?Q?mYI1DczsVHbfjJi9aXsh95bL2o8Bqdi9Lwuv2hDgM3nF7kBl1VRD3W0o3Dq3?=
 =?us-ascii?Q?1fplrYp+Dou33MraisBF+ey9E3lM4nPt9Mv1Z9hs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244ca4ce-94bb-42a3-4537-08dbf01d62bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:00.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZRJrmYhgqfFJrFJ9MIE7VM0fzZfgthlxKD69H97GibZG4VdVY6ipc2zwYalfZV6IcFzT7OHahnDzhGOPCqQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk() helper.

Then every fields of struct pm_nl_pernet can be accessed everywhere,
not only being limited in pm_netlink.c.

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

