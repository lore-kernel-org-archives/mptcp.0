Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA135888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="zxu//6c0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7/LUIB5CATZnuf3ZzDjYLzu8RbqGVqp9lAxvbMVcIfkss5aZVIWb5QwGR1A8baeaJoTTLmdBIKP5/+7MIJ2p1hRXlLqmdlBW71UksLcjAPGFiKRAoyAPsBI15DYjQg3E7iQwhCY/I7djV8g1kgkiGMvorrpnyp2mNDF3kC2l6lVMSbWEvC5tMT03+F7TmlfcA3v+sO3sD+O29I6e34iqbLuVOx8FNNajzXhlEfR7qJt8LO72rfufZIrCHoG0pzYm76gZ9Djv5xZUgxUwv6Vz/JDVL2htoiK3MDuW+/S596CY9ZrRBQ6s+AVaufKy7rqkuvV9PpfwlRZDl3GNoleAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyO0dDjGQ8YNpkhOtnfh0sLwo5M8qTyjkoRsOX/2DU0=;
 b=Y6wEE7bhwpZhWi9wEhHfMjMwCHkBi4DZlg2hy7JtuQxQEEtD4E69l1U/4rncx2JmBh6038bT3KBTC06K870BwsuBgt6p/ZRMRp6fAyCjGkHsZ1+128VLAXMv5aoZQXVmWSIaQnjP3Eg9zZ9LETlmyiqYQzKcBUKmaZPPx+R5cMQULnu5PubB2w26Lqh/3AUlWPKVgYAUqlZ14rp0OFSNeECbmHIC/Kx7pTOykiEaXeyn2tgQDL2cMHui84mygdhvadvyVyPkuWRET9hcFpSTt2HPtQAxFhYXMC+D9oE4Mg9cdmoPebwIEohGHqvfcG1cUtzx+gq67hL5nnfmVtCm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyO0dDjGQ8YNpkhOtnfh0sLwo5M8qTyjkoRsOX/2DU0=;
 b=zxu//6c0DAA8f8IGirk8h3ul1sQsJMgzk2LfyHSBUxDmf82E7AzAvWU1O+xKkVmzAQaMYjvsMJAN6SLR7PvQhjUVcxlOU4o8FG6kDvccvTyz/VbkIYxVtblcN/lxRMxJm2YTC7PInqqn2oNTE3ztzxAvLelbf10ICRZYKQBkTSwtKidLMKYREMwD2HXUBPCBqY7yP8rFu8GY3kd2+UjT0wzILTcr4FKuiJL7gs4mMTlo4v/GbqFs+YWRf+dIn9vxEYTZXbOFNNJucNHSP5Kjcvbk0Q4OqrYQaQM/Zw0Tt2u7yDlHvXg/++QZWpYxF5q1ddE8zalOXCGGt3JgMmwoRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 20/32] mptcp: add mptcp_pm_remove_subflows helper
Date: Tue, 28 Nov 2023 22:22:13 +0800
Message-Id: <45e57e6e1cbb87ded323af27a9d8eb692abd9139.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:4:7c::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 210010a0-1256-449f-6d36-08dbf01daf13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jzlVUKRXedH4KgcJgjWFNQbq3JAVtadumlX6Gbyu3a1/Ui/v4guLVQhxnyDufsW7jJEq236K1pwb41pFDWVdj3VmWDKU1TvWisUyx7ARe0122tXm9xTmYIDiP+ZIlpIG0lw9axw3u0tBTwi5b9vn7t/0eccQaq5f45txc8BXzJznSMGW1ka+qysoXnCwr35viGSpijT0nulXUpDmpphlETup9+ObCd/3eg8zR7kC/VhjwIHCu0yyR9XcadqpEjwVJSpiNxyXi6OD7sMzL1DXtwd+YsgDGbuV6qjwlYiRDxNaC/2+no5gW6BdIc0FNb2zkYrkdbf9WXcLsdVxnREQ+iLvEybaylAp35CsDMMlO32qdXna/W34fj7YQMGWzv5cdaoFq+xkMw5/KtS9WAxfMlUiE/cdCUSxlRRYUWd1GoKrfuC5NiaSAhLn2+2cIwp6IMjMswaf/2Wo7uVL+QkFFvG6hIRE3IAV2FGyJVaqu7AcfAPFQI6rf5RCedr/RNLJsvv7tdoz9BeRUKsNbPS6cC7Kvhzz9eXR3XgjEGrMYQE1vbxQOIFrh7Mv573Fi7W/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zj34khadI1xA8MMGKFTZFni2UI4+mZpuDfHnNOmnER+b5dFui1ZXYvn/EAWz?=
 =?us-ascii?Q?p7TvGO4fLkZ3mEX1glL+x6dgdmDp/2JeDtlo3USq90zX4lGvZz+vkWMgW9Dg?=
 =?us-ascii?Q?Sy20NjUCwOVl00JA9s1XJ8PR4YMl+0l2MvixPkrYlx9XjcqYGAFumvIxiEfe?=
 =?us-ascii?Q?98pcTqcXPXbqBKCJ6XG9ZJU5ehFMOBu1LT1MIjIMumgS6U0vvMvs0F6Ud7kR?=
 =?us-ascii?Q?se5lFPNQQLBeWQIvu8Qodm1wL9QtpM9NfM0MB71WGRpXeQUB36gP+NhjKOsY?=
 =?us-ascii?Q?XldfUevXek7YstDdVaiYhrECpiV+Ji51kGCpxabH/AX2xmbzJCfr0hsNd0X2?=
 =?us-ascii?Q?6MlRnGKlroxE2dYpmcWeSrxhXtLmE2csVvNnkLZhmh4wJ7UPtGtUpFjMkA3q?=
 =?us-ascii?Q?ZPY3ZZYrTsP6su96QmJm7AufDcjss2osVz8hqQxpA+A9xu4NeHP/UG3Tm0t2?=
 =?us-ascii?Q?aqDDWtcxxCvYRy4XTzAjR1D0xdcFZ5aBB/gKykL+crsKGX8kRH9Cqc/Rkxk4?=
 =?us-ascii?Q?0dys0S1MdiKpI8iGxj4KF6+nLhgU+JRVymoaOdCIzue1FKMH6Tmu+7m8htS7?=
 =?us-ascii?Q?AN87/ps8Zz2DEqeG9R+BZT5fr+App5Ks7afpf8x8TEZonaACUmBAZQzh2bKT?=
 =?us-ascii?Q?ETNijuLk/Jlul2t9j4VyhINhPkNXzCPUwaudw1E0OsC9pV0WqlFSPLHjimVS?=
 =?us-ascii?Q?YAkuSJLjF3jyf/1oHfVU2v7ukJLXJnx96DvkcHFxwWzu6Pzx6lunMVgDo8zF?=
 =?us-ascii?Q?xbuTriU7RJ8lI4rAl5JTdd7LlwPRUnHgKo/NPh+tNx4tURMJPrCPJu1jOn+Z?=
 =?us-ascii?Q?MPzXqgzKNsP5hnvUSFrOC0ADkimOfexpYtW1N6CvAHwn/X2W94piWmBnvDAr?=
 =?us-ascii?Q?mFNYppJfAQJlYSmnRk55QNbkPRU+44rc9AluDEn4nKKN2JDXUSAgrwcil+8E?=
 =?us-ascii?Q?gV3D6DqcLZcU0xa+lElgNF2I2itukRfljumNrKezwSych/VZuNny57BfkJMr?=
 =?us-ascii?Q?PQ/oCBpoHxeTXb5VotlYp/xru3VT0YAlqGwcdiMR7gXlSsVYDRxVIDDm8Bps?=
 =?us-ascii?Q?XgwLlYFlSQgRUVfUc3DH0gwNHK5cwCdFh00KBFwB5TnF7YNR5R4o+iYYbdvi?=
 =?us-ascii?Q?OmsMTc/4RnxT47NlWLKk15dHUlBpPRiylu56NaHdH3wGAZ9Uab00lhtYWi7F?=
 =?us-ascii?Q?yrWlcgATkd+5ThxJaa0N5/3QaOxcE6WNBVeXNpB7P2uKvAumQzoX+cAWjL2+?=
 =?us-ascii?Q?EJwby5twzfPGxc1C5u3CAuum9kuqRe/59CysYIcYLZwg+cqanJAm0pmNmufl?=
 =?us-ascii?Q?skWJeyi5t7Hp+DYCQdu1Zt5/R4Yy8xON0ijwQcHtKkI5mDkYRDjyk+TWC8kO?=
 =?us-ascii?Q?BeprXI5/KNp1JCmfZ1OGgtaFrA0C90NWaIKyze6XrKRl+AHOPK0eTNvn63Sb?=
 =?us-ascii?Q?0rvYwKFEUU71NAnfKkNVwnysnjNFKaCaVC/yO1kwNjabRH1dyw8DyEQVOyPO?=
 =?us-ascii?Q?AUSb0VYJpDnTeqiAS3wFoVHyW4pqC7VTRmyUg3UGEGJ0X4eJjia6xjwQ7/N+?=
 =?us-ascii?Q?4xZ0EHei8f0C68IyViCezh1se5vAIEimm2UGxOsW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210010a0-1256-449f-6d36-08dbf01daf13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:08.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OSEe74XBf64g553Ikgq01gFSLQFLID9vuTsEqAOUdVPHpEHKIBpVwI1f0Mt/pO5WLPVgSkD1eGAZT9SB0kI6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Similar to mptcp_pm_remove_addrs(), this patch adds a new helper
mptcp_pm_remove_subflows() to remove subflows related to addresses
in the rm_list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 15 +++++++++++++++
 net/mptcp/protocol.h   |  1 +
 2 files changed, 16 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a510c7d56d0e..a4dc2bc8fb55 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1489,6 +1489,21 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list slist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
+		    slist.nr < MPTCP_RM_IDS_MAX)
+			slist.ids[slist.nr++] = entry->addr.id;
+	}
+
+	if (slist.nr)
+		mptcp_pm_remove_subflow(msk, &slist);
+}
+
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 94126212da8c..efb24c05a7e2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -941,6 +941,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.35.3

