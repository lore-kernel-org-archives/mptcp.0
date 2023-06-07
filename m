Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2078.outbound.protection.outlook.com [40.107.13.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CA5664
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 08:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+gXUzqs6M94XfnTd74YHa5yyH/9kWyUIzotzmOAUEVl4p2UxdS34s4zMmIz5M+08mnfVfFNFQEKVJkrMznuIwRRacU9jAuQtLPY+5Q0vsBnulQq9d4FrApZYZI7YJW2Bw2oWfIb5oBxl8sWwLXQWiXuZeDth7wK5+6j4NRX3ctVfeOa9U4e9YSycVU7pih7r8lUuhghIKLHvFzqOV+A7QkHNOI75XsA8AGCOeAea5K0LYqGsykm0XNN6dlKp5tmPh6la+zSD5wukg7KWkGcXMxKrVPNTPVuNnIC5JoB2qA0FE2MlfhNLilj9u/EFaLpugNcT5MMzt6E5EOWehCfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrKQH71qKVV2B47NqWigCJaD4PBjzQzE4faHUci61rY=;
 b=PQ4IK5KO0hrU6VRXDqZevZKNOip810gc4TMWu6n9TMgrO/znTT9AGsiuK3akf7nm/ae6blRMtANtZSQFR1KBuUNRTieNnR1BoH2feI8Xz1ZjXClKH/xw9XWoQEpDOoz+F0bXZF1JZnWONOhK6rwr/xF9718IxLzuojlw7//rJviDTC+ba2JcJkv5F+de+nwwyl2K4DPeyxpmxdbLORquFNYqCGpAvy26Sd21yzyLt7WtTIJ0p5N4NTUDLgM42drFMlj7+kOi+pbP1rnlvVmuBUIrC2WBs2duM3utb5g1HeDt7YvljkFVPSsPr9M/HX06c/cIjqN8i+PoOfnLucWTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKQH71qKVV2B47NqWigCJaD4PBjzQzE4faHUci61rY=;
 b=MWqOWPOc0zyotoLWFSpDeoymdjXEISZrGiV16nOqTYGNtITGLaU0kjaPJNN8AweGD2lzkktrBEflf8BaOQ2pTTawZam9dgIkmIDuorvlnUakx1+rHUYJtabjKy6Lz3iCvqGjzdD2A3GM39SXpTJejpmgGw8KtV9NJvt8NCqA+LqolWHC2etbOxdcGYamDC8KzIzrh34aOKXNVqV4kfeAhJ0ANvX/UOs902j1R/2JorYSM3EJab7KkJhYSC6hJU7RkIb1j4pCTwvKHLuuXduT1SG3F95YwUbVlu5ycreizc1ec7EmpepIyFNmEdJ6/1c3G2gw5goeGI05uBCHc4VeGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9467.eurprd04.prod.outlook.com (2603:10a6:10:35b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Wed, 7 Jun
 2023 08:41:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:41:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 17/19] bpf: Add subflow bit flags write accesses
Date: Wed,  7 Jun 2023 16:38:32 +0800
Message-Id: <5c913d111771683a7c4a6d6dbbf9750da683e4c8.1686127032.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0206.apcprd04.prod.outlook.com
 (2603:1096:4:187::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b73507-7e1c-4b51-2b11-08db6732fdf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DmcuELtdVQgYKoxRwktQw2fQQRn6ji+hAYpEucn2vKaVLA4hy9BFWscOA2VqMjRr8k0aFxmSpTnhQUV809oc/akbSdSLBL4kvbyz7kQXkjpp1BbMerV+aLY25eF/CLuAGakmHAaZz+kEfzt6LWo3SEiifn8jumSnDBgWrgoEKhKQc4YJw7MSYM1MiiiwfQ9i7/AWdUUYHoUqxm7KPkAgF/eUKdVTqOjDZye3NgtxsHxjzAgBXFI3EOFdUk9s+ToLYDPZWgHMEEY2jl6KiCQbpLSQmv4h+53TF7Ivd4K4mpAaVfT1QyzRhQsjC+5yWxUE8cuY3EYr3SF8Fcp30skV2PrVSPZvkjD99crJ9apBfO1whY9U2rjzZqH/o/g5NqBc9YqvCx0OoQib1gBxpQ5TcOKf5fbLLzYptegVgZ/AGfTW8PzLFsMRQYdyybLH0zAqOra8gzS2cOQmR5VAa1UOYSk9K1znJ0MADEkeVSoiBiEkogOO50m5n6FMRC/XfQLomEcAKvd8mk89JS0ClXiQ3/AawlVkEdKqXiydwH+W7wxWghgB4dgPAMZhxMpgPJ9y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(107886003)(6512007)(26005)(6506007)(2616005)(83380400001)(186003)(6486002)(4744005)(66556008)(66476007)(2906002)(66946007)(38100700002)(44832011)(8936002)(8676002)(5660300002)(36756003)(478600001)(86362001)(41300700001)(316002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOxJgwvZ+M9F1X05hSaYgnnv3p4hEpXIaiSLWv3u/AbdyalC9NJ4j/LwJkRr?=
 =?us-ascii?Q?LMlQP36Z8NohjkpqhU4bsFnSqhZGY3MG7noTOM3OYdltmHTS8keHHFujdhm7?=
 =?us-ascii?Q?n09/IY50q6Ck6y+VR9G1mcMLOaUFWZZAMRC6wtCElD9kK6Os/mu/yyLP6JqO?=
 =?us-ascii?Q?bYMd9rgxmv8jeK2Gbjhea0wCMIaSmQfvQ9kWbVATA1Z6Weh+GDX0FMA1DdUK?=
 =?us-ascii?Q?r4joyAwptE3bKqBtc1aKCCjLcP859FRHLv3EeQgpl26BggfqpviioMOWOnes?=
 =?us-ascii?Q?zrMK5xYXEpnLVt5HyR0eXj0ZBY6/cvnG7bg/jX7P9WTMmwDs85GY53GC5ArK?=
 =?us-ascii?Q?+JepYTPpypDR0QlRK/YQtEoRmo6fUfWTqlCeSnVRg6O3X+1vyorxbRaBTTsR?=
 =?us-ascii?Q?Zv84gfe9jXlobhQ9gvh21tVbfrFe0TEzmSsEjMi2qGnKjf/o6GDXYWOoAf0T?=
 =?us-ascii?Q?rU0Ghi2OBav8wWGhPhZagJcE36BJsRW7fUY6tzPoS7OQnMIUV0DEluGDClDf?=
 =?us-ascii?Q?mH3spJABr2nnDTTdNZTF1JPsj/oqi9FpDqf/32nCNNaS4ZgGM9UGzAG+ASJv?=
 =?us-ascii?Q?5pP4RLbAMFQbI2hH4YljfZSMykgovVw3+WZyeTSwu78yFRDzkzqhWxMiqdEf?=
 =?us-ascii?Q?z7fzGHkKWkc2oFTw29JWmozKBjuutU7TovoA8to8/bzSn/c32ZW+2AAfs3gY?=
 =?us-ascii?Q?9Ar/e9+S9/RHX5J7Ev9XiQTLUGBgfyRlWYUQ5llggcMl84Do9NjKGPrLIJFt?=
 =?us-ascii?Q?Edy3YMiqY4JTPYobANxIe9dTF+qtKjFMJz+ysDPYs8Nb7FVJQ+WXLeR9pqLz?=
 =?us-ascii?Q?HvAmyoph6zirB53jKAqL5sKNBED/apBPzD45yq2iVXM4WADUONO8a91501yG?=
 =?us-ascii?Q?tXHgM1hfRy9LrXfE5g0BFIyOMATZnnDbxkBggVpfSeih4CJq+Sw+Aw0B42yL?=
 =?us-ascii?Q?06w/ctlkj5kQvkWxMR3/9hLCs+Xle+dIiAfqxGkCxhS4QkwC67+mNJhE0qqU?=
 =?us-ascii?Q?+2dJu97A9+10wy+9PT+ZHBONIgdUKneXritOmRmZ5rLc77gpW2DryBGNJn/6?=
 =?us-ascii?Q?/x+RWNQ/eIzySUYxtLQ1ziJUWq5AlB8rnMNtAY/aNtGkYU/HbsiyXLPF6CPM?=
 =?us-ascii?Q?3I9qd9rIX2cJk/+8cdT5oibArdbOAztqgvBS5KBAQLb0rVmYGH9WWN+Ah3dE?=
 =?us-ascii?Q?wcqVkBgYtTuVspUdXf1Q3QkC2r6Cv6zut2h59LSLHf0NPJ4ZFAv8gp14hWCR?=
 =?us-ascii?Q?eSWcRDZCYDPpe6HwRp6FGw0P1Lt77lsqI0/q9QqwxsIct9NoIVIKZjBemcvF?=
 =?us-ascii?Q?XvDidwhBobMKHXF6Lji+CYtmPMONP8BITkJp7M68Qvu2uE/oen09SmXomQd+?=
 =?us-ascii?Q?9iPlHcP05Z0nBUcXLTLfzQ4TjN7d2JKxA9TI/tSfXW0hOVrV4c1TFlcoWHsI?=
 =?us-ascii?Q?3oJV5mDIt3OFQ2+AiEleeTRY8wCz3BBbRYn+n9YfH7IObht0zLpOlNCFDQVu?=
 =?us-ascii?Q?nvy8vmTvZleYpPR+T83EO+C7U07yXgyUoNbDtOp6Oc9kKlO0AmutP1v350/W?=
 =?us-ascii?Q?SHGUFwXy7VbJY9edBwyAlSMfRLu8tCsYWbRMwtlf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b73507-7e1c-4b51-2b11-08db6732fdf9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:41:31.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0QOibXh8qHPwjpSuMPRsOC27lqngqWS8hXNVF8WKhmRSRHy3QHz6jDXO3ZBnL48gT61D8DIyfu1jnL4SUg9EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9467

Add write accesses for all bit flags of struct mptcp_subflow_context
between map_csum_len and data_avail in .btf_struct_access. The stale
flag will be used in the bpf_stale selftests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index d82e09d86312..4963824ae1b9 100644
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

