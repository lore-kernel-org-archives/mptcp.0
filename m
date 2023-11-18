Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B5C10A2E
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cxNwQtm5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzNF/4lrTidmuzzLWSt+DQkyI9YJ2cUp976G1TS5cpB4+N/9VDb2MSvELRPOdtVseyUr8/mZBFnVFYlwzS7XqnX2/SiLsE1AO/AVu3BgcJ9/mmWM0zYirZnhX/osgWzo7w35cvPwO8sFwKh0cHlAPuE4wLjijyNbwmrQwAywconBietYuHXBQqVAosOq87c7zoj8FETay62e55ewsqNbK9wNH+6K+9sS4DLiarT6YYUXpxZRniw38m8DisK9XNoklF2TzzSqtyjYSiB9E1osZzKzOk/P+UAFj7oozl7Jxu9SYnWLeO4F/Jyqc/XvslKr7XkSOMj7AXekvu8/bVufJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=kSUyhOC4DtVJK0IGjQYiWElkZk8B1kDwC4b9lSu1zPl2BNcTuQQ1iBO6Bemu0n/SWj8cxucjYgVTf4Eh3S4C64x91Eu7qIcEX6kYuoMj8QnouYggngITIFVwh7jf6aOE2nZcedf/CYzg07TWp9OPZDls9SRETOcnrwNH/m1IZSzEN1xIUXIR8+AYcgI0TidtrvgOEIio781Zn7QbLcqGA20bec0OFnO4DWlA1SNXgDDRTFlsprvEVO375Bjqh2MXi+ea95ZpUbZE46mdpeHgsTLLvAIc/3QIVqC1k4drUZyC+MfydVkTcUWQZG7bEufGywbbd2pUEBxbMR49nj8MBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=cxNwQtm5uSfHoP2Bp50Zh0Jj9Pi9odqlK78d5v+7uGy6w7IG/heQOeS0IZZXmDqVWEKknf/lJsvS5KE4lkMUB7NKe8ZcQgSLeld85DIq5WMQ2nWwjDEufkM0hHMsmMSsWVOcRJIoZAA9WBTxQTPMdgj999YnmaezMYlRgnoye17TlFHxXbQ/uzTAeZNe59Twu0t7lCEvyYCxIPnUvoH7BYdWJnacTZR3gg/p8np10Kl3FleFUmA34hgFW/tBjUBKhvCkKbYcQzwYSd/UACRVGh9gK6ljOBuABqM3pcqezYOsKFp4xFnO+A/uoNpjLPX35uwu3y8uJ9z7fmlyyZdEDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7014.eurprd04.prod.outlook.com (2603:10a6:20b:121::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:28:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:28:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 01/27] mptcp: export pm_nl_get_pernet_from_msk
Date: Sat, 18 Nov 2023 22:28:16 +0800
Message-Id: <24da5afce1c88d8e3bb192138b9a5de256b402d3.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:404:a6::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 9476748c-76ed-432f-a528-08dbe842ad29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AT2PFhu9Tog1Yr6kIt5gtc8pakmTPfvmosrHMf6jW4ThQBjTSpVPbl+LgPSebdu1ce8eke04nCObsQcExwTPdhi00bNzrQ7Brg6XjHIHjeD8thppMtcLWqZP3+8H/LdrsFpz+rdbl9gBxUBNRjwUUUKijY3FHRKna88CghWuP/jNELwbV4cMujesWKK96Ce8ZIwuNSPj5wdSiKuqzgzgF+W35D/X1tbKCTVpf8VYSJDneuHaRAo8dt98J18s9XBR6RwlQVtP2i1qyd0LSTLB9CeBxxNBFRpZNO2jtst3/bovnB1ff4gI/NBJLI4e1XMCqVDWoGw/h6b881QIHC4CkW/5OcynpHqwIboa61dMM7j8GN6GVAO9wJ7PMJjx7obx5lmfkVA45N+kfRehzN3VxdLGZ5iRtNsbWc/O3CIi9lJvY/cF80Aghhat5omrS3cf2cTahzhPAAFmMMiYaOzNm017S3Ki9Ql1e7ZXOjGkrSZgh/hSu7UzHjdDcNJfBRlwq202/VuG157312soCebzqoVuMuwbkjRkDy7b07YUXNKPSQtMX16exZ4UVb03Y+W3i3VQVdb+Nk1fQAnNzDedOz4rv8XmjVj3UoMjTlUaJJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(26005)(36756003)(2616005)(6506007)(38100700002)(107886003)(83380400001)(6512007)(6666004)(6486002)(2906002)(86362001)(316002)(44832011)(5660300002)(66476007)(66556008)(66946007)(6916009)(478600001)(4326008)(8676002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6/JiToE0+h06lfDy0/MOCoxt5h49Sa8x0bPsfplHcOrf02SFesicRzBAInKS?=
 =?us-ascii?Q?2OlL4pg0tOYpr3aYQyXFAB9lI5o1kawulYEiZ1puYMrrV8qIOSrsVf28UwAy?=
 =?us-ascii?Q?c2JofSrtbtCkXlPsn8hKgQ6ykr5ka9grdCiuXTkd6lvOfcR5s2/A138FGvWI?=
 =?us-ascii?Q?jgtywexEGPzudTuSSACQiibKUHirhtfj2qnl7yaZZSY9qr/POvYsILMNTQ7k?=
 =?us-ascii?Q?OJJQnleyqIrZLclP6hVjGmXzXbPol7+/q3wbenBDs6hjY4r/7//rn3hKwLKQ?=
 =?us-ascii?Q?5y/RrJ+QpwAtVm5ziyD/+W9OTdIJLtT/xV1DJ7nalb1rjJqKzu6rO/v2hcbc?=
 =?us-ascii?Q?G8SZP2O2Icf/25SNw0mIRF4OBjM8HKbMgHumuKnPfnBw+N2e2+2wKVoeAtAt?=
 =?us-ascii?Q?2zJ+dWjLFor3T6PpN7uT+htl1CTyw0NvqpKyC3DS9xs6xtnLXq80MOc5aT0o?=
 =?us-ascii?Q?1HUqnuSXbee50EZt9OWse9mkQpDVtH/ZQZjP7WX93bkFJbvq6fLwT257rAtW?=
 =?us-ascii?Q?//W9SUwuHxreL61De1sT2GBH+NUQxH9ahNIUGbaDrfTY+fYGi4SsU0le0kJs?=
 =?us-ascii?Q?n0zSr5RB78/Oc80qlMXglRL7ZmrFdBuD+Af7LZN68N/MRT2IAeoFDYSxl2Zv?=
 =?us-ascii?Q?mDxqI2QIexKnDUVMWmrbeTYODpjuEGgslkF+HFzj2GjImOurk+XU8GFUnr4z?=
 =?us-ascii?Q?/WFq/YCxpeOCrfCyRZ1ElAK7K0Ghv4Rclg34ENxJprkXYsfzLBMA8TJEACwr?=
 =?us-ascii?Q?00nFPmiqn0/Mb3hHtcMknXtpcpoisURPzjRjemwo8ihkZcWjVN/SxtaM9wc6?=
 =?us-ascii?Q?XEz/LI7IFwkrXmVuTZPegqNdCh1c04tjIgqwSvGoX5eVC8x4njcEYkfR5Wyt?=
 =?us-ascii?Q?yFlnutJV8X/tqYwF84la06Cq69fFJ2MWb+d8GRwBVknM+hrJkRqAtHm5ztNQ?=
 =?us-ascii?Q?BQ0hzoNfnpr9nYHl/8Gw2RgZ7o2NhVicx/kSjbrCsEHDcCB3lz2FyaXLPK7r?=
 =?us-ascii?Q?KZWcuBrtkoCsqNan3kvxasisYVtOWClIzLRh2cbDK+v6ad9iOFiOQiu7OTYL?=
 =?us-ascii?Q?LIgHWlfzfNYIXD4PPhLjy/nkSVIPXPbs2HKKW7KP2YLImKUdmPjtnwqckWSW?=
 =?us-ascii?Q?b/B3BN5Ul4hZz5luSmsIi/5sNeAA8mFqC8pTPFZuMY3FA3arOsbIUJqAAOlJ?=
 =?us-ascii?Q?875hRSLWOGCLPtsed26wyPWagra1dszVDME7FrPUnAUWnNcYGtyFVvQzR5iA?=
 =?us-ascii?Q?xrSrwHDhVdmnKSMlV51fFIZUiZ8UAWI+yA87Sf8xbWmrGzl9a0gODb1VsXe0?=
 =?us-ascii?Q?NuRL+7HNr2pVfxTJ1KNSS+Kjgx0M3K4WEZYX7IqVZFY3If8VDF0Vl46DrmHZ?=
 =?us-ascii?Q?P95QjPAnOzyOawML9PKrpMy3qfICgl0fOFo2tBfPT8lXksAYg16tuJQtUWWd?=
 =?us-ascii?Q?K3BdP2w509eqIIRuzSRioIJIdE0NDu6s71gYmP65x0xQKSOetD5XSTo8ZIsn?=
 =?us-ascii?Q?2DNOXq/9fNycK++zR9lbNrKqA6j+F7cpMIwsi/f4x7NpwFnXEd0vke335EI7?=
 =?us-ascii?Q?tjbK+eOsR6LBa89n1eZLuVDVVidSeApu0sJG3MZ0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9476748c-76ed-432f-a528-08dbe842ad29
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:28:47.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn0tjI/VWjyiRLuZtaeuJd9RczecaBHHomBkiy3UChSTqjdinabtYE7c5lezsMSSZ7ROKBvVLt42lCIzfMU+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7014

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

