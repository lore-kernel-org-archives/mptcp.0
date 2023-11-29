Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5463B6
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dV04G906"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA8QT9SAcZtZfj5xpVa2OcvWUAbG3qvHkfjGOxfyPOO2AQANUs3zOmP4nq6c07KW6iyqISVZ4y3CNThmGJfKJC1kjb1F9DXtlltxGzNT7QQMRwXnFjsCRk7u2B2or/+Z4/U4/fKuvVc5Ks8gaqyDWbtVxmf2AzKaw/ifoRM4RKlSKqV6EtNd4TtOLkSwJfqyBbVT1t5uLcRXmDRfb76y4uVo59hF6eqMoSPbi0Z5QOczEDiBG1FsG+bUC7H3VZ4dLNv5pfhlbqiNGn9BlP9XcDBU+PJRPX3bIB/S740OzSOWPFZyRwPaqaJ8u3e+OsAJrSRIZpAlmOPbqc416cpH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/FxsarSo9k6d1N9RVgvgH/s8I379rJpWlV0VVud1n4=;
 b=BpmMFuC4Fhqh9dtlHbXl+q//D1ihSRmIKjDqYvBOBERiVCTsC5pc7sMxEmcY53lNNpMTM/QSUfka84RXyeXrau/EuPFxc3qWa+Le3mnJoUp6y54/vbPpnVSYZmmT6V7C7+uccmpOMKoCp4OoU5T/vn9dYEQWgjX8ILZmfVNvXFZnkMfRChNzBRTVQR5FtcQGNnX2S9O5HnXpoP6y4wF/spM7sv0FkYBaSIlTjTiMHq2D0qBxcbB/4Ckt+LvDRwmOjDhLKRzaUaGj7lpJTCigs8waCRp562HoQJNWSw2bCMvudcKBLnlu14Po83yVV2XhRwu1EL0NFpjXhyH11m3AXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/FxsarSo9k6d1N9RVgvgH/s8I379rJpWlV0VVud1n4=;
 b=dV04G906DMPOWPuDG8BtA+ZrUONzb9+NICQgcTaHvPmS/lp1TjO4PW+7DVpdTJydicwYE79Dftq26sM51yNmA77ruQ/9oiX0xW3XRhtK57PRGHNlvUHh7qJcvqSGWIYUNQswiY0cy/whDrlTgJcLdMxML40XmkiY577dAH9HDG/CdWTxBonTOp+pMcgfDZtnAHVST06bUxPWLAWZ3m/JPO/rjW62iwbOBos7TLzGlgZZEXfJL/c9YM0yyJAmQJWyUkw5+rEcS1lM6H+tTQa0IlBMimM3LMhhqwyhr0gYANuRA3OXbE1hGXWc1nK6ngecYATHA1alMWjzuNmX5SsIRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 04:08:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 04:08:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] mptcp: add a ftrace callback for tcp_set_state
Date: Wed, 29 Nov 2023 12:08:53 +0800
Message-Id: <4323a04943500dce8c072c49ce50b21591357876.1701230012.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701230012.git.geliang.tang@suse.com>
References: <cover.1701230012.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992366e-c176-44ba-e6be-08dbf090e2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2ntIm0fHIQt1knVxm/XCrThQzkfFepDCp22Q91LTrpzK/8ZUMbKRPLxkff3oHXfOZD1ba/djX/L51afAcfmiQOXB/QRgfFNLKVrNmq5ffhoWqRC6ligAJnSj/7MldcApgFdRX+qLRwWSMkz8GY+BVpVXmM6AUoaMeh+X2CpkZm2CszA8zy9ge/gei/xaNJcJ9BWltLabyWuZNlsuIAU7m69HdHDI8RmWucKifAaUH3+Su9lFc/Ln/zfUF5DyHM1IS/dtNM8Nqv8D+0nybO+kU7QYMGMLDoh4g+EXWx46umhN5Li7EuAWCKpR7DaRJSwxrUKx7KiXJ//1lDGg7JNEqK6BNX3GqCeWCT2WOcp9JDlIcuGLF7NQOs6hoOjepwXXuxZoJ+NDFHj8wJGpPiF//lVHGtdphskAfwhCxE84LL6iKfPGBZmgJfIwnQ6p+xnvUcJUfB7vmNbsdyvkbC7N9vSJ6OKcMfIqKyXapqOa+fEjmiP9KPWpsgNPuE0vhyA73YIQ4X3isX8abKoSAdSYS7gWOA1DXqTzfhseAV0cbb9wD8/ldlCq+oL7GIUDUZLqxisBZeuxbw85BQ9JHI4cVu1ZKt27f0mMun8F0Mv83JM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(107886003)(26005)(6512007)(41300700001)(83380400001)(44832011)(36756003)(6916009)(316002)(66946007)(66556008)(66476007)(966005)(6486002)(5660300002)(4326008)(8676002)(8936002)(86362001)(6666004)(38100700002)(6506007)(2906002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qIWelLUclWa+Ml2ameVwwZNHaIRE/QRy9HnQtNyZglOwBpGIs+g6ZQHLdU4l?=
 =?us-ascii?Q?MPLLrVRTTI5nmgUl/WX693+7N1vWwqquaTHec1yk4J+CJdk/xFAqR0CerWHM?=
 =?us-ascii?Q?2kjb8zYXV0ZmXKg1W5lxJgXzG5EZEKmY3pNTApu5IRwKYEfZkjvsOTt6K79q?=
 =?us-ascii?Q?/3VSVt0ldG3fGYmDX81BPn97/l66R++g6JnQyMorqvRzxLs8Bl4IEu6q+opA?=
 =?us-ascii?Q?JFX/R+GGukYZ4YWoKtFlHug3tKg3r6IoFSPFNg6PQPqy2ANmcCCapMJ5y7yL?=
 =?us-ascii?Q?tXrIYuik1+kAdVeMRFgWbbT5XeKNkE++PWRdtdItieUftNg24ymcphndiVpp?=
 =?us-ascii?Q?UmlN43TxKVcrZgGvLXvldtPJGOLOeg1tmxN76ZC7wuoodjY8Q3h6iuXlubcL?=
 =?us-ascii?Q?q4hOb1RdX8P83mg8a4XxvwKSVd5LcMdbUJtwdZgQKIz1RFWrhNgjZYGGWdlk?=
 =?us-ascii?Q?pg+9DSJhGo9sWsxNEd3od2STmvqwHS5d9poHsqQRfeAD7yyS2Q4I7/TkZNZB?=
 =?us-ascii?Q?PtcyXEye6eUypNsDPgbG9ea9jhwJTqSIzgFrmsmzvM02G4blNuuTA0S3+DoH?=
 =?us-ascii?Q?z0cOV/xK1AV62UGf5kWxUDPv5hGB4jjgU/5UVdh71EZcjER6RaCUmqdSNd1F?=
 =?us-ascii?Q?1J6dfCHrDm0Ue2e3N0FyJOX1IuOs3OysJttsqT7LaLH+MAXQO1bHFKoH02zl?=
 =?us-ascii?Q?mcThRuS3lx3gPH8hgUtRPslueFYeBOfGxMETVKwyhz3UCKpsYA4XADLmFCfg?=
 =?us-ascii?Q?+LhubL7yWWOXv9Z4H5Y9drGsMZroFvhBXeMvx4jWvftakW/EwvFe/jNa/uTT?=
 =?us-ascii?Q?NbGjWAuk9zMIjm1OCnBz2fABV46yiQO8P8TRpeGfAqhnfFuoFS6+Np54Qs0u?=
 =?us-ascii?Q?xj68aK5mkUQnsm0LGKu1RnbbaeuddAas9Kr7G8XEAF524Y2J2i/BGIuC5reH?=
 =?us-ascii?Q?h4kY6TTCaCgy3srP7udPcDjpuQ9Xuq9Triw8qZ+pdekvAGV3pvki71Sn0xZJ?=
 =?us-ascii?Q?o4La2gaWbYZYLoCGyD8q3MAVxnzNBf4KCA6+LzfrnFxcArbyqq9ksWYf2yh6?=
 =?us-ascii?Q?9hFFKH+ikUWYVaWvGredfpnzgEi5JQuim9U1aRPW499xZyx8+HxRt9LhicP/?=
 =?us-ascii?Q?B3rMJHY8vC7g7lZLYcEHmLzu+Tgr5QcWANu1jv0NHtGWa3wXf2Uqp900jgu+?=
 =?us-ascii?Q?MOfr/BLSYj1tvKWVDNsTde8LiCf6wf+u/bxOqPtAi5UQZ1HMc9ox78P/AgDW?=
 =?us-ascii?Q?wv+eP9hobwBTGppLbXc8zr5olDDEeEPMDJCLa+yXTzZfBuv0/gjGyIOnDR4N?=
 =?us-ascii?Q?5JMf3tDosDaH6RIwX6UG5T9P1z+m+Qf+mmx2dK/K/optpPz0DnD6SCa84WSz?=
 =?us-ascii?Q?qHIloKgRwCRUh+GaxRgVHusHv+tSzQuFepsWb5QQukscKB5ZE4etmYNei4bO?=
 =?us-ascii?Q?rpzNU1aTE+k2/l1zk6pCCtiPD4wQE09uBcood2hNn+efDxRM68m7UAh3eL3p?=
 =?us-ascii?Q?ePaBypOwcPI+DsEzwxRO9rGFAg/WXXdnhtojT4Wc3FMg9n8sPcsaSdw8X1Na?=
 =?us-ascii?Q?zh17zPSSa/R0o8ts5Nd5iqAaaEUA9i1qNW+VZokbkqWT5rOUFeuNsMPNvO8Z?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992366e-c176-44ba-e6be-08dbf090e2fd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 04:08:48.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOc4RDwTNxbePS/dgxyM6djlVsjMvN1b0aQXHjsDKpi6B6l8pQ581vEd0skLF3gHT0FBM3dbR++v1Yb+j003uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This patch adds a new function mptcp_check_state(), in it if switch from
or to ESTABLISH state, increment or decrement the newly added counter
MPTCP_MIB_CURRESTAB.

Instead of invoking mptcp_check_state() in tcp_set_state() directly, here
add a new file trace.c, in it use ftrace to hook a callback function to
tcp_set_state(), named mptcp_state_callback(). mptcp_check_state() is
invoked in the callback function.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/Makefile |  1 +
 net/mptcp/trace.c  | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 net/mptcp/trace.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 67cd565bb321..bf88bdb222b3 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -14,3 +14,4 @@ mptcp_token_test-objs := token_test.o
 obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
 
 obj-$(CONFIG_BPF_SYSCALL) += bpf.o
+obj-$(CONFIG_FUNCTION_TRACER) += trace.o
diff --git a/net/mptcp/trace.c b/net/mptcp/trace.c
new file mode 100644
index 000000000000..7dc33ff88813
--- /dev/null
+++ b/net/mptcp/trace.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2023, SUSE.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/ftrace.h>
+#include <net/sock.h>
+#include <net/mptcp.h>
+#include "protocol.h"
+#include "mib.h"
+
+static void mptcp_check_state(struct sock *sk, int oldstate, int state)
+{
+	switch (state) {
+	case TCP_ESTABLISHED:
+		if (oldstate != TCP_ESTABLISHED)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+		break;
+
+	default:
+		if (oldstate == TCP_ESTABLISHED)
+			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+	}
+}
+
+static void mptcp_state_callback(unsigned long ip,
+				 unsigned long parent_ip,
+				 struct ftrace_ops *op,
+				 struct ftrace_regs *fregs)
+{
+	int oldstate, state;
+	struct sock *sk;
+
+	sk = (struct sock *)ftrace_regs_get_argument(fregs, 0);
+	if (!sk)
+		return;
+
+	oldstate = sk->sk_state;
+	state = (int)ftrace_regs_get_argument(fregs, 1);
+
+	if (sk_is_mptcp(sk))
+		mptcp_check_state(sk, oldstate, state);
+}
+
+static struct ftrace_ops mptcp_state_ops = {
+	.func		= mptcp_state_callback,
+	.flags		= FTRACE_OPS_FL_SAVE_REGS,
+};
+
+static __init int mptcp_ftrace_init(void)
+{
+	char *func_name = "tcp_set_state";
+	int ret;
+
+	ret = ftrace_set_filter(&mptcp_state_ops, func_name,
+				strlen(func_name), 0);
+	return ret ?: register_ftrace_function(&mptcp_state_ops);
+}
+late_initcall(mptcp_ftrace_init);
-- 
2.35.3

