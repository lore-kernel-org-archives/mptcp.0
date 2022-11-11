Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23B652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeMLFIV2bA5hdxFMOkDQ9M/7wYznxBvpHIDwJToqnj6ehEhHSGAw+UpWMU/yEtAlPROzFgwPnJWf5uoK6bXteLN92vBE1wsjigNu6qMgMs9Hwd7NHid/HZhxkoF23AkIKwqwCHE4XAvDP5YjT1DunclYPy/fKTmJvPfCjDbImf5GANH6lnSbaRurl9G/ZyFloYcBT2TgzJ+mHi/RlHM7/RIkbyuE0ibJQLs2CVtrNeVkSNT272dQInV4dMk6v5K4Uf9NMXWRRLocm71MW9dTNn/83ifhKafULHY4CYH1Kl+8c6gUWhJT6C/vZeypHKx+UNCjyoVsFMwDtSv1XUe3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=ZCigGwpNize5yQHqu7506eQcfX2TnALlp+bNzLyvQEbTRgAReIH8t/LLfXt2rx5zKfmElP16nlvJJ/YOd158z4KeFQhmgFTxPnLuFDVCSJKvl2gMnhHiO66bc6L+hst+GsItm4nXiF5SZJCw4IuaijG4roPcmXkGtzvlhYpxWGi02B07Rd1SsqcuZ/TVJDNJ8+kj3GX9wCBYrsfv5sbe1dZOhvmDvbrbu+YJcsbQMBNOiOuWVtonVIk8/1M7aB0ci2zE0cPvB0uZQKimTPKAAhJBpprLJBxQToUhphCo3s+CfizKxqJLVmGbsh5Q6R+VXhS8MGgarxx1opqa4Qdgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=l63iqs3Kqc6aFlD9rorfAErMipsBsEe7YaZ3G4POoTey+YS/6y0mbURn8/r1yPXaD5g9Rtl0fgHEmLpNLOMJkYYE8G44OUyyuG8mLim6Y6kcoMMfvqYjOCcrJGuxpby9oRdRN5xqoXQ9psWV0IbtdHTTMEzPLENAjcKO16OJssRaGNJQZwdTkWvJpFVLz0Z8WeeanZbOb0zXrEL9koxaEmrLeF7x2/qguLdpOCRvby7PuLzVnOAqXSXT8SgcIcmUefpNcuAsVerc3cWjPR+g2ozEwSauSvzvBYe8OU/n5GMWX1k2am+TU6MkOrE8pe12tIWbSYgm0Iwk/0av8kbC+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 07:48:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 7/9] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Fri, 11 Nov 2022 15:48:02 +0800
Message-Id: <d2860f4996b9cc278a1929c803e98f9c5829d09d.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a79ce4e-4eb9-4bdc-90e2-08dac3b92d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aHriwd+cOTCGGinms1RLstelYkHCcwQT59EuE76hU8Lpcbqhm7CvWxdBb5ZqUNDj54k3Uz2xs8kd3ERzpPC1mG9eP/TtnWr+dAHMcCBlPaeddZfudfnvfVh8s1WtGhbeIXlO5qk+vnULNltcEBso9xh1LhKBpqQ2ATLnz3bJ3DN/3QIryQIgT8I5mLpqaMc/kggLZieBE95YCFwHTNzak9eUTSyN6CaU+YMbjNpvWayB9zrWxbAF1ywTagWGnSriGKcG9kFAS0G0ayQGOdpZE9cbJ/RrH/apDcrjTaGZ41PvqrA5VtqfVISeXI7fg/dQvJ8GUToZGmrqdVTaB1eDGKw4DpktEIjIF9T6TWmJSrHmGcGLNOaUhtE+qygkEczphbZ0htYIB1LHonzfn3OrVktZUKnDqsrSn4g1Y5LcPo7TVgxAE/5i2ha5LD8bxyMXWcKdQarKpHX1NJPCdx+ERgZqgbYoDNHcGpT9dgKWO9BeH7xPk9wZ0ZbdQYZOcXi3VytE8vUpyRYl3N/akpCB48ljQjM1XvmHWJ7rtFMNVRMEkwNdtU1ewDUB/Z3KE1/vlByeT0dvvtilT+N/LAB+nOAaHG+3opvz6B37ZzszwtSZ/OHWIs9izUuj8FIdycbbnyhKKvBNrjglWmLNVRegzOmmgbudaZpiEdJ/wsECAlCgyfJZfZ7lCOIje3e4Awxn7VUm03Td6EtWNiwZmcdRAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(86362001)(83380400001)(38100700002)(186003)(44832011)(4326008)(8936002)(6666004)(5660300002)(107886003)(478600001)(6512007)(66946007)(41300700001)(26005)(2616005)(66476007)(8676002)(6486002)(6506007)(316002)(6916009)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d+fqqtD56FhGJGQAXNQxw8FDw7QvR7vofWPfvhSlWjNxYY6uL2mN6c0xi4Uu?=
 =?us-ascii?Q?JapSCmCkHymcENr9uboyzzMAPJEYI2eqPWK1sujKEjJMMksvWhw0SafSIoLp?=
 =?us-ascii?Q?ts2VmeBLmuswOl5P5uf9WfxxQ0lsrttSjmPdY7yEnTlRxctl74JSGOVXjDUd?=
 =?us-ascii?Q?PEP1MoPkhi5nn9NEFuxuNDqXJj9BGvyQbiL7wjcgsRtXiIBTlaAMwUB+1p6F?=
 =?us-ascii?Q?jRz/wdx9w6dXCmBPLlihv76R/1qnqCG/Ni4DR2XSsaFIGQLdl5sPtEl2FsGB?=
 =?us-ascii?Q?MCyyhlyqK5febkSoK+Ih61AIBRInKQ1wVpzfb4dYZjBtqcj/it5Cx8y0hbJ9?=
 =?us-ascii?Q?PXWR6Rx1IrRg/5djFzglZAx18ucqi33DiXfqvzc/Rs2V50gGdy+4OAcQrPZd?=
 =?us-ascii?Q?RQTiofSzavcRzq/qv/gsI4w93gAtsy5eDK/+m2zkXAlR1oQpfec87ScHS4mJ?=
 =?us-ascii?Q?bEHns1lSGr2bLMf05X5lmKYVtHlK8ONO0IqWgYZ3wRj3wdQZA2LPFtxrwZxg?=
 =?us-ascii?Q?3fFVvrARadNzvB8iLsEsumTqDtVARd6izKslVPfPvmcIaJ6oheUr7mS5MQSi?=
 =?us-ascii?Q?GiUgwPC5dwpf7D0STVz/mbB7Wu84BLHJoF0e4B/kH/hKO3iQuLsYWlTMf+HC?=
 =?us-ascii?Q?S+hab07tlFLYnHwXrBowz090IYMVVSi1ro6PIfOMwEGzaHv+mV22LYowANki?=
 =?us-ascii?Q?mrcrgvoFpGpp1yri/HHtht0xWThXoD3Bgu8buhywEWsKFtnq95fsuhSPyUrL?=
 =?us-ascii?Q?9hXH6EGwK9KHDm9l8XHaH1EFlgxmVVw4Gni3+4EJH1hMb9h9DIc64AqMYsN8?=
 =?us-ascii?Q?EwhyQku1ln8523FF8tr6EkJDRlLnW653tDh4BvC4/X9OEoHPeTTIwkJWo8TG?=
 =?us-ascii?Q?Sblimkql6PoLJDWXm3khCY6LrCu4ZrHiulZvNuhVcI4d4dOm+xt4QkYDjdgi?=
 =?us-ascii?Q?2TmtBI+I1/qcI2m/KpxMaQZJBF1Bo6/h0CWBCyWXxGfvIC/fMIGetACRqakq?=
 =?us-ascii?Q?LsbS/jg606MwgttagRE2oUx4xa4fXT29xYhpTE2IiKLgyH5yUUy7ep5qPaRb?=
 =?us-ascii?Q?cnQWOzmiAON45TD8Kw9WfvZigBjrwSFMWAHR4o8Fx0eGFUYvkDA/HgU4Ok6B?=
 =?us-ascii?Q?yvVR2HjpkGRQOQOpv4s3AOuOldvc1LMi2gBXWLIVzMak2WfktqBiD63YcyiE?=
 =?us-ascii?Q?p4MTVRyOh3Zq+0tRCaK3Nlk29d2qOtJHVf3FxRoGDGb4vEQDpVlfOOi2uwqQ?=
 =?us-ascii?Q?tI8dv/RF4t/YKduNx35NkDsjL2jlAllZBF70RNMJL/2ckFa81s1NpIHUxojD?=
 =?us-ascii?Q?2lQ3hGY2CKDC7dmrN4Vr3TZ3sHEd89+9E1VRgORbbh/5v1fhbDon/Qu4/f1B?=
 =?us-ascii?Q?gPoLbvmjUfMAR9EW/fw5+n0ShrKhb4/V6MEyy+R35YOA3CX8pZxaw9ZtHiDI?=
 =?us-ascii?Q?Uw7ck+1znC/PEdImugWalJZSreI3tkC2DtXUugb+IflmJvH65yym2o8HZPAP?=
 =?us-ascii?Q?E3F6NKLQkoN50MrKxWsFaC1i7HlAWyWa0hUm1Vp1mYSO4DLDT90o1M+1YLlh?=
 =?us-ascii?Q?ZpM0ycqV4pEWS9Dh0rF13jPomKTeHMZdgf9IIGDZb43cCvc4yCBaKIS/uKcl?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79ce4e-4eb9-4bdc-90e2-08dac3b92d3a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:52.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S39elio04JC2lKX5BvsHvCfa+4EsP1TPOmDXKCyG5PTJHiMvjcwBP9ZIob2o+v/4UEeQT9xxvVhqXpE+JKvxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

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

