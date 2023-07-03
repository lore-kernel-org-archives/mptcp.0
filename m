Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2A803
	for <mptcp@lists.linux.dev>; Mon,  3 Jul 2023 06:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3vU2yXnRPwYa4c1W2p00Fh++yhC0pAmD8pPIF4wsW1v9LJHIX/tGKFOoOco5Kjt67Yx4jJ91cusv7fCLUmLElsKWHfq01xtLHlfw9Cq1Q3xqMfTc1VvjCYqwx7ARPwUX51AebrCm/dx8HWFKpJoxETKHPOlx4dqS/4DSlQ/IRKD5Tt64ACpcTD6qCVWwA6tCO42KkYqLph6us3J9Aez8akIMJEr5hcyu+d/oB6JTiy2WEv5qd215hTs5G8zurOO/UFOgZMlKL22MOsCOg38b1O5kNFquY3UrfGb0u1VxjYpV3NxWB1UAugYoTgelb9QuYg1i0GSPghDVKXsHxMlCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH6bP1094r29ByuFTJb5/07E/YcQe3WKZg110OvNdkE=;
 b=Bxgf6jwdO34oCNnY/kbJhjBMcTo7PLnlsfOXoH/e7bnvPKKKl00zIbv7qJfsAeCB33moVaFBSYfKBA9HpOCBegY1bHnV1ndkDpxNEXK0bh1DOEnse13F6VMSEdN2yTy/09Ghger+M3AD7l4OkTjk5cf0agG/UKzCpR5gFkdQtDkRDeV0VNkzJldf6/rPyurXjphnwFouF0FjCF0enlnV60C+pQQBgCWfckYxPc28qTWa1fr1hsbWQmfOC+CRElDkbb0HNUIQvqlicJ3oXQ2O1X6fch6EKJuiC1sL8I9hKVFMu4x6Cwpysg4V5vxiNSSuTC8ugNbFE0ctql+0K/oybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH6bP1094r29ByuFTJb5/07E/YcQe3WKZg110OvNdkE=;
 b=hJrBQ4PZeQLzG5GTLpRu839jHXTumsn6n0kBgyU1t77mA0BuofB+nsB9D3+EjDvZcPSKVsXpu47vZy7UuSnsr28JVJky7YiVCWKwKTDBMlYTUBBsYYGNwDy8L8MTguM82vFwlThNFuz/ykIBhP2ORi/OPVF31vUmvJT/OWB7MnjvVevp/uq8ZKMA4xvp1D86JhHiTa5K8LAWI9GoPD3nD3l916X3mzYUYX0rqXCXh5Pct6Ok8Wj9FsEkx+kdSHNEeOCrN2Sl+TYYi8Qm2hSdutp7iYgDVWk9ySPejeVc4CuB+QVmsd5UPOwV2DYJc0L+FhJtWv1afCYYRnMIObPEjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9524.eurprd04.prod.outlook.com (2603:10a6:10:2f7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:40:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:40:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/5] selftests/bpf: Test bpf_mptcpify helper
Date: Mon,  3 Jul 2023 14:39:59 +0800
Message-Id: <97e0a030557e9693280e06b581c39b0efebcaab3.1688366249.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688366249.git.geliang.tang@suse.com>
References: <cover.1688366249.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: f928acce-6240-4306-7dc7-08db7b906664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qn96HFnCuCWPfvt0gfLp4Hy7JTwo5E2IgtHrprZNx0xXVPYL6uWiW/guKnL1IY5cgPxF5s4yL36GGgW+zt5VV701vmgcPFsBfpyoMaN1diRgh3wUeka8aukAiyQoCFxKX1QpG7i8VHcfJvu6V/iuBrpHOjkjN4eJSaeion/PGdAN/g58qh0K7NpHT9z4WcSSXihJ9eiwU0uo2LX5+QkNLQ/ybXOPZ7Qiv3/gjkDevOZOGe+EnPepBeP2HMaSWsZeGpdcIA7bPGZHj+39JNE/RlhnCLkwn0OFd1hfpBfQ5HlLbNQEM2++PNT1Nfn2CZAiYWNrk7b4c/y+u6pJpmMz24pk+J+9I/WatY150u2OqptW9DCmoF1V9Dmi5p1Eb2BF4t/8XDXV7SC17jYDM4smg4SUTnbhPgBwXFwMpweNfIKGZSUeG8szPgDEZo9UBxTNoPteJxh9fwgaABmQ2TFPfD6yzFa5SV//ua+lnbufdc8tBKFKnfUvvbKsQ+k8kyuvl8w0F1HCY5RB3KyKcgHfg7nmy2hiobnd4arrWdSacKpfn5Cal3H/xJbL88NfEtuH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199021)(6506007)(6512007)(316002)(66556008)(66476007)(38100700002)(66946007)(6916009)(4326008)(107886003)(2616005)(186003)(26005)(478600001)(2906002)(8676002)(8936002)(36756003)(44832011)(5660300002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/lZu6MtF+L1/l5cfU/Iq6Oc5Zpa9zMwKZVOGpn02PV7t46qat/wSmW9FW2X?=
 =?us-ascii?Q?IZJ4w1pnJsQfn//GA2BxcjyRnUGLHQWU8Dx6pNGfGWXEL7OiSINiUvZQt/6U?=
 =?us-ascii?Q?7yy7i2r8GMHoCP8vh92L3mE/46Ox5GNX2vyemIhG32LmGa+nApxf1uKABYaw?=
 =?us-ascii?Q?Nly7+6/E+1RrnfYh9RxguqTu7mb9EBxjsZEcRHYW9lvd+NX03sG3DEox8FG7?=
 =?us-ascii?Q?2rOzcVCN2zldr8WZt5s8bQY34/h0AlaIRFFCK8ZXz56FPG7O34np/8jw+lRW?=
 =?us-ascii?Q?TOphf2DdQu86LSBUiFxCFLIOeymBwCGT3fqWmgMjfSZ/BiwXgAnF/DnIK86E?=
 =?us-ascii?Q?R+wG72MsxqqgzrMSN+Ira+Gmw8jJT22p9K2FfmUI8TSk6ASaNkMqbjM5kr7T?=
 =?us-ascii?Q?kcol5Z81ZTW0o8wrOWpdraaxuFjCzZap2R2oJ3JIQC2gGsU1ltqW6tMiZZVh?=
 =?us-ascii?Q?q+F746bdl0+2gr9A7PV+EVZmuCz9I+w/MbODhffOwi6kCqgXMfv3K59Bbf+1?=
 =?us-ascii?Q?csV7CttwTn4wYZHIHsCOkbOqMoLxruhmkjTgbaSwiLpKGuA4/M7TMa7f6sgS?=
 =?us-ascii?Q?msIcuXJhYKqGSKzkUdAvDvkZxFXjRAyhJE2MqdW/i9okibZ7FFoU0s2MtSD7?=
 =?us-ascii?Q?6L4dbR98/3xZPqB66ZkOIl3KWKh1OAXwcNuY1xoQ858hTpcExVayap3+SD1g?=
 =?us-ascii?Q?uvtWYaHT5/Td4LHlRem3Jc85Arj/0MFzAV+fY2nwm+ESjodb/ufNwROAwQFA?=
 =?us-ascii?Q?1Ou0U1CjQ8iihDq6Z7w9vzyZcHwlb91rYID/3ofFIpnPdv5MLDf2J6f1wGUg?=
 =?us-ascii?Q?WZjalFZLBvmXPAkJ2m+3sNCvZgtCqlIPun0Lkz/IA45Nc7irgpcsleYQ4NnY?=
 =?us-ascii?Q?sCQ/LdwDshs6y19J1TSklv6lc3EtSydwPPEcxO1wR5WamEMSwKStKpQwLgQj?=
 =?us-ascii?Q?zTXak1HKq33vyR6D7G3EUk9/5/gBZKFUTUxUoVRf4ZQY4mHkJubl+45Hjc8o?=
 =?us-ascii?Q?efVXOZ4/JWG6ESPkMwDR0wspQiuRC5XPNxaQ32/EZw3ZMwTtZbezw+32oCDk?=
 =?us-ascii?Q?pVQXMaaYJyCrjK7pbAxmX7WJN5pUWpWePqkopbcb312+Vgminb1/fK1Nzfrm?=
 =?us-ascii?Q?u+vpdO0+03rVaGQxIjW69lhHbthb99SgpIlspu0q8jw7xvs/BA+CBHkNlZpn?=
 =?us-ascii?Q?n3WK3181L5uGPy3Hhl48FMAFezB3+Lz/9ABghkXEWhHc24JByeZuQTk1vi18?=
 =?us-ascii?Q?R6CFpHSKlf4NbX+kt5AnUmumAcoQdJMrJ519bscyIpietkvkOCR6V68kZNZy?=
 =?us-ascii?Q?mLTKPYQ5vFkzJS47zzYs2Y4nXm1rNbTo5Rui19lI2cvVW4RhPw3BU6LF4F/x?=
 =?us-ascii?Q?Q8MOcS+QI9y50d2KtPkkhjjhQmv0hiSb+IPTwyX9FhRF6uAKhlsf1XltW2qW?=
 =?us-ascii?Q?fgvIDda2b1NNbzAX9g2eJKLwJqrw1N86ZLzFft1vXzjwcciO5oPvXRwMfkRm?=
 =?us-ascii?Q?ldiiuHrqVF3kXOT+BG5NUmB89tP8YsVSfW0hmvVV+z7qzeMSVcnrWlv6EjTa?=
 =?us-ascii?Q?MAso8lZjcPiO5Nst1FmODvGmILEPY6e6w/OzqO9p?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f928acce-6240-4306-7dc7-08db7b906664
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 06:40:32.7462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoSx4ZoN9rpouIsZF3f8F3lVeewkQEOeCUYgXFF3iLZLxVYbOmmoEzxBfeip2O3WMw90LJP/zcweL89I+p9Drg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9524

This patch tests the new helper bpf_mptcpify(). Store the new protocol
value after invoking the helper to a local BSS variable.

This is defined in a 'socket_create' SEC, so it will be hooked in the
newly added wrapper socket_create().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcpify.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcpify.c

diff --git a/tools/testing/selftests/bpf/progs/mptcpify.c b/tools/testing/selftests/bpf/progs/mptcpify.c
new file mode 100644
index 000000000000..18078c1d351a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcpify.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry/socket_create")
+int BPF_PROG(trace_socket_create, void *args,
+		struct socket **res)
+{
+	bpf_mptcpify(args);
+	return 0;
+}
-- 
2.35.3

