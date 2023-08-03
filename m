Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CD846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu0YD0V5uNz5HMDhszwcZG1bfVdpRdJOJoDmfmZkaG6aCy0y/Fn8QVrxkfJXwCCg0k5FiyFmzojR7wJB0BWL10mObQQBKBdEiEMG4SP298zDW4CSBLs8XMkU31bsDaHRMs2mBrqf5Cm9UGJjIoU9iElfaUyJIoBGbx7sEeaoamVLdJXapEFb9PBKSzRMCuDFXh8n6k3fElTTO0toch4iQZALK7sYzm5mHslsd9XfVPQEeQcrmRs49pEO/i++D7TSbA9XaCEMa3ptet6pLBa9w/3RN0fzlaL9DQrn6k/tEBFK+YJhRYsvJ48y2qkWZK7z3HtPl7G9lcMXnANvCxiJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJloULwj1gBiBMs1xYSclep4ylfd7uxtUoB31RelkzE=;
 b=ITEx+9wVdIUx0RXGKoSpddRV1R8oMJcggov752ANdcJpytaOIWy/27QuUXHbB1VyvoWAHGDdBSAN2/qFxUvEPZ+fV27XPq4VvQYWTgoiHOCNUHmjEoA1NGi62Fx97uJQC9KD8dlZclUsSp+rQmDVI8UWVfP1bJE/lABKAeSELt3gxeyjPkLhby1CYI74g5a5Ur4s9XIshUMPgSeqpWAaZzyteR53iYrO3GEeFnnEBgQeWkrLOJYHjgICWmnZIwBlLm6khoYaUf4J2yJVdSFxeJ8/ghEkJD+/dvBTs4QlTXoB5kKpnToZN6wENVL5jQUbV7+69oH8jR1TDnCYPLPdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJloULwj1gBiBMs1xYSclep4ylfd7uxtUoB31RelkzE=;
 b=iGY2YnDyO1UNv10flhBKAX7tC81BmCRyxiCflxhGFMSd+AZlQbjwDojGov0igoDLfigw9cpXcQErC96s5CqCrDk49NfVpGd8jdVkUzeWmhG/BaQwX9jPJbCMuuoiGHisFr7LG/nQZAqj8zhoaqDRNYO9EFXpAD+H6+FGDf8JDcbGrWYrfNJdIGxaBTjF171+6R7yZchp3XvP9UtwlHuo/BZ4xZnNv7zZ+23Ch2SXASAurCyUeDp3Nc7U2cEh3x12Z08LRWgMtNdfhGMPM42TF59k14fBcH4OVB0xoz3UFNJPr802FVhphnlSoL4kQc/dieSJWH5DYA8e8lBUDemdxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/6] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Thu,  3 Aug 2023 12:27:18 +0800
Message-Id: <a89e8f23059c409bcb9070eb70c595728414fba2.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691036765.git.geliang.tang@suse.com>
References: <cover.1691036765.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 4efce844-b2b4-425c-1925-08db93d9f71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+gTUFxqSUso5LzippdhGRoOApMkMHdOtj5X3zh6KWlVJia5shC/fYv0Kd92x3sxbDfrXP8FHVDu1EUWf9EBss+w99MTB4UvDVNtq98cIkTwItAefeIVYkIS99vYWBlZoONcY117lFGC+Ke2caToIIHsrve1vlNtnKzfdvXLw54iKvMgheheXt4ohxTqVzgfn6cHbi1AsMvfAJgAa5ZvfKTyGAor+bQn8CPk+4eKaFupne7a5jazn2TbctqSUVxgZ3Y43UcBwwstnZk2gUOWeDT/ujA/ZGtA3E/tNVrXJY2Zx7v5UCOQajnX+FLR0K/77bSsve4kJOirZoYa8ounDaCTpebr6ioYUWzJlTU09C3JNxa5F0er9PyS9RNhiPJVkOSE24B0GA+/bBIbt5RZgIzYG6ybPwRxr4tPTjVKtQE401DcB4y1jXUd6XqJ02rx4jenSOizqYbNCWTl5nNXU1+3TofYzqbE1yaqBnM5TCYfzR419Ra4N0VIROEmgB7CAQvMYikG9fCR6ksJTiNzl4Evbev2Im7i6/tvExIlUNXh/MJvn5uwrAOyy3p50cfduvg8fnjpxRM/tGq/uhXolqZclq/FsA0YiPD49BgtsQWE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(4744005)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WrnFfwDH84yaCuXAckVCpia66QpOiejAJ793pLH85TgiweTQ8k3LyxlgAA14?=
 =?us-ascii?Q?XU3ugWKFC/pfRUxDVnLpNsbXWcHe3hchE21iAJZY7k8vvxu9FEux91tOARcP?=
 =?us-ascii?Q?Q10VzhTYSqXrw/570ByRSJEA7krRu48/pAR4M47romqGKbG3vOijpwf3HZzI?=
 =?us-ascii?Q?8vi4qhHi3MR0VLRrbpo5puwsgbaHZL1esSyeW2AGK8nOvFtcilmGb0WzvpIx?=
 =?us-ascii?Q?1gKomH692dzNVdE/mek6XbLq3BfzAqXoRFHQdrqGplK3pIO12LCgCmi3cpbt?=
 =?us-ascii?Q?/F7046O/5eq2ySG9uy95s3WgvpZ3XMResbZi8O5qSxYsP3FvnrvPke7126Fb?=
 =?us-ascii?Q?MASlg4/XYA7pt6SUFkiI7BZBUC2wo20kU8/Z+2X7AT/l/iAmWYahOz0wW1gI?=
 =?us-ascii?Q?ek5frwfgfs+LdF66T5tDqC8MWQ65Tv0zfGOKdXtxGp1jE7AAWVUKqN7Dcw7P?=
 =?us-ascii?Q?aqAUu4d91oGFAYpXQFnr/PzRiSOdMBzQwNo4FzAqUqBzPGUPrhPrQIaVG8FK?=
 =?us-ascii?Q?TzjfCm3h2UZjawcINFTrl3rHO6ZPBBQixyGrRz2ormYf0MmLKAjUM4go3+QM?=
 =?us-ascii?Q?ZB+lkPA8zS/38yrdQ8w/WgAxKMwMblVWDZH/M4XbUIiUKSg/yJfvz6mDSEyY?=
 =?us-ascii?Q?8xm2B4xYT4BnfTC5u/ZPBCnstKQA8smavczamxnjapzRzYDKSdCaCVkUPtvu?=
 =?us-ascii?Q?rs6equJ1nN0hpjOmtB/WIY0n1wtKhpjgXEj5bQxx6UVOU83FJ3iGKyURKiO4?=
 =?us-ascii?Q?eYx1jGU3aC3HR2yeoVEVEAKMt7NoP91cuwFGok0JRU9UkkOTLQIFsZQvwhp1?=
 =?us-ascii?Q?V3iP/j0tbcM9ecSXMc6vAmhjWVOqod24sDudAOm2II0jqQ2CO4/wukaMsfm1?=
 =?us-ascii?Q?uH7PrRKjkBsE2HvF+Lm33dI51kQI8PTMEeG908zcVlVEd+DtTLkii4i/lKPZ?=
 =?us-ascii?Q?2ZtEK97rJEWq9wvV+ZHKQN1aC/zaIrShNYjEkSGu3xK6seh4rYMpw2kiqK2I?=
 =?us-ascii?Q?c4YLQbi8Eu5NP+W980N+WVKFC/aWNIm+xvFILyog/Jm4YHBVtNoTRIIfbhWo?=
 =?us-ascii?Q?+rxKbnIU42n3m79D+99EuQfqozk12SYaGjtM0hOkwKOwrAMMv6zC8X0euJ5Z?=
 =?us-ascii?Q?1G4u/rj0fZW36XVelhV/TkmjbJVUpRlCHgoaYyVRUuuOlp4UynjiCVWAFkdO?=
 =?us-ascii?Q?vB+dPKvt4QYzLY7bGixKlhu+RrxTXBNcuhjWoAwLiesiYAQ6v4lOfjWQRx8K?=
 =?us-ascii?Q?kA60HDAwbzkZGFHKmkobDxENBZpbqCrIQ+bzEN9sDlZ5J0csospnihflsVPv?=
 =?us-ascii?Q?V/8xa60yED6aII+e5Ige9N4x94bWYoG4a9eKbQJrNvrqLQDOWuSImHYmXyVk?=
 =?us-ascii?Q?64CQKU9mMk6l+pri6yfcKGQkae7ZrYX9hxiX7RFR572pbiBu08f/smKyi976?=
 =?us-ascii?Q?vrTd2Wq6KAd7PqzoixLJZllYu29RZmyofLbFnHwZMkeiCpbs4ooMgC+cRTkN?=
 =?us-ascii?Q?iko+q13DdhH11BTIRzElOCHcyRO4jRbdrGgljKNs/qKeBUTJYYNTk945MIAK?=
 =?us-ascii?Q?KzKgvIfwEAnzl3d/HFCVT23IUVXPxm2j1z47qjM6nzUQvM9Ea/dq4OTqX/oR?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efce844-b2b4-425c-1925-08db93d9f71e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:36.7402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruEbYHBsTtqRLESLLtjn8MtkVPMS5fnMSi3Q3ZV5YdcrfJWsA1clPqVZJxQvV6dGMsvoiIBHibWNERmA66csmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

Rename bpf_mptcp_sched_kfunc_init to bpf_mptcp_kfunc_init. Since
some kfuncs related "mptcpify" will init in this function too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index f6f9baa822ef..2e1a228a2ab4 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -172,12 +172,12 @@ static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
 	.set	= &bpf_mptcp_sched_kfunc_ids,
 };
 
-static int __init bpf_mptcp_sched_kfunc_init(void)
+static int __init bpf_mptcp_kfunc_init(void)
 {
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
 					 &bpf_mptcp_sched_kfunc_set);
 }
-late_initcall(bpf_mptcp_sched_kfunc_init);
+late_initcall(bpf_mptcp_kfunc_init);
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
-- 
2.35.3

