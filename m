Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140077.outbound.protection.outlook.com [40.107.14.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066077B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMEf0lkLIr9z9ZESoc9ojTDnw83ro9tvL/MhEnB2GQKkbUzFKYVQKl4Miu87Vu0pfWYLjBA3aWeqxshtNtdHtsSB5+jYAxWSQS4yz9hp9m3pAq8yAGPxd9hxf2S333YUFMSIj1PwGiK514L/dm/SbI98VP39ZwZJlSg0w/YhNxoz1nsY7hQnCLyZhZJyr3jqYB4+6pjKIL15bCBJo1dEEcRSYv43NkdsFmYDBXiKhi+mctmWax/DHPDwc3bHtuGOkBqkwzOjjNhJQPu0xSBCdiDInoYwfGCfT/cG3+J1sA2zeTqERICO5R/egRU913ju456FWllekIvPfg+QlJUnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=QIznLkWIHFT6klmEpUV0zlKOt14AgowKJz+y6yjWNTGEfNfwgMOQ2dSW8qrZ/jrXicdqRu/Aqyr4SELiKsv1LZjfZ4OWEoJGUh7wOLvX6ZSu0Zrz7Eh2KjGWh5w0eQcbDyD0skVo2G/9JaW42KMTY2KvJBb6OTvQC4ongXzERAlTCVArmwn5pOpQSpGvCGQXSreGItxVGt/A60GGL9oKZue5U+1df7YIgGY8TDnA9JpQ6Ezu03Tng6fvi5aFK353CPyER728VuxQm2X2tkrKqTULoEp5K8/VEImILfs4nKEHNb2tiBMDpbiCDjxu9xOmsagsDWXv7Y0w8kAjGpIkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=PBHemWUIM6mwwd/pxoNsoeyli36onGadwwrMMVp3h9T2Un9gSvJz/7zKfkRifee7mxvW+iphm5w25uK5IaC0tpFCA5r52coEmf1EYQHZHwwCSIk+Euv3hlyQ0py5hWoxJxXNeIzKxSzvpEJN5RzjprCpop5ViVFOhmLT3VywqzxW5Dj+/aWuNHipNBHe/9BlBiNT50yls3syavqmIo/MWvHDIyIJB8r9p9+8p3vFK5qMM7QiY5J2xkGhXioo6Qq/E5BadQYS6B0pJTuLxNe9FoU187by1FEx9y43jwuI8osHxdEBaKfjq0jKPrQdcEz4BhHgvphbkHb++8ybStYGiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 08/15] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Wed, 26 Oct 2022 16:04:17 +0800
Message-Id: <0590d6fba08eb2dab1c51d6def07ce1c5508feaf.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecf093c-e5b3-4e55-950b-08dab728ed17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KN57mMROhL9TVxhhkBQZQRV+Szx70ARcUkjMd1DpQUQz9/joRoD6ELrnDxcI1yO7GVo9bhWWgtj5drPlVKT90RV3nXQo2u7VBbgbbLEO6RvYw18f/llQKDKvaAxdKQU0zmYPIztCewJaPONh7cEWmA9jjTSfO3pZA+XjUAN+Fg123deqvIN7SiZR04ecveeSrFs82quvoyqS9YmkzRZtHStH0lOGfnNVB14MnrTKLIWLo5wXWMt/ko1BT2pHEeGacoldZpawznzyjw8K+/n56XMZNgvq3s5ErYnJbYuHjArPsI6MTUoEid7vE9e0SfKuFlpmD1ZBM6dY6boxlqsW7QUODxJblwuictwBj5encBobftKp+n9h3IgV9RYtuDgnobnY0oFqMuLX5iohPNU0u3XrOQt1RgblXThjEycMDYwA6A0BFCoTYk+gkXctoMU/1QYh5eiWkMbQywVuuq1shh5MLqbTKlZYKgPeHJBEu/hCef5XylIKvH0wAvWLZQ6yjpJN1CcHYHBWNmCp0SuR+WWhAPj8bKvpzTWXcH105glpTokGWjYzdl6uIUwFS6ngT0L5H6wc0r9A81NfriiVeJGMzDJTIauRyWIpar+ATly3zF2WFodTPSlf1BE0YIJemdZT7TYk1Wpb/vIwA+EfT2wJ/9qpAOmoCJsmJcvSlcDkEF4DMjFEYF7rBJctoKMc1wN0pFZGJYiiybaWES7LT3RBnhEiiU0oe3ShuE9q1s7MdAZDpJ2tGJl4cxyEP/cF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(6666004)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nbaEMLupb/uMo7zZ1hFWfIZ/oSUyqbiZRrCQUSI3zPcVjNFeL1sDtJ1Kftgc?=
 =?us-ascii?Q?0kJhN5OU1jBkvxgvr+UKSROyfm8oep2bg8Nu7VC2dABZd/r9g/xlfF89g7HQ?=
 =?us-ascii?Q?YiVpFoTKZBJ6BOlVSQSmqwhoAV8+klvMwi8KgLSLbLIvEPs9nGeCUaVPyf/a?=
 =?us-ascii?Q?4CBrs52YapBwhex0s1r0x2hrjibVxQWlOtgBKJDu0krmu6xReXv9+F9CdUVY?=
 =?us-ascii?Q?MshTk2mHEMUw9bHbhgCtk8A+N2hZhoDHu5R3ISy0kbeZGZm3a97cf32eUA81?=
 =?us-ascii?Q?DYNgECHEgi3XYIafZIDJjrzoFPRAHz2z3Z3S5YsYGmOHEe25YblInzZrU3km?=
 =?us-ascii?Q?LjXynh0yuSxPWmylyiIikOyfeK3uQkgHGReDb5W1VdJnP1bkaRHwQ23CnQq3?=
 =?us-ascii?Q?4qyvcP30kktupdxXG3b6D4L17EOBX5zUfoDy0x2anBwdv60mG5PaiLnjXeTw?=
 =?us-ascii?Q?Uw8krcEhxdeNNrt5AG6O6W1nVYMDFm4X6PPT45f2OwDi7pPXC6Hs5eq7b3x1?=
 =?us-ascii?Q?Oic7zJ5b7rfP6HJrv5XyrwWgp2zrXANE9IHM0HqKmBX1PwzjB0k3L7EbmqAt?=
 =?us-ascii?Q?Ocfyi4V58rMW1E8QvYlDrxQIiASYpw9LtRv1afeSNObt7BLVb1uVC40BEBmV?=
 =?us-ascii?Q?Vg+9G4uyC6SPF0zPp1Mi2IHDr7WxyH0JL60ekmn16vfOrBd9Sz5six6IHxPh?=
 =?us-ascii?Q?prZX2TUWbA0+zYlvFdtmqKvwBtpQDWeK1LBRVRuTnmAu+pKzxmeIiN/rE95P?=
 =?us-ascii?Q?MJdpPQFaPpkuf10WSL7HCFz/2JY2rPik3YJ5D4krYa0EBJpmNEN+gHAE35cV?=
 =?us-ascii?Q?WLTUHdoJBtkdq9uuv5vvGShrbVLohvprWIrWToxCIAqWsvQkyi2p704aIVCc?=
 =?us-ascii?Q?NE0qfyW6tAvb2n5Jv95IKpXsZXoxtsKiexTm8WXHMSRU5Z9u51ls2Dbep4ZJ?=
 =?us-ascii?Q?UFcqQbDDq3mCZLC7wo7D94RIvgu6wYuxQrRF+TmcSrjpg0/e5JDlP1vYsw/p?=
 =?us-ascii?Q?+q8Grdo8b/D9rXeUMpzalUtf9FbTBQPNQOy3Sjf1fPcEVmeSMrZkNanMtqzk?=
 =?us-ascii?Q?Xq+QF3tzEjlUIEYCxv+YDUqK5JeVnleJVyITFe2nUkagYV2BpBl1bOHoYkdf?=
 =?us-ascii?Q?fJ2gE1/g43VY5ebOEey6yF+Skais3OCjMfRZwMnwBikL+86634m4QkQ2Fc3A?=
 =?us-ascii?Q?u/0LmilTo7mQYHfJT9ragzAvnfKB9F0t3ifi12r0EWRqfL+lq1MTvuYj/2FM?=
 =?us-ascii?Q?SihX3X5iFh6RlsA4s+5tfEKHqC6uEFwYYS4vokhEelZaVYOMw8hBUOFYk28G?=
 =?us-ascii?Q?Xup/A3mK237eTPDkCm8PTvHDfmEcWXsI0tw+kntqiNWhrTqQAK4lvH8w72X+?=
 =?us-ascii?Q?YXSEOq8nsO3f8jFs/NK5Vm7wahkoLY9b0ThM71CoZkHZLoEFK3YRtIj7B9GY?=
 =?us-ascii?Q?BfHOZ3tJFMhbPjWndH5q4YPb69PzvrjGh/E5J6+8Bl5Eq/TA7/gCsEZ8a9DD?=
 =?us-ascii?Q?r8YXS6q67b29lxRVnbcZbIM5kU/p99s7EyBCzZWVKVGp4Uo5AY+/wK5ByspD?=
 =?us-ascii?Q?R1J8TwyN9jHs7oTCQg/CuTZ24kAW2O09V5PZL/RB?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecf093c-e5b3-4e55-950b-08dab728ed17
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:03.2854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCEyVjjvK1ZXTX/9H2bXJgxjXtHAAEV4nlteIufLYP06aQ/VNQPryeVtbYT4syawB7DRFubNmquustoSgkcvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

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

