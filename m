Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7291FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nnjjFLIV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE3kemEVUdJKfd7zHGv+e16Rz1Q6BM1NYDpy4gVxvXygz5bKIDw8aDc3VAMCg7qSg+Rb/3QmRVq4yAgV7e5u71nn1ca6g43THEiQi8P1vKssVs9WiuuAb7JcTVCEDVOGx+bXLEzJt7arXNkGLzyPM5F7Tvip4HLQU9Ig7njdPD3gFG/oGeYL7et88Lo8xAN3cs29GpGmJUu178ButWR23bSdMcI7jepPN+EzlDJJdcddugHwwq/5BwtsyLZdm/OVMGB8AVFoTC4cfhoowQjtxxFWm7OAkweoqi4wPfMbvZ+Fb95dc3nC++rp7kaGIPKI/r6FFLorrcqDEP9Tr2ChRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=NmixI4XF4o7QJogScMAL+4Mu2rMHUc+RwP+1U6X3hfkURuGW2MRhyUkgLl56sUAXmlx3+fqQ34BQ5q1+M/tjQZEvfSm5mxUeLbn1hFQPr4ZAwunr0MYirTHak/rmzs1siGn3Uw182TF7qinD4bXwlE3vowL4+S/inRoMqtwJFwKMM+qcHSNBd/PdEO8d/KImtWeElrfC3B8yFcERGGlWWPk51tb9FRac5Io1FiMpRuLy6ijV8D4Ec50SC+8HQbUmPZC/CNY5fuNAzkUYZmC2fog3J2JmG9GO4u65NaXzP6p2DoVL0+NBBwUQ8+5vMgwXLhvPFUx7pVS/6aZKpiURgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuEwtPTT1Xgh2FC4RUPWfAfSYFJlXOMeXPVpClzi64=;
 b=nnjjFLIVfPFnb2cXtJ+E6Wd0K03p1VCf4setuYaFcYKqDj06uOAgy+im55okQoAMSeiC44O5kB9rOpHA1z7yOjjhUkAyTTJmSNJWqv24koD/OBXBh6lx59wx0svfn9fXv3Dm0QqTKCWYiqWIrTEC39cUasvKDSJtSHVLNCP9B5LrRg+Ot2UR4bbvmpqZatHJ783iyuDAxP2qkoq6lrk18RqVvor010jtBO/oLggBQ31jUfpbKKwpwLBmPSC3y3HrE0qa0p6bbqHmLF8+NU2YoWuXwC2tIvm8E89GTk2ZQACiAw5mhRfdz3bqcnWo2ODk1UuCMZ8Iw6sxSQF9L/NAJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:51:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 11/22] mptcp: add a prefix for free_local_addr_list
Date: Wed,  8 Nov 2023 14:49:41 +0800
Message-Id: <927e718d31dfceef1ae409061a4c4366bbeecbed.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0110.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 9005d01b-282b-49f6-ee23-08dbe02710f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ny7T/whm6VAPjLcNfGt2naJL7Neh5IXBuS48lsF7FBDcjE1tlQkBOZvuek5CQb9sDAVxKwK2GY6QhzebFh0nkK4VwEAVYb2FfSIVQlYolLPhFh6PGag/jrrlJ4OtKDM1q5hYF4S6x7fJvhWoqKorrG8xM+wcE+sPj+xLlFgwgGvxyvl8sDUNA8v1OUMpRtjWwert3ONGqhP1J3QKUB4Yhai/N2mmkB++vgKJv/NDo5VOh71w5RFln256FtMgQrCiBtT6WZb9IBqM+qxtsSniFXs5FT8PRv2jXdL+PtotCSI9x3AQT3U4e6dCXW2MxhqF629uqpvFwinh1o4A9nGTQ7RklIoBktwU5OW7aj0qXNSAW7LG8Ymi3IarPX13tWjFuWrd6jZsIQ6m/yLFVW0csJxOHq2Mh+DxIJqMsiqGFITCg39DLec9rbT5jgrYqeB/MCyulyhJb5Og8ypScKkHp7hnpPZTYNmHF/vG8zcW7NfVRU7gpbCgeUc1wDTJY3NIegfgMQeKDqimG0L5SX66zsYMeXd8jSf/01auaCfM1PQsJIobJH7DJTLlgcvwRX7P8dH26/SUimsylaLOdlFRIrY0IakDKkr1F79JHOfhl0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bao10R9GVgD9W+Susj1dziXFLfBFIl6k2uAxF0wG5mp2fcT57uahDWPeeQwD?=
 =?us-ascii?Q?+vdAfKNkfMguE6WGMMMc4JNSnVpAISpFWyV9SoAKPz+k4TVH+IQ0NKz2cXbS?=
 =?us-ascii?Q?pjjIxGazVXchq95GW859xQiRkF8XfT1WHQJ6nmZsLTjtS4hGcKNQwfU4WwX2?=
 =?us-ascii?Q?SvBjFzxVBz05ufxtc2LdeUS4toVxbPe6IQecsX+SS1NdqXJqwpk+98EX0k0X?=
 =?us-ascii?Q?40aZzpcvV4A1UF68aJPUPVZnGKQTYbqIDfQzk6z/tYpvJtlRClpYS2RoZmZO?=
 =?us-ascii?Q?KW5OAum5sDgmnBcwBgFdjm4G1moxxwFOJ4Ck6SDIy2Hzml713CxcYPwVptbx?=
 =?us-ascii?Q?adtypPKVneJeN8qFGNEm0ytC4VIE0ggymBvHGYmx8GB/THWBOC5XoCQkgWip?=
 =?us-ascii?Q?ZhKaGLR8bebxFYQD+Yxv8imVUe7m0USrwcLVclfTCOhLVEFkeHPy61ifc7fz?=
 =?us-ascii?Q?mETmQsj+KT0Lg61+upchmLaCSW8pyJCSaGNOCaLYhL5X3pPo5/h07lNkrRl6?=
 =?us-ascii?Q?3dzkfS+CJK/YHpeA6AXCZbL1e2y/tD/tM9DmpJu7AYIqVYtYBtNoiEhJHNzx?=
 =?us-ascii?Q?8ghAXqEkf+hvO11qgm7DNVse1s3V0/u5UBZLdrq6FST4zKDDFaxt6gU/tPP+?=
 =?us-ascii?Q?0587c8mmIqlsmDk32IfyWzIj24GARV2Mcy7eGZgfLeNveXUUGRnypZR/qrhv?=
 =?us-ascii?Q?+Xyldhls6TmlAT7rBGFNpkTp+6NOL5DCGDVTA1foP3mAvmh6NUs7BvNx9YQs?=
 =?us-ascii?Q?ZDYmcoOF0OTat87whgUY85r9tbT/ZU6AnpUt4gVdHiqM8+MD6BRzRkDrjHZf?=
 =?us-ascii?Q?1hZeABFOmrovD+NCshj39Wyr8ejMQ61XhYGG/jBmvQeSFlJSQXVVi555eoz2?=
 =?us-ascii?Q?RUa5Inu62gTwDMMv0mRI3lCD73jbE/dzXHnSARLGY41COlr0IjqhMneQt/44?=
 =?us-ascii?Q?SyLCNw/rvy0Cgg4ePc8R9A/farApsKnDppzl7l1CsNhR5D7urbHs/Y4nzZG+?=
 =?us-ascii?Q?x8wljJqTjDNFseLOm8tl2spXDgA/ogN05F+E9uazq4gl4MKT4Cnz3trrtZr3?=
 =?us-ascii?Q?s7fQP6ttw1vUrcaiX+rW6q9guIYRF3/c3eQCa9H3Cpr0Fu5e5EhyKtsA8Yo5?=
 =?us-ascii?Q?gv05/KHDLhhdLjALNMcENvF9KoEniDf8JzxeQ+RSnSigl58GGEReefOWOKRR?=
 =?us-ascii?Q?AoFu/+sveePbwsUde6rgUcX16LfFI3y6SHqiE4JjinoAv0K1Pjre5Wna7p6u?=
 =?us-ascii?Q?59+IlpMAlxq0XZn48odVEALyu30Kl/HTaGtjFgg/0HL8PvrvudtYtIENeT3B?=
 =?us-ascii?Q?y5DEQUPcaWHi/kpDAHomvA4C0/vstdEk0NB+JFoQp7Pkg3c7JRDzc2JZdbDI?=
 =?us-ascii?Q?xWyKPgeNjD28yQWwnNge2I9I7qW8mXEO6WAaoJUD3ln2FgdLRX1iNQnNoSze?=
 =?us-ascii?Q?U8G29EPPdHUfqWFqagLJyMqRaYYTysB29LmK2YlxnVBE4RdkyucQCn4YfjAJ?=
 =?us-ascii?Q?luZXSgQVn6KPFkPptx77Ks3639NkrHkZA11vtkEOK7ZmCUwTd0NP0nlwfRdf?=
 =?us-ascii?Q?v958jA69TT5HnM25ngn5VBRGu+Kbra9riiE3H2WtAHC9EeWBpeXGglCPs6yo?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9005d01b-282b-49f6-ee23-08dbe02710f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:01.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7wPM/Suca+EGG17FLNwdxpG8aDXpr7b6lIL5Ycnzc1lFX4GaMGzu/Zc9FlNngN1uq5yNHZebBwObCX+dQGXsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

Same as other functions in pm_userspace.c, this patch renames
mptcp_free_local_addr_list() with the userspace pm prefix as
mptcp_userspace_pm_free_local_addr_list().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 +-
 net/mptcp/protocol.c     | 2 +-
 net/mptcp/protocol.h     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de10be21bf26..70f6a510e3b4 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -7,7 +7,7 @@
 #include "protocol.h"
 #include "mib.h"
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk)
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_addr_entry *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..f2f0ce608219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3321,7 +3321,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
 	WRITE_ONCE(msk->rmem_fwd_alloc, 0);
 	mptcp_token_destroy(msk);
 	mptcp_pm_free_anno_list(msk);
-	mptcp_free_local_addr_list(msk);
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 static void mptcp_destroy(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c30e59278080..76981adcac22 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -943,7 +943,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

