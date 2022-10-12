Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2082.outbound.protection.outlook.com [40.107.249.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE4D17CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVy4tvUEP2L01yumrNn0b4rNxcR0S12yIjPcABF70nF/Cjkfd1wT6IKthmQLeKcJgTLgjOX3bgrSx4h6YjzM/hPdJR6LZpzxiQqROaKavm4vfj73BcJviFPcXZHGJOoINiYvKGr2d7dB+vncxdBGhPt63HZAC9TnBzFTuoRgGsWLwL/7QoAslZqX2Js3Mu9CGOjSfktpjyAiAG1IlW0HL2AC7YyGrFVSsVGR3tmtytWzTQaMiCD306JT9dcxG2/HF7zZRuXZYDmEdYIxhl+fprFk41jKPRPZSW6D5ClV4gpWVvMHFnEHoZYQNAi0JjnEWS7BcBcnPFgXGlIKIsXm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=GfOIEc4lBhJ5VAtPlavzDmdaky88fhRuSgH2DNW1tfnowwIyJIwVxYAjvyLIynKK60nq6HKIP+QG2+cIGyiVZ8cLCkky+34EMq/lH4akXCydcUzBGb2mUZVd7ELj94Xj/1B6ehZtUCQzexyn6zJ7ky/SR/rtCY5e/ggic0kfGuDz9HxFmkj48kBrWlPWPT11d+CJmC7L1Ub7OPpGPxlrX0CsKlmFDtZE/C5PpyEBRkKNfNsrZwa1Qx40djxfxgob8doaifOcGjQfESoeErmW/4xxCdCTmi2w5zMSEQ7AxgGgR5xf6GJu99Atnq3DRD0ejwrhyAnNZmKv9YLztNN/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=zk3KGWT++Wzt+l6Qg2Fj4Gg7JPjNeUI1ezjetVhvEjKjXLD+gIdfsCp5QEaorlduB+ZRIYGy+ASO4cAYjDsbYIYPhPrc4uukKpU6neZq5C5X8OfdqPvQwYSbsqk4ig7MEOwFjWx5J05lcGhjaVUhIXSzJz3QjawF4uewcJ+W3CtQp/bWrfOlCvQIVcNnuUmb/vSh12iyrOJCUhX7q3YJCHisMYXpFNTFG+rherCsQZAyI/h5W3F5c/oTmFL3YBeyIEtJZYObWbItv5axjGIu0e+1Mbiw5WrEGXl9wUQYA+ihqGxwVMYD57N+L2srBAs7OT6nRUe7hOIEKg5k3YD54g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:52:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:52:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 15/16] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Wed, 12 Oct 2022 12:50:36 +0800
Message-Id: <cd8d91ad4c5deba98a4c929748e18756d7ddd110.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f0347f-2997-4191-dcbc-08daac0d928b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vm8AguhfQ+Wi0/sWG6GC5vjVEaDTvVwv2i5k3UbNvNT485SNfxfz2CrkTTlh8zFBGzZ6gK+T61nJc/7sSgAM7RHSvQQvn/K9tZd6yx1w/JppTwfO3GgXQa6CNRXg5s2o7/1PWciwx2oRbSawgyz259Ri6yHswUrygFYf+Q/1Ck0XTpLIbTUsmNxHvxZSCSyKkmr+V1fYXWBtOcP/8qaUmuwUFcA8M+9J0VP2iCOFWVdOheBo+AlhroyCjHwfGm+8RKRcwKuyPlRIWjtTpVbTIgFEI3ZGdUaTGa6zJWsLpFQF4mmwBkF1mXmX+ZB1t0igKiJYbBB3r2E9vI85zuywBqkLkySiUI57+rzgaoJn5LfOU8jxVdBecoFKfCr7Zzm5RAsG0DL9UdeXaQhjMyn6bNhrJpCVaBQ2Txx2LvOAro5rz5iUhVD5L+Oe0kN62NSvj/rQOYjbtYUE2e1nPATjoHtp+ukImGDaRRDczGgtyv36r8fGURypfiuOKd5hNe079zU3ymZOEwyjwsF4j+Jfu2wooBYnqaZgQMJ0gzPWNlp6LO5gSEib/ZWtY1g5qJBEhLzVDsSp3psNWKRaezoa91ikQIUzV246XqjekoGxEJyOKU1PWlq/BONAR5/Ne/Wbe8u1t1DqKm5L01U7lAFJ/7P0hA5DA5i/EA2ZLXD2iqJ8E64s7GxO0MqaeJ6Oq3MxwWb7L7abPc1jKuGnP9f2KSGFrP4UsDlCyFPtzm6GabkzKaUVmkzhGYk9V133cSHc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199015)(8936002)(2906002)(66476007)(66556008)(66946007)(44832011)(41300700001)(5660300002)(8676002)(4326008)(36756003)(38100700002)(6512007)(6916009)(26005)(107886003)(186003)(6506007)(478600001)(6486002)(316002)(2616005)(83380400001)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akRSzEZO2YTlX4Mv4cX9b9MMbjOP9YEambUc3zYf+6RTjCmcZ0che75XPpco?=
 =?us-ascii?Q?e+XfBQfQ5fy2lTvDQO5X60QBpvRPFFDlOeVRhhvSlfrQBgbbJwqLGEAVAp2H?=
 =?us-ascii?Q?yuLfWgY4iAwXRR23zeZzzWTBSqSwQD0K6O1Al7WwiM8kheFRG9PlGXIEJjH/?=
 =?us-ascii?Q?rrldCqQzaF62FIjpFjGEiRZjrx/XrBEq+tbOcwRQyxM3PF+inCNyz98ujc8p?=
 =?us-ascii?Q?T/NJYOq+E3jGu+99QGdoELO4Cah3YhCr2zcZ9M2b7Nw89y8utePC5PhU2Ldt?=
 =?us-ascii?Q?JhAUw3nH2AVLrSueMIzc5+axbHZOj1q+xN+sfudD1dcIsMqLb+D5kTzawBai?=
 =?us-ascii?Q?imhynBSPiaIuiXS9VVBv6yf35FSMXD/r67GScQDXw8/kJzC8PbxQ6eKAKcsM?=
 =?us-ascii?Q?DfjtIBC06OS7+YeNSwqp43tm+URD7Ti2hrn+MFonxWq2OacU03GN8nC3pLC6?=
 =?us-ascii?Q?S32K2BpnoHg07xAaF13jb7LUOONShp+0+7YZ5mUveoqXTBLhmnOSSgz5rYYX?=
 =?us-ascii?Q?4bVg3TlnjHtIgoURmj5xBXTfZPLL0w4112J+T7Y6wEZtnd63TVN0KolZUEXa?=
 =?us-ascii?Q?kaIyl++rtYIas+6nufwaJhz44092I4TV+MEu6tCBN4o5WY/gnUxxdZCrkgHO?=
 =?us-ascii?Q?AQ2LCKb7O7m1jQLsQ8lW0j8R6foc3uql9XIqZ7L5aYkFXu0ZH779DvzwvxrJ?=
 =?us-ascii?Q?FIfvS4HqL1GV0XrMoNz66Z5s+L3UosnpJjwQhoSwZhbYwIfGNHk3/4xxIqbD?=
 =?us-ascii?Q?Kg5CiVEkGAoSQ9FqIY6yZgFLd4sF8yuY4/8f+4yHIVBRpEKcRUBMRG4PcNWg?=
 =?us-ascii?Q?hauH/YOPj+ACCSpEN5bMeTlqGYviwWQK63H6C4RkOWe0pAmVNFjW3ZpqpPJr?=
 =?us-ascii?Q?pqVHBgGSeue2cWYEIK7ZO9vV1DGGf17HvbqDgtqtpfx+krI/u19LHLSkSC0K?=
 =?us-ascii?Q?6rqU1VpEvU3YAroMeodJfAIHOwscJV+A4XKfxnQaF2WzfCa8JzuNV0NzzK2k?=
 =?us-ascii?Q?05QmyL4z+Y6uoRX1Te1DoQmgM2JosCq7EW3TARWVVs6Lh9Ic+7jRoqpLHgaZ?=
 =?us-ascii?Q?upsDL110aA58YgchRZUvHeyAJYzy3B0Kf6xxyulom/AhMRJHJpLkg46dVNwm?=
 =?us-ascii?Q?0ZWCv8vWntHfIFD4u1TxyUnYe8WjDhCJL0ygioJS7lJqORC10gSSKWDobtTY?=
 =?us-ascii?Q?OhOsY9FEFRa5MwRWKup5HI1zUQKmcDCYECGQdCcP/2TEiJobmavJMmxDQFP3?=
 =?us-ascii?Q?r5mFEmLebVg6cM50WokiH98IoEJTj+4RbvP33s47Ij6ctHVKQMoJpCZAxZfF?=
 =?us-ascii?Q?b4qKojdleicThd324QiIqPpcwP82uvf/SxsDaIqxf2n3U5wS0gsE7wyGD/dS?=
 =?us-ascii?Q?YlJB9I83lCOTJBGqZhR/WjF6iXV9pvm+2jTfdTsRJNEZx3I8ufUy0zQ7Nd9G?=
 =?us-ascii?Q?koexGxIy9WPK2QPLYphgflhBThsaCn8NAI7taVvqGietOTXi9RkgjeIF1JRJ?=
 =?us-ascii?Q?9bGKHgy96owbmyFLAZnomZzh5KUefcBfywPUTaiwXICgaJ+KdFilCFToG8bn?=
 =?us-ascii?Q?pkNsvoc3Vc+j2VvEmhiQIDY3Wjcef9dQYPJ/LiAy7VVgLO9iW4UgRa2L6IDl?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f0347f-2997-4191-dcbc-08daac0d928b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:52:32.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCRrx0UHiVmUWXQoHruoZOdKqnYvwYpk0ObfjwPPklZA5YfIs6Lixa2rJmPMxLHhC68PnibJE/tLwdF12u/hSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

