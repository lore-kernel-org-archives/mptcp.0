Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE8E847E
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebeZCD/j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLmSwldBNoVRcVxDzfonU3ejB3eG75JP/Rq+Pj0qFYlH7LccrggP9SfdFP4rczSEcF4BRmbzLRD8ktECbrYlOPqauiXPIVb7aqh3E8TJt1c1C/nY2tJyLNEo7jZW3vCpqnp+NCrW1oYnqOaRny4Sm9AvvHmHTmLiBDg9g1Rrep3oDOUK+z7WiJCx5p7LojjtCSiY0ifSLN6bVKYHZFoX3ecHQHShzGvFC59sAqcb21d9svn5ftfmCjuH9pAdtoFHnqQsY4bLygYI3dhQVcQiobdO6stU8X0rMO3K77zorr9SB7wwbpNVMs9trSvgmT+w61WP5AbS8ZeQ67AQsErm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvCAMZ26ZOXMmzNNf5ow9S1lE4qLCgq2D/FrRdpHND0=;
 b=kOvN6ickPNWoMqv0npMaVNsYLjD6vwPdYYh8nzAfu7YapigOAGbeHrUsKTjpGhBVzcDuIrbbMPffjhSFQ2OKtXz0VJEP+zWL4X/Hy9AGfi2kokO/aMEGZRIvS0FpMHgyuntRXwZuYYcKrcXxjFqOgxwY0JigWqNs9ii5rym5pKMM3BM19SbnZHd9G7hxSuBZTaSguLzMpif1+6+DAq+Rl3QmBkme94OByYp74vmqXsg99108kf5YuB1ng/xaj9ZnYYlL7v+jGFiMBHRUb+FUdQiuCz/5XIJoEXGB8i9oKueu0cYhrMT21aciz6PO6hdapeQF90RLxK6ZQtGCz91mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvCAMZ26ZOXMmzNNf5ow9S1lE4qLCgq2D/FrRdpHND0=;
 b=ebeZCD/jw+f9ZeeEwsKI5l/gLwBgHBt74nYv+9OfxMQ/U82jOAlqB7hRFmOxNt8f0XCIWC7hGNbyR228rluEefxHGTdVeAQlRU3FWATscUJYTaQsTX188QgEOWyIkDi99pih6Ab4NJd/xTBYzyKgYVtcPo/WH7GjmhRJ6acWtWq8UpCllpkOCj2UhzIsdlVXQ4PKWJygWIxHd8PRTaioU+wuph4F+VOWLk4yvEFt4totKgI8mzvSo/y53BlmRdPTB1vfxpyNuSYVfs7tSiy0QfEwJ2qz3unc4V/ksRtuOLlZ0eMycdiCpHi5uowT8j74408jblI4cl7q56CDQlbqLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 17/22] mptcp: add check_id for lookup_anno_list_by_saddr
Date: Mon, 13 Nov 2023 10:49:01 +0800
Message-Id: <2cd7dbfb20c1eecc69d1579d41c5a673b76318dd.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f2b4cf-e5c0-4ba8-ce9f-08dbe3f34ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c55Iyi26F6vsfuqSpkVVb6/sWvO+1lHEqAEb+ayWgcd3dPTpOU8YCArYNhXzvzHgwy50b5dkJrOLSPMiJiuhXOd7rdz9qtWB3KuTYuDaj7v5f9NENNhY6CSWgaN/zkvRBJA+to7MK2Zcm05jPrUReYovf7WXleFm9uquORABVF0vItscqF2Z+efHaxIsmJt2Vi3GnLAwC7NXXmT5AnhacHTe/Y0fNvwVIU2v8kOgo1JhbYWkvQPIPcdteCNW/sYNK0e3eV7em9eXknYlnrDjaZkhZBHseu+k5NnqiM8r0Igbog++eBXgG+HL2lQHGgm8jeTKDbjDkAZ4nUKtSZ8OHJQ2MjtHM1onJttDjKmD7H9TWa1Sw1QSEcGE2xv1Lwdbbf6WNVH7pqzJPXDA3VPbCj+MRbkvLDN+nGiucG55gGFw7wO4iiP5QwtIfmYA6oKFB31AOjwcr3w7IZE4kSE3s6M2OmT4e7xC06I+5nT7ybbJB9QEpOW+MUJ5L2rT5TbPDtFWu3zckpLhLglnH7o0tFB1mVmIsjxkLu4DXwJaSnOIm+Lg76slLh5IM+ttY5nu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIzSnfdb/T44dhZIlmccHG9OjSAEv6XwyIH861h3rhGaLbWnbNs+sE4skW5a?=
 =?us-ascii?Q?Tgy9gnCReo8Qk5NXCS7U746qUJSE9UUaO+a37XG6fyYRG5e+Ou6QQWXaQbFl?=
 =?us-ascii?Q?5+G/sPfJ9NkzNCc+YsN1otJgx+NtkPw2Md17GuoH5bBDOZU65JvS0Lzq7jnq?=
 =?us-ascii?Q?LBxfBbh2+XulXCB4alR5ddcYu1c+nLy2cxdJbPSxnrDqw06mTRRdEM0/VEZn?=
 =?us-ascii?Q?EIdaDWOdjQ4u4wgGUnjxKGecdURR1czowAlfRzIXcbaffLabUq2OCDvYA9GZ?=
 =?us-ascii?Q?P+JowOStDBPElLC8wkwygTqXPNuj6WbtvQ8zGiIF9eRDIF0pfBzkuFnTLn6O?=
 =?us-ascii?Q?BW3/cqd6/Lo7Or5CYPk3iI5r4DG0yrk9eBFpyGvjy49tYlPfofCcwXG9VqRI?=
 =?us-ascii?Q?oYLTV85tZ7YcqVzp407XsJZKC9oWc9qLPkiRudewyYdH4/lPwb9WjDZmstvM?=
 =?us-ascii?Q?S9kvgrSy/c0kvKMCUbrnHcLZDIyn83Mdn0yEIHbERIVTsJgy0xdj6Xyha5tK?=
 =?us-ascii?Q?Z+SXMxNu9gbrniXJ4N0e05K7Y5VaQJj2qYClM5tRdmxgWSePBGvDEs5sXUga?=
 =?us-ascii?Q?Wq1teJDtrA2ATEOxXwiSjESuXVuGmkyEP7JWfWFv/QrG8rb2unpBwzhN5Y3p?=
 =?us-ascii?Q?VnWbBXG3YQUwPXjYecGu+7OJQfOMkVvKgSXyqvdWxxvDYF7LFtqjxOghl3v9?=
 =?us-ascii?Q?anmSbWjn7Hc1GYHtkx2qk2cLHp3MgNS3K1etLZ2lWUW8pFdDjTp0777A0LlC?=
 =?us-ascii?Q?k0pprknydE8U/Q7AdNseOniG3UcENFeMoET4MyQ3DGib46TAs5BvMK63VEN4?=
 =?us-ascii?Q?ESI3zq6CfHMT8tb0Z6sBvOiwQz71++E9zJlvRILWviz/K+zBPWHhKA1pVs0u?=
 =?us-ascii?Q?M8ksLhzK2hri+Et2dUG10+Ih8qKV/fABQEOj0gSKxuGdauZ9xy9KxkwtGnA0?=
 =?us-ascii?Q?BQh66jS8Lv8F6Z/thI9YSWulK0d+xgZm/Ov0Pgly56nauwC3nZJtWBihdRry?=
 =?us-ascii?Q?nQRm9TWWDhv5AA+fNjlKlAXtOSsBXAhh33wL4QG+ba6rqMg4SvrV7sXhm0sk?=
 =?us-ascii?Q?aLaoHKvO1c11S8IsyJ2N529kE3mLeMzIn9JD+AHbxlTuNSIBvW6o95Hnr/iD?=
 =?us-ascii?Q?0qDWhWhAvEBwYQCMhUIoVY226zEwrc3TOBR6Z8tr7my/INEPHiBeCeYQAF+4?=
 =?us-ascii?Q?ArHCdxle+DJVQi9LzO4yjve4JrVdQbpu9TWOPSe/SP4mxKwEeHLB98MPxlzb?=
 =?us-ascii?Q?JbfWzb2tkyGpJun67/+KdMZ7IVMmHWVC9w0BnZI+zmUNKSRvSp9S2Dk1aGhH?=
 =?us-ascii?Q?t+bp3DgD6k9oxrtt1Pu6lezljxfZpCAq8TcLUn+ry0+jxi2Px4yVCip91mlC?=
 =?us-ascii?Q?9zEHIcK035zvLCBTluooXmopq+qNGpUmMd+KoWVKg24/m4nKIToiy1Ta/Nla?=
 =?us-ascii?Q?76U2Z3FX40l+tQv1rJ9heoQa/IcfA2oqR6lZfg6YKj+4Q7ZosQyflr73iTtb?=
 =?us-ascii?Q?MhpDm4k0xq8MprURJsqhJuaeMmeiupqmIzaCyK44rdwOu2MiqYIm9HBPqjoA?=
 =?us-ascii?Q?dSp0VaVqepxfhGeidDfTL1UUMxrcGBj5HL1qEJVI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f2b4cf-e5c0-4ba8-ce9f-08dbe3f34ece
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:34.4689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsuowmqOjUJD6WjZ+tP9oRJa4Rnt2VNFyrUMm/KvAp6ZgZGzL2DwSBYLRn0cmi8aUysga6DGI0u+zyh4kUZs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

Add a new parameter check_id for mptcp_lookup_anno_list_by_saddr(), and
pass it to mptcp_addresses_equal(). Then in mptcp_pm_del_add_timer(),
the input parameter check_id can be passed as the new parameter into
mptcp_lookup_anno_list_by_saddr(). After this, this condition:

        (!check_id || entry->addr.id == addr->id)

can be dropped, only test if 'entry' is NULL is enough.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  2 +-
 net/mptcp/pm_netlink.c | 13 +++++++------
 net/mptcp/protocol.h   |  3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 77a0e859076c..d5ae2e775059 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -259,7 +259,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_lookup_anno_list_by_saddr(msk, addr, false) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 599137001148..af915ba3dff5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -203,14 +203,15 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+				const struct mptcp_addr_info *addr,
+				bool check_id)
 {
 	struct mptcp_pm_add_entry *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, check_id))
 			return entry;
 	}
 
@@ -290,12 +291,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
@@ -310,7 +311,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr, false);
 
 	if (add_entry) {
 		if (mptcp_pm_is_kernel(msk))
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e66b1fb7b522..d0eb7b84a262 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -919,7 +919,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr);
+				const struct mptcp_addr_info *addr,
+				bool check_id);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

