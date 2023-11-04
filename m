Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2078.outbound.protection.outlook.com [40.107.249.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E177472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="lzppAdDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SR3v5S1Sz8hLRd1a4UmqPTUudw0HAxIfmP/ObLocsFDDIu6otb3kcGBS3fBAtFqp32c2pZnoYs+A0I5tfM/5yCHyQOHPrRb9hNONtnwpUMUoa5zE/SPij+Pb78p+/1Q6HFuUiqxC9+5b2zVZyYYGYFMzL95MUwjA8C/0yg64A99xig3RLMDhbh2CRpD8nC8wUDwidyKHc6EpM9Qo32XzDuYvWFXtKaKFq+hmh2v7xMPVv0UtlGSeTQ3XjGutCrx7pizSgSzSnpoH6r5LV3IAIBEMBNvJrEirA+06kMFgKLEG/qr1hc0EEaQfFBGDfCp7ea+hnXDZE/sMeC2GVL/1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4480WJdQWkJXBCygEA7mOiPrwCN6r9V/egttgfN/imU=;
 b=kigUu0gmC9UTXCLhfSBwvDttBUxcPQGdZ/SXKySDvPuUg+ZQ+2aRIroYF0OsWPZCLaI6dyGUTZuz0yeyqTnuCSPUd3RgwvTbh2jbZLoynQ63hBdkz7iu7BHwNS2IIKZymyJCkOsLNMOADhApy/iMvSnC4EDWb6UdD1/U1B95ioPVMprHhZsrozyNgwdCOdatDWIvSH9crr4v08CLbfJ7b9AjA6g/FMCRnDe+pMXBlByrYXcXWdPEUCwOxHWr0y7zrIDgcWFehpHlAWMP0qCvHX3Swtrl+BVel0JJElWP6nFOs+m9xREBItT94wtfib9YJUmp7djZe6rDG/E9j4AoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4480WJdQWkJXBCygEA7mOiPrwCN6r9V/egttgfN/imU=;
 b=lzppAdDw4jQuU+/5TJT8ReaYZHEaNLaWFpIfgtSSTTeqeun1mRK8g2rvGesknXzJuDRo/Yw/4M29op67Hg/gNPisQlOV1GK4gbmABNmpNoHhD+ad3LMCmlEIZ4Skz43bFvipbVKkffCLZD1SB22s7Csn6b0bZADRWcF7MZuup4uBe3i/rK+oX5+1u72ou9hl5mBD7/jnxgbQubNOxLYKO3wtdfLBC+qxx1dJ4C2Vi9hD5oP97qbDmQI8DZuZiRgMfJZZHKNWh8G0tP8qqpHpAEjBAMLSvlp6gYPfO89ZJXIWIdQlHaxqbi1L+nCIvP1MNdx450gRSlVvKlxo8mAzzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/12] mptcp: add userspace_pm_get_entry helper
Date: Sat,  4 Nov 2023 16:35:49 +0800
Message-Id: <f5eaa11e8f59d2ae73b12c6b9aea216248c57544.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 41be1ba2-ba76-4c7d-7a25-08dbdd113bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eMIp7oaOzUEac0IXn63fFLpShJbkKMRMvonz9sTVhpEQ7FwAICovWFr6BeQpoB5vT7pzTSDOiJ8jTwMnVUwGtGu0E0OTGfTkg+Vrk9O6Vh9d3U/6QPOfsDyT5wJIll33pcemrVb0stns9OCMw1ptuviWT2eNEoYagWPssrrquSU+hzMgmxOnanaUYLH8xD6K3Ga0HzAgrhQXoIJEbBxMXflYrK85OudsM4qmLqNhaVyMwCshPsM+7ua17HD6TqCuxXMYrXkI7x21+tG2D5hFtC5nNGofrMuH8nse0QaUrUJHJG3PhA86jYlo0bhhm+sSI3mEpa5pCIZ2pA4D4UfWroqz2ONnAYb061hxjEb4yT6wD1F0F77GL8OcibL8/p9gKqgM9ZINd13511VrdJedfHMVtrLWLLvWaWzyW0gtuP9ansGTmGQnBQ8juixdGjAz+7dyzZ3uG9hiWde6PHi2+6E2i3DN+BE2QPxPgNfwqAwwDMAXBHwpk4mqz7WD+jZ1iubFro8epFnwUE7v9C93LW41YXHkH9+Hlm46wKj7ARwk0zIQmtGhlCzOJ0DnZd0G48G3Nm186Fh99MS/GcmqgC2IIeG8Lj073hyP6Uay+MM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4V2puwPcqZAcypXXjRnEChxMulLBX9BiNiM1NYZ0vy2e5stFJtqkjlkaut2r?=
 =?us-ascii?Q?CNrc9hFodc9C4rzScWTyczCqLacqegqNqUyqRZHQFe0V82YP6UaQNhK3kJFy?=
 =?us-ascii?Q?Nw6qqj4gEvAv21KLlsawcIUq5dTtcMrcAOZOxP+znimWfqS8MMakE+oL4hhz?=
 =?us-ascii?Q?KTJAoV44NvqNgnhtGPOBYmd6fXVZ8/s1ddYfMSzwbGEjIdMqsIVJbj5QWOHM?=
 =?us-ascii?Q?JREneKG0LC/BqS60/v5a+rVDiIgDMyESolEfmGV6bVImRaMV/JdyB6pwviJF?=
 =?us-ascii?Q?64+acn9Ny+lKd2J4reAhleb4B2AhLWqiPQBO2LffGEdMrAYDFOCevu8Ti3Vp?=
 =?us-ascii?Q?C9fTX1Iw+J4O5pVpW5FviO7iWW5AYiHYGNF6p0Z6JmaoDj4vSE0eIj5v59W1?=
 =?us-ascii?Q?4NLwAQ2Z4lVP5qSPw56vk31I1ji46sqCr+fL95KKSf38HMSP7I9C70YPxm2/?=
 =?us-ascii?Q?eWKdKbM0kg3bOmjCNM0zQ1mCNslOvItltvAHKHHXd4eMpwI/jUC+QkY5THOU?=
 =?us-ascii?Q?4I6ABNF7ivnoxrguv8xxXfNyhx0iEELi7usGsiWP25ViAORDVSaEFhKpM/4Q?=
 =?us-ascii?Q?4kSRyaCoT5P5hgXegxZlKgvzy+8ImWUh1iaIJQ1Mcg1JGcWqKn1Xh9h36qfn?=
 =?us-ascii?Q?T3donBTe1vHk5tJ2YA3es0gpaI5bAoamfExp/2zeFIc2qD5P9rSdPyq0eCbJ?=
 =?us-ascii?Q?lJZ3dYr/ccmprO3mwrXvj2hSKXiYI5cIahCk6ra8X+W6+GPhXyYXtQeuQ7tJ?=
 =?us-ascii?Q?voSQ8jr5EVWNa6sXos6tBDrHCo9TsVXhguKsKoWGTsr67e2RrmFoDnlTUh8A?=
 =?us-ascii?Q?BvLZLU7rQUe8JABtkHy/QHAHfHhDHJsi126nOqZ5ad25KiGF81dS8m2fJ1Hr?=
 =?us-ascii?Q?CUq6gv8I4Zps3/0QmEQ8aZi8HBDxENal1hdA8cGDtdeboZbUiMU8wRI6SklM?=
 =?us-ascii?Q?/6gsEwEAwrqksgacf+5zkiaiMAdDrh9PiTYRa/BO7apOXm0bNOm5sacdO1Y+?=
 =?us-ascii?Q?SdW32g/nmDbHofjwwi4ROld5p40Vrj527LhJTz4CWend8f52IrfRThD6/6iU?=
 =?us-ascii?Q?kyXeN5UdTnwafC8FkoiKfyjY1AG9cCzkDrWKUvVXBXsqHHZlvWmpmTy5kgvb?=
 =?us-ascii?Q?28+QEyYmeLKilkG/Jtzc6jUgskKeyPkHyX7jfZBEGrYW50ynxh5nSWYz9uHv?=
 =?us-ascii?Q?RJ3+lTFV30ymvlrLivhPDSjlYRAo+KC1ZPFm/hUHMUc1FcvZJ9y0cLLkgbUX?=
 =?us-ascii?Q?TKPoO1nxqNsnXWOHRi4JxMGKMWi8ocwF/YbYAvm22/RE/wy/nFIXe+op5eRl?=
 =?us-ascii?Q?mQijDiBQnDiSnlJUlKdMvRjHg7ZCIaCTdK80upUygKIeYubo8eQ7J0wtoChw?=
 =?us-ascii?Q?SGm99q1UqIwOlrugroOs6NnT0h/CfNStUTgWYS8ulEDr50quF0LZaSiNYhJj?=
 =?us-ascii?Q?vdvTuJgYIxbZbC47fAy3NuvIT/HcL4OOuxojVZ9BSinE90X22GjPcSM65vj/?=
 =?us-ascii?Q?zPkwX97zxgSNReEPpXB7eWp/9WpQWforot+5nojN3ttx98sLULKcf4G0kqd9?=
 =?us-ascii?Q?AVF8oyUZCrsfhYWeRM5CcbvAl+I3K7zvQ90Pbobj7bSHgWte52Mm4Daq4CMw?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41be1ba2-ba76-4c7d-7a25-08dbdd113bdc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:09.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgneCAmR5D+3DbnkLZ2inVl1AcrtQ83orZIWsnROeOUPzWYyFH0qAIF3uYh56aeGsgT+pZHSwp4vkHC7YE4fWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 98390d048ab3..3f42323c30c6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -39,6 +39,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -103,18 +117,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.35.3

