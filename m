Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F73BE7A
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWUyljeiPyubkCW+cagd9sH4AKofkGb0qfKDSUxqnAENwIE/ga8sLOnZghjqpE5TodL7rmmiohh3EBfv0d8rQJn69ZGyeoMbyKmmvlQtMYs7JLaHSMlJZH7HtJ6lnKt5Ngl2DwO9Ktl/iZO4cQa+bmMoUo7UKWSb9jW9py3IQhJvtC2BGSh1i1wEN34RZnJUA38kC8IjgR/8nIggzb2nlJz+nWYWzUAtoJtznOaiQVDkncGWTR3KUpHxbfZaRi+Va7xHZQIyPrzrb9Fn6sWp80ldifUxdPNo4eA8nebrYYACVmpoD5fIRhN1gaY05rEVaMNsERj0kTGI6yM9kBhmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR2qoiELcjQIGq6UdlKrMjbLs1/ApsUMoHnEypGU1UA=;
 b=eUX7FZiQp9/c4bxZa13/s8sKpFzXiEpEmh5mlNA7HthFxVJ4+L7spa9deTCWA39KPqJH9099CzFXgrK5uZ0gx3peVRq+zur/4rBp8EXpQagGIK5fOmyFH+jpjjHLKvDT+nCtISg/zUnFs7YWTvA7kj6CgQadUo3V1GBOCyJTPrUvdYhGSZ0p/4WNfGVSSvIzzkzl3csZUg8jGkyS7demD82FHwv0Fey/itk0cnFe22d2A2b5zfQE4Duo9zZxbMFwuHB6/Gp8opMjFCqKM+MWlkTUoK1D0OBSs7GE8gFwFMc8RV/GcNH4uNnMG+Viibg9PqtIq2Io/aA42uYTPAVZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR2qoiELcjQIGq6UdlKrMjbLs1/ApsUMoHnEypGU1UA=;
 b=a7Hhpu/ubDtdRWDiWGVs82cPRqcWL47e2/zVuDaHXLRhiADwIxcsn8CRpRGjLyaiMluFxe3qJ+4ZcK0QymhXsd2J6scNWE3EYGAZ5Z7Xj+sK0WTAH9dLxCeCO/dkzF3TFcwsSi2vv36z61SQv4B+TmxNVlmgz/53+7RXvO+vW7i8MDVOh0E1NGLK0Am+L209K5eXPr7GcOnE2Oyj9Rz0nCHUqhKaKj+gj/iyEVeTymCRLxVqostmZPhQtlmWARJk/iv2/ZYdAmdsRFupq/59PdCzG1DRBfP3SQZG2Otn2Y1ypEg3/J4TITPIulPW6j68ZznLeYE8pxsm2cabJkRvww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 08:03:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:03:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 1/5] mptcp: only send RM_ADDR in nl_cmd_remove
Date: Wed, 24 May 2023 16:02:44 +0800
Message-Id: <a874a125cc15d78a450d18c87dbf1b0adf4ada61.1684915182.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684915182.git.geliang.tang@suse.com>
References: <cover.1684915182.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0012.jpnprd01.prod.outlook.com (2603:1096:405::24)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f43a670-2b2e-4ca7-67f8-08db5c2d4f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tk166DFdURIFU+rCWFNSNRQENU9DUxISXGIdprSJ5hjfaWyAumDsS14K+3lnow724AAIxwkuUS4j29gopnoP0z0PLQacvjY0i+d8R3NbH5hVhPCuefEfNI2YtrXrHSFLVS/tONT/beDV/Enoa0eL84hHJilD9bFxaxpNJAAjZu2IffN3kvB9SoZbnUZw1qcdOfBlTzTNGCfUL8ihcmrHT7bW5vgPa5eUWUX0oWhUvvWvLcecg/CZ28gjqsJTcfEaCCaLhIXkZALlvB6r+TRv054SlqAMvo0T7yIUk41m7gxgocEhOxekU3U2wOvpy8YP2DiWVSwjU9sL3goBEDlhtaHf2sJtUNxUjpe2TrjswtalSa18PtOaNocrTZ6yDwlE6740zbuxsRfzwUFBU+4f/5uYMrKKceT5AFFrmoHj9RALcEYHyyaPEc7C9ThMjbgyqoX0EOOQZQ/7u4LN5Q9wPVj3i5Dx44hLRUYSYUCUnVyq9E+nEkR78S1mlJr1azcpHvIVlimTWF7NMUKFkPauTLBMahlR32ZRmW75oLjYhOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(2906002)(44832011)(5660300002)(8676002)(8936002)(83380400001)(66556008)(66476007)(66946007)(41300700001)(4326008)(6916009)(36756003)(316002)(966005)(478600001)(6486002)(6666004)(26005)(2616005)(86362001)(107886003)(186003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H2Hl3heJ5wnXx8p2yNNsgDRkE0HnfdIQiOU9lQMF/wi20pNFTQBvZ6Wd+kFb?=
 =?us-ascii?Q?HkDS3GOMeqm3rwQlsqEZGFX18Dwfzi/qJtnNFtwXEtqhCHKTOvYh78aIY7lH?=
 =?us-ascii?Q?AaJKqppepDD5uCEAdSmATTwqVYiQ+QeOco/QGC0rFiVNsETPdjydkkuLzp63?=
 =?us-ascii?Q?X4hLP0vWg4fWVApuKbHUivt3fY/tNN9XlvXKrrCHbNqXL/k45fNvuhPgXCJj?=
 =?us-ascii?Q?ApQSBdO3PhDuGVCTqGfH4rFgVEe2swtrSd7RGqivqQZlQtQfJiMo/KyJmg3O?=
 =?us-ascii?Q?GrDVHYAUe8M9KsowjdOP2lv2jf5WXGN2RVuD9pM+InRPEKtq+C79DMbODi7U?=
 =?us-ascii?Q?8SMqwiHthobTgRokKh23qJ09nzBxlR0qNdjHuONrYGS6M67rcvD969E79oiL?=
 =?us-ascii?Q?2LpdbKbhlLvCNSvoSuv5yaEm7Hpai4/4aEurwx60ICEIKPRkpsEqplJUHHep?=
 =?us-ascii?Q?vmTP7jLE8g6hmAB5H7qTFhowlxIg7GZQwcDV/zsMB0iQ7jcw1LtxYlxlFVbP?=
 =?us-ascii?Q?IDSBHlvc659UGAInn9L1VslFtFO1vK4HWA7rrs1IQK/1eBjl2YQyT5I/3bHT?=
 =?us-ascii?Q?M/O2/+w445mXzUVXlXPsA7LkkO5TQmUbQpEXDChk6EzwQIuptXW5mQkZT6JU?=
 =?us-ascii?Q?wgf1CSoDREgc5HOG2k/V1bJSAbeNO1S/UkCSeRVP0MdFnhGZlJd2ob3ccDaE?=
 =?us-ascii?Q?DvFnD+z/xbzdu8x1/KGYmZ3aiC9VMMTinU5sQ00BUnb3z/sSBpu1FrPYqqR9?=
 =?us-ascii?Q?jQJG7ZMSFz+F8oVxVdIZRpVaFLEHtOobLlULGna0G+9LKC8sPKUm8YSy9OHS?=
 =?us-ascii?Q?qYVU+A9vp/AB8doyefOWMo2SDjEbvAIDPMtfDz/ikEhSHSuhOgBpjadspFub?=
 =?us-ascii?Q?Qz1Yu9SrizxBe5zCDf1qMs/GttloFBchyvk3n8bmymXgLkMVwMe7LNF/EHFO?=
 =?us-ascii?Q?5pTv5+ok2h0NAI83k6A/qvNv14RVK98qxOZAIfXNYYZ0J3Y4VYCOzrX3Q+Z9?=
 =?us-ascii?Q?fCTQXbSUatzW3HkK7DUiJofRkGgKpJKAJHOc9oTK0TxoYz0Od83BYUf7LcZO?=
 =?us-ascii?Q?VQP6bQ5kN8ZeNwvzv5zTBT/MBgF6kp76h8AFaE7uOdJ+TpxTebt08hbF16yN?=
 =?us-ascii?Q?ry1prMguDCvIqZwIbu7qMcP5IELt3cnKcGPjALJm1InzSz6Fp74X93XRGqd2?=
 =?us-ascii?Q?WvDTWgPQGgoXb3Th+toe20n34VBRZllcmik4sOeZ2VPDNYJemmZjq8auRFkl?=
 =?us-ascii?Q?eNBc3CpY8WrDUhg6asRfY3U8y87rRY0km5zENrGmvyQbZhH/Ga1CBUxSJORq?=
 =?us-ascii?Q?PfGBNcB5Ivdqrlk+ghNLdUNIz1sSJf0MINPMSvHdiGgVUynnHPb9YuvAYjfa?=
 =?us-ascii?Q?HMCJnnr+oNerRZE3TechVFLIoToNW7Xwo7xHEiEy1u4F8uhAcJRz8DZoql6p?=
 =?us-ascii?Q?NaItcPdOc/kZE/FB/orgp2+X0vWr1XFAvDhoGyC+Kr5nOUgCK7V6OQWz8wnQ?=
 =?us-ascii?Q?EY8YVWZts26GvRkBBzOWYZ1vTI8pC0bzAZASMdvWDeGbtfXDfPLoDJF5z0ab?=
 =?us-ascii?Q?GWyD6I/+6bQVjVO6D54ne09L7bziOao8Wzpo1Eb6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f43a670-2b2e-4ca7-67f8-08db5c2d4f78
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:03:08.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12OUBo2IZCADI8lJjCqnMwz756xj26RxXXfHe0wofJK2yGKtvnqLyvepCJs4jzHqsjHGEDg1EyNND3y7P0YOJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

The specifications from [1] about the "REMOVE" command say:

    Announce that an address has been lost to the peer

It was then only supposed to send a RM_ADDR and not trying to delete
associated subflows.

A new helper mptcp_pm_remove_addrs() is then introduced to do just
that, compared to mptcp_pm_remove_addrs_and_subflows() also removing
subflows.

To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
command, see mptcp_nl_cmd_sf_destroy().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 18 ++++++++++++++++++
 net/mptcp/pm_userspace.c |  2 +-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e8336b8bd30e..ec892fb8d85f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1555,6 +1555,24 @@ static int mptcp_nl_cmd_del_addr(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list alist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		remove_anno_list_by_saddr(msk, &entry->addr);
+		if (alist.nr < MPTCP_RM_IDS_MAX)
+			alist.ids[alist.nr++] = entry->addr.id;
+	}
+
+	if (alist.nr) {
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &alist);
+		spin_unlock_bh(&msk->pm.lock);
+	}
+}
+
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27a275805c06..6beadea8c67d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -232,7 +232,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	list_move(&match->list, &free_list);
 
-	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+	mptcp_pm_remove_addrs(msk, &free_list);
 
 	release_sock((struct sock *)msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1e8effe395d8..a4bc937baa91 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -844,6 +844,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
+void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-- 
2.35.3

