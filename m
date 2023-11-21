Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FB3171AF
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f25pQ7+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuGvli7QtfGBEpT+pjBA4oWBtX8IFz9qTNCGqqCFgh8LIKj3BU48BkzJgCz8pKrSVndMq/KmAm+WBFM+TsljF3Cxvi4VPxYj3as2t5i02tXjBIiHAXlU0U0Ug7m//UHxzFXS3r2VwdrSnuCMjqiO0Gg2Y4g1qHkixCjtYaUEcIB6pryXuh6VgNruB8fGjwUTFbo0768i5eqHIeqFtsHELceUGon7oT//+t5x3GR3ndU6/nHzO7EpmbDp0d+IWrnCPPnjOx3IrNyxyIz3o9NdgNrsod/3WSvZcHfOkvP9w8WsReky7sprDF/+S8vOXZduog08Edi9O+Hgp4l5vj26Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=JHjRmb6Ep6WRjoS4QM/NTDFcZ+bBTpi98Q/7GZccAdGBrCMVE/w5iRTe/mZGSV1MuXaIiAOsFNpy2S7DKGrUrIyLwrTch74vS+dPSy16pg/2gs7rUtZECXU2SBOzNKgFsKgq1UHiwk7WzFPhS14vM+HOBz6Mrasfxbub77sUsUkM9aUt1qqEYXYWgDUui8iZe21Qs+QsHw4KaxapgmwIFLZ9JUvMcLBIB1zjHuQjhHODbcATW3yEfirU3B/hlKnUTjNOyYthc1RRJ+zH7sr7Y2lddVvd0QsBsia1Kpm+qDwTcFBAvw/uxlD4cX2qfOTrllPKbEarRaGtpmW0vVqBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=f25pQ7+SZt9ODCtLhMCKHmoPllf2K2b+c1Bq8jYbFiDe+oyLJSCYGoaBEkehjJn1WSmGfQDVrPA0tuYf5oxSM5VHWSW4ATNgCGFJdifYbRDMW1Z3gJVR7zXrOZ2kCeRQ1whKbY6wGZ6St1YGip+bKWUZqLctJ6x+t6wjRmCTC9ioYCZoY1TyWVjhWxkQ/A3ERynDiTLYdsVOPsWfOeL+ZyTv6bML27gn+KYrfy7lMn2uJOhPjgEzU/YliisLclQSzAVQiuRDMe/kMeHOuvQacwubxaJe/UOx1QkFCUZFUJJTzx6zH0YBR5ZZBh09s6MRRJ5G01lLgn+1wU9Jw6DvbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:53:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:53:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 04/28] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 21 Nov 2023 17:52:27 +0800
Message-Id: <212b9cc5467ef119574035b60401492bcf2c5075.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ef8c44-1bcc-406e-ebce-08dbea77c4a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1QcRYdgMVePwGMEj/5g+0zPjQO4/debo0YrQ8Xo50SM+a2nbbmnlfS6Bhw/3naatJzCS/Nw5u1Ok18WBMTcCr3AjBYfFZjNN49/xLfvVjc4WbKmh7zW4cPhNPa5n1vJCfpYjPAy+H2OnbzYfzk5gSzI1ZnvbcvB+Pr7UUQl/41VjK/OTnSOCaPM4h2WGvOAM8rhLWkt9dQ/fF1FR6dl6wQc9Efk5pMmy5dQaVRphxJRQsi0WfteJpuAckf3r+Q7Phn+xHXao84Hg32Uv9IEMJDxcAhkAtij0zEtFSgHS/GD6NBrrwwLNZkPUBgZljs6PX1wWwrTneII8y71SgHQqzWynOSRq6MqgvJU2KrLEjdPqaDIyO4V7HqpMrOcFwd5bBYY5WBPAGTIGfcvX+NFrY42gGih1iQsTUteNxqU8bNwhA+3GFpMiwCzovoO7/CtnjZ3lj0CAMSSa92MJ/ZBvqw2H1yOHxXQm95kUn7rfH5hA08Bs+1AVHOTll6+3TyW8azbI2ziN+fOWNXywQprv6NKfByKqDR2Dj1qnRpbL70vnhWb5/bWq2zI0honKH1Qq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzxnzUcJ9aYkxvtjrVcXrgp/iSSfFKCCg5mirzvgb8GYtid1mszmaaqgSyWt?=
 =?us-ascii?Q?NLtBvcdOdxSL6VVDia38UtkGj6fhqo6oDA3V4wKY/g7d4CLnpNILvw7Z5qm9?=
 =?us-ascii?Q?xNQ3CCuQ/3VCiTbMjPwgK1vtY7R1txPjAS0+VaQuiDG00h93MFQH2GJghYi6?=
 =?us-ascii?Q?mDw9MEg1Id60KKGrSZ8aN0NwpPfDDet8Ii5SgMYzR28aXr0mmPdcwOFKGzyx?=
 =?us-ascii?Q?0IRz8wfJWUQ4ZeO6X103HXoGoyH/YsmM+y/AI44oJgZ8L/KBITwNEbb0C+Wu?=
 =?us-ascii?Q?Ky0mtXHALs2AWOHDkR27PO1oBXQTGwNs0XItt+hxHw3icsbZxTjAJiKhtl1h?=
 =?us-ascii?Q?2oVSUnietKI32+kitId/p0ODAHxiI34UKHTamI0+/qEOHuHGQj/4/5kQPRrL?=
 =?us-ascii?Q?9TiUNui0DpHvdGDuBMPuNCVnEswMJXbPRYo9DPPX4EbViOOVOAon+0VfoKio?=
 =?us-ascii?Q?I9jAIDNlS5E0i9lf63dQtYxgRGDk9NwvNyuAleoX/O40qjUyfgb+q+hMUXel?=
 =?us-ascii?Q?oBoI9mQRBBXkfF8RR5ZvQGELDyUpLPE360QeKqNC5fAYVfPmrWOgBNgi/Jgh?=
 =?us-ascii?Q?t3mhtr8mpKZa8OC9nSMhiI1uxsCH+ChTWrbqK6GKc241pr7hn6LcG3l09XGV?=
 =?us-ascii?Q?4BVXHYRSwWAa+FOJzbU3QwsosxXA0K/+o5ymlop2uc2M/M+9jPmeSmy7Mx4O?=
 =?us-ascii?Q?jeEfzBa9V35kyGujumiETdqAb7Sbx3xkDOygEpRxOffz5Qb8Z6fTSrQ/JAme?=
 =?us-ascii?Q?fPT1b4eTGXf7sNortU21ohIVittdqIeuoO4JvuhSGxtM8dx39Etne8BOJWaG?=
 =?us-ascii?Q?lbuApK/ib6C78JV87LjjaFGlmxiQ9kEXVIxMWXz6nJPfF+zG1cGmMsQjGK8z?=
 =?us-ascii?Q?YF4hPPcvkX9aBlHHjGyaXWIChYpK5OLcMKO/JXrP8+SM9pVAWuJQAfJ+nIgs?=
 =?us-ascii?Q?HA8dFZugin81usR62onYDprTLSBzL2So0UDUaGeDTcV/NXMST8lhqKeZjjS4?=
 =?us-ascii?Q?FWMKmyhFwR9epUKG0pbBsMiKjrJrQsFItBImpoQ1Y227aufg/0rkoBeQEeDc?=
 =?us-ascii?Q?s2dYMOvsNRuPUpizOuitNm20htzUvmF+XzcNBpUn8aYZFtOxwR06fLDBhiLX?=
 =?us-ascii?Q?JbgVgQqy8RPQCEnH4cof33JdDhVQY9LwT3OTr7ipL1DMqmo3X78KzV4nIebO?=
 =?us-ascii?Q?9SJ9MFngQmfeCIXeK68eys2+IvfPZqTMPvpy2Jz2Rcb/dcu3jFvbrpxTycY2?=
 =?us-ascii?Q?xzGPT8uj9Y2gmP8Io2CLx0LTJVqroogBiPz015U3w5RZwoNE1eSDUgpkzwIM?=
 =?us-ascii?Q?9izG2nGwc7G2RnP8BkfT8po6fUPae/WOPk2w5j6UyChWp4DuFgc1HZ1dRAM0?=
 =?us-ascii?Q?mU533VNeb52ahnonWZ6kJ54E0I4+EPFmfCfPWgSPfKdUAIejJZGEA6bL9pll?=
 =?us-ascii?Q?+VoFx4npUCUe5FQJKikXCon6qzk1ygN4PJq1KV+tyuavWYQFjIsefyK/5rzk?=
 =?us-ascii?Q?yZuvDzZ5vGPz9b4w4KJczhNA6LAVHlwh/7olyoV0D5YbUFw2xu2vgOvEHkoM?=
 =?us-ascii?Q?yVK5qB9H+LPIG+17PibM5Mie5qMjIF1ckZbIsy45?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef8c44-1bcc-406e-ebce-08dbea77c4a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:53:52.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+3lNjFoGNGezr9ae9IseGkYjFwaC3L99Xer8iyD5bTcDpcuZFfci8Q3HRrp8sHwQGbcHt8dnGFdYcL50lvyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
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
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

