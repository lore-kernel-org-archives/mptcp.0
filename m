Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2076.outbound.protection.outlook.com [40.107.104.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF11FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="egC+R1iP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ9U0OpZoy2n7FTGL602cyNvRkB54LQJggVmbL6k2hhgyXRUngmBsWCcu5Ank4zlTdjMjftxtnkW01m8RMjUjpr6CmB+EtbPpO6A9hW+KVBBdNkioPSet4qPUAS8MLdO4oU4tSEXqtfUbYFcvRTuOTtt90t9ESBC1XYl73EcAvwcjNd7KnxThgXA7OiPnHGILNPjNw0CaALfMObX9nXSt8CK/hmKmr+Gtzr+QXIeDaTWcoIFgCCdaBhuZ9AUMrraH4NM+KI8ATpS7qShheGSMVrLBDNi+8PfmegFDO9DnT+W9xasn42yZ17w/1c1gPHZRKIk8/mg08qkFxoGTzEpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoP166l0cxfbdzoTW90KFZp8hVW5a78ALyEg75TjHvY=;
 b=fnjiPvoH868ULXAi8UwGaOHVLSN2U4i2P5j1Um8lBOiKGPrp1dY3DVRgUNKOjNxtpuxmQi8svMBYtdtMEK4iDL4/BnQkiuLyHt/qm9QAXE5dh+IkOtlrFkjcUL/ZMS6L6hLgZj9XU6zRhi+JU/ad5CEV+RKQYZRr+jQTsI/VFkog8FQvuZIrXLo1uSi8t56eyFs5ejFD7lbya6S+lp+Bx3mMRITTVQV+xhZsXgSTTuJyYZ42LZmeihLkwLQPyXnLX30ROk8LsSFx5q8YHsjBT17MxQbWa6rS0lXKBf5x+mT+p9/xdaq3LCY/gGq200CvLWo4CJufaNn035BAKs+lrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoP166l0cxfbdzoTW90KFZp8hVW5a78ALyEg75TjHvY=;
 b=egC+R1iP6hV3IQSe+/z84aEpV58K+YKpFXsPvCaBUgoZJKBn1fC43ukwNvHTTHwt+YXGN/U+DKsJzkklIzc1J/4tJkSysrw3pSRfLUuG15sTnZABUT5Zp+jduXYT3IhfYyYlDNLD568+WJIvqjlXm99Yp5HHkauRED9B+q2BltVaKvHh2/kFREQs56VCUa7H1iHNusjMPkKt0s5MAWWj549Fmw/2vpjGH9Hg247k8dVc1f8R6oK3wR/rjbJO8N1PYgJpl8C6qpSyWCGF+11+6P8cIhmJUDOgqdUAdIuVqPGfhgG/BpVXhpVZsPuMTdQaX343hqgYa7MuJCfSp5aAvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:02:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:02:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 06/21] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue,  7 Nov 2023 14:01:50 +0800
Message-Id: <a9be5c180f18d5f193ce1dd2f3515c25d655972b.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ca159c-5b98-4616-065d-08dbdf57293a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNbDfXv4O4shIoFGov1NYgJf05eU7URcYPqeh7h6hBEtgl1ysoEnhEESGTASd67txSL6IBFUBjzbboPahw7sN3EkOinh9nNNeBiBo4arzFsu3SjOWA5cw2inuEbSRDLEk5Hk9KQ43iYgGV56ShPMFMl0ykl8VYglP+fBp9kgr9NfD1j4Gfnov7uELfGNt/DDVkSZAA4yPxjS4d4Y3K48GVJnIud7UCVoXATh89PLS3omiraK7/S4QGERiIcfqR+YLVw405iBrqqcbd6enUtUNbCuCoqMAxhKDkgBQVNVn3JVwZDW6+hGNdb21P8U32br2Ji2COOD+nEDbOlka/NNMKzeLDqvRqB+9F+IplvQ5TV9C1HsEERAEpHDR89dW1gyF3a+jzQq6IFxuxMOlksRT5ZzB89Ez176hcsX/0RN7EUHAz8mYdHflNe6P5jH0QhGjHFXuPnI+8hwA0WYiM/jsmt/ET8H/Oz0Bb6r12JX3BzmFIDRyJ/FYnQ2ZxEdHSzjjNOqdGYS05NkLd5VD7E2ILy9rwRCvar/0npVZfnEhZE52yRDxPNNjG1uUWwnnOg4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(83380400001)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STyoNh1VeDAgxF923SDTrA5FXg2odsE4zPv+M386GjuNaRhISdgg0FSs/iL0?=
 =?us-ascii?Q?zaBtLiibfScnIHLotFNgEsCSV8fkodtGaumKX1FhrzoblMTVVaWeMgrOFS3C?=
 =?us-ascii?Q?wrm+PF5crjXEHQVFTE6s99VTvQg20G0c/WGN4POKEKVe1PZ0Y+Z21xoThuT6?=
 =?us-ascii?Q?0D2xFSdjwVHe0dGXpGW1+EpUZZsZjsvqg9hm9brtzPL+CUPXUm0xyByxTvaW?=
 =?us-ascii?Q?USONSnva6jiH8zbRpAWdokLpX0w71qnoITEzuljiY5/vX+ILFKtF9IJqcMVn?=
 =?us-ascii?Q?HrCqFIOqu1Or+90hqX4wmuUsZlnrq1dj2Maz+lwKTFQwqAEACbCH5BL1P1PE?=
 =?us-ascii?Q?6mak8uoEQEkdOZ/O4+6mJXJpPfcLsR2cHhIhy+/2qhdE4SRli+3AF6ysp5EO?=
 =?us-ascii?Q?eFCqxkNradWOpL6iFuh7bzrjviTjJZ0/t4NmU5clD+BsTYFg6DtE/19CfUjc?=
 =?us-ascii?Q?Yx9uu4QrDQfsWE3OyJAfGTfxu+uH+738M7vlcdQrdaVGqnUN11jh3Y3x4WZD?=
 =?us-ascii?Q?7i2D0RQ11mt0H5+EnjM0nyBKAxsRNiACp9Y2RiQWlrPcTFPn5znjy4ppi3yj?=
 =?us-ascii?Q?KDoPOQ+C9dmn1/dwu7C3XSXS9KCpjgq2Vm2NFc/ZAFRg+UBmdlTvcsOHi8a7?=
 =?us-ascii?Q?O46aHfSraT6+JUDzoUtDPtk08482eDigLuj/eJ4Tc34memsBEVaeDuJJtrto?=
 =?us-ascii?Q?QSJw0yLBkSEWOlcBgUwR8KIWnauPTV9FAdTWpsaKJ9X1bfX4HAr9diMQYH+Q?=
 =?us-ascii?Q?10fnlvgtbrY5UrckbILt++uctiAEkgZlx08gOj/G7rplpyMbbGTrS7cvneoP?=
 =?us-ascii?Q?EopLvekIvIOAs7CnqbDXBstawQIdNanZzY8JqfUqvUNdGTu3Sy0qpcs9Vs+i?=
 =?us-ascii?Q?RTJLa2vLF2glrb8hjjCAKy9etM4WpIWc9SEsB3emnNliENSH/9oBMWmqgTbu?=
 =?us-ascii?Q?342iU6ysCIIoxmnwxVhU8c5BAzvXU+zE3vOrFlmJEuBm+rE3B2y40NhYQvqt?=
 =?us-ascii?Q?wvIp52ub0+qsiqUPVDjxMxdY7IdV0zpS8FYoGba29R5Sjgl2BbGAv6eS3icl?=
 =?us-ascii?Q?sWm3vj5GTwDIvoOvXnPNsMs8Ej3mxsI8Ua+3TTcLD2LSiKUZXiemIZkdcO7J?=
 =?us-ascii?Q?oP2maFkTnnp6GOkuTsGgDxkBAeX39G4/cxARn3P16fFVh4IAdT6Hzzg3HqSQ?=
 =?us-ascii?Q?nWMHUjUYvaMdlBirKARFESkN9h9VluXwCHN4iKPZhUnLLOmbeXLSOVaeWYc7?=
 =?us-ascii?Q?ZHiTUml6I/zZsXGDgFHqk8MjQZCrD2Kd6OIraVOU9DK5WWBBnwt1Xhsb+gwt?=
 =?us-ascii?Q?ldYJgdkog6FVeDTP5vp29SK9Xu5yAhp4FloK8N7+UbTKmnRHneEidhyBpLac?=
 =?us-ascii?Q?L/QLk/flGpaYW0VRjHSibWjlDqGaGX937fv21X/c+O9RAlztdfDOC8HaNTJ3?=
 =?us-ascii?Q?4fTqZSpEAyenjqmcnyQLqUnmxY0tMcTg+nqk+VFuss8UTWW+95Y5OKuaH2ZO?=
 =?us-ascii?Q?8FnmgMLyYHw0amUSknjdO07e4BEdo014Ou7nnkibM0DDHMHnwSsrcTHO9Cgs?=
 =?us-ascii?Q?5kWPMC76qmYIgoDCL97ALoKTh0iHw7cGcQzeSNPo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ca159c-5b98-4616-065d-08dbdf57293a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:02:45.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e5/sH1j4ORZoaNwwghCM2vrgHpuJzz90osy2TxBO9vRWOOxBvSB9dWRTroy1A/jGFnxweVU+ExDUlDcbDrC5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fd74c0092039..73d16c8006d1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -27,6 +27,18 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -109,15 +121,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -249,7 +256,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -286,13 +293,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

