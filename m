Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740881864A
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wRP7DCmy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di+P+LQjz6hsYGp90wg+i/QCi8NvtPr8kAZMRbTId5emt0tZlbLv2d3OcXXCyaLLzeO7QnR7BgS3oS9RKHp6bQBrYyJ+ZcZOki5wRgnANN7D3yQWCiAKG87a6/nGTwdXjcbrdVBOTNGO1J0wdsByK+kf+c1HZ5MOgvkXDn4JuikWVvZOSlyeFnug99OejN5fkx7v0/JxzDqGHhZBSy/EDAYwg7Ue6P7gLKZE/nbS8il5H7my/QK1ahmy+FebuviuAHoGY3RDTTG09lrd08TQ3ngzJr4mVJPVWLjvmvdjTZCD3+XmsDrNQ1la8y8Gj3hvrmBI3Zu1veT01BbU0ko4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTxCSo0vaRhbuZFIZ71HKTCum76Pw8eW5h0P/uRKP+4=;
 b=l8SrUE4q+xLtFC75jyckinkJWIoEXPAHNomCn16euxMffJLrhgfmEeWbp2pVidQt71JP+uESpRiaMs8qayzGookFHo0r09gRNSPrVRb3xpMbtnYKem6eF/mYkMHFnifkuU91dcU15+QAcI/VkNDdPhZPDLdBCP9R64k/mM4s7txT1tynrTktiuh9pZzRijEerEzkzRfS9v2aNLHoEFjSwQJTCu+vP7Z5UjEJh20iKoq5TwFa+cTKcrfwHxKWXIjvdSAEuEVH2rM0+YwyNfElTHpAIryfOgqv5fZfurEH/5WzxtkYTSSsLKn6aVHPIWJkRILNm6k40XYJylNSOjkiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTxCSo0vaRhbuZFIZ71HKTCum76Pw8eW5h0P/uRKP+4=;
 b=wRP7DCmyAPDN1Rl0rneu/R0Mzj1eatWFlBDvr4TDggkilRMbt6fS8X/CwxV2V7MXYfltGnHSmpEdknYlgrjdV+Z/urasvae2etZXEeHHCGg3ULXfZcz0DLw5wwI8NDiifHzw1do98ao1HPEvwOgaxJGdI461v+SiJyiZPryaDtun8GFXv4hA+3gS6Fjmz7pWPO0ICj3bBp/xsS7tklmi+pxqlBDzq7oxbzIskLICoZ2oLE55DtPWJt7MMo61W1heed676nx9QJ/3VjHa8t6FrWUsWhsv/2bn/t2PncuspSoUalWE0slolRhPk7sYokqMTNjTsWq8pytZLcuLI77qXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 19/27] mptcp: flush userspace pm addrs list
Date: Sat, 18 Nov 2023 22:28:34 +0800
Message-Id: <a473ba72201864525ed7ce8209e175e5eacba0de.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f63c70-4bd2-41e4-fa08-08dbe8430b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lLpAaom7H5Kw4xV+TyENRllzHJdLdQwm8iKQrSrFFO3oWxfoVizseONWrs+TuiZzs4j/dZriGyMJV6KSCT1QX9fdNZ5YPyuTTRMGbFzduuGV0+07SURYzlg2fAWX4o21JKH/CyhuDRDmAc02Z2Ph5mS8Mo8/5zVybAx1j40TZWNpdDJBoLoU1wDLzS07dTtc1+0G6cI8/giAfLsRkE7SPitAOnjVq4s7PtLX57xMhlfFlXnKELcB1IjQrm1vGORsd9MNWenQC1SgID7JjXd9xwh3QNPEGnRD3cfe6xD0LqAqul2NxDT2nAHDSw9Mk5OgRP+LOHl5yfFelBGw8tJwgQ6RvnfHrweET7yZ8CIFgY9v/vmcn621pimnKU8FkaWVCMgE0rUXQMXayfDVsxiY9VCr12B9I0W/s0QAbMZKFFnNAbDPo7m3t0D3zkc+mkptCX5+a0yQLY/8DgUMHbJG4GgX7Kg5IXzv17BNz45o3g+m61y32rk+PyT5Zw8XvVGXy2zaQzAm3rG5+P/4t0Fieueom0qp4Y1ffEQFeyPTrQSnGYQv5AfAG0OXvFd+4xv4TIbzUfLLpmaSaXX8vKkjknqgfV/G/cJLSnBxffof2eE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5+FLAjcOiuSGqzNFL2CKXMmmWZEShicd3Vi5HcwMd/thTuvq7EPW4N6TM2dK?=
 =?us-ascii?Q?OuJztldYVwPpUlOeT2FWohxyrR3KEj9xOR31ix1LrQXdsUlDC4lbVqCTyYs2?=
 =?us-ascii?Q?hYAOAy5piqYcSzQkOcmGqZzBmCFBqNePyYmzBY+S2D2kC1rGOW6witfC8sl7?=
 =?us-ascii?Q?c+Q6APqWG9k1VjkW2G3/8GN+kesFZUaxQGcDXahP8qgJnXHwlFoKV2O8qHWJ?=
 =?us-ascii?Q?uCkfTokLE00DQfGKLXpGgtF7YFRYNlgdRpdLfhNr5DsfiNtaZdbOAJSSWV/v?=
 =?us-ascii?Q?utnvhMPu6ihfqAkko2VZrZ8PyfQ0Hiz3/wFRUTenE82CvLLxvxWQvJEzoTec?=
 =?us-ascii?Q?QnTgyW33S6vh9IV5QoPRToRtKa7RoHPjHXzh5qq8vKrh7PNKDPx6p3vYBJ5h?=
 =?us-ascii?Q?loOSon6j4COxD0n5AVUZnpmsM4SoA2ci4RjX4Qd8f09rx53pOVFpLIz/jjxq?=
 =?us-ascii?Q?uUCxOLlvLw2Evh6V8ttRK7Gj1zzarG5P3X6AvDBO/l6rO187loedR4M1ilVz?=
 =?us-ascii?Q?zCaNMUoX5u4RLgnmIqP/Acqv+quuMuuz/7FZHPrLoUrYQSVMwpOd8A2WPRD9?=
 =?us-ascii?Q?bVFry27N4A3/Mr0aUO3VMbIt3weL8d3UhUy8wVRHbF4SvuH6KLF/h5L0q4+G?=
 =?us-ascii?Q?qUWRXmj1+1s8LsEEYsGkYnC+lER4WXNJ6s51UNsnarLmhHrsQfo+tVUGqoLM?=
 =?us-ascii?Q?Nxo8QvYsf8n3kbQtyUsYml+7bDkCP/+zZmOhjy5Dl+GMmCMza+wv8uDQFzN1?=
 =?us-ascii?Q?L+IQOTSQJ1o5SCEjSAWDZ+UreyVoFUCpELFESqAPVO9Y7brW7+vZWLTkFszN?=
 =?us-ascii?Q?suwZhQxuNhukq1pcKJDO+jeMQ5H7c+EiOJvxvsNBLUDXbNGZHjobtuXCJcXT?=
 =?us-ascii?Q?ct3ijFfZ3TCG5Css12GIkfaribjL8+/cOCcAMye9uyM25l+S28nRBfewJMKm?=
 =?us-ascii?Q?ns0MfD8j7jtgBlfmmBXz7tB2U+JcHcNxmY5jpA4Gdnc2ZIMScOqxITXGH8/N?=
 =?us-ascii?Q?edeFgSmyfz26O/dWcvqzD9EFY+I6YkrFpdlIfXvb4jS7kWnBLudjKvIqe9rh?=
 =?us-ascii?Q?a6mcgVLzds597kkL3R9uJk7Nl06nCyRf9JBp/6rdNSx6wO4OcqV1AFzaPC07?=
 =?us-ascii?Q?dLKJZ8TWr7xRd41MModem48C4AQbFadXPxTuxygrkZGC10N3AFuTDMaEeN7p?=
 =?us-ascii?Q?m10rcu1piBEd+5gaqmxB0yOjGeAuV6oKrK1j9/mxGKT5QfqJQFmCa34WZ/8H?=
 =?us-ascii?Q?A/obQHSbB/Hv0LAZ7XHNy3838YlauvYf7PQEivsyBJPLVkCRe4tRAo3YJdTT?=
 =?us-ascii?Q?5XOv+w+/b9OsBKNE1cJO0nEAtkIdWHSK/8AFlFpoEY9gaVFPlwaH1YJCx5NV?=
 =?us-ascii?Q?i+Sw8O/88AOh4067GM5RwKHRVg7RKaSuzVdg8Eer2bARVwPrqvXPIzH4btUx?=
 =?us-ascii?Q?w49j/TqnAh6MFfUqKxa78MAU/Zu695QLN1QW90IfxeY9SDo5OsL9GwOwGdFE?=
 =?us-ascii?Q?/s4S+rmhzruTmqJbbS4NOkLxl7uS1mh2gu9mzx++F47cm38vfNID5Jp7iN3m?=
 =?us-ascii?Q?mBKMFmV6TI/J++3WKGmsrbpT1Y5PKKvpPn5l4PbYhhaOZLHcPtWoswgsdIlb?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f63c70-4bd2-41e4-fa08-08dbe8430b09
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:25.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pe2DyKI0LkgI/RGaz33HGZ5g8D7Kgz20QLWD+m4LbrsHt1dIHfVYYLvWAPGrQHcgUyCKxK+s7MMECSRQBvtGgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 412c6621592e..60483ec9cb31 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1574,6 +1574,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9fc5dbd346db..aef8cf3d208c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -596,3 +596,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
 	return entry;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4999bb6241fa..139332f48a66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -945,6 +945,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

