Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840A612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fG2ULUxT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9b/WJRzOl3wxh2smJR0AqIhhKLMKcKuiMaM0vZazNmC1KcLlzFACAcQqD6QwYzE7GLj3veB3iOpM6pVppJRmSJ2o3UYtmjWu7Whwx8bBpCBBQJcDSg7iUyaZdcmErsKNUge0sdz6a/f6FxFkFErHzXze+jlxuMkhWtTiT7bJQkp9dVemCfEPMcXbWlsuuJDYNtQ24V6AxYIDGjnRLsIeIuJAJBi9zwp727aXXthWe1ht37qdKGnGdAu7h3nV6lkqjQNSOSVu6GAaJK4TnoD8YOdjFHIqy5zn8jxLFxbKikLOk6jKzqE/ytbN8i7WsbN29MMO5kS3A/ps7Yq3zGtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=aM15LYYUgcUDN3ItDb9zCrC7+wEcNQ5UEekNu4EMU9u8VPyCr9n+7ZvtXiIDEOAtT0SRmOWYYkDQO7eV8zqDHs+8+74Z5PQgH04XfkCAm9KTK3Ga04ND7LfHYMY1QCm5jM5PlAD8XJOLwZOdMFh+ogrmygEZOCW0Op11QLfQeZHaX/xLcUY4D4UEKGxPNREe4/1+n9CpuJFk2gSJQEbBZcepwMRLI8VBLR7GsbHUgziaBaqRAvSgoOmPlDftMFyF6Tj9qVP7DJMvat/DJMmWrP+nKl0Xl9phusfCYTjHXRamehWFjLy5a8517CxyZpcdve9hIUSaHR+773Z6qkU0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im0w7CtP3iX8S7SAEQ/Bujr0mMzfVUiEcCrdAu32FXs=;
 b=fG2ULUxTNl8wZJ/CGFhEG+GoMonieNbz9MRanjI9DWXHNpNm3H7y75k/pXY7HWtZVtEDd7TCicumP/+1MFIRAANLksw5E6N18Zefzzbud78Q9V2/WGgNFfUqgf5z/pRpiNixth9yBtsh3sP/klqPk1sT0HlmBk+oiLyqu/Hq+i6yJiWUeIazgpQjMItn8c1z5mxoKk8D0iqy1y8PDGpNDN9FjQTqlflfO8PxdRqqEJZliUhP7W1V+/tOEzljU2afbc4G5O7oTzl8ZIX9a43HPFBAWsOhckSY9QUN1QoPoEVCse0c3o6MIopW6NNi65rxjwToBnkXrGzVf4kbH4Qc1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:35:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:35:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 01/21] mptcp: export pm_nl_get_pernet_from_msk
Date: Tue, 14 Nov 2023 14:34:58 +0800
Message-Id: <5799cf1ca37bc4ab7ff1d0f21ee57a092b8a1847.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 506673ed-0a5b-4f9c-e3de-08dbe4dbef6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f6CFZVg0bnJkSxkrrhUzTiVQlXFnFYXUpEwOlDnq6GYXSqhgGsv2pUuwLgcQRz0kK7fp0NRy6wrbSnzbAkEjZE3bzdg+v9Ag1kAdN8feRPIvOkQ5XgbvNqxmBg7VseAlMBdFK8OdzP17UHWFtNM3SiZKD/a7SNdGl8LlftfdwfNKGExk6eRFcOvRPATxhEo0UjGZ4wpKUGzooGvu/rqx5PgOlsCDgi4MPuY7uLRgnG6jZFGiVY+sBoZu9kJycPtS5xq0CdQxFzkMYMYGs62LI/ZTX9CudiOV8UEQfny9M9k7Gx/4YZi9Gupzp4S1+f9Hf7sPpwalhDBwHLFa2WpIqZIFUW74eSslGxEsHjOpFZjVFDiH4vzTBh+FBgjhcY2NDIz97JsGxyFciBQTz22+RKdLg7oGTjjf5aH2u1+DiFT8GoMDjv7oFD987NCLIKY0BdSrg3SPsgXrvNpag7rGmTnzquXKNdHd0skvGdgVsJF00r9DawEbsoOjZut40Xt06cVx5G3SExKedluE7s4PPyvwXfA4GotGGxGX3gg+7TK2MPNK7QWYYVzhE70AR2X+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?818fF557DDQOsImKvYNoKxMZE3NeWsFzQnqNAGcbkAp/CoFCrnOVLcZ5sGSS?=
 =?us-ascii?Q?mSfJp5FQ1L9I63GU/ahmSC09FmT7mqyowG74mGiufGNtJJ9DTsZFj6TQ35rU?=
 =?us-ascii?Q?eh0W44Xc0fZjDSRU9juHLNnbp4CcAmkbFnxMX0SihafrY9B0254o2uHxqUwZ?=
 =?us-ascii?Q?INHabOPfQ9sRrw39HrHBnUnFNoqGOqd3P2oVdTOP7kHVaALDl4TKmEvaJLZw?=
 =?us-ascii?Q?Z/zEasrBN5iv/QtSfbKDHWddjHjJOcxrPW1so0wK24Y0l8GDpxsnZRb32Ok5?=
 =?us-ascii?Q?ZDg48V0BhlcZBUAOnmEmpZOkXzezkPDOnu3mDX8HQmQy7xmxjryzviZhwVU6?=
 =?us-ascii?Q?HC+bwgzIHf4nJ3oZrCIS6Py74gGgah5LPSU8bwAFQXYADhbt+uUwsry4I9pl?=
 =?us-ascii?Q?d7eSJrAeKLS4rBeUtl8+yS7gwVrkgTvH0P0izC3aFCkutNOAMD/CB1CJyfj9?=
 =?us-ascii?Q?pOKlrB/vqvpAWHt97Tvr3c8aeW9NsLMOhGVja/uH2qxtzC12EbvsEGBA6oM7?=
 =?us-ascii?Q?W7odD82712ZskYnZKv1cXP4souY77MEhBKozwahh/TkpXMwQmP7xFmTqQ+tF?=
 =?us-ascii?Q?T4WYPCMZw7kdDbBJtUTi77Qm/w2OL14uV9uLtU1vwCnB1mS/PyX9Kz1AePqQ?=
 =?us-ascii?Q?d4P1PXrL9vrtbiEZur+LLwsXGWO9xCg1EOUL5/QUChVbHI+PVfLHMxb7uKGm?=
 =?us-ascii?Q?6Zfh/ORFewNU17Xsqs9fYdpuO8Th+ewYZteSRgOTbJZbFBQxUrwqoToTvI8j?=
 =?us-ascii?Q?QTjzao6b1EqyZmbVNqZzdwA+PhGhIHbae43y436ZBWFlCfoUPuWryq2WitAo?=
 =?us-ascii?Q?VoeVcsaWxHZfk5+QiKvXSaRQYKbchGKpBuR+uyFoP137qh0uXBt+hGBTT0Ua?=
 =?us-ascii?Q?nV2JSIbkkwitC7lu8eHI2W6xy8CEVuAO/gAzXqll6ZX69tfyzS2SBPEEYd24?=
 =?us-ascii?Q?pthjudq/wBK6PYhbBjS9wISSaX+DDOzV89+XzFy9fk4VZE2Kb1EcHLwRPhEp?=
 =?us-ascii?Q?3tw5mDc6Se6rzJkiRGUPAdWzt6cjJ0oVsvcpfST94msrVoNT7Z5iZKaVCyJy?=
 =?us-ascii?Q?qN5yzy6oAoeVF1pNxy6G995ed/7tVAJ90UqF903uX9LTKFb8AaLWLKMuVyJe?=
 =?us-ascii?Q?VlP9GVmiZObff06Zm4tctAvxGo22aLHtUtYkmng8kX9rMy/aSb6z2PjPU95n?=
 =?us-ascii?Q?27zugfVyN1UZ4zKlusjW31iAHoeRx4wY/8I8Z5f/YfbpHe7D1HVhqSyqVIHq?=
 =?us-ascii?Q?Oj+Tibko7gCgWrO/BPveamaHlZO4CX0G05PskJPqXwFUxI2LkVf6p9MRXnzJ?=
 =?us-ascii?Q?BrxRMWsA8RJ1Uqtm+fbsHNw5b2hxLFX3OuL7Wj3T3eTxGSkRm1g0r5bYa/t2?=
 =?us-ascii?Q?DMXPNfjyfL3477rsdofIL4XB9tUB8U8yAB5gpQWuVPWadIU7+3LjYlBWT9UY?=
 =?us-ascii?Q?WTDM0RqRQX88ZI8IgusjMOn9mY7LdxCKPVRe8t1GU2FNqsFRdqUXOwLq+aeq?=
 =?us-ascii?Q?CwahrMNm/50cHqELz8gXAnnVB5sqT78cchrse0Vvemzeq7+2YJ4pvxOC4OKv?=
 =?us-ascii?Q?li5s502XFnVehXbmpVur3Pf6n0askudPrs7UZxoK?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506673ed-0a5b-4f9c-e3de-08dbe4dbef6c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:35:46.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCMq3LxuPutn53EmY0NEkZiXzJ9MOOXSRcMW8n4ymxwNRIcIzYiD0lz9zFyt6Q9zy5ugAPc1N6enocQad6l5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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

