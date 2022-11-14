Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D1110E
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 02:39:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1nQ+NNwA1ejCi0HS7wcB72cee3PM+NYT4qKdKwFecCiAswSNvJycqLYpQh70lZRkOT1jlPRiR/Zd3f4zJS/3Y5sMIuet9dahHGEbvP0JxczmwFqJymX66iLadMJpQEHdyT9oyo8gq0puwEpYrKW5Gq6Iqc4E7Zh1ybsN4hUItlR8H72oN/i3W6X9CHLQV+BhyLPDAJrxyrhK0UFrc/KOfy0oE5EbNAPOCrYUAYYFdzqirzOXWCtTXsTsdUCjqQUwLREWVm4qt+wis+M3og6XgqnIKGpmec3QTa1Mr5zgtNmWsH/tdFm3BxKtow1IIAVDvsU4y6StRsODUL3pDWfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjHKuLDkC6jZUDNEMpQCOaQf+ed1ygNPk16+lynX7UE=;
 b=SHRoWM7fRHVNeP20/ho6eSsZD0LpMYQWMgkHzgt3/pdeaeB4WY43HNfUtUGNJef/I5iYVTSGcEO3QCNpCKjEBnvj+PiJc1SwZdzrKxrB/VBEwoSruyu/udfxCkLC8f8wCvumn6KruMzaLk77efgXrkFieUbeJlZqD+S7TRFfF4UIK4Jimf/wy50TL4K5RkTkpCk5vjN0qYYwDW6XIqg/Q+RJbL6TzXyfzy70pCd6V9rr8lDzdAC6rdLVF2GFLYauHK0rbNXOXcc4w68NNtU/eKJ/YEIIaONaBGub0OZzp6503kvA5jGnsGP3DcysWMqwOd8jyRNfB10PYKtM5pBn2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjHKuLDkC6jZUDNEMpQCOaQf+ed1ygNPk16+lynX7UE=;
 b=0/b/zdMDjnS5W1PvL6TrdMtY3/OnTE8RWXqCT6l+1oseEyNl/PntvQOpQSTHfeY0QTp1z7NV3l7FF6vrXUv+lTIvs2rWeGE8p+GZ9+zZ2nWLmPnULy90TvzxHoJ8o7eX0e/Kpw0M3o+k4dtIxE5TFYHgnX0YUuinnOOdFpsZcLkwKD50/0quSQUFKQsXtq67klucPOHgGPYj6jLqGpcSarOB+dVWCcHqYhZZRJJh6RxVE2cRSVaq9J1HpASd9Otb1nZ509+xeQbjUI//VXLKcLyK0A76ORkRUvHU5tVpxovzZ2Shz0dVI8JTge4LqAqxl0H84i5Uz395CXfwwIQiNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Mon, 14 Nov
 2022 02:39:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 02:39:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: don't fallback when dss validating fails
Date: Mon, 14 Nov 2022 10:40:05 +0800
Message-Id: <20221114024005.26661-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7d3cb5-c450-47b2-6e4e-08dac5e97e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LdNiEbIPIvPpS7+2TfFDMBP1WcZYIn6VOn+bbTLiUu578JiIXBFg620r539XElry0Y0/nxNQ6hWXerXcxH7Y5ZgXPKpTIi0vDu/CcUjPiUPRvXReNCCLXnRHXoeauh0/lJbuLsRwxD20SU5I9nG4oq7Ds4kYyRXeckm+jjkA13AM4KGf83koZl//mlr/Jt+Jlrt2CvHNS8hH241zPcwxuAUVAxdPD+26AVCrHqsXeFPWl9kc25aW4uPrcRGGoHBD+3LMLpb52LmlnO46usJzf/d0CAnfgE9zaIMPEEH1t4oyxqkQSliNJ0tpI8kiKahBZQYTcu8dfNhPU/8IqcFz5/4eSG/dSndwBEjJgdL+b/FE9a9hDLyU8mrytOHG0x+Kk16XorKVUpCDqOIcTPLMX5RfsMsk9cgSYQptfjxvqe2i7DKHZooX93MxuzvCRLgD58nXia6hMJziouSP6Oz4D4xIWPJF4nDlwMPLZFUzu6dzjr3vJ8tAHVXJVCIVS4dVl3j5LWyUyFt26Hh6kTecgQmZRm/foeiO99wXaelIX6bF3KPj/xyU+s/rzYfQn2VXLIiKujjaJ5Z9WnrXUHY7hMd6wW6zMCeAuSnhtbU82xk2sxGKmwd92wR44dB6ijqOSz7JiJuFyllUc3oqsFTSTpD26pB30k0kgBdns3u0rsXE4oqCq7KxTVzgg95ycpHEoe5FhmsZsov2SjQhBBPEiiVhjNKAucNdCeN7VhS4pyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39850400004)(136003)(376002)(451199015)(83380400001)(41300700001)(2616005)(316002)(186003)(6916009)(1076003)(966005)(6486002)(36756003)(66476007)(8676002)(4326008)(66556008)(66946007)(86362001)(2906002)(5660300002)(44832011)(8936002)(38100700002)(6666004)(107886003)(6506007)(6512007)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ciVNxrT9BD2O8VWlUNoROs/a3pRS+cSYa7JD8nKfTDT73g2QTt6WL46raYXB?=
 =?us-ascii?Q?fHskYcvL70NMcGEFwFvfjwsJ9bIpHPaxYQ90y2aOM4DrWOb03/swhK+jS4pd?=
 =?us-ascii?Q?g7tKyvqZKEhOGVG7bshkCmOvPUde1UM+Jw7//LjF78wyN/O94TxBTqHXXh6G?=
 =?us-ascii?Q?bDTmXeVfW3ibhCEjlWbkuHEg05htZHCk/NfY3lBh5yJrIkc9TNdNQtmHrrzD?=
 =?us-ascii?Q?jENKXucnK1uV7kphLKuUmBnOT79QOTvWW0VjOMZfVsBFye7YnufzYnwX/nV6?=
 =?us-ascii?Q?VC6gqJVIqxt3vPZ0yJ1TYSKtk7MEZ/57VO86namaDGYykpEXt2lImJBlhhAu?=
 =?us-ascii?Q?u+EpQpunTdhdl+gaf2Lkyje362mGJ0HlGz3C2BCpkRS7P42xRWhu8i/Pg1aH?=
 =?us-ascii?Q?lb+BLmVCYbrY7NUUxpe46kFyiA+NzIpxr/gOoz9cPd9GcWKnmQIM4VslsoIW?=
 =?us-ascii?Q?zqtQgu/Wp+b+lbuUvLHWnyI1tUwmLxmGcvMZ0H38gii1hALGN9hYK0XVQ3Fr?=
 =?us-ascii?Q?Zwj/r6F32ujGBvuwTyM2sburWfkdG40AFy/Iek8ZYR/WbtN6XVpqzwzVdqt2?=
 =?us-ascii?Q?dGOQjNlZCr7yYwE82sHmCI9fgMruNw92hJScFCLImUpYaeO2Dk0AaanrTbbn?=
 =?us-ascii?Q?JUtE7+naEYDaNMZlp7M5tF6dYphwDJvw9AM9mte7GXaftw+urvcOnkMRBHrY?=
 =?us-ascii?Q?u2+vFpBgUnWEqjAvuipiXvPV3xToIccOo1pLwoiX6tJ0DXz2ebv1xvT/J/YI?=
 =?us-ascii?Q?Y0x36zoXzlRlmNhH+hQT58qkZYzvZbsk5BU3LqZEs6Z5rJrwo4xc7Wk6wKHk?=
 =?us-ascii?Q?CabMjzMhbzl6VGAP+tsmHZl2UPxUZcqSq+sP7Ub35kUFF62VLRhSkzolAgFa?=
 =?us-ascii?Q?xBf+PFctSut3cij9hUn7PBHMvMvp+SRjf3IiBNWdFkMe8rwtF188IlmiPTA5?=
 =?us-ascii?Q?9CV4JVwJ3bURvicNhFg3eA5u76jLgJsju29Ysmm7ewLPxfoZgK0H3/pUJl72?=
 =?us-ascii?Q?SRDdu4RSenkBgw9eqvQdEbVbjyEj+5XC/+J6+WUOMbjayrhUW6GULVyU17GT?=
 =?us-ascii?Q?dfMP18Xbeyzy8DN8xd0BgXY/MtO5TtjbnFbYSusK6GHoh5n3OHNdMOl5wJzy?=
 =?us-ascii?Q?/DqX/VhqQBmLFilhvgPpZQqykwMo1IlDrtUlA3snfosY9aDjrCrhiE3HCj8V?=
 =?us-ascii?Q?fmEw5oPKKh9y/mUGf6TNXKbbe9nvOHhixt4dMZASimyrVNudgrqsfK85ej8g?=
 =?us-ascii?Q?FJ7O8M/DyKNQwKmO6ldqaFEvCkd3dqofV8x0dxIjpMtZbtKN37cFjCnzdIDn?=
 =?us-ascii?Q?UZyyyQgXdIlGMwoheo1aaQlURtCZNFacHm8hQZN3naJLFRuKPRDK8oVszXvr?=
 =?us-ascii?Q?EFFBxQx52VmQCBYhyoBulZuqo4VbvyxfqBa+PnV1Co8VQB62eb6nCIJfCnmf?=
 =?us-ascii?Q?RCCuLlWZngJ4DohMgIf/nM3EAk+dSlTb8DysMs1WzapfHlJETHsihP/FSta/?=
 =?us-ascii?Q?tQ1t2O/Fum1LZLUhKMYpnGL5how67FSvdlAn58I0SCJ96nAQPvmbbg3zeskg?=
 =?us-ascii?Q?itjG2xzLVz55F78+6P0o13nJT8KVxu2T4fSPr1NzytNzvG8WjyaUagf4rwY3?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d3cb5-c450-47b2-6e4e-08dac5e97e66
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 02:39:46.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QXzwd6z45D9PQ6EI9lGdPwZdquvPOliojO4J0pT3seHTdttdp8WftX4rZsn3VO+XzRFLeOlOL4Ptg+xt9Ebdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

When DSS validating fails, just drop this skb and continue, don't
fallback and reset the subflow.

This patch changes the return value of get_mapping_status() in this
case from MAPPING_INVALID to MAPPING_EMPTY. With this change, in
subflow_check_data_avail(), the code will reach 'goto no_data', instead
of 'goto fallback'.

---
This patch could be put into "BPF redundant scheduler, part 2" series.
It can fix the issue I mentioned in [1].

[1]
https://patchwork.kernel.org/project/mptcp/patch/b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com/
---

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 97d301d3bfd3..3944ebf492d9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1128,7 +1128,8 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	 */
 	if (!validate_mapping(ssk, skb)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
-		return MAPPING_INVALID;
+		sk_eat_skb(ssk, skb);
+		return MAPPING_EMPTY;
 	}
 
 	skb_ext_del(skb, SKB_EXT_MPTCP);
-- 
2.35.3

