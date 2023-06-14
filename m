Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CC38E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:23:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OttpwXsQM5B034EQc7KkaRugX6tyTEwBW/EZea88hhogWRCSGuTbUb3nm2F6qYQusIoim9WkfAgApBK/B1jtYRghfmWB7E4n2UJ82e1t25mlW5xlyyDunUf0QiqTDwJvVgZOldD+Hq7NzcBJqrMSpkIjMkZrWU2sCwhUh6zyQGIS+wZBpilEffwoilJIV2t/cGH+KWoJsX2Mu8rpEXe0EK/CvDpCEDHVttsPLlOwZ40MdsRCZSkC4Kxd34GII0hkrcRyddUbaVGIdFqffMvUYHoWuDuXRTAwvClQwET//MQTU6fgylGYowP/E8vygFrPFFK+/3Rj/fpj/gCvJGMCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywQ7Nz+6paAuyrMDkTNsBPhuc6qsXJe/eKBMaLsdbao=;
 b=TsGPMP7OwO4kkYREWtH65WiFtYmRT7H4vKgIkbvAONdNSvbmlNwbrEOUKJzzGzDoXfa9guvCo9jeCUNSXpUEVugcjktGQyvcbV92qx5hcq9uXp2ooAS0zdeFhtJIXrlisyjJuJp2tbgqHS4aK9FqINGqySVy02y/o56r/+LSVfIN51Zww5bmD/93s2tnWTGP8+kMfWPRl1KTi+jDH+62hDys2x2RH2icpWBAsQ3tp4liblz7zc6gO8iaMX+NasrXBZ8q6EeZXPqpSfF5SabbcBH6ZP7ffx/2dQtJVT+IX5zkOuRa7ZkBHpnMhE/4ACp7U013lW0cME/aYjcm8PJIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywQ7Nz+6paAuyrMDkTNsBPhuc6qsXJe/eKBMaLsdbao=;
 b=2l7mZTfvQffdvCTK2f1BGFAMa6R0EfQiEXYsIFgClhSVDowbNF9+RUyqhA7imOxthxVPC7/ngYdgsLI54i8nTDn0D4AX1nDk5ot3xro+Ar9VfHowI5MXD/0ByBaGDs4jORxSsJxnbQF2USKsIBHZD5Nb81+2piRJfvxRjABNt44pxCeu2XOyGpRGfLXWP6uNWzokd5O3E/7I4s3BujZaX6mZcwVu6J4MM9NWDNexa9iPgyguRrw4nwcTb2DXu/O3satfgbwj7IOTBReyTc9OX7K7kfza0FHaOH0Ot4NLJAZ3iF2LdmPXQzlGp1kbiyRCwynV+S++hAXskbt9Bb8LMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 12/23] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Wed, 14 Jun 2023 10:20:59 +0800
Message-Id: <aac2fad0f41f4ff3b949a43d4f6a12f785e5bce9.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:404:f6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 869d0599-f2fd-4982-a9be-08db6c7e56e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W56hzgd/V56ijgdayroib0AglkPQN/WrMJF6Lxu+WZwiQUgNfh6z0FzSXKXcFVjAo8txeYp2hHUSQRE+Li7X0h1w6VHwIMKY6UaVRWes+Y18q5mIe+5DwRVAFqIjDKOM8VnQndPgphOgKFb2rHFnjGPSAGb08QxtaIu/DBTb6xyxnQY2gyb2qdGEjODP3euYyrtjNNLgxlafie2mJd5Pxne3/8JFJt6DPBNRlh+KnAySsUxJHjAvzOHWe0Rqs0Her8ymZqSWbsX4S2TQgST8TWyVRF5re0oRVpaeCIgu1ypEJRihf0ARbzFAc2EEuYxbPppYP80xWiYyV30ErNQJNYM3So3GHT5C0XM6g3jky+GTHVfpXWgldDwfCFxu0TUx0rjVtSayeyYWH6YH6VIVPz4s87CFw9CZt0CvNw7SyCUKdu/fFBdMfIHb0zkKKNnpyzTS+s2LuzjZ7oVWWniehiLw8Z/7rTQcXYn6JJQFdmLF4Bulf/u0M9BPZYlHJDOVCs7y5XtVWZ0KtlNmjzTm8m+F4PXsL9POrrYCzLopWzzGu2cV+U1HE0CZlwdes16f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(4744005)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?99DBvx2HK4i2MzCyP0Mtgf2yv+9dglP81TPmEztzClDweG1jEgcYT1smePBt?=
 =?us-ascii?Q?sQKmlYVfqdfb77pylZvMBgQgvaCW0WiTSJwgaBS2nPjMT76I6fohlNVP6vJv?=
 =?us-ascii?Q?gkPImFa8HAmON7flBNOGyZiAabZkaRMzl3iJbZ/JeE//u3ipWnzg72O5n0p0?=
 =?us-ascii?Q?nB+fDaT+bTEYwaNnifP2H62Np7pWt4AhqmdbJTaf+D69ypgIGq2VzHvpgUF6?=
 =?us-ascii?Q?vOp7Vo631kposrIL8NEicuXfljtYJP4ZC2Fqjxckmh2yt9dLzETuXyo7OjJz?=
 =?us-ascii?Q?9V9WBsH5OKFYAibdY3yjeCeZeoRDYF6CG1CMnkLA/FjooWPBIYY/nS7NpMpq?=
 =?us-ascii?Q?wGkfrUJdYcclH1Ivs0BgFRHYuhwfhDhB773+4zz7Y9rB3/r8Zd8/LmYDWDp0?=
 =?us-ascii?Q?5vwcuz4zj8usi1F0Olx4TZSddj5whAqLkGkHOVfYrmJ7DAilTCVWaXyuV7wr?=
 =?us-ascii?Q?hDI8PP2IPnlKzzlIRugcOUPCM7D03iLKJzuTNutcnwWXO7Te+XOpOHnyub83?=
 =?us-ascii?Q?Bx3S/v8jjE2k+E9zLPJ6mbKrrqvcP39sgIYlN232Cw3eor9qg5uDUvHLh5Fj?=
 =?us-ascii?Q?kBdNarzNEYb6X4+QUNU6PbUaYEdevxmYzkvliUJ8Qb50zjdjfB4LLq5N0e4Y?=
 =?us-ascii?Q?4nITTfX2i//jH8O98vOBTlx100usyA2FpxetcIpARcMBBiKQJjH0mq4BKeaO?=
 =?us-ascii?Q?uBAuUs55+TVn0hQucXtgkwIhPmepDFbrVIlrcj+QL/wnvEuiFj9j76Y6imZr?=
 =?us-ascii?Q?lYbnjHVYiIuegAxHxvSdr3uLfi0FxuMrmvtSLYyKzUBGLt9LPgwHrbyiwcrh?=
 =?us-ascii?Q?oZTFSKhBrBr8c8ynQRTupipTK2AIteGPss3ZZSTi3YolejwyhltBPDwtr9Li?=
 =?us-ascii?Q?drtu4ghJZCQbsnIoR1CkW+C733abpqVDp0Dg8xqaxyTCJNgjkKnp2LI1a59J?=
 =?us-ascii?Q?BVy8g7XrRk/2PJJOv3rkYpAGPa5w2lyDIJACql8UBIsBlNbvJ5MbFPqxrjWb?=
 =?us-ascii?Q?rEtUr+dLfGssbvmZhlKmaO2JTsbf54iMWUMM8nIAS/jub+CgUx+oo+PGbUM4?=
 =?us-ascii?Q?/FTskMXUF7vY8ZAswvrA9kUeGKNPoM6VjNn9WFLlxWgGTSMh4qz8uTvBHW2V?=
 =?us-ascii?Q?DQM8hOwS5sTMxYd0E/o/XLq6TfJidQUvg84OFCkQkyoSro03XSEHufPwjVko?=
 =?us-ascii?Q?nPb0YnE8dG4++CVxZLMmK1d2UJxGk4hNYmuEhjIbo4qCPx8dDOAwdr15NI89?=
 =?us-ascii?Q?lRolwTBsB5XI8Kk01YYONt+CnRjRlBzSK8aS+7wrimCCng8WllXfr6Y0ZnD3?=
 =?us-ascii?Q?32OuhwDcgKEG/DJCnETctf9eRimhdYJRDCmHmnZIqhStkvfA2DwXw8qbJJ7V?=
 =?us-ascii?Q?Fx5sm329fNoVPF/LXBB04sr25ylowkka62OavTmYN8P2z53D5sguIE2yID8r?=
 =?us-ascii?Q?TBoux/WcjtIon71rJ2zCg+pQOwIzALNiqqeL20PCUIlHEGz4GrMqmpUDZ66F?=
 =?us-ascii?Q?mGAQpS7vKZO9DNLjMND03gImC/HcuRyHIoOtmWCgJQqiDZUGy8xIlocEvYX1?=
 =?us-ascii?Q?hcq++hQ1KKrydO1P7GH/BjkXFqKgnQZIfB87YYQE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869d0599-f2fd-4982-a9be-08db6c7e56e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:28.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VEP/HNbfrZWVx7vbzd+lh1r+3bqV0NfoLBSA+WxFaMcL8MxMDZLwZkr6SiN1VVmpcWa4+15DTh+GkHnxIPtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index e4caa2dd8c6f..b9cc4a5a7125 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -25,7 +25,7 @@ void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
 		   struct mptcp_sched_data *data)
 {
-	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, 0), true);
 	return 0;
 }
 
-- 
2.35.3

