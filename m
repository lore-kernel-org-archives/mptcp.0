Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D320F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCuiNYnlWX84NCjMIS98aidtwmcVO12lBcyBGNWnZ8OmUU2Uru7K2KTSBWQDqrYQyOHSWeVmACoGdJ+/roDW9mLH1Mw7vEN7ljR/xVg8Mpw2YQBTujQCyD2iKwU7rDceL4LC7FNHPiy44uh9EQjQ79kN33Rd/x4C/tJr1ttFTdr++KbqhkJVo3gCBC+1aP9k1CZxTDQ8zavlRTKBnspILZ64S4/DJQIkgy98Wp9gedg06t6U6pQwDMTQq9QbkPaBHABZQku9zO2IF2qE8dJaTofQEtWJYs7kQ9zxN5d7XxjAxo3bYHYJ/tawWLojzIj1re5vZMOI4IHZQG9hdpH9oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=NyGSBS3uVHoZhG6fP5uGuT7VtmAQkR4Weac4u4v2gUToM0KM0+66CaDyjpVs5yPlxtVPFkGYMo0V1B2rq5aHtiOKJQLkurEgGrCpWD1RsdUvCVTwATwpJ0VuSWr+UHEAbvIYu5Ke/ZM+HyPeuymzwFFAYOpxbewVl56kZkSMC+UrJpJjeOzuo/WcMZGy1ZgnGKdWFC1doirdfcMs0EeBORZD2OpUHEVoahNlRBJgigwPVW7a4V3egvbUGqZX1SMYMG9/AJ9vndLdvd8EpKFptySNVRSQkH2oIj48AdlDAK2SQ+8TC0cqmlg0Xq0VQYl1oeZyoddGG9IF8wLoGKErBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=gva+bBk7dhNeekjHd/JpCmiq4zbDpc3jXZgNIbWpIxoaSVnaDjz8iAlx0vMyLR/bAraOpS+1Xj47ZrGY/jEaCnugz+yEmnTd4zpynVKVpcGszIhUcOjC4Fcd7bYDRZC2+TR6hM3Sc7tTsF5UM64+5E6hudQlrub4Mi7jmPoOUt2YwlQx3ZoOL+tQeIMxFCCNE4lC71nfCaYslMtpBZH6W1luZwkvlLP0K9zTEgpEeEQWE1PSDXiGS7y6ILFSMeshB1sufvdUJ1hHPXnrzetsBxVFiAM0Az09cVzY3EwopLMw3kQQ+Kp4DpQ5uP87bBZowAEgy82C6pWbIhvK4ofHzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 13:34:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:34:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 13/15] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Fri, 14 Oct 2022 21:32:20 +0800
Message-Id: <74112bf0ecb5e8a83985e6d38d52f158cc9a893e.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1909381e-e2ab-4451-48ec-08daade8ded0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+JQjIfwZ5+gekIry0PglYgp5tF83lZQlo+1+j4EqDx9tmBwStldzq0oyReEP4HPwFlleNzhXNdtAscgULNXSsfseU06nyqC+Pa0ad6v9GWFCKdX0s1rRygrsTQ+2zoaAqVzoU1m0TXuBQNmlqiGNgHGxfdDdwwlb2lXoF7V+VWH5xrfYoiphDjIPcLvb9nyFm/LOoHDC2myKe0F/D0IYIj6fSnCBvE+FFCHrVSTOiAZlbT0C/hu42gexAU+jM3D2vLTamHjZAmG8OTVgg9+jnkIO1u+622NlXH8Am33+YpUnomj2Diu0jujCA+OxmoTEFFG27VHefhiH82jU6x8k4AxKD0NMpEdBX1fHUQppxElXw8YCjn7QcHHw26Fix2aRGIvlWIgarTy2HwxGo6rd7AGNAJjBplTBAzeLxUtxdpte5x38gItYO3qWouWLnzE+06UsYe+FjWw/qIU5QTduTWDKe2/FLBE+Sukw2OH8ofYQnstCG4+1h+48ayTj6KvR4PNuL13QNNWJjv+jf4b52nxk6xh98EtnkkSWH8CyVCgsEnymTZmqhTTLNYr8ZnlidSYAK2ipiI+ci0y3KK/Y0j/KxPH4clybBegjHF7UEMUwcbgj9CjEPtN4ZoL080Ady8S6HkXbosR0EAFIUMVEZ7uR5XrOlRr3qjfoviifV5ron3cGgRkfPP5WgXaFEW13NN4g9bibBKvdN5gYSurFXvcmVlVhffAzt80r9mlbxWBomB9dc8M8gksBQh2Teyss
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(6486002)(36756003)(2906002)(83380400001)(6916009)(316002)(6666004)(38100700002)(41300700001)(6506007)(186003)(8936002)(107886003)(26005)(5660300002)(2616005)(478600001)(44832011)(6512007)(66476007)(66556008)(66946007)(8676002)(86362001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fh1iicUtF9aXX3sF6Ivbhzhzytt1ALqGbbLbkWq2LRlx4FAySq7jg94QjQRK?=
 =?us-ascii?Q?eig8RPo17GnpuVyTIOXcd4aqpitKc+V/ivgOJYKU587rlgmvsNl88i51wz36?=
 =?us-ascii?Q?YmVYi1yc4i78+ZWYiH3yhS66Njv9eRjh9cwr1XnpGanQegxwso3I7g7K8/bp?=
 =?us-ascii?Q?cmFHjZGEWPLSRpaFLPPGLQFJmkJAnNvvhCzcSu6x+DzUVC3WmU75Oba+5Nho?=
 =?us-ascii?Q?B1pTaP8c6V7q2Dp5/fpAkHXJ10OYt8FmvtVWM4buRsRfYq+AADPM5rfeV2XA?=
 =?us-ascii?Q?j2W02C1/zPcXfAlB3vXzsSzUs5+y/XGkTPdW2JdvxLx7X0ime6mOUk9XHlmE?=
 =?us-ascii?Q?vVs6UNB7DnZ7JWeiO4O1JUHaatLhKobhey7AbYpycvnEiuYPdHXHdD5SwLGI?=
 =?us-ascii?Q?zMsNm6gJ9zU37Bohw18Cn+3w6RMnj1PP0rL1eNyo6u+blsVdC7RG1+O21hWT?=
 =?us-ascii?Q?hQMmrM0MH5ePhfxopawsAWqusoo0uI5P5hqQLkCHUrOKSdE7EmVVKuGbY1ew?=
 =?us-ascii?Q?OjYWzF+QpVuD69H36yOTvXbuVrTbu/xidbTYBBB8LoRwsKBJbAXjR4WKSkfk?=
 =?us-ascii?Q?ahczDv+S2j3cyHPq2bCakDmaplmpyqdc/+kT/Ti+59432cBJXMuumuufpgLy?=
 =?us-ascii?Q?seE45r5zaAg8D2O/KmFAffnre30vyw4Bi7dUOscahDH/1nEuwQACt3COj5eW?=
 =?us-ascii?Q?EaJWAxj6J1xSJZ4WHp5SlwJI1b8KUvbQDaseQ8wlTKa1TGHzLrX39uUPZenL?=
 =?us-ascii?Q?A334ZtiT9+oIVepXnXS0v2xm9lPjqTNWtXeaYNbE/8Zcu15zLbOG8nl3ey2y?=
 =?us-ascii?Q?3bTnqGcokcrra82XO+UTWZQR42uk+BarSgA+JVdPGejRzCmh61YUgzyTyPSY?=
 =?us-ascii?Q?Vi6D5QG0HLIXTEx45JtdieSO5cuTAHltsZnkCKqTlSVgjNQfdoS+rqR8GY8T?=
 =?us-ascii?Q?v4thaWlAR7znVKmNJQoVlqxznhKc6b7MUEqt2Qs+trJ1xrr7YD4Xn4gwFemt?=
 =?us-ascii?Q?TGipB3hRpWC2OFr/3qCB3A0jxWwoelJQMqMHowotpDYHHmQ+9gPnr9GnbBnX?=
 =?us-ascii?Q?eEw1JqdTzTw44syKxJeE5/Ecg9ai8kyy/dncwExL2z4oxmRxwoAV5nYNVMwN?=
 =?us-ascii?Q?MCE/SKforXDJfsCEKvbKek5HMZ6O17U8ExgCxZhAzT5ac4E2/L/xjmXie+0O?=
 =?us-ascii?Q?XgEXZ+nk8zbmdTQKfKjUbvGMSY7VBvhL+8YtCn1lggc+AXtY8gZGUeA/DYdu?=
 =?us-ascii?Q?cLoLNYc41yQWGz83AwKQxJ7GO37RpGGQOl01bXH1UweqL4m6dt6ogWhnjUut?=
 =?us-ascii?Q?8uo9cVP34eP94yvYpKqvGYhoQigREZ3p44ndHuJUXDnYTCbOkKDlDLmXCj00?=
 =?us-ascii?Q?JxcZmviPTbZWx1IC4LPvISRmIAnW46D2OI0Wd0jj8k6QFqGBR0nD7DlyBDQL?=
 =?us-ascii?Q?YK7wGZB9Suy6LfGAzVRa0cj5Jgyya2lXTv4mvq6j2ACoqfnGViCzTwV/vw3N?=
 =?us-ascii?Q?y8Sr1HP3ROnPiigh2BgDFVxJdSEjIyzWg0nlf1udZR63a45L4CDLaFRVP1z/?=
 =?us-ascii?Q?rADLDeC/jKnKSW8+Xm8/i/vMkHUHDzktOUJ2WKsfuHsnf9KnU5/H/vfp/TJx?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1909381e-e2ab-4451-48ec-08daade8ded0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:34:50.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uL74BuCkam7+KSpisMza+2wccuiw8izMCugRt8RwJEv6ajCnGJ739m0P9RwwfKIaohFV7TaIw/o5sQmVe5uH7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

