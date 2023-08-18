Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104F14F9D
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 07:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXUdq5PxwVZmimU5pxAF7JsqjtwRypvxjuVBqSd0Qq3b26En4nbQuRn1D21Ha4N7ELbnFKvW4LfqUGX4ZtKyR2ClQIRsnfgCMzFwGfS3lWmwn/c5M9kVELZCvjR37M60h0V2eh7Ry7htmPzJmmTtgS/w9mq19s6TAohVcbmyWu1OpkaaQz5D1qBZ3yA+MEh7XtHxruDzdZ0EtvVORPtRYCjNCoVQE/NDeLrHox6Z72GxgkhqsdfLv38mv5EhKZqPZ89ibCw10lK8A/9VoJWSoWeuF+togfx6c80DxhEtECLMMbDQP2wJ2JhJQtdCELYccTaDE9WG5iQ9hcIYvQS2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP2mzm+LwEP2i7GLiBfJseYI6hMlG/sHnVR55q1zVDs=;
 b=SpmbxvGaabR6Xwm+kGDaFmEy5BA4hCJcIRJhfOCi7CY/KhE0OECmXuSmNOQvPECihRjRBQWaFNq8abFo3rzy9ag6UEi32DFLzLPk5sxv9fzL/jvDTT31Wjha0xQbFsHSYqRkshhP9M1o1HOBKt4WtUsmTcHQttM4hlkV957/4tUBMf2VaZc2rsxH1ujrM/GTS6RHnyagHc1yMVKt+7yaYG5WrvZR9H+ZX+yEbrBAWt5ZqBgdTd/pzJRe9r5YEGDdZ9mkHGa8uBcwowEkqmNKclwIFtkepXR5sjCNPW2j5kadp8Nr2+iZh9NiYR5erfrOSkwenhyXVzVODM+3cTnfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP2mzm+LwEP2i7GLiBfJseYI6hMlG/sHnVR55q1zVDs=;
 b=zEYI32rLB7OCKKi4pHKZqbtEDUoT104s04ynLolqIFk+SfsYFHF3zxWufxV2nuNhCMUwd5H+1cRiqTYnPF9zmAKw1en0ef2IaySDaUSATu/9EDssr/K4rcWqpH+DM8vJ41SeQuLjr2arJQYxP+f0no95K6EJEdZytrCirQ8eBBpD37efxaBvaLMJZ+6fydSexOU4f1AteCg1z0dNImrM+zNZFy++LgXMwgng0xlyQLpoTFErZwGqw/PI/NmbXzI3TGPGpNAOvDVneXNAW6qg0xBeEfKeA6kOFJpclmaYg8jzIUt/xL3Y7EmOlq/YcqqDr/4fgqEIV8856G1NXHZ18g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 07:58:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 07:58:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Fri, 18 Aug 2023 15:58:29 +0800
Message-Id: <62a276db600b602203d6d65f375e7d2f421ccc93.1692344463.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692344463.git.geliang.tang@suse.com>
References: <cover.1692344463.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7af72d-b741-443b-5000-08db9fc0e3ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u98WKyPMlx4S4gYg1xJCRSNUYNoLHUIIXLT0bLyq09/wKlJrSrm3HFE/D04XanJ809rC5Y/Cy9ZqlskZ5z0wAmwbNcmESzQvqZKU+z3h936LJ/pqDLn2lHLozljtzBxj1ih5G/pmaGTzmwIFpDGlLOnWXpmi60Szx29kRrkwep7ROBKrqirhwGg3sYLbJ44Ds5EJS0b3yGzxMSsmcWCD/+nyQR6ExUdZUDMNznQb51piHTHus1dBS5TSMNbXRs6sck00REGYsnCKDwfsN6E3aJsIzXsZYj/IsmTs9dIE274zBWQfa0xQFgfH4kAe+AF/uuPzT45YrzRQnNBg7apP2H3oUMeQqlTzJR7bkhED5aUtrXWLWfgI2yhJe90Iv7vzUlnK4E3B8axSK6NQoBSsCliReHZlX6SRAyONE5/OQAYEEvFspvohjo2V7z37nnhf9d2Cmh+hjkVf2iNcjYoKCt5kWlwxAr06vsKRQ/MVhF0eYOkTek2JGG0duwRlqZaO/yStjxETetO9L9L8tWivknm1tjAhnLOAsF0yZO0IK40TFCmFyHhYnIYj/Sd9eAl8R3re6mo9Z1VpQhmOAJ8Wz79MHSRv8rAj/XeiJ3XlKAs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39850400004)(346002)(396003)(186009)(451199024)(1800799009)(2906002)(4744005)(83380400001)(26005)(86362001)(478600001)(6506007)(107886003)(6486002)(2616005)(6512007)(36756003)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hJYYxIc0svTWA4NbIMRt2CN/Dkv3qkoyS4k7/wPUiydBeaQgZCurjbsffnSk?=
 =?us-ascii?Q?YsHdEc24tzsEznsSzDPMqSxWJCZ8sQGEf9x2xOjtCaQf4Z7PTdVF+/c3Bg6J?=
 =?us-ascii?Q?GMFF8oqe1J4Ke36tBSfnZaMA/Xp5UTCmH9lXE1S/xFdTi2Bmfz2fxbM+bYV+?=
 =?us-ascii?Q?VSriJUIZnGV3uKKO1l5BA31aTtrmlQZPBbw9tdp2uRgpLxgOybqDtjUpO6wV?=
 =?us-ascii?Q?oV1isjfpZPXwGc/5Ty0WZqTDjt42fqnrK+DSB1iAfTrL/emwar/qthwss1Lm?=
 =?us-ascii?Q?YlXW+1l7B9OCgIjuf3hA8vLRP3LPvjWu6EDjio+dWjR2Z9KZWxUNez+7nJre?=
 =?us-ascii?Q?15H+KqHrqkE7F381l61nG9OlH+6qMZ5SyW1tJdeI1o0AooFx+0ePfJsBGtDp?=
 =?us-ascii?Q?llrZZ1EtpwhciNnU1rKB+Nw5qW2UdIR3C0sr/IY1azHZK40zpl1hfVN7IRRa?=
 =?us-ascii?Q?Oy8d17U9XKUqW3lf1dmB3bB2V8KPTZJ7yvwRCuG9STYzxPCUS65yW0R+ALSv?=
 =?us-ascii?Q?zOHGe00xNxNT7Azsvn0rxX//eA8Z0xWbVCLxqM0V9sDAC8u6l9psa9Bmk9A4?=
 =?us-ascii?Q?IJ1I4FRNCd/jIN8HmKBqDlCH31ypEnO1mHv9NbL7qBFtZqAJeagZtOqwC7Fr?=
 =?us-ascii?Q?OuhEdVNFQx1xCnFCbN2k6HftpY/NEmpvyYuDvle+jMmHo6CKFvfHLKOQcumH?=
 =?us-ascii?Q?Cm/Hh9/pHMfxlLisiFt1xsJ9WLis85omjVcHLKOyoLQmMvSN65hDVFoDpzoP?=
 =?us-ascii?Q?7zujCGGtrzSdtrZwwmA7qVIIRhF/W/x4293r23fBvVzje+GBMRf7ZRAHswx3?=
 =?us-ascii?Q?sbUBHGv/+0SMQgp7M0XNr6tuuGQdjyHoSfBkYcRAQa1TdWIoE52HZKqNRDzX?=
 =?us-ascii?Q?pcMcbWuEf9cS0Vj5OD0N9NktpfqL4HQzbuwz+vJe3JLLXaSw9LVSmXTM1nPF?=
 =?us-ascii?Q?jwcBPrzF6PT/+gn5ZAvWJDEfPMEEF40caWrr6VwJrz7tyRJqACgbY4GwCldy?=
 =?us-ascii?Q?tYWUY5v9L5J5WbCXxUgwJTSHevjvXumDhbFPP4hikxyg0KGz/T03X5+E1yGR?=
 =?us-ascii?Q?pXSu5RJgylVPs6oJ85oNkWt+ZfFVUFZzTIklBOp8MW4GATZ8MaNQY4NUuYJq?=
 =?us-ascii?Q?MTD4ixIyNPCENQpGUhQptzLJub+h0x6OOHlzCBuxWZ5S3Q7PP9H8i9wachYV?=
 =?us-ascii?Q?MRhv/Qrgo8UfqcWzV9cQGPoB52eAB3S7kzkZx8cVgz0PNZt/ZkG+V4oS6lCX?=
 =?us-ascii?Q?jGBzHE+QcRhjZUIdVP069AlU63OcKudcN+73IC/NTxYVWb6Cz7q0/3PnihdM?=
 =?us-ascii?Q?BcSnEO6k5W5HgcYTkHv/wtURKnorj6iUAiT332ambjNS/KBZryGVpr3rapb4?=
 =?us-ascii?Q?rurtcWrwEZxgGBb5T+7avVlsoKxEwXNGtEAVNfYtzfZScbGMkDNe9SAee1XJ?=
 =?us-ascii?Q?6O/YGwtYXFpUaEufuXVwhqSblQmpG8eqATClVZSg+IuQXXV7vDvjHbPfOrJO?=
 =?us-ascii?Q?7UPU/9nZ2e5/byoHDdeeI2Q2fBNIAv/a9BSqojQuOMwCq+rv+MoYBqlBvW7o?=
 =?us-ascii?Q?do4ls29Z1eQYsxYfqDCts/qOUWPtq487lbkOEUK2uINkjzHxb8e9XfTnWyV/?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7af72d-b741-443b-5000-08db9fc0e3ed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 07:58:21.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m6xqO6fzc7H7RvTktGfldg17PZavk7gjCuJlwGzQhHCdmepYbQCy1IWXxbypFtl6/CaxBli7srGFSv7tf2bkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

Return -1 when no subflow is selected.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 7e66ab839d14..904186fb6750 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -36,8 +36,10 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 		}
 	}
 
-	if (nr != -1)
+	if (nr != -1) {
 		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+		return -1;
+	}
 	return 0;
 }
 
-- 
2.35.3

