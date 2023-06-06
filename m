Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCD125C0
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFxB+fWw2Zsa0dkOkw7kgM5fc5uXJKQMgqUCsRrXl/bz6xd/4E++9/JS9ZdpPBB4+KXIdKreoajYPxc7UBE/5aduzd/UTm1QTVn+oviV40V0DFZwDfnmRxIgiPnVS1s7jH7o2WXV6Jj22TOMy0KWF5ePFizCcg6ZCyq36voPWwaDBHjNYi8tXDJ6wwCmw9VmrzQK/K+tMGcRTmrw9UIUdgKCea2sJhYkSoDvZ4NIxVZevTlBH2qjP78ybECXE8MbIfXBgovrjqSrkzhEbhrh75y51DbEKtgf89AxqY9jBTGnsOuNoSCUIJ+3krNVZ89y2P7M47xEGyuhotEUBFs1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=RiN3v1z1uudLBcXLTHIlIRKTdJfiiQf1osXCrZ2b4W9JIWbpCgDjudzW+IEJN1pook3DT+WFQ8SJoFSxIBeYB4Cyb3ly1J1SDt7/vqaad+7msEdl10qJxRquC7Tu24WSvAnpnAYgRJX4uA7WWoBkqRuoVzY6kD4EeyZDTGX/SMnIi+Kwdl0ctjE7EO1ysIRop28BjJ1pF150+3L5ktJ8FYmZzUHNpcnys8rPhaXjGlGIJ+GyB1NsH2oXevKkJMRrfensXtqk6QwPdHX4THhtmcySI/d+dCdCILOuQKn3WbE9SFkaQR3xLSOW/0/2GYqTjoZJchdjYFxSL+vWCsXY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2Ro9XRc4QMXxeS35DjM+OwsCfuaHyAD1TxDPyPZFtI=;
 b=zYjmMzZ7Xqotpxn1nbIwSf6+30u4Fr3NzpXFxqjMC4xiMvV2F3Ubkvofmhy6UmwjOrYnDP3r5sduREloSTman9xNG0UHoEZZJLELe9omv+OiCpBjVn2E7u3t2vbBihvnsMz2C6wNKyn5DGKhR6U4hkaxWobHwv72tbPhHvyIa37xJcQwzhJNusaOMYg6pb5rnMn42Wgynr+wmzLoc1ab8GV9Xn5JcNMKB9QdDBuxxlnHsiUagqkj+hu0vj8L8blw8s4fQvgV3chlHbSrplRW+q/PuB+tTCsmhmd1H/xEhLPZ/p0wIbtbk5HDZ9+FQ8sqGp8SLIaq8Tbkm78/ktDWIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8998.eurprd04.prod.outlook.com (2603:10a6:10:2e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:03:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:03:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 17/18] selftests/bpf: Add bpf_stale scheduler
Date: Tue,  6 Jun 2023 16:59:31 +0800
Message-Id: <5ccca1739b37a823ce3aae98189dc794c360f0c1.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0031.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 512e69f4-39f2-4ca0-8529-08db666cd5e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QesXc60mIqzt7aF8vKY2bu6nFrrJWRuqXEwIt0oWoz7LhivUi3EV+XrvlPZ2h5G2u02a3WUpGCz95oK2+UwbwuFlC61odqrLdd/wgQvTwA7+62sQcyqnRE/TYiOMrBVUJmJ2w5xqEfagT/Zlh2Fu9gMyn1jQSEq4JVkKi7YTa4ZAq1s52J7OFjLelBOGfcJJIlf6b/7zji25LpfVspSeXQ3rPf/NHGM6yPVugFKKyM1AY504+hyklpHnnZVViIrp+txCA9VMLqgjrM1LdD+WmTnnqCcTILD1ZvHffgfSKUaSz5ljWJrGdyDrNYFqWSx+25gsqfX8MqNlA5wO47dCfLQDzjyccW3nFh2pwXd+6UVYwumXdXbBY56mxAqeP2/RxMMansS4RVaLBMOSol4oSue1RQffgHxvsQcz0+E3KItf/DM6ZrwfC1MCZMLg+Epxr+qguqOcyNovqRfayCIpPwxwa5MkWD5HsvLAyK/AX+5nRJp2ax0RiXYGgaabqMaCavTIdvkc5Cn5Md7B6NShmv0ibENHEnJp1QS5ZmZLvB0YJ9BqO9LuWbi6uJcxHNW9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(83380400001)(186003)(2906002)(2616005)(86362001)(36756003)(38100700002)(6486002)(316002)(41300700001)(6666004)(6506007)(5660300002)(107886003)(8676002)(8936002)(478600001)(66556008)(66476007)(6916009)(66946007)(4326008)(6512007)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1IXEbpKS06vDnBZCJhR/qEoXyBR34MdyGK5+KGpYQOsTyfsEsOp6MREAEjdC?=
 =?us-ascii?Q?7abAAYTgrZK4o1fCTk1oOAoOEoHvI4AyHZa2Y7K3GMFv8pavdnLlDIisKBoV?=
 =?us-ascii?Q?OTrLnmr2aizLfOOMW6xwNi1FfTMyKLj8xuD1SVzjpNgZIzWAZl3AbbZKhEo1?=
 =?us-ascii?Q?gH5QZtmXwOrT23Wk+RwOKKYbJLHqLIrYr9o0bNxPrgBf3E5aL7/0ZmM8uPZg?=
 =?us-ascii?Q?MieiWtvToZ19GOh0rOm7W2RQ92SHO3hYrdNRAaOFUlypy+NEZqMZ2yBADbxk?=
 =?us-ascii?Q?gHnYESnP6B9xKNYA+hMOkzfpzC3cUK7K3akiL8i8R+iAAHM5Jr/n7WrDnEYQ?=
 =?us-ascii?Q?LnA0YGWq6MnjIorov6KO8P7GEPKpn7ee3FgyrQ9rH+2B9Wk0N7t/3QSUlnfd?=
 =?us-ascii?Q?pYEPHU9+mKfGSRZYc922YlTWwqFQVr5khvuwvWRE2as9pC0WD2pRbC8AieZY?=
 =?us-ascii?Q?bQzEzW11oYJcaTMeBfZPOu4rhSq+sB/k5iFEOaB5joRBL1J8IbT8ZRSQJ3TZ?=
 =?us-ascii?Q?NhwTJgMka4UXl16sp0z/Vh6sl1h6uVYdrXHAcPbc2sGh75yFIOBWP+QpTRFy?=
 =?us-ascii?Q?QHKZIw7DFdw8hm1lg6u1Jaw5qw+orOJVr8emuM61kv4I05vvMWJOjER+Xc2Z?=
 =?us-ascii?Q?VtyIEAcBwe4W5vmetpxI67aD2ZXI+pozt02qljGCt18/Jox2eSGRsSkYq5vQ?=
 =?us-ascii?Q?kptshzqCuAtfDNWnndZwhO6aIuedW3RhvMDhOwuY4MLjLr/GJOlSUx3aBEfa?=
 =?us-ascii?Q?gG8OqZBSV2IusNkTrC0QEydocI/63H2QNOoDo74kwc2ymeWQTjqvv0aSYGdz?=
 =?us-ascii?Q?zUg4Gj/2qsZDgTSPp928ZEKJXUV2R+CMUibEIRUTEntc0XWtZmDaTCJrjS0A?=
 =?us-ascii?Q?76MEbj2WMFyKg2h/xNQ3qj+GWNVb/kiwqilDbBfpAEC+HQJpoKKaNdUnDeL8?=
 =?us-ascii?Q?Ob2UV+jsgX+GY9qj9W9PHR2//IOHatvqrT/xJlk0zL89P2jybeYZo07hv3Zt?=
 =?us-ascii?Q?rI+wU5CGuL997/wpmgVv7UJuNsizVGcinMNaDtfERtJuAGGZjN4avczx/XZ0?=
 =?us-ascii?Q?ptwiJtX6+s4JMOsoZ3uZxFJCRpXY+NeTw0mngk7zmJ6atwBVH6NdyY1/C06L?=
 =?us-ascii?Q?9iTf4I8d+V88xL5G84ki6br7N6aMePobBQuvlLFHlwbK/GFIOucVhGv2+tDr?=
 =?us-ascii?Q?ftfUmADRcOIlmiEjNxQ8mEdp1M8lViIeU+1VqtcjR69CldrSM9fMWpf6mFXB?=
 =?us-ascii?Q?/qK6g7GodBWkIlDAwlFvKxDe0rOQJQAi2Fu3JKTFfLMz4Gf8Z1rbSb6WlWPN?=
 =?us-ascii?Q?NLqnerwGIYeyCC5O7WrOt19Lpyb9UamR/njejcfge812+hKeks48b8YRBloH?=
 =?us-ascii?Q?BSnVlhUl+ZFL94GZXOtHeTIWgokIaBkt6aURGDM+rRKyXbzmPNF2aSh3Vw7q?=
 =?us-ascii?Q?mIyHYG4xNdrRjzM14+am3OdSo+dSKci/kVDBcVKW2VhuQQEgjlnXVoruwjWF?=
 =?us-ascii?Q?G0Bzw00uM46nu5lSbi0WAhfKe1HSK5sPXFZ9evsfeoHl2wdNHkFgXFAYm08u?=
 =?us-ascii?Q?bxeLBKA8IdxDuOn+xXnRgSkr1eXR9e+jsQ/DzorY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512e69f4-39f2-4ca0-8529-08db666cd5e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:03:03.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGaP/Qh5E+FgbftD5lDxlqg4dl9eRnNj1S72OCYIpQMW3Q25ORSwEzPje9lkz0hfc/6wPwjP2yxVVkFkV4Evyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8998

This patch implements the setting of stale flag in BPF MPTCP scheduler,
named bpf_stale. The stale flag will be set in bpf_stale_data_init() and
will be checked in bpf_stale_get_subflow().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 59 +++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 2c35cbe05d33..9fef10fa8aa6 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -236,7 +236,8 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __ksym;
 
 struct mptcp_subflow_context {
 	unsigned long avg_pacing_rate;
-	__u32	backup : 1;
+	__u32	backup : 1,
+		stale : 1;
 	__u8	stale_count;
 	struct	sock *tcp_sock;	    /* tcp sk backpointer */
 } __attribute__((preserve_access_index));
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
new file mode 100644
index 000000000000..125e84a1e49e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static void mptcp_subflow_set_stale(struct mptcp_subflow_context *subflow,
+				    int stale)
+{
+	subflow->stale = stale;
+}
+
+SEC("struct_ops/mptcp_sched_stale_init")
+void BPF_PROG(mptcp_sched_stale_init, const struct mptcp_sock *msk)
+{
+}
+
+SEC("struct_ops/mptcp_sched_stale_release")
+void BPF_PROG(mptcp_sched_stale_release, const struct mptcp_sock *msk)
+{
+}
+
+void BPF_STRUCT_OPS(bpf_stale_data_init, const struct mptcp_sock *msk,
+		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+	if (data->contexts[1])
+		mptcp_subflow_set_stale(data->contexts[1], 1);
+}
+
+int BPF_STRUCT_OPS(bpf_stale_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
+{
+	int nr = 0;
+
+	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (!data->contexts[i])
+			break;
+
+		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], stale))
+			break;
+
+		nr = i;
+	}
+
+	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops stale = {
+	.init		= (void *)mptcp_sched_stale_init,
+	.release	= (void *)mptcp_sched_stale_release,
+	.data_init	= (void *)bpf_stale_data_init,
+	.get_subflow	= (void *)bpf_stale_get_subflow,
+	.name		= "bpf_stale",
+};
-- 
2.35.3

