Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E71876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/8LorhJ/0u6oEBxk1o7aTJTXnSCUbunTGVZoBgaGQ3ttSRHdy1pgTpwCWd4haHrdTiU3/OrKk4bMEsLpslySSi2pZRVSrKZ6Ax7FCaeLVko/CeQadOA8gbztA/2WsUDLQ39YocXCRSnqsDxC5PWnZGoKwcOc08ADNCbqqpaQqoqIquKyI0shpBr6gKUgF6gYTJgH96WTxxKuV/mB/xIKz2y4qPa+HJYlvNfnGU//g7GQruPIogXv4Drur1bWozWvPf5GS6sk4Xkzr2suz+3CSNjcDBgsKrN03zcXA7rCgfhVJj1kM8pDfzrJ7c96OR5QD2CLHDtlxTrCXejlRgS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26iWokZzac81QCDO3If3ITIZSHHPM6LmLzyOkDdEQbg=;
 b=WtH1LYq8iIcwspfJ42s6Qzlh/dG1kYwKu9jZzON7YiLXde2U71r/CCrCOKkAJ6l4q65bjBTauOXbn+COE8XGDhQ1FUVUvWNZ1fDTdhfHieWSKbZM50cVt2YxuupWdOCmGbGmsJ5By4D8ipKbN8MkVoAh+96nVCIYjjLPmra9kgKiTetBT5t/KmMXSg2Ac9Ho95cUbmiFuPE10ZaKAdUGxGty1s5EhfVmUloss2gBNR+5TBcLh0pFq0IfZsVkgpQkkhKAP8AJz3zVxkd0iyUPqKnU2hj/lNqkLknOcj8xTgUrpmymypjjreVg2NzotSa9eEPckYs1rtXJJ9QopGTFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26iWokZzac81QCDO3If3ITIZSHHPM6LmLzyOkDdEQbg=;
 b=K5duCBE9v1FnhRMDxh88jQcS0ZDeUMmG0nvlBhU6pEAO66ShrONs6iVK1Kw9f3V/nusFXRtaT2YwJXAFD6/T42OBeajVznnZj9F0MBiZU9I+tEWuTvYgH2/yTj6r3G+74EGfKX7xvDnsL/205QrBN1wu+899fsBJbnTyd2pLXC0XyKwdoV1FhJD2OfawE2madGYIg/tOeGUwRJATcMaHc6/RNkl/WcG9/gv+r45Et4riM0kIgDN/ihI6H3iBWCjN6BV81E1EGZQEEISHzeZS+UYmLDh3SPeAMeXJUOCg1eT0Ez2PowKEaQdQlYeKX3Bzt95cUOrVUyPVS0gCkueyoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 10:50:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:50:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/6] mptcp: accept right edge of mapping validating
Date: Thu, 23 Jun 2022 18:50:24 +0800
Message-Id: <38bd913f129a632e1919343c89a76151227a4a97.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f778821-b0f0-49b1-7f3a-08da5506341e
X-MS-TrafficTypeDiagnostic: DBBPR04MB7659:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7659219E97AD5486AB79222AF8B59@DBBPR04MB7659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l8oaRfcLTNIESNqHkQqdUneMA70e0AObAtlKO8VRfeNxqwC5r7XX+VKotv5A3ulcQwpORYp4mxrqmqs8Macv1Z9CjlFj5cF1sAo2OVp+195M7Fx0xXEbTlJX+xonlh0cUYFI/yqrOUx7cubJtoIUVh5DWBSJx5nZuJotE+B9pWSRWdoONW+ZYXVksh8RMvvlMAURgURkv3Q8imn9KrvnJTMiubGFwayxbeTwNp6V12nRV4iXqLxnZXqPttEX/pDlgsOwbOIOgnNU8LQJdNo2aqWXB2joInznY5LJpjOgY8OdWloL4qcWivoTvRC4Fo0ONjR5v011pD/TrJ4IvDCnbGel/D0ExJoxmIQU/yTULzvatgJD1DCrysGJpfydUoXOMDT1WvZiCIJVLXEgBnolp+Wg8I1gbZaEr98a5vVEC7EEo5eDcA0cdJ/RmWzRBFab7/irX2Wt3NbeuDtm5cMAKbewOPHkJS8uYrjkY01KsrJP9UhmymsftXm5TGuMu1RuQHVy9Ly7mDWFt5EY0M89vKySny25e/kihiJ3onQF7qIitDUoUwEoPGUt1PIRW8XM1p3CQYqpgXZ2SQER6xeZ8H8GdX62Jsw+cClLvD51gJuG/JJTChgU/D7jY0+o2zwdR0iKz3E/6sOCVwybel2luG3st4bkokz/fPirgg0+T5egwvKFpKYNPsbhMRgmir0yFaACKBk8xyTc1TSwy+7ZsX2CyrN7V9xuAEz7q270C+JIETWy+watt+C5osxueiVs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(8936002)(186003)(6486002)(6666004)(66946007)(478600001)(36756003)(66476007)(4326008)(8676002)(41300700001)(6916009)(66556008)(6512007)(2906002)(316002)(26005)(2616005)(38100700002)(5660300002)(44832011)(86362001)(107886003)(4744005)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPnzzpBpdvU490xDm47CFn2d9SRGZIcxDMgF9y4ll1LRycQn1CUtZz67DycI?=
 =?us-ascii?Q?6FOmF3ug3YiFxpcIGCq+B8hNyBk6+QnRPGJ18x4+6qpnlNVc7BMrSFEaGjrj?=
 =?us-ascii?Q?Rg/jiUtvFdp0UDaiDZGQfLsMoYUXTgh4bQ/m7swFu0ejM2biuwRkAbcsMnBJ?=
 =?us-ascii?Q?dbeerxqXv4AvbfYRt1RorKg0AqeTKeaY9yXma74vYYTHt3WUNG2H2B3GGEpx?=
 =?us-ascii?Q?XDByfG4hxQh7Zao7n0rkpXfHbe65112aNif5SaBxYEITmwfcHRWd/H31Dxwq?=
 =?us-ascii?Q?wBzGuakhUTydtId+qvBHwP9LsDXk1jh4i1spI1I6SEn+JJ8vNt5IfrjoFBpi?=
 =?us-ascii?Q?hzFxjiEzxi6WwKBQNpkSsGL5bwg0WTnFiEBuoT+S+9DKsmO0spVkUyQL94tJ?=
 =?us-ascii?Q?1hqBY4t3nYENXBsDHmLJrEy6gx4nxZoL/COTovSr43b1ezHnNj0Dli+95h7+?=
 =?us-ascii?Q?iKwlwyxUBwqnepJvW5oiykhH3jmI8NgLwlPfmZWd8sBBtr1L3Ek/bX9g2Y/R?=
 =?us-ascii?Q?CT/ZkKRoykVoA+cGABgf+jHiWSAnlutpfYPpVVLt3PzucXXeH0Fs0bhLHZt0?=
 =?us-ascii?Q?wtj1zcEGufwmNvu/zEtCG2C0OXT6NAyq+cqKU93DtklYDAkpULihCmBycDPd?=
 =?us-ascii?Q?CYxcVAWg2NdrdWYcOd0GCVUfYDfnMNiYHDyDFXm9iayZ+AeGfTCaqvKU4c/n?=
 =?us-ascii?Q?EWFJG8oRUnkUPAZmGodnDGYK2z5p38UA1EKqME4GdSDna1VJLfUjRP5/9902?=
 =?us-ascii?Q?o1o/n0TT9nN03aK2Yn+PlKwMNGKI65wtJSjHV8/ttEmwwg9l8rg56hbg/l7/?=
 =?us-ascii?Q?C9T4qntmvBYKVYwlCp9x5Q/lwn0h2M5FWSeQmr5jHOxivzuqNYfZsZwR0k+L?=
 =?us-ascii?Q?YLzgAdfgy4VmH4VY4+GkmKZQ6+gqnhnCmLeBLaYYTNva20Fy2LSbczwsDfzg?=
 =?us-ascii?Q?+OLuPGEqQUqtTfrhCAgaYtnJX0fv83zlfcymOYx2HIRZH3Tyre9pLOGHWjrt?=
 =?us-ascii?Q?68zW/nX3wz4nvuKyKxpLStX4H+3uEW9TwvOYylKLEf2EcRFexNwDA6EFOfFp?=
 =?us-ascii?Q?BDRIxfZDP3sDTNvCGfp+BYIG46m8eZ9Zs2MVpyNf337XVgDs1vHBv8aU0IRt?=
 =?us-ascii?Q?9dx1X41NWshvZD5jsQJZXL4UEKxfbhcnAwpWSY9MfhLtZJb7xQ8dqik+bjHP?=
 =?us-ascii?Q?aMUJRzVwXrsSMqSP9insW8UgcObkb5YI3alx+oFTmeTsydC4bDgnA/LXKGzU?=
 =?us-ascii?Q?d0qZmWdqmmuhm8OPU8ztNDjaNTJd3dSR0XOEwpofzpK5zNDqWRhKb4gQntam?=
 =?us-ascii?Q?iLsg2SB+ggU5f3/zXmE0LvWKN4TVq1OanKYZwSldLnrnntjPVcAYdVejSxjw?=
 =?us-ascii?Q?QuaRS1X3ILt9cU/YQtUblHxQ+XKa9py2OX8ujqa8rcjWq+j+hF4tXyIfuhYe?=
 =?us-ascii?Q?t+XDl6L7vohWeD5bbl7jHKrPH7RkQHWO7ExzF0QnamfnJblLAngThcEt1Zb1?=
 =?us-ascii?Q?zgKqRZeiA9RYs21TxQloih8ppYCBKDtBcIqjAIFDeLxDNmEe+awADLANr7u3?=
 =?us-ascii?Q?sbLikhWB/aDO1uAe752uszfUXRxEPO4ay22DCckvAIK1PS3c14EYphdt2lEN?=
 =?us-ascii?Q?n0GGKHaGD1xbjtNTSFD0uc+aPc5dmCJBXGZdEp4DP/l//LAzrKh6h2MGQh+M?=
 =?us-ascii?Q?3s7eD8kuAwL8E9nXpCGp5xG6lYRwzdCpDY+hHoNfgCLsxDEaPjac2OsQlfQF?=
 =?us-ascii?Q?0Hni16PVa39Y8mTIebxMIcwrTQqm3ao=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f778821-b0f0-49b1-7f3a-08da5506341e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:50:36.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdrSig3PEqDl4PeozfNgndbW9+jhWARwPZCj9MZyt3zYQ2n75LPIR/H5hYTqGDC8fDlxsiI5Y/C3LnqOPlbp8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

If ssn is at the right edge of DSS mapping (ssn == subflow->map_subflow_seq
 + subflow->map_data_len), it shouldn't be handled as a bad map. This
happens in the redundant subflows test cases.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63e8892ec807..69a2c3e6fd76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -878,8 +878,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 		dbg_bad_map(subflow, ssn);
 		return false;
 	}
-	if (unlikely(!before(ssn, subflow->map_subflow_seq +
-				  subflow->map_data_len))) {
+	if (unlikely(after(ssn, subflow->map_subflow_seq +
+				subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
 		dbg_bad_map(subflow, ssn);
 		return false;
-- 
2.35.3

