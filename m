Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2089.outbound.protection.outlook.com [40.107.249.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D207B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj5FdT4k467b7/qdQ3/3WOWuxf+Tahc6hLujWCxr/erXvM3eswOx1kPCu79XO4+MAkMiVStWbFzhFWpkDLMvXsAp+/O68/txxZorssfzhYdGNa6j92QRhrox5vcNJ+9VFXi8qPpgQ8vfcTeUMXxwGoorV+ixHN1bfwolVsiJpRBpMQu5q/9c6t+Ls9vUb7VoAb9hjmMFljX8DuSyr0c5gzojN8WNUGrmo1r669oRK58NvBq34WBW/zF9Cfw2G+xEIcZkdOog1234ijfzGVTU7Q8mFagV2PFH/jzTTANjUTU9cy3g0I4e7Tnn3groGw0OY0Y7fP/QgyRItF0ZHOeJGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=K9rfqX69s3LdZllnps+KkPesumnC9PBQERPRhe1lRy88zLOin6mZ00Uke4pi+YHfw2Kb+zDSFJrCH4+l95S49ps8D8evC4ysioF/bGj1KgJOxKf7zrF1H/Bt7fBG1XQm+wBHK+zOdd88nEjqlPizq9yIxQU5/Rk7mHYUXgR4mwVkW4O15ZRLTsnG3QgUh9wsg0Zc6oKodnoqbVayplhMbqlmzIqWn7JZLqplETbFLxKqSsfnsJixgqdFYI38Cf0XN5MqmkrVBx2AxQs1OiLT/8D0FL+vP9RJm0Cm+fwdjGsbSmDv4c613gA3i9p26rDiLSGskSJybGlBbRrUAwmE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3LrEKZXEKHwgr4y9KFxK+dy9jKsU2FL2knK+B9lOYg=;
 b=aUHmF218KGE8/ZPlGsbGz1gBgLjAchL5XZowrconNpQe8rIw/r9i2cdpr/XioW+bfr9MQhTGY5ji5VjTrW0GXMAHWQRIma8WfSC84Lcwl0ECwV/LTwNnD+VWruaRsg6uRVBv0y2ap0Njxq3MkP/7vH8Uq0ZpyLJSOFR1HQ7MdrxlodkBSZ9HRv8fUIYCQ9TOZxd9Zi0ajWXb6CObR+ZHJZQA9rH98wSTyVxO7FfGEoSvOlA6PGc+DlcfjyarLsyoVKDvZ+Kn/pKmmzAHisC04qfBtA1z9nbhy2oFhmwSRW5edoLozTfW6ixxL+1JLJVst2WR3Ct0gIgcCxu/IK7qoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:06:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:06:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 14/15] selftests/bpf: Add bpf_red scheduler
Date: Wed, 26 Oct 2022 16:04:23 +0800
Message-Id: <dc301ba25f20d4c41d948a81ec4c425278ab6033.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: d41bd00d-490a-454c-f8ff-08dab7290442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JObOSFJ1AgA9PKjgEsagzg1l/RzXOfhRnmGxd/NGMvHuCpfhaUhA3z7hMHTr2kRyGwMlRMDbrw0fRDGe5w6/FpY+1Z46rENg6hOnNcsZaC9rZVazJk7VR1o5MjiALXpsGqe+4cJmxnC8sDe5KTWCucZARwWJALJTb2JzsLmwUBUrEFLGpgBANXZkC6aR17txSNPhEpMqSyVLSa4dt9UKs/62ylIdUKfdpE3ZigaV412Q66nl7XnmccWB74uTIBcM+9LS08HMxmr816SfF5iEzj+r0Py4O2nLrxcnxddeqai81boZUgD3Qq9pQrBTi1MJhCBXatKwVqV41HdLs7sG6PbCv6hmooMOYkahyMs+bNQYX+4edcHt96NxnId+ebM6ESfa0ybusQH9kt4r3o7MsVMH+ZzviJU0aF1hZtMclmuCHe6BeVu5T0L0XBTHKwmxJhDbYTiwcslL257usTBrt3gtK0ybPO4NpmfGymM9sRr5Iw28JiRSk25Dyu3/PQ3LGWGGCjwYzui5JCPj19bjeUg2mk1u4sB3lqWz4LzxL/vOSNZLRKoVdkLlelU3mx20a3CAHuYCsWeW26sqdOqCUq5+u/NOn0AXCwqNII9ShaSEDC96VUeIqycAAzNNIeZXv7TJ1oKR4yACzDC94VGsGf2gVKzKt4P8lGqUpFuJX+9bT/xVYO44iMPS1DZPapZQhIFl5G1nlRgXFMv6z2cM3LMeZz8YSRgeUnpzkASagJ32iPf8UBKIcd1M3nEvQHwH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36756003)(186003)(2616005)(86362001)(38100700002)(5660300002)(41300700001)(2906002)(66946007)(66556008)(8936002)(66476007)(44832011)(4326008)(107886003)(8676002)(478600001)(6666004)(316002)(26005)(6512007)(6916009)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8YaVg3RAaU5IDoXXiWuodm6cxBRiyOTNUOy1DgUabl5cri7w5iP39Y2FxZn?=
 =?us-ascii?Q?N5hkc7vS7Tt5yp1mvKkvONBEcNOLhMNBjtEQzrnZpFDaPoNFqX+kN9XCpUhB?=
 =?us-ascii?Q?J1/TGxPsPRhr5wTmp3/J9/WEO6h5r8XGbyGHjrysO+5jiOsrKSJBBQT1E0b6?=
 =?us-ascii?Q?PbkmjFCkyYmZu5emnzeV72hlQaehbM75r3/Y6UD8Ib4S3p4lVtYJEO7VsnB2?=
 =?us-ascii?Q?m9uH8qlKeOysNdcbIge+v1wxiSho4O0+xrAe+Tn99Qm63RVyVC4AJCPQr6CO?=
 =?us-ascii?Q?ypsVp/kzQebsJlDAxXexhrJKV3hycSqFw0SdL6LydU9e5kO3jdCgLuP6fi+d?=
 =?us-ascii?Q?LGvs3V3tgNMFn8yW3HlPgL50cHCBQ/Fa9J0U/8J3wFCA6V/yaQK3SlLnEJcR?=
 =?us-ascii?Q?wOAJbXvekBj896JnPAIxCtdbNs4uVfOxYndOpN54hC0cCggQ8E80Pa5iX9lC?=
 =?us-ascii?Q?lJ9SCeMOxCeNhTCDU+NkMuwwkl9y4nuFW52TzDJfYk30xkFAIbpA8r8jjug8?=
 =?us-ascii?Q?nP2NqQTEpsYGfZr9YgQuQiX7Zku8oQQcPdh13atIMEulqRq+wGPBVt6ZEfuU?=
 =?us-ascii?Q?9+980ox6BKEPmC8HI1PkA/QoF3/rNOkKtBk98QcPfDEEdzOzDAPbzSYzEtIv?=
 =?us-ascii?Q?rTEmotxeq4+Nta/XLv55renuMEQKXPIxt5V5H60mbGR8gZSB9kQc8LEhS1as?=
 =?us-ascii?Q?domXBGjq6bKuAGAeVIwHbAMPtzWbiRd1LV/IL95YFRxK6W5QoBhOoVQKEebj?=
 =?us-ascii?Q?cwslW7xhzZ1el/E/uT67XHj0fhh0v3JNXAOgjV93wmT6W0tWmOQF2kmESiop?=
 =?us-ascii?Q?rwMdgUgcmEJuNhCrqdWi922oAOtgLkW2kXOReCANl8zsOOFWt1G8iZmw6L9i?=
 =?us-ascii?Q?9nK4/z38UJXkGcye14YubqO4txYfWqmXZAcTJ0C+/cH916+PMbAbFGs4SK+r?=
 =?us-ascii?Q?0A/g7vxbFHSxw3mq2tI2TDu2Jw5PljpQt6Wkc0it+q0MLEyYF5F/44aonFHt?=
 =?us-ascii?Q?1Rdrop+JOlsl59CGqA/hzN0+log5NPcIrz+r/wPnRCPPgQH3lbtKjOD1r/Fu?=
 =?us-ascii?Q?Lc5IBRzyNnE7EuKr56LriIbUdqpeC8A3ZmQZmDlhP2+fbMWQYc0pGwR4Csxa?=
 =?us-ascii?Q?vwydOURbVWHXuSFGPyh02rgLfxKyuZBWE0b+3sLKnRgqHH3UPvNp06zXzn81?=
 =?us-ascii?Q?sGLu7Pogy2Q1M5O1HpseXJC9j5nM0EaGvjgDAWGyFJx8cf2IPbU0nHdzVw91?=
 =?us-ascii?Q?cRC27NbkOJPImx7setiLmwn+SjZrc318DvS+/Go8FoRnRPThq/CpA7nb0q9E?=
 =?us-ascii?Q?7IjIhd7A6LAgOjx6UNCdF6JP6eK3oEPhJosxsN0sSOMSTA0bNSLa34sNHmF1?=
 =?us-ascii?Q?2ryRxummsuPOolGopoDd1DJdJbdpgzdKcZdxjaGUnaVGAZmA1ULfYlWxpLNo?=
 =?us-ascii?Q?9Tt0zH5jm3NUnUwZuuwkeO1KwpWX9KRJeGMe5WPxWPwFRIBlhve1YAzmaBwN?=
 =?us-ascii?Q?MXkIEU1e48YFBuWx2W3+/XtTrC16KQ6WzPG7JftJXibuJweripTMpm4CkdID?=
 =?us-ascii?Q?X3UG2ns09vvaNjbbWhJLFp+ygolDOnwEW64EDb950AUAGWspkS9LdDOI1PXq?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41bd00d-490a-454c-f8ff-08dab7290442
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:06:42.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxVf75hWxpiV+0Y/VY2o0WR2xt6Shn1xyzlk65GONLtRxeEb3zbuJZQX3uxydZ6JAfLzIMlQ5GheeXn6iMenFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617

This patch implements the redundant BPF MPTCP scheduler, named bpf_red,
which sends all packets redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/progs/mptcp_bpf_red.c       | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
new file mode 100644
index 000000000000..30dd6f521b7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
@@ -0,0 +1,45 @@
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
+void BPF_STRUCT_OPS(bpf_red_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_red_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		mptcp_subflow_set_scheduled(data->contexts[i], true);
+	}
+
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops red = {
+	.init		= (void *)mptcp_sched_red_init,
+	.release	= (void *)mptcp_sched_red_release,
+	.data_init	= (void *)bpf_red_data_init,
+	.get_subflow	= (void *)bpf_red_get_subflow,
+	.name		= "bpf_red",
+};
-- 
2.35.3

