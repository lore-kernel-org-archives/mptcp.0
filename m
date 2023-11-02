Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21811CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AUeg8pJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYVzhNXGIDoN9o4ml+1yKkz0h4mLxdvkQvEVqCvAdwdTPzrdP7Az5t8W7AT6kE7EPEJzm3F7SuKaL9Ws1exgSpgmrsRI7pu/GhVE8e48vF99luAy598VdsfFTR2zriYfe0FipMgQSzfM09q+vW3DsSSHEQnfhi3gxbSB8F+qEtD3plfsTBhVxfHza2o1xvJC6JBG2pCtQE0X9a4+iRcM5ROKelCZtnzQoe9W2wJzqQtobJCaAm3nMcpxornaADM+G6mOkaX8JzMS18WC0XpuOQa5q8xHBM7p6C55BTG+bZNifFkRYU8Ynkcg27Mi4Lhvu7dWlQi3Iq58uhO3wKbnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVcnHRIltRycavRbdvCml2laIYR5nBNug13cxICTuO0=;
 b=h7xIMwDwD32TcRL3JE73qC8/fkv/0wnSu77Y6H/lrrBYae02tjVdrub9RMAY/wPV4fuDaGNVZZs4OHWV2qorXPv7y7gH984yJzlxbyZNwmHGgSKFl2WCBrk3/8ThWjUYH9kjfQRSuaRZFNHjn12/mY5xJmivlWQJSUJ4YeOdSHlVK4QHSxNsczBdnqDwzuW489R4pO2lJkXR/j3sMa0w2gHXhPo4EZyZFVkoYGsCgEQUTab1auYymw2qfogJoDivEeH8+gvdUPoUOMOsr0V173Y+J8JVgKKLWqxUC7pNOHe8z2XUhtuHs+2ZRGdKZJMobectusr6YN4Zm50AKav8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVcnHRIltRycavRbdvCml2laIYR5nBNug13cxICTuO0=;
 b=AUeg8pJIdMFbKIOiq6DMuzuuiSPsCi6BFYJfRpXBh40YRjLaENeuZCVzsUiQL/ShfH933FA3NNmyavgS8xckmXyVSe4b5EzYRe1wUtQdDWyhskcpFJH/myv9Oh7fuw5wlLb2T2S+vzKKN/NOH+64gs+hHzuxACqtGUDO+ZCyChFhBXnCEs/Fq/C1SLT8zMUnxVrOhg2HhxNdWN79fwXRzL/zg0tz/xiIh4QMVqTfA/fbyOljakgZRBeiTAX3lP/uXkub3qzfAwPpm1kxpTtvnaTqPgzG3KtHNS7mTd1nAQOrlIwRUQMlVDwIYxDQ9IEc/Ecw659fsR2tSyS8Emo5ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:52:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:52:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/10] mptcp: add addresses_ids_equal helper
Date: Thu,  2 Nov 2023 17:50:52 +0800
Message-Id: <f28f00456bb6f4b281dfd6425ea47aa10f9e417d.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: f75a5747-7f06-4873-954f-08dbdb895c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ugFPQlNgzL+4T3nm+elTMEQ4GVJBta/sgjaLJRMJpqafkx4ti4UIKbD+nvqaoqoinj8h5FbZqju42ZGnxkAIFqMdYHCdKvqR4m266XytOCaIiCwCh1c0C92hagVlCHLQbCzRAk4vTVSvMEHcUw674yjnR0q5Tnb9KBuvx6NW8EMTsXyZCxBzrwuXW56CRNiZ3f0fZDJTL8UGld/niLrCjHv4Ibz4k5L/bjE1K0aKqpIXUXPmbnMlxG8M9UMe66+5LBSkCYTNDud8GEbDakG/GxBBGEikPQoeR1SN4d/e2Oqh4VpBJgGxwG8iP/icbQezMJDGswKHy9BzuO1YGVBTktoonSRnFdA5lOsstZm94wWcZ788NmJgQ+bMsI/I57J0uaD5s48lyS8aSx1byOCDu0hIU+MSLVvIn8brj/bEYJ4lIE1NWOJQVkeczLA4yLODbejV5QkKFIRRhtznfU7qnSUzqm0uX99BJ+Nvo68acvMwPxeOsqrc8HBVsS9g1AupSmSfSPkRbJrGitKxXP1kfgYUl79RbyyWnhZPdRTwlr9NI9ereW5FfWaAuLy4wvsjdffQq50uZrZHOzbhroZMCFltnbGhovyiIBxh84GSNHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6512007)(107886003)(26005)(36756003)(86362001)(2906002)(83380400001)(478600001)(5660300002)(6666004)(8676002)(6506007)(6916009)(8936002)(4326008)(38100700002)(66476007)(66556008)(316002)(44832011)(66946007)(6486002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2vyJNARltl16itCiXPbOa888We3NKlKqZk5jAO5628XGlXLO7nECNhP/ZXD?=
 =?us-ascii?Q?TQfiDgUMrzrqVs18K5sqiN9ZJ7qCvQxKgcM44OrusgBMSx5NRDHI0M+JsHxS?=
 =?us-ascii?Q?5c5Y87pFDqusKI9tIACONfii6KD/cBSbGWcY17rvtVCjXa0sAX7V5R096QZ1?=
 =?us-ascii?Q?17xlBaKjZh7lRBZRcJ3GuIfpC65SUJCJ+OfJMb2GlGaRGnzc1F2XIfjYeXe5?=
 =?us-ascii?Q?2HQu99kkw302+0QQbynPsm37ZzH2VXR4V0Eck+JdFUX18nuEKhciVwyhfFkV?=
 =?us-ascii?Q?DdqsDBolaVEcHGF1/XW+eAFdd22RaYso3R3TjHDIIyai7dLYDKvieGYtzMqj?=
 =?us-ascii?Q?XzafIKJiNggwZw5knk2ZhYEWt4jJELsqW5P+GwLFXoG896kzKyUfX5N3jwra?=
 =?us-ascii?Q?kogMYlacqmUmMnLy2t2iv2O0mLmdJeybzE9ITazgPOWb5LgyEgREnpTLFrbE?=
 =?us-ascii?Q?vVN7KVrZO65pqBAedLtG3pwPB8q8j5kPk5xFUdM2g/y0z2rDwtNMyJaTCHdx?=
 =?us-ascii?Q?HomrjGGWeKaVjzVRadK2c/by0JIdsrgfz0QNHUkZU8Mo/v7AD4Qt6mdDteHz?=
 =?us-ascii?Q?rTL4QvoEQNyioGBNu15aCBa5giqPj9ygL1Pg/Qny0iK+h0+w2v5yU7HUV97R?=
 =?us-ascii?Q?2urkTOp8I21ALR+DB+HccCSbDdr/N7MIRnVKmGsMjDqvBjfWL/WOF7O+/6R6?=
 =?us-ascii?Q?fTBxsKryqhO7ZgrgUXr8JncVQ/BzqqAGRsvcVlAY08whtTvbFch2WPimXW/y?=
 =?us-ascii?Q?mwuIZ9KdYc1J2rgMgbsjhnmeJv4Yn/vfSHm076vuuSI5kDyFrI1KklpeKiE/?=
 =?us-ascii?Q?4IH7LuZPZP79DMh4d5nash8IrSnIbKmdcxaC1tBTzCFrEseSNyigtik7Y7uJ?=
 =?us-ascii?Q?I70LfCVzk9pO3oSy/eo8lsGiG/3lJSmHCQnA4g+jXmAOydZ7h9e38krtl9co?=
 =?us-ascii?Q?sprmQGAMTzHxdu3u5Ws2zHbaB/4sFhRzIbncqt06aXLcIPHBXbO9rGyD7uiE?=
 =?us-ascii?Q?+1Qds0n8x6tkztzgNQYSG+GfpQC1tbY9Y3bSMI2X/2O34bsoi+tQP7aBj1sT?=
 =?us-ascii?Q?NvJPKH0JZoo32S9fgBbdXjjtmlpjcEIWIFo3gpsN2NQ03RHsco2Rxc4hpSJF?=
 =?us-ascii?Q?Wzss+843IfIiSXMw7Rj5GfCnCa6VXnXfDkMzKruAyMKft32OPem71PiBttOE?=
 =?us-ascii?Q?mrkabzKKqP6bgmcTa5DEuIupywQNMJpWkup5I5kVwSkRUUbPKMf2DLfAYjc+?=
 =?us-ascii?Q?+g7OfhQEQNVrRI9m1CrMRoDHYb7ePypMkSRn6J0mGV5DuEYwg7UdAIgSVbIW?=
 =?us-ascii?Q?GPN2zKYYFDfmS3o9nFO8V+VqVcWPO8sr3qssNWFFwd8rtKEXvYTjZcjZZ589?=
 =?us-ascii?Q?3ZU+mx7tCzirNlqyrtUdzJHFv9JE/0LCyJh0vowXE1gMpq0o/NcX2sSmMufz?=
 =?us-ascii?Q?Sw5uxm7eSbC7FiGvVXR2G/kPjRzQ96Ah5+Tv3YSJZWaonxIqVyLoB3uFYu1P?=
 =?us-ascii?Q?ikunGuumJtibR41lOogYLtNArQ7ptQr16cY1iGSPFGgILSQvLK0xl3LaVI6j?=
 =?us-ascii?Q?uq8OTWLZETQHC8KxUCAnutrPL+Xvu8goGYjl9Ic/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75a5747-7f06-4873-954f-08dbdb895c1a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:52:00.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JnXRDxYiPZaLsV+OuJeDWc6GuJ7sSbsm+ePjI3sThzFgjNgbnyzHTqkwL87vn7PB/+O9jVxS0IJNmgdoSWhGew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

Add a new helper mptcp_addresses_ids_equal() to test if the two given
addresses have both the same address and the same address id.

Use it to define a new helper mptcp_lookup_anno_list_by_saddr_and_id()
with a use_id parameter, to simplify mptcp_pm_del_add_timer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 657db778a084..e900737d549b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -346,6 +346,35 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	__sock_put(sk);
 }
 
+static bool mptcp_addresses_ids_equal(const struct mptcp_addr_info *a,
+				      const struct mptcp_addr_info *b,
+				      bool use_port, bool use_id)
+{
+	if (!mptcp_addresses_equal(a, b, use_port))
+		return false;
+	if (!use_id)
+		return true;
+
+	return a->id == b->id;
+}
+
+static struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr_and_id(const struct mptcp_sock *msk,
+				       const struct mptcp_addr_info *addr,
+				       bool use_id)
+{
+	struct mptcp_pm_add_entry *entry;
+
+	lockdep_assert_held(&msk->pm.lock);
+
+	list_for_each_entry(entry, &msk->pm.anno_list, list) {
+		if (mptcp_addresses_ids_equal(&entry->addr, addr, true, use_id))
+			return entry;
+	}
+
+	return NULL;
+}
+
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
@@ -354,12 +383,12 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	entry = mptcp_lookup_anno_list_by_saddr_and_id(msk, addr, check_id);
+	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry)
 		sk_stop_timer_sync(sk, &entry->add_timer);
 
 	return entry;
-- 
2.35.3

