Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2052.outbound.protection.outlook.com [40.107.13.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691ED808
	for <mptcp@lists.linux.dev>; Wed, 10 May 2023 04:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb73D8/UgvZ4CQQg4Oi1hclubNnKmgfdSlqKKmD/ix3Qtr61P5Gi//Nk/DetVUb1P9dMJjCVSLZ+DvUm51AWTJtYTtDUJ7dwcBkyamMHUr4rgHA2kJ6kBdbXL0+ANy5BIIhHgyemaapu4l73Lyp21RDUInKKtnvOS4DoEZAdKEI9ZxTsLV35+pKxqEYWO8AFTYDFr+NgyF55oZ6fABJCwqtrA3qhvgw3R/P1uX4e5nvW1TCQI2+9m7PyRaMMRE/1FXjm8SruUXw2SORoat7Le0f35Tc2c2fpjtyW0h+Z4kuO+Hdrh3NXQ4arnF3nftGLp7bAG9XuVVGEhsl/mSWCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=faYNegEey6aYO60PPUFmG+edt5dwoh7nj4XRsfUL19ofXEoXQlYJj0YF8TOqTbtZzZMyHq2NfYm3o6+PrMnQgB762SNHmxXpeAuYGxflmo9Go7Bo/VZywIQ2CpBSL4QSQ6ruK44BGqphdgU5Ws4XQipl9OyE2iZm+7JFCVSU2aOcO2bRycehobpUSFjW6OdpBSv2MgJ5IyAX16oCLpnU8QTnK6hLYUWEqtfwfVupT0VLuogFHbdaBM6YhRP5kjKYhRFI3Om4XzcQ/9fl6qnpc/CcdsPAdp7uEw5sQP69WrY94c/4VpyMsm41uk3gxSbaqlYBSa9qWBhwlIaNXLCdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCV0AEWEtidxTEvBQUI1wBNDYg/Myr+Hzq8yss6HBH4=;
 b=y/mJJRtlSZrmz/vGyl+7yWux6JDLitdAz+tXqjR0U2f/7vEFYC1nJS433IYGRRy/q0jJ0adqYs0I3zLOJDdUNuEr0WAKGdIgrUbL4weeAPok9sxPUqju+QRxSOkZx1J445NSdCbG8Ewmuw12+c5tSicisg/YxEeZhJbPDrDyO+F3RCUf/ddXz1tUq70FEhxxJHsaG00AKD9soKgiyufbrA7ID/0AwrDPvoa6TIEQou9aawVE4hfzitHTYZ4oLH0mdjlzcIJMTU1sapacubh0lB79IqExKXV3fHaNvpp0mDMsk1LH+wGl1p4l/Ee6XsI6uBEiEDxMXt0XjzndF5D6RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7146.eurprd04.prod.outlook.com (2603:10a6:10:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 04:20:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Wed, 10 May 2023
 04:20:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 3/5] mptcp: export remove_anno_list_by_saddr
Date: Wed, 10 May 2023 12:20:10 +0800
Message-Id: <7fcb810112dc5f03328d028b106d737b60b1bc46.1683692137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683692137.git.geliang.tang@suse.com>
References: <cover.1683692137.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bfa1fe-af45-45d9-ecbc-08db510de615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RxK5gx8KAXx35uOjDrXN7r65Lsb8kGJRx3t9nH+EtrP4VJ95Vsg2wuB8281O8SMZEquy//B2wXonfnlSnZrF8LJrZevjjbevW7QztMcpfQktkicjm3K5lZDgVzQKiekjUoM4pKKFlcI0CszTyKGwhZ1ay1pYdJp6b3OBMshQTI6RZMAZ4FVDbgAetkK7sYF2Dq1LkLmhTyCqvaSMNjTKjK5KEfB8nNhgw14d3ieacTtxATce+REOcLdt7GmjNMiqHYjzC6/657QK8uUJ85e9Iyv9T9T9kZJlOzuhUSSVHeJ46lEiAAvecgUNanzfEPdfetMVpIyJxY3n7e+CJtrQhCarOazUA4bn5V58mFtsjP9sCDxcZbAlO3bi8YLgnvAoxEJQC9i9/z5HpLfBipN9DkPXPhM0QNmg2Zv06MA5mLj54EHZZ2JRtFRUeES6Shji0724LGUHwOLgEjszyKsqP+ZzvLPLrRAkmaAM78Hdht4aCTaqQ5UuUMgh4z3ATq9UJIJ0U7ii9ElGf702O++jrd/dAq/eKSbZHzyu4ODZgXcTe0glFXllFjFDGrQmaY+v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199021)(478600001)(66946007)(4326008)(6486002)(6666004)(66476007)(66556008)(6916009)(316002)(86362001)(36756003)(83380400001)(2616005)(6506007)(107886003)(6512007)(26005)(5660300002)(2906002)(8676002)(44832011)(41300700001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SlEOkEmoEFQ3f7eLt3/KW8WCnAkx8g5Zko+mt8W+B4Wjgif2H3kZxow29mpq?=
 =?us-ascii?Q?YansDO1Gnl4oza40H+h5H029Vns+bor3uODuQia/7MqfgDEE8inGrIX2aGwD?=
 =?us-ascii?Q?I0oOWqnWkP74s0oiYpWuOa9q0jxWiSsmJZE7P1cwrbKbnGGmzMhdB7hDivRe?=
 =?us-ascii?Q?+G8x4jocHZqEoyyd5I6Pee1DI9eMHNsMzA3d1kDs1ZEMuI+GaHS6DJTTC8fI?=
 =?us-ascii?Q?Whfjgclkux+8wvXjHnxEgBSBJg2Jc4tTKqwxxVAFRElqSRKMbwVndlIpeiKy?=
 =?us-ascii?Q?D6b7HoGMPZZ0OOwmxph60p59Kxhss5DWLS8CMo1sugPSkTB+QdEVcrUMa9i/?=
 =?us-ascii?Q?uxL0ykddy2JkXQCfKd/yWAi6jMdGdVCMT6HhNtbCLPRJirBxqm4D7Dl4yidQ?=
 =?us-ascii?Q?KasLDaY9hyxN6BB32qtYdyux2EV1Q7eh2pb2h9OTdq3JdtmnuF074uiqRQ1+?=
 =?us-ascii?Q?QzrjIy9EJv6FA8uaEpg0j/eYRFG++FBANGvFEwfas55t5iQz/PzR6kTQipdz?=
 =?us-ascii?Q?fYNuGKkXswyJn6dIEQuqwanaU5kYpfM9wYcxUGuKNLJo+8uBsEtkMoSrCGfJ?=
 =?us-ascii?Q?zi7Ki2fI0ZV6w7G7n42bCkOBak1/XpqIZuRiaL71k1qYJeORvZxC7GRtM/au?=
 =?us-ascii?Q?b8grlHX1dtcMx4PCD9wkNt0yIk1wO7u1KwI2ViTDcEJHF1dLSTOgo5fJfQHw?=
 =?us-ascii?Q?MsGEBpBsd8E5iQM+5b9wbsYObWcCHMhEVQo+A615IGEmHnv0tz8OUVJPWbKZ?=
 =?us-ascii?Q?60RW10hgLPjodl7rMZGRdjqxaVZWe0QIrKTyw/0fyP+WOoorBjFY1UK4YqP2?=
 =?us-ascii?Q?feblqzDDmO6oH40uC8Q4CiSOHp3fI5z2YWNGIMfumCkjnWml+YAmDtkkyJU+?=
 =?us-ascii?Q?xQzy1Djq2jw1HI9x+N8uGIpu+X7WTDcWUcROQcm1Oym2d2S977p+p+Nen9Mo?=
 =?us-ascii?Q?zAh+XPrNEZ2n2zvZkIXqZz4G7jMzrLf4qfJ7evoq+rdEZPr29bPTAwqW37rq?=
 =?us-ascii?Q?sQSvDyDkvYIEWqYEOM6mtYyVnkcwagAKdECAodsZEWonkU0XrQFe3V6r8/ld?=
 =?us-ascii?Q?kxbPya52qhj2kGaxtfn4tpTFBNSyTWLeupjySPPI+XyrfO9zgeSzVm1rm9/O?=
 =?us-ascii?Q?aROumLvsStxh3XIJfPOMQbVh1w5abSf74uDcWb1p3NvozWsCwa7RW5mpjS9C?=
 =?us-ascii?Q?u4iP+T6EH5yzeRWWGY8b2eOGvyTxe74YCtN2zYH5fcglH2sfwljUI89owl99?=
 =?us-ascii?Q?SzFU98WMm9oalkBe1T69cuYEnzsNCEDGIJcttremEQPNRwIKKAqZoIE9qtHn?=
 =?us-ascii?Q?73Vk20zHqJ+/6ooc3hfSgl4rplpZLO7IoMOIuFQgi3SPmCnZEehIdEUz6K7j?=
 =?us-ascii?Q?sokyqLhFIWBGuuFAE4lcNqklD3fg7Xp6YbXBecSxXijkRSZNFyiCpmDRhZDM?=
 =?us-ascii?Q?TI4kYlYRLnxSkEfnb4aFi6IlwEcmWhh6n/zpOpSiLuXGCUwlwGF6r9PJBEfg?=
 =?us-ascii?Q?0//RFajD55HK8eJarU+qP+MzLdzBPcSaKQvOonsZFKhpf4zkawb1YiZ7hn1c?=
 =?us-ascii?Q?lMfYVpm73YNZntgaOMgR26ccFYkQT2TN0o9ydnpU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bfa1fe-af45-45d9-ecbc-08db510de615
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 04:20:34.3610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0P58QahEN5Msv90z2CBIrVC6FgsGT+vG+HVgGMhFewyiEYN+cByTbWy7z5/PxTYFHyp7788x2CVeB2AbBwLMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7146

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

