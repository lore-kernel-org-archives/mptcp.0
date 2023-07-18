Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA517CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeXKSnUvIF45PgkmaMN3+BTg0t73FMdPl1pIEa97WNnlyZ6Oje/n0IVKSSH2tL4569z6p3Cs5vEURR3KH1WACodL4EuEVj8JWVWc4Dizc3iZMumLj4ZoCGHT6Ryv3+tIMJOg6l/nvALwkWYpm9j7BOnbVc3+SUE1OS7d+ObXaGUQoU4XCPBQMj6S72tL8uoCIti2HVjErRnxhd8m1Z1XGGLoVNcdWrokIYhcDXBTpv9AtMbHbd1+nefniAXT8wkiSrbjgpHksBNls5PyV1znphB4fZ1KCJsDvvz63/l/Dnz3923fMqxuU9ARxrLdINYpePv5VXLei+UOhsKie0Sxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGbExEe4raeUz7hcKVR/DxUzitw8k3t71W1ldyNI8ko=;
 b=gmY78WVEuQHlV19+Ksd8J8bfatfDmhQ9TJ+Xgx3ShzhYvNFUZ/lKQGte3Ew8H6JpNZFocJC0EJnRODR5lNromyjV7y8ZcSQA5EBJ66N4A9/ICAYLcjt2vJI3tp70nEEnKI9xlkCJq66xCCJi2PZTpXx/Ua2dphLYn9qSGiSLiGxREbwChAm5t9qjDXhSJ9RINXAvgfwXL66YGpog7w0NI/IMhjlvr1mws0qOSLxUDvvRQewmauqB3BYGDueSbWtn3I9BBf93m6wuIV3EsVnIO638C1rkELb1so40xXj2R1I4JN35fbk1cbqDZflMOA7ONQJ7bpx9wr79hOJc9HHB8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGbExEe4raeUz7hcKVR/DxUzitw8k3t71W1ldyNI8ko=;
 b=msCBNVZyDMyiZOOd80kSDpKYNmEptIcgFaPGEcQpz/cm70shyGlhTx7POJ2XjEaZI2orPeyjlSkp2u2p8VjDMZHJDSOf3W87Pchb2ivfpnX7EIQVAiw+2KwK6467AAwOkqyIZmaG7Z2+dS0nKG8VUSyoZkT+H6PGAZrJMEeJTY7qwolIvMSOfD6/8f7MxHhAvHhGPq30dYsq33eiO6WGRSAJFnTXLC4fbkwZO8jq62QGMpXkr2aghKxiR+U0kfZmWO+frJI8Q0HP8Ah1J98iYldYtW57uTvqXckMtWHVStaEdng72ihBRCnjDeXXjLE7Pc5SyO/b1n+OdABKbbdWYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 04/13] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Tue, 18 Jul 2023 11:36:41 +0800
Message-Id: <c2127a24b2512e97149cb81f8eb691bee92dcbe0.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc69000-7db6-434c-32f1-08db874054ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zrP/UluBDnANbCV6AhiyEuKpLs58/kwLCWCgNzhoAUkNgBz9mIu3MISw5OD3y6qCzBt6cpfE4zDenOVMTYqjbfQkVuvAc6Pk0W0Ha1a5hbCpfcF8N10o0Wv+EFPxuXIN7b+he1+89e2dL8V0o1nlhUkaThw0GX9MiB4U9weXD5g5I7EL6QOTme70b7QQaM/7p/0d4FdFeSajTIyYJ6r738Lfjpj6ie0zMZ9ouu64s2u5p6ap1E+L1NTqTNEtyfXttgznxPN5eNm+i1dfWl5zktHN3fUVjhUgZ/SPI0xh7QGv9ptp2VeUcljqVV/naXjP8p5f9kLnukZrwhwGm4Zl1Rm6XtT2bhrefcnuudtTwoRnQZ0BfXOKSux+40r79EO6VFaqnf4iYR9UkcB89jq31h3JmRt0Gv9I/SMQNVjKCAdT0ku2F93DW1ji+5JYJCB0ptNMtjqTkbwMUBcr2NP882uUjZkfq2FlKBY7i60oD+NuHg/wgl91C6K6xULwCYL/d+K07CtfBNY6e3UuocwcdIIyFkBm+r6Xl3IEDmO1GLeNmGpvSUi7GrfNdnv7kvnkDjnGfh0F+HtbD6ejhwWYmKRDrl2b+NDvOyIDzPLQBRU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RGJ4SGVCXFEy7TsUAr6hu57r0CzjwcafmSCBIkUxxAXot7x3EKq1zf/0GGh?=
 =?us-ascii?Q?dFpGdFFwgrl83rz0irgTC2BbllDpMZy8MMXsOs6q7qOqGK5xjCYkppXU/R04?=
 =?us-ascii?Q?f5c/OCcLwg1PE/Zh1p/0pUAX+oIYzLnWdSgbcr3kQZ3OaEvHX0z2JNEiqQmC?=
 =?us-ascii?Q?WFECCV5UYOeG5t/BAUNpqFLVQLO6cVGWdlRsd7zDDy8Z4McGrWVKwDV+A6LE?=
 =?us-ascii?Q?0MCNcd0WAAV1cvjO/MAIGjn7+nMS52eEDI6c2eGqty+lfTYsV/R/Mffn25/Y?=
 =?us-ascii?Q?OlPgz69KHs0vFd5iP+CCM9e5HLXpSgac+l44isL2DBqNKyzFOwFpzEHHh4h7?=
 =?us-ascii?Q?xCsKNAsL5CnOP1otaUohVHhjfAfSgFN/LCKXgWUIF6XkTbUQYE0r2VJnnq+9?=
 =?us-ascii?Q?6LQoF5Zn+9gDNos8n7ssmPH8UXW5fE7y26wLaJYG00b5UetnFSfKWUzYJ0nQ?=
 =?us-ascii?Q?+EqJUgJ89Z5perRELaxrhFnTL307MSgVBUIMr5+mLgFCDIDRUGjFyrCI3KgE?=
 =?us-ascii?Q?ozupIxkxRTycOdYCdKTDJdjj1v7tXwf0BWu5T5Jfu1/flzAVqsqvx+e9FqiX?=
 =?us-ascii?Q?CnxakdQR25yRN6TWY99Ui+ZSESev3WeNfmv10onTO4dKtmLzzcEnU4/aUQ7v?=
 =?us-ascii?Q?nxMDm/oanH4PkjhiqRa0LHPeDHRkMvddYXUdJGOZIq5guix6Ud6pMObH7p0f?=
 =?us-ascii?Q?SvWyxCOba6Plxgi53FJUxQNCrVUm+fjL3JohnNX/rsAKuTd1mI14nOb6g8/i?=
 =?us-ascii?Q?dyNOPJIQU4Tz8efRe2neY7/t20uIfTt0t1BQSRMiNdHF8um2YUqYGn+ycq0X?=
 =?us-ascii?Q?r4KwEhV+h37LbsQGY2jLIVIkVJQWZ3/A1HCmOH3NfdiBXZ2fxKVT27J5z+4+?=
 =?us-ascii?Q?xakYEYaKFUZx5LiwfYXj9FnPXQAh9f8MEzhyBOWlFBe1Xz8voUcQBxMBAfz5?=
 =?us-ascii?Q?dpoe1r7SKjszfudlUceHzpeD+1cOw1rrTKR9HoOEaDWUsQxhmnWmGvkMF2Pa?=
 =?us-ascii?Q?OQOATj5kgZEJ1KLPTGXUwBobNEXV9Q+3Jvis8+WzZ9fiCp5oU3eadQIP6fnB?=
 =?us-ascii?Q?D4dzaFiod+TfiXmyhy/oxGHzfLcpf7Q8epKnBth9NfBScugdETAXaUnShlaH?=
 =?us-ascii?Q?Akxg3rLoc8F8EnbY8lCUW16/dY/b49HNLjYKU9SLutLuXnoFh2Xpt3GVUogs?=
 =?us-ascii?Q?ZEujgZzwgBxDSonff2cGCBaEN39juKAKpZ62LwFr3Dvk4OpBQQVL7hegjKMD?=
 =?us-ascii?Q?SRs9QgP0scDOcmBbTuYsa2Jqe0yb57kPLQWHz3NnBQrZ5EjiPadrNAC+7fgO?=
 =?us-ascii?Q?Xbkf9BfImoGazJGA5O78OqP81ZwVQjqOFTR2IxPGeyAWuqc2JqL8xFBCGRdh?=
 =?us-ascii?Q?bsJT3by7YyeUgvLFqOpSqbS2CE3bieeZ0bcjwx7RuXm8SGMhvU/Cc/KudTcn?=
 =?us-ascii?Q?vQL7zsl9aeNrWVvjUBjaViD017YElBN5G6PZVUOTcUSAVF2Bm01FJm78fLTh?=
 =?us-ascii?Q?PY2TyeZPy4BbPZp/EgTBlGLWKTdUcA7LQUq3/sDMgEiF1RXPmWBcUNg2Kv21?=
 =?us-ascii?Q?Lou8Y5dIMUklQCEJRaNksFiugnt2/G2pNGnoJhKT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc69000-7db6-434c-32f1-08db874054ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:37.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHb0PXFifsveh306jbkzK9HDWZK8lAOcF0ydztI7S+pQ+5JVhYLp5Vp4mBTAxRltOHiR6PPhPIbbR7X477Rl8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Init nr to -1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index e5ba97390e17..21493a3affdb 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -25,7 +25,7 @@ void BPF_STRUCT_OPS(bpf_bkup_data_init, struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		   const struct mptcp_sched_data *data)
 {
-	int nr = 0;
+	int nr = -1;
 
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		struct mptcp_subflow_context *subflow;
@@ -40,7 +40,8 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		}
 	}
 
-	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+	if (nr != -1)
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
 	return 0;
 }
 
-- 
2.35.3

