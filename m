Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174D79E4
	for <mptcp@lists.linux.dev>; Mon, 31 Jul 2023 11:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5k9SB26wjYWDAGIDWU2ebt9oulquZGFEnO6d+IFtrAgMwIDPQxjiZ8B0VN2FtPMxtwlO/7G8m1Gg6hmyYE8HJrcdg5zrfF2PWxkWkcpgpCAqgqYftz9qDJQ6U/kA8EcFWrB7gVErrhzVFdU4sc2NkUTQ9U1L1ZYWlcW/EL8BO6HFZG3EUjMy+rnswNmFQLSWU+LT5pWCoq7Ia1iQrkb16BMhl0i6JuM19GwsBEr8J3lKauAqvGzqt7c+Igo5imnjpYOGIzWveQYik4Ijtt0rrmQEAFaIZ4jTlxyRQoZRHDGthhSb8iKqnmqz0O+oM2+ltcch7kq4GblreKiqyTZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN67srPL4596lQ20Rksjvz05BBG1d7SI/BFvTEAaXmY=;
 b=U+lr+k2G2bvDS0747n5ZENNuXvb2Y2km1KjhVw1eLUZHolmtHWUiUT/vwqb6uB6iKZ1ephIpNTMsTIP14HbCSDLIxhFO2OD9yJ0KQPJL7U/BQIOmv6lssyk4Ajqrk6bvDlODIyhtkCZohUoVQecaMoI7N6qBVDzPiTxLVNptxM6jk29dOqlir0fKBrlKC0FNfb96ZfkivrtDt06V63CSni09jqkGM16HmKHfIk7imXxvKs3jMPEPtJ1TKLyLBXZvzQtpS95xObMd2J4JlLWy1M1FE2yWb0edOYhkunTnye9PyS6z5ISP5MFpyP7Hwkgt/TVe5vEW23OxLuVHgRDR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN67srPL4596lQ20Rksjvz05BBG1d7SI/BFvTEAaXmY=;
 b=y+W2oeVIhJi/R/7cuQft0H1gFVkaR1hn359xhDja+P2ggGEzHw7AZ3alOzHnu5p99mPRXAH8najns9AwJY5xj9+/hnj0n9Hm6q52sYKxgKwyX4G5xwqM0ctEq+Vm1ZDqY64yWwoolhsAJDbjcKorifZ+wVDLVfiSrNPOUGrYS3evuxUjXt+jmch+lBbmmrv5Czv5l9Qg+Khfyxsynv7FiRxiBA6061N9fQDAq/lbejUyQvhQpPanV0lQWiuznvQJbxfK6XFVqZIxsZJ3evB5N6qeg2xbOl1xWFfOqyhP3++lUjZta1BFi3nGR1KPIgJRCLCNTl21B41o+9rpSuQWqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 11:03:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:03:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Mon, 31 Jul 2023 19:03:16 +0800
Message-Id: <fc3b5528378d3fa3b6e606b30be62163fad8a1da.1690801329.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1690801329.git.geliang.tang@suse.com>
References: <cover.1690801329.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: c17468c3-a294-4b7f-ea7c-08db91b5caf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U2/PFfRNyX2TRCAkxU4hAUSTpns45lR8lngxF8YdWxXiugXmqrfIiLGVA2D5+Hb15G4Gjcb9y1hezZadNQCytYJrNN5ewxWAEBoms8PUqx25vI55Ymq8hklpAr04lufvleaAnGLvj4rFBvz+olDDoWmgl+YjVwdN4s4eJi1XZC/fXPFnCn6VacMBdOGS7ByyQy7evO5KdVPsWLA2LgIIyBkPbX6LxayaZwXk0Np6Yxy+iUONr+gdBEE/NJNEfF427CqfmuC01pP7FOjbUTnFuVjjVoZHt1tq2icS+KQSe0Zzwnma5DfTLm4Ez6OvGKc/l+ggihJrWAxzKtGk7KgsDD7CnsObxoZm8w27dC5inDH8NTpWJc20RgyvJXSj6P9hVs07ob40hPG+ugxWekHG4M3rB8A2Nn+sOeF/F+oyaGncvedVx8IMMfUu4PaipGiq91lUBelR9PbbV5WEjw7x7dA/LZlHPrfDNyH5/nKNxu1sURwx2+gckbFs0AccSlZN+CphJYlTVwK1VROTEX1ZoUO11e2MHIQmReqFPnwfKCZlVOog1fW6mo+ojQEoMyOg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199021)(6486002)(478600001)(6666004)(83380400001)(6512007)(107886003)(6506007)(26005)(6916009)(66556008)(66946007)(38100700002)(66476007)(2616005)(186003)(4326008)(5660300002)(44832011)(316002)(8936002)(8676002)(2906002)(41300700001)(4744005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qhcGLf2NPRM7maXqlLbwoUg4r97ryitW/jbtqH1NOfBerU6ny6eOwjfh4T2q?=
 =?us-ascii?Q?eWu/AwbTsEL0tmjz9HUUKsvMEf9g4zK+zjiKekhGPrilDdC6+0hLO7HTshSe?=
 =?us-ascii?Q?PbMD7fcWqOBr3EQnNXlVRCbnK1NsF5vC36dXzMScXjaTiqzbFtmoHsVHwbP2?=
 =?us-ascii?Q?PIPsveqeL798w+bL9eBFTq/Hk4TWA8mNWKBtCcaOY+MNJ5z7g9W5MRfb+qSR?=
 =?us-ascii?Q?qLZvypt6cZwl9vAGYN4cZp56MJoLEy9MvPss8j5yyzckNbmrjkFNma/u5TGW?=
 =?us-ascii?Q?p/yipD+5mt97Hqhztc/52vJqJDMwnxZT7r4oFp13lRBJ8/dSclKnEi4ujOml?=
 =?us-ascii?Q?g65c2iBmVfUs+fxnSPKOAW8lRAYE5fCax2CZ5vFMXnUvUQ/56bOKShLzfmDG?=
 =?us-ascii?Q?oQ+TjxD7DuZQSRdEmQS5B9ao9Rd1MAdJK4ertmGcW8WUEePBPLp830Tbk8i+?=
 =?us-ascii?Q?lJHFeKCM7Z9tyVAFnu9qETGuRyeJlTuX8BISvpQHTLjvCAHCiUwyApkTRtbS?=
 =?us-ascii?Q?s2ELSQqBY5PksfCuIdFrcv+kPytwodY6vajxrb/r8LDhnEbdMGTMZL/YcrWZ?=
 =?us-ascii?Q?gILQxb1aKoD/pJRu858kpFybYkNw872+PlOSEioSOz6Pi4wsMDace3oRrTji?=
 =?us-ascii?Q?SXu2IAhuZNtVuPfJ6Im/GGdaIf7lac3uWDehgJjyw19j606euapae94GrNVN?=
 =?us-ascii?Q?vCW5jNPhNlsT/cI53AngFVUpacloMkJMD0jHZdMHuGq7JW/JMrGlfrVce0NB?=
 =?us-ascii?Q?VZ/N48G1fSIOmHmdKHAWx51Ii/3S8mQ96OtWujHU2W8xrVHx1W4Np7s003pu?=
 =?us-ascii?Q?FrRY1CX/v0uWA9/e7bwomYI4TGb1e+WFGUwEsu7+wpK28NgqQ+iJ/BvIxp6P?=
 =?us-ascii?Q?bnt7/kBIifUOzquyz3axMxfhvPrDVn10vWBjqwf62KzmlAy13rdGvm00H4hO?=
 =?us-ascii?Q?+/Pv668ApBSwAeC74dcLTQ06xbZ4xLA++18+2vwhxq/dBi1asVJ2/uI6W6PX?=
 =?us-ascii?Q?TV36JJMBR0DzmFKXJTC0jJKrSTy+aop5QfNCo080E+P6C2wEq3SY/J4esFTC?=
 =?us-ascii?Q?61ZnauEeBCpt3kQRJVNQBsdQ0plRRhDwjjA3HzuRSIRVM9QYV13S8ERtohw3?=
 =?us-ascii?Q?A471NZ32NJZjhwT3sSDPxMeluYb+aF7MJ8Ettijet+SlTvcSWG+Spf408kQH?=
 =?us-ascii?Q?U/clM54/ZoWy7rnxAyMvYPCCSPgOxvfdq09Ec6jj3obysW+AhN/QEiIgjHgR?=
 =?us-ascii?Q?kLU2ygjLiQmjM/3zGFBIB5Y4OsrFtwbxurDnFddaFfW/wA0tx2eGSkzea8K0?=
 =?us-ascii?Q?O6gBFDaAH94kqmm1ynEzQNux1RhZPdW53jfSVVCQt5kSeN5BDDUwnv8lMsie?=
 =?us-ascii?Q?jPisloG9Cp8fKaZ+NZ2HmmvVOSFRma67AKns/8Ua+ruH92RH0WwZYbSUlwRC?=
 =?us-ascii?Q?5Qt7N1XqPf9LRoHJFMKH825X/yZCW3xsqjHTzus7ZMF0qxogsY0UG2EFLVLU?=
 =?us-ascii?Q?IB9tIYMpFY6DxiavWcefRQvR7LaHmIQlYuw9og2N0n3xIloCQtzIL7ZG78rg?=
 =?us-ascii?Q?js70f7RgX+6qGz/NGDasMhSQhM8PfTBtWb3z7Ztw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17468c3-a294-4b7f-ea7c-08db91b5caf1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:03:38.4141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfilmrjeCeyEnxsPxPfRmnRWWtcw1URw1wJZQPC4eI/UmEr+WRlmGEq8WJF8s0CH8Q84N6r4GNQ1Rbt0+upOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075

Rename bpf_mptcp_sched_kfunc_init to bpf_mptcp_kfunc_init. Since
some kfuncs related "mptcpify" will init in this function too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0cb25ae3ee30..c33b5c7b1649 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -171,12 +171,12 @@ static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
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

