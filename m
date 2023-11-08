Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0411FBA
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WIj/kOjd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGENqS3Xcqj4GE5myT8hYeMED46Dk4yErYB7+Lgf1gonD4aQY/TS07f9uXHhAwlXCO3dZA8l0cKLmPAscDrVwslg8OK1ui/dW26AzQYqNaR1GOboeAHD8DmIk63uckpt/uCIHZ0fgRuhFMjhJAvvdRjBUPB5LxsJEEjzNoxr8WK7bu4Ve47o1PrRSNjo0JEUUDO5/4kIdN3wW3MyMUr1wZ0M0lXizKFGhXJrteLy45ym+3r0sgvz0AwZQoKWhwJZEi7f4eQ4y1yH2GjLlWOdoPddOtzX27d65kuFDsPzdAzWHkJs3ETMf/jDFMQxs9sXhVffIzXZ7tcai12LcpK6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J485LD6uKpdHPTqbfvU4+R1QI2ujw737Dz5rD9eL3hQ=;
 b=Kv3JUMS3oiVRw7qbU5Iz8eYhbzVttGCWhOHxK5MQzNcaF/FuSdixkLie4qFdmGirbakO1ybbTzejHzkcjmoojQ4fB2UPecLHrnwDH+LaGeOkJsIXj9HfTLH0O16+FxAlGB+Atdx/MDvcYBTP5VIw1ZVnpBxcQ0GMtKh9ENqeSMH3YzuxDCApNvnf19q0khrJelJSHYHWYmoZocG7Y0w8FnOjGzZcwbFHpnT3kGYPHzJEqWWY0izEBJLozGzdTysCjwIzcQl2e6g1iZgPYovpCcX4UXDhNZvSDbgIRYhOF7Jz8gv24FC9WwvP6cuEUe9vyyTcyIGBf0n73gUdxtauMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J485LD6uKpdHPTqbfvU4+R1QI2ujw737Dz5rD9eL3hQ=;
 b=WIj/kOjdWXcsuswJHStcArPmADvHB7/gxh1mY1rgmKdA6sfj+jgaZlvwkS7bza06sZgN6dJ0U4pLXSYO2KoNO2H9O5TPGCqsQYZFu2T2sX3jMbNyp+AdYxbj+2jPsjK9DM2nHX3IF/yx+2y0vZWL4knuKCsGDAG5gG7rWbo/6fNC98v4xzxnQk8YCGJan0cygV5mUfvBF7cyg/rXa0vGpy14a2hO2P6NSWlEXv4zveC3mLRYdfMdS27dclwZUFTui8hH0GRrgcO1z4GUBQxB3k0q4gMBaGQuh4o37/22320TiodlOq5xbVhjadiH7HpVo6dQKiZKZCoAcpnOX8BVWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 06:51:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:51:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 18/22] mptcp: dup an entry when removing it
Date: Wed,  8 Nov 2023 14:49:48 +0800
Message-Id: <55952ffb86167826e5830ae6b93ab716bb58a242.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0122.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8ea404-c6b7-46df-bff8-08dbe0272910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zgamVawMeyFh9qn+4CohIGaui3rHfJv/6G6WVef73afpQ9xxncYy/mnmc3Ac6dv48WU5gkAQ5rhUC8BvNm9f1hPMC3IA1avvuBwnab6pvmeQTSLuqn/qAJGlzYO+pL6zuHNXyKujzEUquEXfmJgL4q0TsUknZRP5v/PW2vJu3YXWrUlO56UlzurZ5fWoKDrb6NzOTSTt8rskQ3vaOY4056I+1oin+NNmIUohGMy7v32e7OnJ67cyzpFJoSaz0AIZZsm1A/ptMn7IdiNb4NmJn5I4340vJtIzTMDMa/VpC5yd+yx9XyJkwqiNg3n6kEvncq5isUR3A7cqCmkMXY+7kkX5/Q+jEfYyHvASubfnPKbbUWWHUM6qjwA2hKQbxQHvT2HNnQSVVWKNz5vmvPGiUH2QreGOrY/7HDFYwopaSQe7dT+G7jmU90uuJzAKpXtJ5jG89YFp99CtmOdX+/mK7zXloLCH+FMGMY57fqciG+Q1c5DmXp4za/TEme1Ow+fZkaNmVt/haaTsPfmw8avzgZRnweacC3V2illHdr80AQ0invYjrkSMqhKt6zP7992/YgipSY7F64eaUl9Wmh+CeMGaI+NM1SF8GLC7Rq9GmTw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(86362001)(8936002)(41300700001)(38100700002)(8676002)(4326008)(6486002)(66476007)(316002)(6916009)(36756003)(5660300002)(4744005)(44832011)(2906002)(2616005)(66556008)(26005)(107886003)(83380400001)(66946007)(6512007)(6506007)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5yZ/U/gBGWFXvCIf97LT0crx7BStvEebcpwbgORqHT1/PQhuR5SJYUcdgyyT?=
 =?us-ascii?Q?/qcUsaOQC2pMOr5g6Rp+JcUbsaU/XY8JdbrW3OHX27hwyhnM4toCsK3CsajT?=
 =?us-ascii?Q?GROe7ajbXk3vWhqbWJlnPr/xMgsWlBa/KhkaAHMd9WNH8loJv+cnp09nds1m?=
 =?us-ascii?Q?muAgRBLFIVGa0R+BDUHgnzqGLatczFvdMRQ9NrktRaCCiKTglll5/jO2sMcy?=
 =?us-ascii?Q?xddCS88suqf4xSJoa3LTsyhsazm6nqMUzJ5/bF3sz3eYeF+F+YBO0jYVM5xC?=
 =?us-ascii?Q?0VpZcdSvWAIc7PH1up7X+srdE1sCiP7e6RgaNrI0EyWlnmvETrIp1Aw9kefD?=
 =?us-ascii?Q?sGVLbZ2jHRK91qLwSsKEw3/KTzBiN9o2Gvv4yFBUrmwmn2q5w1691MpqhO6x?=
 =?us-ascii?Q?x73qiMDaE1sqACXwkwS7ALiM2kDRJXuSBeuupft/n60kxdygReXPObCefn8Y?=
 =?us-ascii?Q?taTIJpvNdpUxjYajPWv7yHSPsJwd2vl7STARaRise+MgxxVyn/8mHmffet+0?=
 =?us-ascii?Q?SKa+NLXQZiCUi5VvjK2IvGaMjzituAHLXYuzlrwNffkvWlkweEXoTsn0byno?=
 =?us-ascii?Q?7dC2RYGuWqFD81uSX3mHlh20IF2BYVSHZ37DBqPBnZgaIZmiWfZGv4AvkpPn?=
 =?us-ascii?Q?C5ZPCAFmJVDKaZxuuomSDqBPGpKsQW1AKeIOFsB2Az3hCZp6cUBgMR5BHzL5?=
 =?us-ascii?Q?WLM8jzi4kZWDQKmEj7zrhPJUEYtBhHMNkWkWTkRaoAeh+7xoAC+8huiUqD4g?=
 =?us-ascii?Q?GgmIvNpTqjJ1a6I7NXwHvH/9QKP+5cSSllBB2tq/REv4JdV8n7kWqe9NS2lp?=
 =?us-ascii?Q?vlzVYPqHnyERP4ELf1Nc1G09zf8lw0QFtaXzap4Z9+MvajDduuh4ZnsJfhdk?=
 =?us-ascii?Q?azCzUNXG430dhQ3Wv8e8ok838q1tXRFkY1P+3lVCgD2ZgwW9efC11EaWHCqX?=
 =?us-ascii?Q?JpvQUNllZkbVeZ093QG6wYWO7tcpuHfwIOhGu5Lv76CFRvIgrYll2m0ebrVQ?=
 =?us-ascii?Q?GnYJb5RsbJcqfpSO/yNWgdI/LjemRISxhKXgP1WqNxaZx7EQwPPMuxNnEDPx?=
 =?us-ascii?Q?0tbuYxwpBl3paIsrGMXPFdcYhOqHBshmDpWy5rWctdyifg3Kq/Uedb5IRYO6?=
 =?us-ascii?Q?v8FwQtQAFN7FELbVZB/Yn2fTeS+Jiusn4loMSI5kWboOmLAJ5Dl5MqE2psrI?=
 =?us-ascii?Q?DOj4e4HH7+mzH5QCthXml4OymZJk7DeSBgvzPuRRG2ANTmZAdrmGtPg7tGaD?=
 =?us-ascii?Q?Hp0dNTVUXvv+ZeoGCSQhx0GVfgBQr88QxroafLMxWpGzKUyZATMkMXvUFdRC?=
 =?us-ascii?Q?B1jbQkAUN12zEJ1m3lYhT3DJgo2WoYit4MwizHgXweJTa2fGkafOKXp6YM1D?=
 =?us-ascii?Q?Az56657S3eFNpHzedIMym/yzv8XL96eDrTATiuSXguQK/KRizUfZ1S81L7Lo?=
 =?us-ascii?Q?18lMagTzMWcq2NdovKiFo3ngN6NVth+MfC7wGDbciqTL+GrPTxlV2i91SG0S?=
 =?us-ascii?Q?VbHubxxwVbUixd58sGA/J44bCIXN5CyaK3NUKGcx0LW+95MRY20fWY7Uat0w?=
 =?us-ascii?Q?EJlbHbTpvO8h34iX7E4ZwVdAIzzfsT0T/FgScaGfbiEd9pXRNTQkluNiPP4k?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ea404-c6b7-46df-bff8-08dbe0272910
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:51:40.1388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QYRFwzHVfLWntLAmvk4ASywMSnsZtssJ1jVcc7BRm3X2TNE87Db0xGQ2X8f2YMQBnZJhw68T1CXjJxTuI6L0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846

In some cases, the address entry does not require free. This patch dups
an entry to separate the deleted address from the free address, so that
the refcounts can be added later.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 994f2bfd74be..e2f11e821214 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -303,10 +303,18 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	list_move(&match->list, &free_list);
+	entry = kmemdup(match, sizeof(*match), GFP_ATOMIC);
+	if (!entry) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list_add(&entry->list, &free_list);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
+	list_del_rcu(&match->list);
+	kfree(match);
+
 	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-- 
2.35.3

