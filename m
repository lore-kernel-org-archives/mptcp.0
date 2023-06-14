Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359138E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcgiGOvdlIl/6RZVOrtLRwVd2mzrdYsEvfHrXmc2tyoEQTjj3lqPa4DOGT5t8TX3wldyPUmpujdFmYEiX9XTxkLul1hKge5ot7EvXbpZY0e/YJnzYRc6zUK771Cu655ey4tmU6gUz1e4ld6eZbcoWzbBnvxGY7umPbCvCswz5aTCSo4mWn3U8HqNLv7CBZdsYmJjyNjsBpnt3qgdbNSmmatbW8XD9BO4T6s4/loB1BfodGcugeIl93LhaXuzIZgdD3K9Q5ORScA+H3d3kTenHfJcD/10Na9oJWANNQdEcoavp4FKeROjrVUIkc4pE5S8RKrBlnNm1GorP77ju6Ngsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZTpSisv/y2rQe56B/g3GediAhxa1rJ5AH3sq7BCZ9A=;
 b=Q17SvtrrW6M7quAdWRGML8xg7FkPFli55oo9IsaugdTafWJAd3ez27LraousW7oCbFEQspB+7PwmvvAnSYaAXIApxqosqDd5cFc1Y2uHIpPIzl7T8SKOwbq4gVUlCB+cHjw6jxG31023bNORwMGvLAhsqmtUfR/UAN/PpmGQwnV30xCn0zRDhOdgzAMqlSvdD1xKDb7w/C5mv48fldpqiW8KJi2Md6v29a1OJJFDD4YmiYL5Q9OFonPN+XMFb1rFOUKFPJfp1//+DxzSLdSnOZ7ha57wwkeYDNJnKf1znfUdgvyOLsaJB/Bp1QA+OzpfPaMQUwSZrkGP54aymGfwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZTpSisv/y2rQe56B/g3GediAhxa1rJ5AH3sq7BCZ9A=;
 b=opwTaDhP+QBKeDNd5pceDifxUshrdNNwcr3CxEb1aHFWF4vsr2ikRSYG/octdzYhcP3Wl+zOjhpT7kxdDyVdxHbwaXl4X5s7YdRvvfS1R5we2OyX39x6zz2TxFU++h1wd5mVZcl4zpb7TTSZFcZQ3GU/KRyWBvb+YeoSfaxqQhawNtW3r672TqwWlP2rQxK3iO5mgf0RG84ViJSF99i7JbtcUtdyhGF+gXzeql6FJQzL4tL7XMD8FQiBiCzZA2lmhnXTpy59v2hUIvwjthMFwPFnjhRG1rVKBkAz4SaIPPJPpKpdylHEfCMcPUQWUUO2S1Kd3F3zav8LsQDUgThD3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:25:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:25:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 21/23] bpf: Add subflow bit flags write accesses
Date: Wed, 14 Jun 2023 10:21:08 +0800
Message-Id: <0ece6b08df156e884672031acb2548b8edca5f57.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0230.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bfdbe9-a245-46c2-595c-08db6c7e8f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ekplNQrP1oAXTrERGZ/SZCgb4FZTpTSLy2+4UD8ZTpFJJExwtfvajZSf5myAxAVv2Lxar0om4IqjxqhOeGTdtWyDlgwKpz4Fl+BSeZkODKtMJQYNPKHFVappY74CggpM5BkEipKkCDwv2uXgoc2KBNf/gt1gtf8JMMloNmLV1ctQCIsvYC91Q5/qVIsWrIbl6bmhe3eLxk2J3tGFUm+Dva2fVmQf7lZknyt3+cPy5erKKnVbn8888F6eaIFWho59BjLKvwHkw+HpNdQnfmAOUou7MF39tyHSI8c7FGdqrwjiHpqIqjJexzI1ditkzuRaHP8ElFDoIgCrqyUchbrqkq7S1IwEW7DcyuGAC4dvGk65vvcbgL17VBkEmlVX2FSVZsFaZTsG6eQa041sa1j4Itu00ut0BM9flr+aA62QaawhJAl3iHyn2UYngp+TXqjbCyHhlXWaxN09Ts8QqryqwHMc9MTOcEIffLUwUq84fxAjAsnCiLqMzN//xHHADHjR2CiL7HIkJHcWaKIMZSvtjJzPFujPn8MQBne77km1NeLme1YNZEPJlPvO01MXOVPc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(4744005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UF4OulZDAIt4xYNqHXXq4GWKrqx46v7eIu2OrRehX2m/mlBljCAotQAZzV6g?=
 =?us-ascii?Q?7UNKCwmVb9BYgqnMcz1blVRFT/aDUXKPbcM3MVSAowpnQEMgHBO08wT3oHLN?=
 =?us-ascii?Q?H75I2Fw5d0QFU0M/90Oxj32cjPITAnQMSW/tcOwVzwXprDb79ft8HbV/GCu+?=
 =?us-ascii?Q?aop3Ud3lhGo+cpZEL/Zd9pNldDrJLT5airyJAbAzIkJVK+H8pkmZQmA0f+wT?=
 =?us-ascii?Q?XbuiywFgk5Kg8bVkq+h1WhhF+DANqUCVTbE/zQcMt45lXjF15Tw8OLImTDkX?=
 =?us-ascii?Q?W6wFqoRYHR+4wm1/2oYhUCbIWGswekXX6C7bqvX0LnDy62oWBgn/sVXZ8Q0W?=
 =?us-ascii?Q?yjjsnfeqcnB9qGFKl165iw7eCTwKCtuUI0+kO2eQLELR7+R0NcVyqnXCoFUy?=
 =?us-ascii?Q?W7DvFPS+itbUflW4eSemcxpHfCJ8k0Wh74U5iW88BqjwEfDJbV13HUJqjpmI?=
 =?us-ascii?Q?3Y7cX+RgySUW/OcpQ1RDqejgGlhxxbau7AuOiesGZU4iPIN5UTAIXoKvQdzR?=
 =?us-ascii?Q?RjAzYN+XJjKRBve18OWehgm43q2iVdVWlrgKmf6BhMKTq/XAsLkMLbWDsevF?=
 =?us-ascii?Q?wlpN08Q/jDvpyeoD10aMmyp031Ax4NIBzGhRGFF9OrQq3fLY6vTMamPoM0v+?=
 =?us-ascii?Q?JjTy6CCw+QiXuHER3BYA+TrfbDaB1UhH+b4554wvLLqhkPLBEk5ZjL0x308t?=
 =?us-ascii?Q?/3Udd1BLo/AvOLescjH70qWtqrk8JRMYkqRKDqsnqoDjQAJRygfrLv6foPgr?=
 =?us-ascii?Q?AaTnjABbuWFTSOHSV5W3dRSkrqveO5xnzSbdu/s6qv6BIPHeZcYDIDdSqk4l?=
 =?us-ascii?Q?cCVT7a4t6tT6xUhZP+Afj1PGrj5t6XY4zVY3LARSN1CSzgZcjFUYUZ/E63Z6?=
 =?us-ascii?Q?YYOCcEcLhwCcoJ3P7w06PqYrz7if0FsH/hg1AOB30Z50vT/LPkbgCPc4rE+1?=
 =?us-ascii?Q?gllJfyBwDX7MsRmE1zzQbzydXpzSaK/QuoJWZCgzf+cwy7vfS7lPXD7nqKBG?=
 =?us-ascii?Q?u+y/q4qQ3X6xBwNg0tm8fR+lRIB80Mv3Udble3gQ4BbQ3HrlHGdWI98x0Oxh?=
 =?us-ascii?Q?oHPx3JyqnN9ADiILng9UPh69br0nOAV8ros6It5satXDNM2E8edh+e3TAWwG?=
 =?us-ascii?Q?0VGcoNN5IEk2/jOW9JjX1nq2OxQ8kJqU2Q7oWcIpx2TFXjyhcNTkq25nHEiq?=
 =?us-ascii?Q?OWMyg33oypa3GqDasC4s8NVZXkfiXlSzM3nEoxiBvK00pXZn/souErOchHyE?=
 =?us-ascii?Q?4tEbeY2sW6Rm56PXBGIxpd1X6Wyxl2Dgm+cI7Z7pNW8GPyQk1k7TbgDDqSzK?=
 =?us-ascii?Q?CXIKmX6eI9B3sBZVnZiM6PyHdKHju1i34gdlXkh5Jq1367QlYQQzcMNa/GBS?=
 =?us-ascii?Q?XeIyunWohfdx+xPTktexc2BcRc93oZ8129uNs5iQRRrrpFY7IDLc+JKByzgr?=
 =?us-ascii?Q?ZqyWBZRVLlk6qjOkqy2J+rE5L/iQMfzycxAxSwDZeP6xBLmM7JPJp/fPFd7I?=
 =?us-ascii?Q?lFrRIOkOVf/ybXyAZERw+S8h8/H6cCo7Pr+kI4BlAqwKczc0wspLss9UbdB3?=
 =?us-ascii?Q?C4iQ2sJXdJgQaiyv68dLcAhFuSD9KZmD3qekJMlH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bfdbe9-a245-46c2-595c-08db6c7e8f9e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:25:03.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3FbarPEgM1gbRW+eoXTOd9jJgiRvq4Bigi3O72/MKj15hECm5K9mbihqllmFJ5gDP9TtA6PJ5n4qFNOm4xqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

Add write accesses for all bit flags of struct mptcp_subflow_context
between map_csum_len and data_avail in .btf_struct_access. The stale
flag will be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 15f399317ac2..3b1ea220beae 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -51,6 +51,9 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct mptcp_subflow_context, scheduled):
 		end = offsetofend(struct mptcp_subflow_context, scheduled);
 		break;
+	case offsetofend(struct mptcp_subflow_context, map_csum_len):
+		end = offsetof(struct mptcp_subflow_context, data_avail);
+		break;
 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
 		break;
-- 
2.35.3

