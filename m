Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99E33EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fm1r721nxfCF8+afqXZ2ArDVyQ23zSMd+A8In4W7HzBchMviYSk3rbThURZAR/XtG/bqjYWJZvLpGapEGNZ0Og0EcZMh/4QGSIlV0PNsevS++N2owuD7xAWFJh43pP3kdwIw3hKjdBN9R1cihrRl+jRD9xYBrsqe/PApkwxFyb+cuqJT/JMzfqAizPCv8/lQ2qFuIPOBj2woEPUCm3v67KtmOKiLAiH7cfjcUZOR51+9P7Rze62PPPH1XsK9Cntogq4JPjZ8k1P1O8egkM7QmdaOc2wUF9BZ/8e1p7h2juCIO1sv7vgV+WBf6HwHbUmjF4Ua7IM7kWNluK2/2O92+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=RK22zwD6//ALvvosmrdkO44Lpu8xgAGtf/IAc3Ml99uJM8+h16duBfs+iNSkoPb5ftaLULVW9KZBm9ZiD2fk3z6BA5t1GfscoHhSe8OXaVvo+j4N26peb6BbnD3m0+TBnZ73L7ORFfG6Q7Iz0YwZGv0xwInJ9xHmlwcFlPu3vOO2nIxxKjod1fGLpg48gcFmUREOhpw48JWxFbWGRCh3ECpMfvtKvCubsuHylaUK2rXqm1aiLKBvZgoMgi76EdgbUFTqmReG9XM+S9ByOlG/bMUqssFXn/ZJu5MlkG78bQ4DcDHIRPGPqfSNxqNmjwB/OGOHWQLtstHDX8jKgJFAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SpylYRiXp0P4k3XioNA01AuM9ZHejqqclsSfyCQrL0=;
 b=hvQeuNZZ5VbADSVWdd6Bmc3AU25cViSHptlV0Bz8SMs4vADtGbfOpWeYYNzBR2/pHuERbNTJSi6wMYm4cMVI7Ho16dpJER36q+bN/8k9ggewzOkKwD+/uHRxTXI7QCuON/AJI8Hhv9XpQ086bJ+G0NiKQXnbcvyNkRCNZtNA8ydDUCg6EqA5ECaskVXpZmvsQbQ9fCz6xT31RVfzHNdjZKmu8/+/KCo/UucF9Qe5382XUejrDfuFq5t8+Ipna/TJRRrLR55yk8huAzYmLZ3J+Y5xlpQC3dhz56ov4FCbikRh3QUYIjr3nx+j04919+b8rYD3NrrL8Z5WwUnxND8p5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:26:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 4/5] selftests/bpf: Add bpf_red scheduler
Date: Tue, 27 Sep 2022 23:27:03 +0800
Message-Id: <0a3ea8773690abc47189588b3f638aa0f32ad7c4.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::25)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 81515893-4ace-4334-da9d-08daa09cb238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DikIE+83VR7paOUfZnA/Uf+yvzna+NOr2N5GZGx8RtijudyAulsRSkUGO44Tawi3nVl3BV6wHOnmfRWT16KFuX5sNKWUQTPjh7ViiTsBBMFr51Rn9LQQREmOEeJwcPB//ZH7t61r0zDtIPrCYbADVhAajO0rn9qwIW3w4l9y79DuYCHb/FOTDxJY0tRm8rtlMRHZ+Bkfh0QbbEXKWua+6f7ayFNWxMITnZo4WbPuIXROWGW/5+ANO2cNznW8O6WZEppU1CNo48l43NfbV3crzWVtlTgERdGgjRZoXh/hVtQ9ZuX2UjuAKJV0Mz8vxjIXt0TOGPNDAdMJl809LI0Z4pTqCRnDCQveic8KNcfXFLdUDR7eVqkk4mVMUa8F7MMNiOM3XdPkm9JOUufpv/5OQaB1pNuOly0XldF6pBi9FAUfISFqnXwgPQrBJKBSbzsNyBGf+mfKUCd2GX9+ucAvUhIxhQIKOFfw0eO09Boqe6fcwn3SG7loFMuJtbIE96oTP7cp9fTpfii5yyhQjY1hLSLRdD6WBR2swx6FFxSKJYoOdC1fQPpJ5bluOKEuANp2aE8K8Kf0KyS461vmuauQ1PWVALhuvQarJpzmkRYactRYbv5QYb4Q3EDdbkYsYNz2abBzu428UDbDh/1h/o+Ehk+knyz0g5McdArB4piqlAM1pbjvF29mXJ07Pa/HIB9cIGFn3K3UBUaGCos4myfTZKlOtuYwN9f+BvWaoMhZeSjvDCaU5NUeqaX4nRdu9E/l
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(38100700002)(6486002)(6666004)(107886003)(6506007)(316002)(66946007)(66476007)(66556008)(4326008)(8676002)(86362001)(26005)(2906002)(6512007)(44832011)(478600001)(41300700001)(36756003)(186003)(6916009)(2616005)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TKihG4Y/F6eWsEIlU7UfuKvytZHmyVXYsSee0J2BscJ9SS6skBx+137ao1az?=
 =?us-ascii?Q?VCcn2qbo7zVWLM5PzZZjNu9z8HeFeIIIjOAm35pBUMrvqTeJ/KsH8cE/URVf?=
 =?us-ascii?Q?+r45xG7JlKXLiSEiY8X2IYOswAJkIym4fHgW1qVMoc/4TWfUgCFQHvARFHFp?=
 =?us-ascii?Q?YGTRq/bnQRi2br1k0mDigRatacqiygsVWTgOvI8UyPapxybvxQfpjiMZe4Nh?=
 =?us-ascii?Q?WSQ1s8MG11nDu4tbXoavVmNgk4lZD4uezQpB8WJ6Xyo1Gv2a2Yqrt0p9+Iyt?=
 =?us-ascii?Q?5BEqmdErC8NPnHxxPnGHvTJJrzcNLMotUSKNK+v9anXDAvndWyMv1xX8w3hK?=
 =?us-ascii?Q?w8ivyNMjBmPgRo1zn/yb90W1tgn+04gCAL7zofs2azPUjUjPN/EnjlFL7sjZ?=
 =?us-ascii?Q?GXCelXmKj/Ixl2HlZrOTuoK/AK1r9ACZV3WvmiKuiazTOBlZzwwkV91ojHTT?=
 =?us-ascii?Q?0t/L/9oaoVxiiCN4GtuZZCjwVRcKtUdwYI0EPHyKF+YrHhe92Lia1awvXDKj?=
 =?us-ascii?Q?6bxGvQnYxKpEezetmKCHrBqdVLdNQW1BbDUiFgL/gkpTZyMKQWOv9u48MG3S?=
 =?us-ascii?Q?Bf8NFQGLnKqptwQAxHfTMTBCA3TjWnSv5ZmFkDOZ1ODWVIg/0YdII3PsHmyL?=
 =?us-ascii?Q?Fzr6wTedj0f2klwHe8bc16qo+JmCmMG7lKy/+DGL1wP98eil1xl2MbtnLUOF?=
 =?us-ascii?Q?SvjbP009gHkY8ZIcdpF6D6lcQAsBTijL8rs12fsx4Tq5BC+PJrEGnkDpWqK5?=
 =?us-ascii?Q?M7MhEMTt2qZ2/mfKVgZ44XRFub8lJEEQbNNkIh3MksceRJvizJn7kjl3uwz6?=
 =?us-ascii?Q?15TQxceAusjI0W7cdrjZgfWRx3qHNEi/axFpbXalnjw4RyyRFHXV5ix6uemU?=
 =?us-ascii?Q?WFpRu4EkyzYvMWlHo7bYNxhlzv6NeyJJ5D/uGdZlVDoociAbOWPWqH+t6Or1?=
 =?us-ascii?Q?l4xm/Q1kWJX0EpHn/oCf3CLoRYB4FyvHUZvdUDTdiF1ubBbNeiaPR3YAiA2S?=
 =?us-ascii?Q?5Y4n1Yz0dvEal7Y4ZcqChwf+1Djv/hrSn+tFj2FhFqEiXQqNSeH1R9UpRUQW?=
 =?us-ascii?Q?mfvgInmVA4nGAqit/4FP9/6Iv0GhhrfiUoxspnCNwNyVkp8IgZ2gCh6Awm2i?=
 =?us-ascii?Q?bvnZwDgjS3uxlQ4h874KDyF9OvKUIky9rfJG4zC8/mbpykeaxVoyzdMF/0Y+?=
 =?us-ascii?Q?k9oJDci0rkNQa0PyZyvFJCw8kV/Jd08XETQH63JnknfN01wKKsWWk6UavcXn?=
 =?us-ascii?Q?X4/uU+Db7mZ2juf+bxaaAGUZ12o0WHkmPJ49VvqfZX//GhFMsQfvAqa05Jmn?=
 =?us-ascii?Q?v4cyQYC3vMSqcCs4NiDDQufNLg2u+X8T9zEFpXXguCxEtvMX9Z3wvMjCbgo5?=
 =?us-ascii?Q?r4E6O2k+Cai7oyOno9zMfT57bM6ps1/m3M+oEuMG/MbnEtSAwKAbpMhkYCSX?=
 =?us-ascii?Q?ygTfrZoyrpeFhjHe7LqoM0woCdWYcJXAzrFcIaav4MQjKGBpPYeT38egmJZQ?=
 =?us-ascii?Q?803XyaAmAeW8A73YZ+y9eaexd2pUUM7OYnAKilnFkCn09I5ORT5BoC7zrhHc?=
 =?us-ascii?Q?WvlvprspSh/kpjN2M5B7G7SXorS8yKWpeMJrnA2H?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81515893-4ace-4334-da9d-08daa09cb238
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:49.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G0wsCwwk7Ykvci1TdQLQh+4SAB/dYM6DYSI2jrBMq6FkB2QqEpV+pmSEOrkS2AhJFneR6SNaOQxBOZy404ktQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..58f90473e495
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/mptcp_sched_red_init")
+void BPF_PROG(mptcp_sched_red_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_red_release")
+void BPF_PROG(mptcp_sched_red_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

