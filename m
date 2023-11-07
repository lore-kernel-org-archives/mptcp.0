Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9EB1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G9d5YbbS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3iLJGQldQoIYQYdBauk8SrDTmlmIWsxUyHeKJmTSmGWjtlR4Gima63yEYyg18ieroYjnjpq3nDb8EJdf1Y9iGzY3q4hkJJKpNK9IWyLLssplgAcoa6E2yAOEyZQ/aLXaF2DVUL9pFW+ErScExs+iRp2V3nYoUOHV74hM8p1k9GIfnpUYpqO2WmwdfaqEzgsoNCOBPjgEUPZeHRv/K+Lq4R0s7YW/G8p/BR/jGOj/Kd4Kei8XA1vlahjy4i4olyWx6c6DeWYVNXpXuRIJTO64Uo/VwUtbd2FxpS1jTtZ+Ejtw1nNPIbdUkJrHLUV1QDaCU2PMvOF7Bp/wjhiTn0v/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=X892W82fs039Q4H4RJg711jZFj9JP+KsU+ZFM155aycVPTCN33RZkqEgGOhCQTyLRR+s8H3PFhMru6e+KDekkf6KpNR/piUFt5wM4ehi0CQxeEYToor1iOfmenRAm7OjZOisByz3aIEpvV7nKl5kArTOya6ZrqLtK4ZIDVzJUDDmBTCeGW2NdTN+qnhNbKiKIRAvtSoP7K/BZLToUnu0TVg2KwGWFzA/I0J3iMu6e4sovMs1W0svRAXuJbt2KumTT5Q8uVsK6ZzHXEpopV56FtXjZkkUt7bchoX3u+7y6rPEgNUmwPWfp3cLqQ+j8I4AqT5pV2Bvh6brZMGzIhZCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny/YNTV6iAE3ls6l5bZbWBN4WsGQ64owh+fZYjVRzZQ=;
 b=G9d5YbbSfGxUeFTkDN4D5ogxON2qmD4ZDybzhYb46ywfIKzT/vnfp87LfZnueQME51WWJjPSwkR7NvcptKG8zBIp0XBbZVqPNks+vPy2h+XwfQRS7y/QhyNxyzVSzGhI+/XYYAP4/88W75TvCXd38VKL2lIhT/Ml/7+B68yg712GQDh2qrMonvT/Ms8hBEm5HcBVCRWMquh/78/ZcE90hll+pszqNcOArGvRu9iIGmf6c3kcw8mRRBMJYNfaRLHWyb35aJ6PfJ91wLncVCk5J9Y0ctcMQ7nKd/mOoXo5GwGlxFvOHOp3HFXgbs569z2hWhqm9m6L7YJwU//9PR37xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 01/21] mptcp: export pm_nl_get_pernet_from_msk
Date: Tue,  7 Nov 2023 14:01:45 +0800
Message-Id: <fe3dcf82ef30c7e3287dad783fbd3ea5fcb04ea8.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f06fcd8-22ea-4183-63cf-08dbdf571523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P3gW3Mqhm806/lBmANFbYw8KUG33mR4wwDihOlKC/Ty0qXNijiRuUxYloVek4cIHl6KTFjo471v7cl1tS8Id8ZoCLcOqIn/EzW/rVdx7WXipFYL7iUYT+dLMhsedL0B5qp23tF9SBIcfDRIcuZNIX+SX8imY5Dr6AqhvORgP6ubFfdiW+ojBE+38iFfdqRhtTxN2AOvwclYA6GwXicnDP/1R/3tDAYK7GS4f8cuUw4mmWDUdzsMH7rm4wFejbVQBw/57OzpqzEvPUisusFvKKgEYRlYEeRPekRUrxeqnZCOZ/HNrnpL+RKor56ptIDmHfSUIhFcniVaspz4yzGGRaIYrip4/WSos7UD8APwGeEQSlcFuCJHhl/OVkhxqNtBR6bF4f87CagpXbJUViS84oY8HR9BkqFVUNAfuFl/bTJ7FFDRbgBcmNQIdoTYWf1jVIoSvK2OxmG2l0JapO+ekQsipAhhhPgvojmOcq1zLZ5cso5ihoMhPXd/1foQhyJeDc5dZxsIYXBoRPI+8tDU2WTQW2mZv88g+mr/eLYq8/l9yCn5vz/lKDm5c+/4yM1Vr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?meMXqmLdE8SjLSk/xlSTzF57bDtY3eurnW5ZCVcFfG5B2mcHpKS7//BgAXlw?=
 =?us-ascii?Q?MZ3rOB4pqXr53frOXtP3UbouwbME2LZjOESuzpbFzhco9cJg7LfRlERwbl8A?=
 =?us-ascii?Q?Km2pERJEBjzAJD10JQAtJ4D+/PBrqmNPYmW/75CvPQ2YaaQw9UIIAqK56+fA?=
 =?us-ascii?Q?tGO86vCbLRHirAIIln9Pl0h6JlUZJ7ZTtf9sG9aGqlMc6f3V+vrFnyQ0rah3?=
 =?us-ascii?Q?fu6hJViC7GpTkcKeXru2//ztA7hWMEk0511WNtyaxYSByinnpo6iTQlqQXLC?=
 =?us-ascii?Q?+hggezQrZKHKxAjX30CTSb/HCiULmbFIGmqnd/JzB1rHQW2sVmRE9lXANmEN?=
 =?us-ascii?Q?nQrc2w2SCkWClTnQOr7UNj1ygwSKwPG2WBq5Gr6a/3AaTiNv/lEDSeJh7s2d?=
 =?us-ascii?Q?9Oqf6mJ9TAntWaSFwRp7h0gL1dN8XNe/uOGTdZypn60kUiIEeN7KPte3qXcn?=
 =?us-ascii?Q?28C8mbR+3F8N6jQ4bspgulZlrkl9+bvDXefim/fNdyir2BJsyCFGMhTGv836?=
 =?us-ascii?Q?s0UzlBTB/0/31kZtzrsXMr7OmZuZirl0wCpHDs3rEB24n3YzRQWbyU8Ak3Xm?=
 =?us-ascii?Q?N0rA0FCGTNA8IaHHiw/cWmPDdj7ILHQx4iSt/rYP9Gn7rbry/9Ub40hmuo0a?=
 =?us-ascii?Q?CiFYDSYhLskEGEsrE3/1S8mwIsLYMAj/1oFVi1Ehfdhax8D2A7S5VkexRvWt?=
 =?us-ascii?Q?po4y7DnB3RXR6HuO5p24N3FD+fiTwSafhcKg2jrl+OLjHbXNSGL1uPlKJzfO?=
 =?us-ascii?Q?4NnD/5R988sktXKnB0xDp+Bqx/F5XhzZqMb+yy7nejPzK4wqIGbkkMUlnWfi?=
 =?us-ascii?Q?/yoxkDtgUpMbn687LtJ7tBXqYIiNCBMEkSUtfHs5O3ExBOirSDhF77HSK4Q5?=
 =?us-ascii?Q?RNg8D2q7cgM9MXuKVXZwWjycJP9KSQOCHRvS5oZKsOaRnIt4iOgjxxUYzI1b?=
 =?us-ascii?Q?lW1Yc8cYBh5oTWZPb0r1S6gpHzgO/XGRzF1ZOD4Gg3xPNXuCHA9ujJXGSLPy?=
 =?us-ascii?Q?VQxkmaAQeJ9hMyWLY+lSUDDJtqwW1t2Q7RBb4NvejJceR2vBhHjhX83rYdwi?=
 =?us-ascii?Q?8G0j7I5gdlLhQHeWvsMtIKmlmBJmeyhU4tyv/3Z22Pf47VJBlkggO+sZZZIH?=
 =?us-ascii?Q?YPa5DN2bsZ/ITuNqpwpLT75CTsRZaXXTFvRsbb67Kkf2Ih7pRY18a3u59rtY?=
 =?us-ascii?Q?wOzm32qpvnzwDpYum5EI/nCt8/Dx2E4X08W7T9qVdE8QMcPgPGmHLN5OEfsx?=
 =?us-ascii?Q?ArQWRg+8P/sjpwDM/iBEX2twFQP+uzaob1LAqWlPB/xt9WWSfOC9aAG/KYSo?=
 =?us-ascii?Q?gSZOcvx4tYBaCtif9SMZyFXonGynsEFXsmjepyxEzeLsQDsxwKx647Rex8YU?=
 =?us-ascii?Q?wHLBc1umMiQalHTaHituDQHABWiyf8IqygYCSKw+Og0w+9ptYijuxTb0t/S7?=
 =?us-ascii?Q?9QYAdKTQ3ZZcAEnkASbyTrDzi27QXmf/OeK+9//mUuaFhSTFuUJwKAUYY4OK?=
 =?us-ascii?Q?NsauJbX4PB7TiERpe4N1B/+9VhTZWRwqNS/QdLduRO37aKk5FdE4+0xpIDRA?=
 =?us-ascii?Q?VDczSBp/Qv0fvuMc0YapI89M54wbPNbyI4GrQskI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f06fcd8-22ea-4183-63cf-08dbdf571523
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:11.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GBdlHnPuJq2kxJl5SsudmgeVlv2x6PRs5pGXYYSwFWrkRaOQ68qXf6ysLyfWrYdV8JT4ncrdLvTrDD5hKtBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch moves struct pm_nl_pernet from pm_netlink.c to protocol.h,
and export pm_nl_get_pernet_from_msk().

Then pm_nl_pernet can be accessed everywhere, not only pm_netlink.c.

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

