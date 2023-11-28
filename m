Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13835888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kaht1TyF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O79hueA1ENQDwWB2+2G7LJpAUHm2u0PcEnSAdHC2qfCVcB8BZRapxFSJmcRGTDcyUZ7SSxQcSwdEztEp+GCVyD+pe4n0iLc8yTw8PxBqkFlnN9gJMeW/UX22JqWty1/HwaBunmhb4aJvVHZDjQB8pz2QA1n3MJhW/sHsZCFbRbDXYt50twm5P3wXvr2Zw/h/TGXru60LjSefYQY1+2/NnGA7INhRnayBW8jPpakJM6LwExBgNVMApOzWOtrjUWGx6kZMBdzw2BivXiCwiPt+A6QdpoOB5GpsS517iFIh60LzIDCbEwB5WCnyP2/sWHZb3WSCdWBRHIDGVRzUbNQnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF47YPjOh9vdRG/qjb68HzZW3mWc89WqtwLMGhIC7xQ=;
 b=cDVnRsNFFqwKQxrBT9P6z+H0W28oXCUB4XEg3xI8R6i+XJYRD57MsOlrwyrKv2V6LbiSQEOXptc7WBpt8Pn/FfUcx6wzCOG6pB4OylA6n1RzILB5x7gaKfl5NVrZ9gStVl0PQ8rKEWF2/7ch9ro0ATFuf3r+6btkDfuQsCJpXR8Vkk1mwr453RsIKKrODQL6657ysubwk40ve7SQqPv5NZnVbFEb0m5z14aGs400bsuYnqhjXFQRN/FTtl5e3m0hSriUiPe9H2wh9nvlWQH8Y6lxmOLhowuluYocQIfo/petQSo9ci4nT6ImtlmdS8HwQYSF0FAdPcx8Rnvj5U5fqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF47YPjOh9vdRG/qjb68HzZW3mWc89WqtwLMGhIC7xQ=;
 b=kaht1TyFNWaoG/FGqgqGh5HhgvMOh/OH7v3U/ElKUuWZxkkxj6YNrppDbR8RjNO407ke9Jj++5A4QlWFQvV3WebSL/tgTfvG7cPKgSMlBLHZU9zXww/hkwynjooHmaR65iM0ajIZ2Azhb1w1UuRV3tree1HaTk9Rnq7pZZkNNiS0GPxk/Ps/+JHXnGDUCbA0A3AWwkvKhgeFTHWNJmsjLhOy4ow/CgAKjuCqtTkfuk5mKGV/QO02n6zlvNkPhZLjWQdKN9YrSmDKS9MKYJacbCIShRL5MP/uKaz4OQFruO/SCRGR6neaczZ2R9G9ftjZq9p53R5FW5E6SsD+EiLpPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:14:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:14:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/4] mptcp: add ftrace callback of tcp_set_state
Date: Tue, 28 Nov 2023 22:14:05 +0800
Message-Id: <6f4baef54a7631cdc1460138bc7e52f2c432c69b.1701180777.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180777.git.geliang.tang@suse.com>
References: <cover.1701180777.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f4d8b0-6a4e-408b-e77c-08dbf01c4965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KFN9yUGogpoIMMAkG16pTFftfmu9KIGvNhZorkecXk6HDxQkFzJh3CM6nUxGY6wIiwKZMtBveEyIelWfXxOkzzPLvUGWIv83bibbTH+Kt6H27bb2ZTLJrzSMxRGLCQgIF0FCSN5+Xn5ULP64sqYdi8GeSlCsy5WylN2D+1SNJjWF9RmfhYrj/DfQT4FlhLuJLi1vRVxfDp/H96ZADdke/LHWfTZVNCzTKI9kmvDVrvsMPw6nsKozeIW0GsdoTgSFPev3UJKeYpjDCVOr+B8QcCORgbE5ctqWy1bEiTIsy6+bmQOSAKUNwY8T66468EoOkrMPlMO103Jpwe8LW4zQcTHwdX58EsqUdN8EfLIFUZEKBj6S+Q7hyHmqd49OknHGQuavc+UpQMLdEYFLArtGvoDJIE9bGN0qxrXcqCL07AQS5r1Xp1fRzmgIJ2s0beV5+Mt1lbrZ+o0VoZ/mhEY2RZeJdzUpSgjknR83g4qDLnfFU6D2qluW8QSUf9sDOmwERUm3b+OP0GzrAJyQy+QHdtzFd0IQ5A1ukols4JTR3q0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(966005)(6486002)(38100700002)(478600001)(41300700001)(4326008)(8936002)(36756003)(8676002)(86362001)(6916009)(66556008)(66476007)(66946007)(107886003)(26005)(316002)(2616005)(83380400001)(6506007)(6666004)(6512007)(44832011)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLl7yez9Cq4KDNdALvMd87AX92Eye4BiAQx5eBxStbMnQTwYxqQulIOeXV0T?=
 =?us-ascii?Q?zDjlPNy8AOPrJWx5SqCP0U9DuIvRQVhl2mON09Z6kds/oHXw+eX+PeD8i4bl?=
 =?us-ascii?Q?2OmhL/K4rpQqelgev9tAwDBpt8NDqk2rxYeAKjyRCUIR5QlpcfD7WoagnP/K?=
 =?us-ascii?Q?uh6+RO5e3eLA2uzjBvJncoWxncHSt4umIE38L6pc3sQQ5IHfQN0hOWo9vF6J?=
 =?us-ascii?Q?s92oWyutpjGWpf6ZgMSAf0UNJqmsaBxvQEqmh/nQKpfrmhQFTQVVWNmvdSr/?=
 =?us-ascii?Q?cAOCcKkJpfx71qxr5uYpMQupGbg3ER2oTazbWJ015MbgO5jng62KvxehcSzA?=
 =?us-ascii?Q?MTACTXTBpHmfpzJzdIjfLvOlYVujWxCb/B1iiNux1yqJ7YeOltpYVbWBeAoc?=
 =?us-ascii?Q?HTfX6evd7UKh//34OnHz2d24YBFwllo4khPdB2u1riZi89njGVY17DGbI01u?=
 =?us-ascii?Q?fIChppyYov9dbZIZ8OApo9H5RzuqSZixm3uG8LWTClzsDW6AEindFaXXOdVy?=
 =?us-ascii?Q?Pkg8IsM927pIxS0ZCDV8lmUA4zO1fMRdITiSK/bq3hl+VAwAqn6N+ljHwQoz?=
 =?us-ascii?Q?HvK+zw3yuDk7fVBouBplD8cFm8fk9EO4FriQH1h/eYIrf3nWkEqWXZEG5uHr?=
 =?us-ascii?Q?6deTIkwET6XZlVD9LFR1SDK+It4B1r4kAKzyftpWwhI9VZgOjFAgqYcuCF3O?=
 =?us-ascii?Q?/1WSjX48vkMw3acDv5UXCmcAgjhr3lTebq8tQM7v8vPlWsgb6l8J4gt//tMb?=
 =?us-ascii?Q?F8aAAZ451UgT+N6nmGVctija1QFkpV2J2hMTkI7dCACdvIYr/xvCTNlatmdR?=
 =?us-ascii?Q?8ipl2P6l1JvUcjkMXf4rD2zni91x46TzEPwAcT+5U/hLWw3ExQZDl0Ifz2Yr?=
 =?us-ascii?Q?8B5JxqzSgbc3ot9KcVaVLGIfEQB64lKcRYi3L1sGIxzBagForOCUaDIcZ4nT?=
 =?us-ascii?Q?+npFgXP/8n93b1M0CdObbei8LoPEJRQ+ap0QJXJQpkZQFSo8c5al5+dSPAcz?=
 =?us-ascii?Q?OiLp5idtCFuL8bR/ZV8IXZZ050WMIfLz6JeuqjvTX26zrTJ7sPXZZEPE1+up?=
 =?us-ascii?Q?6UO07DtVkwhpLdOCYejw0S+APXJzgrleRCGScInWoZk91SDpf0IlPjIJ0Jo8?=
 =?us-ascii?Q?yUiPC/eS+v0fbrK312GGGcRJBhfpzRet96BkGVu06jF9SW6gMxqFP/F29mHt?=
 =?us-ascii?Q?PbtZohXeM1CA94eMydseGFYQbGt+MEG1mGExdb4kU/It9A59wPiBqZKUqoUU?=
 =?us-ascii?Q?HThFV9tChcatdvcuJbM9goCgc3cMTwjTRThAhWDs111JbChTdZUsxXvYa70E?=
 =?us-ascii?Q?5BkLx4q5e2MsE78GWe8f2UlrgnX362vtzGX4pecSjIcoJ9frI7OfRdXHc6YC?=
 =?us-ascii?Q?sqwGgIOUyYGbJsaQkx5Oqo1Vlpw6QXTKdvEgDFOcte1G8juKKOXsr/UqenSb?=
 =?us-ascii?Q?QG5poQAJi2urZWPxGv7mgUCzP6yYuygR5f1ZVT7Vocs17xUxOPI/jreSw6JG?=
 =?us-ascii?Q?UfKxkP0HC9zGbUxNP3HWscykYbV/LoEse+W2rEo/J4pEy0Oyj50+AUp+ewIQ?=
 =?us-ascii?Q?PD/kzldB/mOoCqybOll1mG9E81hIySBHhfiChFcz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f4d8b0-6a4e-408b-e77c-08dbf01c4965
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:14:08.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1Oaxp4Nlda6yU6obCpOImZugzSBBrGTUAiSs/QxmpjT+qWGakidTMfVg+eUM44j8otjXwYrpSPp51BzcbgwoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952

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
 net/mptcp/trace.c  | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
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
index 000000000000..a930e1b50d56
--- /dev/null
+++ b/net/mptcp/trace.c
@@ -0,0 +1,68 @@
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
+static void notrace mptcp_state_callback(unsigned long ip,
+					 unsigned long parent_ip,
+					 struct ftrace_ops *op,
+					 struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs;
+	int oldstate, state;
+	struct sock *sk;
+
+	regs = ftrace_get_regs(fregs);
+	if (!regs)
+		return;
+
+	sk = (struct sock *)regs_get_kernel_argument(regs, 0);
+	if (!sk)
+		return;
+
+	oldstate = sk->sk_state;
+	state = regs_get_kernel_argument(regs, 1);
+
+	if (sk_is_mptcp(sk))
+		mptcp_check_state(sk, oldstate, state);
+}
+
+static struct ftrace_ops mptcp_state_ops __read_mostly = {
+	.func		= mptcp_state_callback,
+	.flags		= FTRACE_OPS_FL_SAVE_REGS,
+};
+
+static __init int mptcp_ftrace_init(void)
+{
+	int ret;
+
+	ret = ftrace_set_filter(&mptcp_state_ops, "tcp_set_state",
+				strlen("tcp_set_state"), 0);
+	return ret ?: register_ftrace_function(&mptcp_state_ops);
+}
+late_initcall(mptcp_ftrace_init);
-- 
2.35.3

