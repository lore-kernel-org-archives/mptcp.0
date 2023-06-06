Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2041.outbound.protection.outlook.com [40.107.14.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E20468F
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 10:56:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6COaY7VDHWjp5CmdxPPo55B5OGZzqaDbh3Mhx1m67BBuZP1F9nQHBeoBTpQ+ufGMsaondeLfZUcdBDpbqcVV2SDTInOCXd+alf7P7D6nfOBUj305zcFxrLqUobSlKZwbCeyaAi0urYJ7AWdvQILyQ+oF6axKtDBlt7bEodK1pBG8yL3elnhioKuhaZ9Yd5mZMasLEKJU8SIm5yN5fjYjA/FPtuyfqgWg6VbSSRINWs511VKwmrI8sEa+Voc5pJ+ZYvmREm7BHKuQPAk+CiOxwvf8jKEyGIU/yS/WNJLzmVEuTodNdetvkGe5lPVZ64z4RZr6SQyUApsD+/FrKaP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB+bxCXubS+Edm9WhHgJBDdTPs4jVo811VSk2/0iyHc=;
 b=AM6RPQO/WUfh7dXxVEaOuqT8cn+BZG2Gg+pTTcRLdT84tBE0YW1LOwdtVN7kd0XYsnKPzm3dFKXbSqYLudb6ggNPxMAOTbgx84JU0LA91cuzJrDuzfh4+koJAJs+Qjqjs+a1EHnnS6qSiDnTRq1Jaby25FmW+kHfvUcDA8YfG8zdpmOKn+kD/K4tLeEzIXfT/IkkcqfGQPxyJvHmdy+9Re0SkOJ02UBQIN8YdzMku8Hb5wYN8AA8Xwbba7FkqCqs0UvGlGszpu1YnYCIqB1gKy8RD1BisN5zH/vC7Gz4mZno8mbxQE9/M2d910FWEl0FZJf65xmOVAcKlIPPUxo8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB+bxCXubS+Edm9WhHgJBDdTPs4jVo811VSk2/0iyHc=;
 b=FAq2AREPGhWbmL5nCu+u/Ib9KW1I8RBZC2UT/L26Td8Zg/BTgVc3PxctPW5uPXmIIkoL8gWP7mgnWVktDk9Jegx5KNWxKkUHwZFj5hlrkIYOHZP5Uk7dVO8Htdt3dBaiq1JqiQbGuYRJRKeO7ySc/7oHAHNXhXjvcqWGF0/YARS3UAGVxgerLhuSKQSsugWs6MzO/VfGdjdF6HJ9jxLI9DgXRQGGPUZkRnOOvAKrNbBN3GE9C+gmsT0Z2WU2NopYdegicTerTXTi9nlR6oBgrtH7A3pW8mdSuR25egIAwdEIebLjDu4/897is8VJJY4n/0UuEtP2r2oblUcLQf7AVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 6 Jun
 2023 10:56:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 10:56:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_burst scheduler & test, v6"
Date: Tue,  6 Jun 2023 18:56:53 +0800
Message-Id: <4838f85dce7dda7a4c48372b8bdea6af4a32f929.1686048993.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a6b685-5926-4bc2-4c32-08db667cb8ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qmeSjikyYUoJsrzUahm9VEze583IJeu5WQun+csQwZn1uvccGROHiG4GCkP480zkZWgMT5HIibAB76HtiyaJS65hXfmPE/3P2e6FNawkZZVZKpjV/hz1r0Cd00RyVl/gpy5eM4pgVi+4o9mIE60P/owH1iwdcP/yIflRD/4eIHXloJZ3xV4l5ah3A5eg7tfKdNGnfYJ7aHMhhi6kFQje2fSDR1pniBcQvEvtyxjFG51xeSx1SCY/jMgMzD6XfTAups1qhsnEAq4hKoUapQAXIMDBlszm/zpVtl1xryBQaOmeKV/xttLAggHSywaVBjQ3x8a/2ZNCSg0hC9A6316AYX0R1T3VE7ttccynuo83opPqIkP8G0qB2uu/RBE/zkZ9Ntx0FDS9mEVFGi+A+bHf1QJDQXuQ7e+4UMqEDNDlICps0zLdfioh1D2Qy2k3T/URGdtvXZtv2valMTi76YBuSZmic/iCUMy8x6Gne7g2tWdoC/z5SFm6hpAJZWU+h0imTwmJXKbq7iqvxL+M/gazcruv6Ehf09zO2W3e0OHHBrpXjp8jug11hEPeRQFX17D9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(41300700001)(316002)(478600001)(83380400001)(2906002)(36756003)(44832011)(66556008)(66476007)(66946007)(8676002)(86362001)(5660300002)(8936002)(4326008)(38100700002)(6916009)(6486002)(6666004)(186003)(2616005)(6512007)(26005)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AobgQJ/HPyJKyfXwdkBMifECMIpYXO8u+3Tr+iJdWRgVNvlnACRnExbGpbuc?=
 =?us-ascii?Q?L+fqJaTOEImsOtb2SO3mNHhGWDvPN8XbsNXRSRzXIB64Ty2BLtbqefg4WgPJ?=
 =?us-ascii?Q?gD55jRjVWxd+VjCH3Ku4L94PFLmtTKquNkBVD79NopdsXmjAyXv+tcuAfVpb?=
 =?us-ascii?Q?56g7dXP1mbdGcw2/YicSdndRfp7hGkjOYgXmMxe5aMLA2qy6i5N8BA5PK0gb?=
 =?us-ascii?Q?nw+PqVxhs6agOncra5RQglLXmn0h9WWpNKuD5fQ9dBSTm3IGio5AwMlL3iZd?=
 =?us-ascii?Q?x6bHP4rB8L9XEgLx4zcxe4vOHAVWC5+ijdjs5+TYxGC9scDRClKEtVsK4bz4?=
 =?us-ascii?Q?2me7+OLwuB4jTLTRpSR1E8xzk0E9hvQ0QGtW7Y7g8k1LJs37FlR54sscY4af?=
 =?us-ascii?Q?AwjrJr5T7AHdfEhlOLBbIev0WQ63yZyj4kxYth712s5HABljHAR4GVDvbnq5?=
 =?us-ascii?Q?LpBo0Xd7A+KZdhKCVR7NY/oqzEcc4NP59ud9yTaNCn4p/SQ1svGvOynrVt8V?=
 =?us-ascii?Q?4hypVx/9XxKoxC9WdaDj3fxuAAfEvzft+cbnHIPZrnAr26nCM44QtZxqbWGc?=
 =?us-ascii?Q?APsnKfr6DtHyz26YWCgjIGYl+pBHkGHsrxfITMIZ4C9zNuf6jAnzy0z1VyjJ?=
 =?us-ascii?Q?xJLF3+9mvPvTvkXk/uq23z6Pdz4UL778bUMMe7F4+7i/tvTheywrxoGJVVql?=
 =?us-ascii?Q?yV96cPHi9zb7tAp9UCr2JbBEeENh/b6MrUI9K5YjdsN3F7FzcU2qLQAKuObb?=
 =?us-ascii?Q?Z95akNw2ZAFvKTYKLgE5XJYesY6/WD22O6bvrPzg/Hl55mMl8ivc+J26pddt?=
 =?us-ascii?Q?UGmpAtSrkkSVJSG6ak9XFMe2cWYmeVYDtJNF/eJ0WVmHPFNQD4src53aUilC?=
 =?us-ascii?Q?G8e3QGLsgF0Cf4N3EhQCCFjymegQvBnM7QlCIYAjFgshim1d1eVtSfkAr0X8?=
 =?us-ascii?Q?8qyaCVPxoKSm5u7c95cu53cjKao/JGvpiipSa+KcPlJ6YGqNDYfKvI/4kwtN?=
 =?us-ascii?Q?ub0AWL7JGMWCRjFWyiDXABcu/Dkg2Q5ybAiIuMDNvtfnMLDQ1+8Pmk1iWm1+?=
 =?us-ascii?Q?p0L+20RScQ4iZFUGvGJVBsdtxCo6w4FoyP6rvNx1oEfwj7ViqyLXy17kyjQp?=
 =?us-ascii?Q?V9+4yMFMWVazg9B9XlJ8uIsPOOCEVLIoPhZ6qTVrl2BX7jOxoGdUAJVCodTY?=
 =?us-ascii?Q?lN9rA6aC5Skdq/yw7/cQ8BgmwgcLG0W8zTOjbTF8/GyJoBO+mwjPUxPwYNDZ?=
 =?us-ascii?Q?jrtmVLc7JIBlYop2FkUldP2c/Wj0CMuSwSWqUcE/JrfEBtFyCHv7ci1pUn2H?=
 =?us-ascii?Q?NQgcLGhuqA1Vc7PztIOMrN37/qJdIfbhtmLXXQWIHSAvwp5JH1Uyl62k9RTQ?=
 =?us-ascii?Q?kWhASHi+y/pjgrA+f7ey+cCB7ErBhUzX+ql2aN7o23oCa5mu4aUlpo/Y/+1I?=
 =?us-ascii?Q?p1C61C3UMa+6spQba+e3jmqTvEfdK52nTlBDHeHn0/szH7ESKleRHn4Sy8gg?=
 =?us-ascii?Q?QemgkNNfE1G222+Idlo9iUlHGkjX+9wdJIyQdKXHDhDqtjiV1h9Z/4RObOYy?=
 =?us-ascii?Q?DWDAvzuFRPUPHy4DvJJt4qqokjY5XG1rTG1uPcsr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a6b685-5926-4bc2-4c32-08db667cb8ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 10:56:47.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8CKtY7Ix1+vPOSWgMfIIgqC5ameDCbm4FIjqPSkNCBIZU8N5PzqakfGfvw7kXcnN2890b8O5hsTaT2OMUcvVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

Fix the bug in bpf_mptcp_subflow_ctx().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c      | 2 +-
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 227fe513a580..94b7624bdfef 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -482,7 +482,7 @@ static void test_burst(void)
 
 	send_data(server_fd, client_fd);
 	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
-	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
 
 	close(client_fd);
 	close(server_fd);
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index c45dc1ccad1a..15525eca98c9 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -26,7 +26,7 @@ bpf_mptcp_subflow_ctx(struct sock *ssk, struct mptcp_sched_data *data)
 	int i, nr = 0;
 
 	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!ssk || data->contexts[i])
+		if (!ssk || !data->contexts[i])
 			break;
 
 		if (data->contexts[i]->tcp_sock == ssk) {
-- 
2.35.3

