Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBA468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdsbxOLUCMj5M973Af6nO0C8Bt6DEJjp70FA76+MhEkompnBLFcia/ChdKMOB6kc1uIwJlpjcnWzbF73xAOw4KSdDMcPfp3RH+/ajv7W+McPVTtDembqRTi27Y9y2eRxf19PddTXCsfdOS3Xq8OpPqBvC29+jqlqiDvBunJDRSD9M5fKMO+RJfQ9vNuDI/42SQvKET6VnoUqy4BPjjHEYECK0eIqokDr3BdK2H5nEUNNJqHVQZIx6ADZIQQ3IAIK1fKeSLYYDkjj4Kh/tGSeYwa96dUTi7pwnEoPVBl0jRaAuyeBidPh9yAQTSka5FaloFA4fxzEulylHGzk9OSyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=naILf0S5w3gl0HKY4QnrVMWWrQXTgqCVm6o20CyMzgq3deJqAsgfQ5hdUbyJun2Jdxr/zJz4Ih1+ArNpc4MjfS11CeFoUMOBBoFOp2PontzweVtS7vPnnvQHXTFtxwzk2iZo7uOrtSmaoiQzQzE+SsgtFYStTmrrHyXEbwL9M2I9PvPPCpCTSBhkFYmHueiyj9jXiCR4BLHLxLK9q5bF2DzFNny6d4ufGkurPrr0NggdgNbTww85Z0t2YefvXtQUXoazV+iiNwnP45GUDTQcBM4iCvVL8ZCBuh9GCb25GResg9UMU3EhlvsrzG+fVacc1aW51zuVbz9dbD4RjrHDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=1vM/y39f8QMjdxwz2aaA5FHHRceQmm4kjgJSGIJKdO7ne3J07JXylB6tjSd4Tc/1hS5fCoej0jve3I1mmfYu3YVIU+COC3H9pY+eBafgFZe0si1PgIydGg1vyoUtg+mcmI6BqZ35yX8aEr/KJoBTT2/h9znLI7/Rcgd2VqBvdly91q3WWpqQKi7fKTS/vO2mUhYym6s7l0TydM5z32s8noAhQ6MkaVQTkupiJ4SuWU1K9UQA/BmMxxosDocmsBchpcmX85+R++onsS3sKrWSPpvQ/g9AbCZ21DCAkXTTuzGrVkNPURxisTzUWrV3RvqXaPnFWq3JgC0UTplBGEmxaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:03:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:03:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/10] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Fri,  7 Oct 2022 23:02:34 +0800
Message-Id: <e6c71d50bc421d6ea91fcdad888c6644cc43479e.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ba7012-b428-4b29-ea72-08daa87506b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hm2xfYpYQglaS0s9BUFkeE/njMFuRnxiU844yMzfKjMGek0Hj7L621jbK2NObd1fWSoXnCSs55xWZFR4EEopTaJSyPGlR4L6vdoHb3z+vl7KUtdKuWRLniTkGMWpWNABO/pBDS1EnEsmpKQ9/X+34x/iUiM0224dpawdsQtkbYmCTqET8FlB9rgwlq1THhMrCEKB3c3Q0Q7ai+ZMtuFN+8nRczlsXusbUEs5uJiDbyZvNWyOFJYNza/Slc/kVpRi9e16wYEgK+R9ElErx4XMxsRS0q9QQKOmSmBKxl97wVZ6VWW7Z8Ww6Ubjupjs9ZiwJ3XjC9GLMO/H+CYdwOSfkj3pi3e1fxV6P7IvZ2mOs+BLxVSolbLosAXzMdu8xXBv+01aeLZOFbTUNF61PGH8gINbJZPlTI7goZiRxFpP09bSPZ96lMbz9j3mWJZQ8JymvnW4SutN2nduJfEJHkZl8OgnA2B/SROG+x973ivhKoiW7eDPpVcaFfjyfOkdueOz9ZfCCIFXKehxY/ZTbb+kbYOKZMCmkYg1DIdaKbNkhKRiYdQMCMw2dzOJJCoi1+S8iRHRgQKAFm1QShF/hmBQ5MR1n/9E63wE4kfzJcBCkAOy0qx/2xP3UE5Yc71TOjtKGhyiusD4XBYsVtgxqGk7EK2kL23kDcM9isUsFuyTNfMsNdKd0dIgiIdeNdFhNLfPUy1Sd/URgbUhoIC9id6/rzfPlwRCkFAnsU5gt0Uxsh/XRLBAxqCNHUS7owWEHp9e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(36756003)(66476007)(66556008)(66946007)(478600001)(6512007)(44832011)(2906002)(26005)(41300700001)(8676002)(4326008)(86362001)(5660300002)(38100700002)(8936002)(316002)(83380400001)(6916009)(6486002)(6666004)(186003)(107886003)(2616005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8m0vdPsDq5TjtSA1K62vgfFUEv26JbQc3UyDvU407Z3dsMgcwGKLnJID53t?=
 =?us-ascii?Q?+Sk0xYXQJiNQbcHJU/ITA+pdSWYHkF2OQZU1G5LYiZMsRkBZ1AyVAR4AS1HO?=
 =?us-ascii?Q?5a0Q9LghJwEO84g4H9fCy0+HuofNcKpZsSK8baNWkjdfiJcxjIWTE7cKyJDQ?=
 =?us-ascii?Q?U4pnqz8G34Xw6ycNbzd/4EKR97dTTYnep1LlR88ywKTuoEkO+oarrICcwU4d?=
 =?us-ascii?Q?GGu+xwAnOX/CCu37gI2X3nBrGq8J2bt7iUTF5W9doyUkXV/Jr2DUdtcc8ksq?=
 =?us-ascii?Q?wcw+Y/+im1Ynb2Ywl22u/RhZtJZumKUIUNI7hC6DPaY58bXVrrySIzamwMwu?=
 =?us-ascii?Q?X/5cBpevUIzgoNC4zk0BV3C3C5SQoerk/sK4TGwM5f7Em86oYDzcrtUxxHfH?=
 =?us-ascii?Q?J1Q4tdvPYMpaZaGMANyyx6f/Kejw62HlBdnXCIIhcWAzx941t3cbzVKJywBI?=
 =?us-ascii?Q?iHrGlWhMOad6lnXlQB8v2mQOYhYnxlqkiBK0olLnMlSo+KWQFJ8rtNv25mdw?=
 =?us-ascii?Q?baw3T7hqPWEkKn/ZaiK1gxj+BYw3RG2nUY5r1fGm4FuDlEaIR/zCRI9wvKbE?=
 =?us-ascii?Q?3pLY9pJZHx0Gvx8pq+gGFJkNeZlCd6WzRCiHQPNaGmgkB1z3bZhTce7MYRJd?=
 =?us-ascii?Q?9gBUFemNqkrxIZwzUslqH2Hn0HZ0h0fwEoRtyzDwgA+I+3wN73WDWs4XGF7n?=
 =?us-ascii?Q?JZc0AKfTSu8pa3PHQclxCnHIq2uCmc8KgyB7wTixCcXkPpjJPJI8N0Lkb5wI?=
 =?us-ascii?Q?DL1GCxJkhvbjTdFF054/WPfZblKs6NX7NMPb2WM9AxOqy9IB+dG7HmTA34jT?=
 =?us-ascii?Q?5Xwjk+oNRlvHZsJt7ndSGStA3DAV1SbqzEo1iqQrhFxVjByHafMzUPAmvHUK?=
 =?us-ascii?Q?Nte2umklTFh5zOiXJNbT4sxpBhNoH1qfuINDetimd5GCUIOgUGhcO91id7zn?=
 =?us-ascii?Q?Ll4+qJY0wBQGUh/HuKRwYZp74sT2v/JHYpGc1KbUsMp1+fa38z7MkMunU1Tm?=
 =?us-ascii?Q?QvekRI3TE24+oUvSVD/ci9OHmGKrZ7GY17214GXi3oXRRu6wXZjdwtZ6fMGg?=
 =?us-ascii?Q?hhuT9kkW6EOpoMsw/9+IOW8evM4SrYd/lMhnc0DBibzHTPQqkP4czBoepIUt?=
 =?us-ascii?Q?dfx05dM37KFkH4UtorSOTbfmgjShAeZAobFMb+Pix4AS8cGlILnVQQy8tcBU?=
 =?us-ascii?Q?lmq8To7TzlWo9K2dfkujB5rYk9BQP33afXBWO9P4vAl+GGUCynJw3k2aTkWX?=
 =?us-ascii?Q?B8LcmHDUw7UIWbSueK4SYdZKkJyR8aZW9xLNUAViivPqQvJ5iFpv/p1j0Lnb?=
 =?us-ascii?Q?GqZfejUjpi8wBqv8XWCiu1lAcoykR3LDFMB0psRdbRYwdr4ClbQbdiMk9NxN?=
 =?us-ascii?Q?51t1vjJTdj6gnsy+LpXGzD6uvwmPVE5jMCgRXg5dKtUyxgUZ4vhEkB12sh8f?=
 =?us-ascii?Q?n5enBo8959UY7UP6QpoPev7Sn3nj2BEzS1GnLxGsaTV+sSejKhWO1M1sOSJh?=
 =?us-ascii?Q?5PYVt/iOQhS5YKp3gm67Ep4AwuZW0744ZKHtgEbCYHJQjV0X1gm4Fd/fG9ys?=
 =?us-ascii?Q?mnyj43+CQlDzH/JmCELtxeloy1bUkwPEfA6owNwnfAUAQrwvAO56xbd5wPJW?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ba7012-b428-4b29-ea72-08daa87506b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:03:00.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksk2LLRvG+ylMCT9GO7fr6wryokpW8qf6MT7Ym3VzTa9V7OFrvFC4AaFLlAWWUEvD9O7BTKyMByoJN0NoC3ZSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..e101428e5906 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

