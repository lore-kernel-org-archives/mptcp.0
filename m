Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33441C2B
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 08:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/C9dDxdlExal9I3sQ063S/6TjNw53ZD3cn9onbCS0LsEy0kp9TtqOGb06YfEye9FW+61dxcT8wIC6QE4Pu5T7DOeV3c7GfGdG9ig9/8cPjGOA5Xppa8leovQ+D6NYS3IRvWGEh9oBD40cpzBksGcZA1YHHBRIOnfM7Cje1q9ljCiGjb0ECix1wxVHj013p7IKGlDKkoeuIr6n2RfN0O2h55ZIGssW49QeoJqIjk1FPEJGshC5H8bfJI+LFLoOLIcyI1G7RoWLY6Y67YyK/x83H0ept9Ce+MolOGHGzKsJ+Nnt0M7T1CrtxtyZakqVWVMJyvqovzjsxGVZDRuyUhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=B66YI6WrFjqYpcR2d+Ki3nYm9qNJrTtlMJM6fw7q2Q4gmJv0UmlzrsMaxoZZSLHlnNUDajwPaHC2M6TJXosa49j9UQtEJqaIiV6WfI0ole3UL5PDyfaeFeTo+g7t1kGZ7BhO6rJmqU7foxszJsuXseTOAWQcsMv7NTfBfZLRNoSL8mxsGnalv8vhqPJ53hh2ja5VKnyGXACLHPrMhJkgBTeKIjyRIHV6Ry65gNctaAKy5A7L8DxzlguJvDkvo8ond/2xRBZ9knCIAZf5e24S0EZNWDEutdk6/sNeQhC8qU+HaqsH/6hoO9xixKLcQK6kdlKh6VfWtGBsQrbxZAWtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=s51r5JhHogoLBwPAzS+XXVaP7aDiotjp9597Ys4dmfPZZDtuTFVq2unSVS9ILOSkrE7QGufIB/tLyPFfHREa9nI7wpSNb4njLwbQQdxtWXnM7ZZXUb/UlM5EAe/yAWolBOUIILsb5b6/SaFLjMYTj1AZu+lCXIIXvHeObn9raEAxfQfuMjhdCyTUClBKoC0AYTRq4dMyq2HIY8wlNPDJUCGAR8Tylmk8zbxMxcHOi7UtH4x6KD8nyk0s9mhgGPJDN/vonvc2lyacU6y2fsl/U8spAr/5GI3LL2f3P/mrs4mOYNaOTViNoh4kFs2+EPrXSNmHEJpPUjUsT6d4Hb2EPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9237.eurprd04.prod.outlook.com (2603:10a6:20b:4d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 08:57:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c16c:64f2:91e:29b5%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 08:57:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 4/6] mptcp: export remove_anno_list_by_saddr
Date: Wed, 26 Apr 2023 16:56:25 +0800
Message-Id: <90c3c446e95c4c70019069208b54a54c1539de2a.1682499136.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1682499136.git.geliang.tang@suse.com>
References: <cover.1682499136.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ab58e170-37d0-44db-3e64-08db463438e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bwaiq8RnanyiePbC0b+lOmuWydliaceKLMUan+QvTMPYnr1IY0OuHEb7T/iwuPjFdDlS2zB3hTMb9x6jPUmmusNr7H9U68svrvMAkvL2sxHtQEH4BSpFyJKV1dY16CABLojQXlNE2rEmH1IScTUvu/pa59pBoLNgiP+p1RHuhUVLJL70TOJgKgs7/qpobOe6kpo6YWGqjceGF+P01Kj5aJSP8bKEnHCVQAyiMGxpOq7c62VqxNxZz+qcbgEuT/ogP9ie1OJgj/2UW+QO1Y0ROsiSDiJjurJJvWunq+yMRoTQoEFwCqxxwIpXMTQtkXjT8uTakGXGwqROWv7Eg8O278YpIuezDkAHJ4LhUy+fWPpSGy7MUbcMkhQ/hob7UTr2tvIoUfRi/Ow7yPjLMEBNI/+MvoDwU7SpCVOI7c3ANs7LP8QO8AmIIjwpQUozxmWi8wThJ5XMoBGm3buCjf4cYkHGfnMGqHacses07wwxXj4fh51ZLol1ZTnq34BGeVErWl55VTwNW5tG/dWP/zsYjGoPePsoMYqE8M31yUZbEsEJ+fBjdz0Rbd+xe8ljpzeK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(36756003)(5660300002)(44832011)(8676002)(316002)(8936002)(38100700002)(66946007)(41300700001)(86362001)(66476007)(66556008)(4326008)(2906002)(6916009)(107886003)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(6486002)(2616005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oewic/dwEdHf8kvW/j2034nQm0uXlnPSQ1LbEjb5huq80Eh3rAKyJh7pJHw/?=
 =?us-ascii?Q?srik++7c4yju+EdNU4bVYhpG6hUnzu+Uvrntu5YWXTXtQTfdIF/hGofr/xMB?=
 =?us-ascii?Q?/v/OWElf8vqPEoAQ85ajXL3nng3jlFhqKWwBqPtPsf/tlQib+oczoEpQd9OY?=
 =?us-ascii?Q?5hLvMRDKR4+fEHz8NuvDlQl3PuAY97nqgVNmMP3jYxtbE8ELlRM6krzi7AAI?=
 =?us-ascii?Q?NEWSvwpyofUma5SfZ6uOPhSr1McXaia/owJ5+71IfD9/fAaeiD6ZG88YnEFU?=
 =?us-ascii?Q?YJZzQvXbtlnxgNJZ32eAIsPBYXtJPWFNhD6bhQP/bLhEqjYdC6uSomwqSoNU?=
 =?us-ascii?Q?7JTWZ26aqEdTc6AUX4R1dQNL6ZU7QPVOVTG8lz/BQidD3MgNx04fcpW63MYU?=
 =?us-ascii?Q?UWQMYTw73kFNIUM/GmTAyh/GQSk+GgDT6MrjC4tkgk+PiBwLRmliexSfV90z?=
 =?us-ascii?Q?HatNZiMNbGS7O4B9oK2v+56gAbjBs+inE1sGw50ju759Dq9NLTyih9m41tK6?=
 =?us-ascii?Q?lA7meV5XGC6cQ04hXt19snSWtz6DCcOXiyMnoMN2eQUF9YlMbLfO8kLL/0/P?=
 =?us-ascii?Q?CKg31Irxvw2muwos6nSLpus8Z/jjT6dcYGnqrZkoRaXK26yuKx56XOv+/VXc?=
 =?us-ascii?Q?2PXT9N8TzwbDM94uREk8b62qkF8RtkIdU/Zrnsc3IC/LP8N6o8kECI8I141v?=
 =?us-ascii?Q?61ZiSTpPyyMsceqPlAcxBeVKlUS7G8Q3YkYbty/tV3FZXLbSQEezABbkEy0g?=
 =?us-ascii?Q?+gDLE8Ku6lLaA73qQCl1SsId63uZXJgh4ow3WTmBVB82APsYLUprz3cV2i9C?=
 =?us-ascii?Q?aEVCEbhcuLrhVny39msUE9aX3LF/cS8jrq7ZFNWJm2N98A9MFAKo07/eEqIw?=
 =?us-ascii?Q?g6tBQMhYP45FYMoto0RSicx+irLTRrPZ+zPKQPcTN6IoXFPyOpEGU1SVdrTR?=
 =?us-ascii?Q?KoY6yfSpmtj1v0XGlAHE1dSF9w1gWLE4PAo+C4T5y7eMfN6XtYdp08VeQws/?=
 =?us-ascii?Q?hPiVjaL5zSSEjzYPTXuBs82W7ft7vYFBmu90cpYpIIIv5R05L9WEwRl37F+u?=
 =?us-ascii?Q?1O4nv2D5mfX6xP/RbNty0acaTJmopc43VnvNvVhdQatrR/9fW/KLZSi9yt5N?=
 =?us-ascii?Q?uo4gxOZCAybQosbnvOfEapdpO3tUgpIz/bem85GeVNCC+MEi4EdaqYRe05Oy?=
 =?us-ascii?Q?X9UwTDmefyKOg+u6kFdtgy+cKvw7gtSurHyna7jrNwSNIWxBkwaCukfdEmil?=
 =?us-ascii?Q?8KxYi/DY5/i+cEH+50nMp8NqJgJ2q0TjOtHeF1liGNT5B5M9RTKvUMnCsJoe?=
 =?us-ascii?Q?dS9zTYzjScSDwheqhxB8mGVzi2H7S9fGkrH6AxhdarDu6M1WlitOHCbrsOAJ?=
 =?us-ascii?Q?l6L1abYmPfTmwantDe65SX/wNYn9D1oO3jdoqRuctlgdaW/21zVl4rs0dSC5?=
 =?us-ascii?Q?PFPM6/+cSXwG2GH+Y6B441PoK+V20zg6WK/He6r/HiX0rTjKZBN8A1nrI0u2?=
 =?us-ascii?Q?Op934bozcDYj6XZpAJOukysaz3i+isOh4mhCceuh+6SyB/rpnGeqcid2vNhs?=
 =?us-ascii?Q?m8fv9nNqTFJ2oCHGdi0MlXV3Gd2z7NxOBLv2i++I?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab58e170-37d0-44db-3e64-08db463438e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 08:57:11.2053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vRmzUwzTBRxlioDDdIZBso4TkjA9vx4CQFOl4euV/VivuUFa1ufV5jC0lZ5JDx9QVGgi7t0hVJk9mBGdvlgYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9237

Rename remove_anno_list_by_saddr() with "mptcp_pm_" prefix and export it
in protocol.h.

This function will be re-used in the userspace PM code in the following
commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  2 ++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 784145e6a314..0b34b57fc8bc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return 0;
 }
 
-static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				      const struct mptcp_addr_info *addr)
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -1423,7 +1423,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = addr->id;
 
-	ret = remove_anno_list_by_saddr(msk, addr);
+	ret = mptcp_pm_remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
@@ -1561,7 +1561,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
@@ -1584,7 +1584,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if (mptcp_pm_remove_anno_list_by_saddr(msk, &entry->addr) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1a2772902e9d..bfa7d93a1c1a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -831,6 +831,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
+bool mptcp_pm_remove_anno_list_by_saddr(struct mptcp_sock *msk,
+					const struct mptcp_addr_info *addr);
 int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 					 unsigned int id,
 					 u8 *flags, int *ifindex);
-- 
2.35.3

