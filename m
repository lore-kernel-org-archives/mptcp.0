Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5419B
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 04:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+R+B5L70MRguyQd1O7GNCFlFFTEDxn3Tg1Tv7Zgvt/gwX2MaJ2e4W+omvuWsRGQxFZqpx0d1pV++N2YpSBD18nMp2bKlHvTCTgjMsOuuN9CW1uf69MBNtD5F0sV8HSCx5FaL85ptVQ7C2RZrgZMDQF7cohAiRPL8eMCcrEs8L2D3HanXsxfqsk2j0evT5BklQb/7zEAbmTjQJz94WqXMq9DDYydW68TWDaphjhwHUl1tpnHgRdavhxkXbKPBVCuWtHvoZpmNnGwvyl+ifcIfaGfXAL9aWf5RNeS21EfGQ4MKoc1YTz3xtBZrfi0YY+Q/jdAp3SZb+E5aqU3ZwzVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn7TxGXrGPkD8XORNhYp3Cd0Xyw4K3cMcH6dAhrYhzg=;
 b=Ld3AfCa+23gbuKKvTCW07f5vGd0INPbb/RK2wyjEdh7VyzCVCrKwNw7+hOO0g7a1plvoH+QJrQjhHRg3W4R8LxKPvwbGM/ki5BVUkSJymHogZOKyc4pq1BHumXN7/fM4HjK1eBXXy8xrtGVnfI41VEW2A/SEs1Sdo92zvR5FzQIY3//YwOmfKHuYY/S4ZZvy4qtp3bElDbFXDcQmmPlDR9qau67OBTqO/Dxym6qqEKjlPaQbXutnI2nO4JvfshN6y3ff5kOqRB9pS/JDpLMex+WHQNQ1WrJGKJ9gOd3SKJNT6pEHAAwBog50aDiZb15jCoEWq3aErEAbbna/ZTLlGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn7TxGXrGPkD8XORNhYp3Cd0Xyw4K3cMcH6dAhrYhzg=;
 b=QDttEUKxpz7g1+WyCytNoRR3+B99HkxuW2zhMqQkDDMtRbDpZ4nEDVqzu7qsFL43Ic08/GhQlQs4h6Fne3vDTZZIdiIAoV56lpiHizIJS4FYST8dh31cvu8L//MANf+6myZKBVuiF/3VJNyg37t5btxtNZ8WoBbuztrEMe3jjz5jLl01UikO5kzKHQ2RjgLbaaXHG2KxUJbW4v/jp2BiiYUz1KEJofNvcuyfl767pAn3+2fA4wfugtVeE5rZO7mD0VPBk+KRUH4TOfg2hkfmtm0UA1WbsMhkMYocMufE2L3RE0+27bRjrF+dstatZ8N3Oyvgi9Ok/2gsU+W4QKTFug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 04:51:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 04:51:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Thu, 17 Aug 2023 12:51:33 +0800
Message-Id: <ee69d8a0379e89d8b194d753129d09d986f7e674.1692247869.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4c451c-1346-420e-f7ae-08db9edd9693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XDo6x2Ii6lKVSyxYkZBsSgwOaCsFkoeBIu178r2wdoRSZLttYK3h42CxKSu2B+fbJEXDhj9RfXd3K7QjF0S41F9yHurT3b78DNeaeFMQq2SXDn2gppXx9+LVecAP1rxKH1VC273C9s4cXKh6cuu3bAicjSqhilk6GfCDc/r/PUXCaUP03ALcpLVFkacKSKCJj+b8cMTWQBnD4qbpFe7tHbJJ057ij7Xt7IuL6jpCU1HLf1ryS89DewSPWxvzqk1i3AU8vT80F8HVxtZnRLnfphdmfTxyvwBUbsZJHcUwELxWj8Y25LkvhNAksdtCXMOtXhGShrLuPLelRpc0zpBAmcvwFpDXjXpFLWPCEG9Ro2tmqu9sBzHT9ny4V/0FeC3EnRulpoibja4dX3CrZVUIES+JLTPEjKOtsUZkU4HFVL43gApARV34CsgnSmayzAbnVYJIwhyF9F9AAbfnYwRhgQyJmTj294SGmre+T2Dh+W7toy++miR5UG+yBAhU9kRfPdlopTo+iJzE+mW7X0PDPfg5DahnDsH/ImQQQAM2JLL8ZuYce7iP5t1BDJbOXwRV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(2906002)(83380400001)(26005)(86362001)(478600001)(36756003)(6506007)(107886003)(6486002)(2616005)(6666004)(6512007)(44832011)(5660300002)(41300700001)(316002)(66556008)(66946007)(66476007)(6916009)(8676002)(4326008)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e7vVbp84Nd0i+5KlX6lU+GGei3oKEmRyoIiWhRUUw5ATqGQj8eYILNY70bqf?=
 =?us-ascii?Q?3bnPd1od+LZg/gfA9FDKKYIsysgKYQZZ00eiDuVljMNSpAg2A5y4LW9tpN9I?=
 =?us-ascii?Q?XOWbWe1eKhJjY+Fn1lmE1KBQcREbVwASWPsmkMaLQ/qcMvDcufd2Qgl+VuzI?=
 =?us-ascii?Q?fvpK65YDZBrqDTaBPTdta2XEyq3M4csBDAnvyVj5O4nuq9dTpCzHttI2L2Rp?=
 =?us-ascii?Q?Nuf/SglyTHOgLN4iMSaFwzL/dbMH1/Je14lXtjI91LoK+ZCRmTgDtrLpW/3y?=
 =?us-ascii?Q?y4YWd2q6IV+TfHqN1Od5N8VRdXVcRsGeGqDF6FTjyGRaz2e0FrmrZZT69ser?=
 =?us-ascii?Q?1WaNYHT86RdjZvDHL53vtcPikV5/A5Icwvm5KOm/Ye8Rl3ReQyqGsZWZbrge?=
 =?us-ascii?Q?m2r8AGogNYc4F08yFhtOkJEx2tM2+/l4NFcFQpOC//tcNspd0jGbmncUUPHP?=
 =?us-ascii?Q?26tzrUjKnnLGiPY6+e7kJ9fL7inhVL2iEEEj2N9Ns9CuEacRoU7sRnuhgMLs?=
 =?us-ascii?Q?3fIomVfKSt1DEdfJIiGY2enC9D+T8LedxtY6cZStBS1GwfUSEjx7+z98BZ4s?=
 =?us-ascii?Q?ycLlGRUfH3LojHCXLjJ5P95Xnt+IOn0wytK00AyxRDguGq1t77JPxOmi4bPx?=
 =?us-ascii?Q?gQnL/UPIy619eGpUhaOsBxDjefAfPlTH11T644DBih0jxaAJ46X4mpeTsBp0?=
 =?us-ascii?Q?lPqKotMD/BTItewgsu1ps86GvBkSJBPTJvlbApMF/GQmBB+2QJmNz4N3QeOE?=
 =?us-ascii?Q?Pu3m7Y95o7oiCzrzbNVveAUzUx1yL+MgXEsga7+BnSCIXBJ1FVJURwV/Sl/o?=
 =?us-ascii?Q?E7LjNUw8TzwTO29C7cRRr8ALkJ+nmkqYvn4oBCjOCP1FTFZqxkM5h7Zb+qXn?=
 =?us-ascii?Q?bqGBJDHpH/ix5/dHO94+7tpCce32D+0uIcXyHLnv2+C9B8Zz2kqyw7noKpPv?=
 =?us-ascii?Q?4iEvHuAei9P/yCjYs3JRRFCD+s3SJBdK7qihc09pN17cskk3rrwt7iJcjTFq?=
 =?us-ascii?Q?w6tOyAxlANxIQdmGjnHS9fQXe/y7Z9LiQVDyO4OpzTr/iCLJT/5sJkSdQRU6?=
 =?us-ascii?Q?StoKbAmrtp+WLGJiE+F9ZUhXYWyG8mKCLeJSDjTAvjoe5ejFLZ42P/UDERHo?=
 =?us-ascii?Q?ov7B01GdF3fJNB6BnX3UcLgJPvvwOLAKMWx8Qk2bDJ2x6i0cJm8Cb9sYZyQw?=
 =?us-ascii?Q?WWyIq71snM+zDLzTuUIIYO1kbU96jZnKUnMWyWe4tz9Zayeh2rA7D2XaQSJe?=
 =?us-ascii?Q?F6z4NdTET6VYY6lGZ0DyUjDpc3fVF5czNBHUE6Q/6sdOLGqqkETV1rrtYGnt?=
 =?us-ascii?Q?YiVx5u+Yap4cJzsNDsfjvBTPRJ4H+RtG1InC0LSSQhHcj9n5vSvMCazav40i?=
 =?us-ascii?Q?idjhrvFwJgTGA33kBsgyYoIwPfLROeYlNUkmsj1A4g2CSMapSwV99I9ZYwVE?=
 =?us-ascii?Q?KIhkM39uIXrfQiXnNxTZWViDNeQ0CyT55UNJkZrqloIYC7kY7TDgIWPPBJBQ?=
 =?us-ascii?Q?YS1FGAy1XfijXmcpE5umoQugCH+JeTeu/MIUsOVgmqpk4aOdaAsaMVi2254q?=
 =?us-ascii?Q?a/S1liBnN+ObX32Xh5vSjPSEwLRIa8CfXt6bRtMy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4c451c-1346-420e-f7ae-08db9edd9693
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 04:51:15.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsPUkR2i/+u7up6Ybhcw6P9tr4PjwrJQFlE4UbL4p1j56HDZ3FXTzGcY5t1KWXsWIYYOpRx/+H5mtubHmF1VhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

The commit "bpf: Add update_socket_protocol hook" on bpf-next tree will
conflict with the commit "bpf: Add bpf_mptcp_sched_kfunc_set". This
patch fixes it.

Please update the commit log:

'''
This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
mptcp_subflow_set_scheduled() and mptcp_sched_data_set_contexts() helpers
into this id_set, and register it in bpf_mptcp_kfunc_init() to make sure
these helpers can be accessed from the BPF context.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 4911293919c2..92cf6fbf8275 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -144,24 +144,6 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.init		= bpf_mptcp_sched_init,
 	.name		= "mptcp_sched_ops",
 };
-
-BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
-BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
-BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
-BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
-BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
-
-static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-	.owner	= THIS_MODULE,
-	.set	= &bpf_mptcp_sched_kfunc_ids,
-};
-
-static int __init bpf_mptcp_kfunc_init(void)
-{
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
-					 &bpf_mptcp_sched_kfunc_set);
-}
-late_initcall(bpf_mptcp_kfunc_init);
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
@@ -181,8 +163,23 @@ static const struct btf_kfunc_id_set bpf_mptcp_fmodret_set = {
 	.set   = &bpf_mptcp_fmodret_ids,
 };
 
+BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
+BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
+BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
+BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
+	.owner	= THIS_MODULE,
+	.set	= &bpf_mptcp_sched_kfunc_ids,
+};
+
 static int __init bpf_mptcp_kfunc_init(void)
 {
-	return register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	int ret;
+
+	ret = register_btf_fmodret_id_set(&bpf_mptcp_fmodret_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+						&bpf_mptcp_sched_kfunc_set);
 }
 late_initcall(bpf_mptcp_kfunc_init);
-- 
2.35.3

