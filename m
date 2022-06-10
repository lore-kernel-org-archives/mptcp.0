Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140047.outbound.protection.outlook.com [40.107.14.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59D7A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkOVjfvnlwullsfQHecOBPKFsqnkQMcS9iVPpiNzjXn3B2AdXBiwMxB5L5lP+VC+NFvDRc4L+/Vn7qFdWabnSiKCZZQ4s9CTZsGXsWOH3NEiuEqTMvVbN/fRvAYT1vXldogAbYYYoUIX24tBIK4atNLqqOJEq8vt22Kr+4vbcY7v7Sxu0Na1uAvbYbkna/xbGr7TLgbrQB9g2FqSqI8XDx+TM1ao5dL/WbEUOcDVHSYKkUyIy0vHoKcZYpg1xh4BemMD1Z0DrBk26CQWT73hckXPS2alcof+hDeVwbzYJEtQ/4+bLjcOQ2kfW6wlyKRdqsVwtGb0DNaBCFlq5bByyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=BQ6ZH+eOylPRHUCmYYiOJoSF1hYr08xlT2VHiIJy6uH00bW3f+oj+TJ4rElHIYGLRFN5SqHIVtdg9YkJhefC3NyLBs5/You2KM9Vmk3NTIk9tGgIH9gsGTdmj1JN+yrSQ4h7IdFJiV2d7COR4ZE3ZgWxesndW/lEqkOSSphfPwi9GKwKJi5NAgoNV0huQiUOV3hqxeDxVR4o178eOuK5mriXVz1Ec7t4PtbSXR/uvuD3D3Q1AbCeCB5r41+X50hZj8g95EGJPPtNnj6QpP73uP6R6pcuHvS3SIEV9f7O2SV+zVkqNM7RCOBNMKvW9b595DwLUgEVFmKIuFnwK1iqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=xBRS1tlCv3UXvjQyGAQ/M7xqIKUghhLj4+lqq6OiZSetPqzujoixBN/sBQvBgYh+clQtfSaQCH3/x4ybKJ/ivi/qgW+2UGvTDOyxwYtJSuhq0HUG7Y1BA2uZFzi8OmuoeAXhMLw+FCD7B5q/khK4bIa4WycuXs9aEljcZCE4yKSneK8wl6nn2zlkwzq4y16DnzuBxAE6s7TQ2Ec5dQ161mmOGilK9q7JXcaTSctbNclH5Gwqq5UZVIwCCq8ayyfNvdS8VGN1wjTTqCzuu8SdmNDOhYdD4sjuOV8NzZxld7Txp93ei3r2sNzerezpshwEi8ivXvV0aEBnrvNtOPprpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 9/9] selftests/bpf: Add bpf_red test
Date: Fri, 10 Jun 2022 21:05:34 +0800
Message-Id: <36aefd62089f887aa9e640d5dd1ec513e8fca592.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d7a8bd-fa2f-4f96-3d11-08da4ae21761
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2725F027EB39A6F9C3D47D28F8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vo7iTCFdhfwMxoJvIyWcbFsUiqpHNp+CUdlBWHjql424rBZGrzWpfwJWdmshy27HIPuzJPo4AZ+ni+U5fc6+/upSMuvt9JEQlOjUFRj10EVVMAXsost1AB/aD9ZeKJKRrNLRHcIqKUKoSsPW5T6CwHA1w/Ye/cvB3sO6FxvSdktaxipdo7X9srR+MS/LDt3rV8MfRgmFL0UrpfAGPs+dvGIFpiDDzVQs+IK4zYNUZ6ljbTyhib26y2T3EKHy5IGiCI+S1QZMHyKgan1OYluHhPz3OScA3R0+0eL1vTVO8ZrdYmdl6oit2UmtVc6dnxO0SQlzfpxjiNPDKeE+UOq4WMCESrlQmm5Epn6NV1KplJv9pFD0LaC3yMry79aGEL5WDgsFlxKArOOip9Z9E6dHCAPyHXrOiqnQP4y+99rTLR5b72xUrxQ4DtCR6MQGqeij0t80/JwPL5lpJ3Xl8Ne1iS0kMM/OGsn9djS0xDonXafd+4MqUoyGi6qfzUcNHOzl/hbxN44D91UUnxjeju5C+O0WJusas4h4NyQ2eYZdUgJYupOSJk+muwoouqAJHcum/lqpQahcboqAjXyydKMTm172F9KJbWoHRrqtsWn4CuZBWNLZ4B8b5AGPX/lkzC+r6OmErTNPyQlo9mD6eMT3mbhTGrGHSZmP/ALCI+q6uPE02uY94ENWAq7zKgffK9fa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(44832011)(86362001)(6486002)(508600001)(6506007)(83380400001)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3XV1c7h68++zBGMeAdGL9fZA1vE9tUmMpRTHf0QoUNkPGpNKnjsKiplsWI9R?=
 =?us-ascii?Q?H9C7k4GrHnlg7sWTEVHCrkBrzL67UxhrYNin0g2hlVSLwYNJzXuQrXIpTY1R?=
 =?us-ascii?Q?xDpycKHDj1rqusbtE20bVTQmyI695bRICyDo23dHlgMc8I+9Fwp7pOSsHxTq?=
 =?us-ascii?Q?ArhjaAPVQhyiDZ9hqUzRUkYLhfsPnTF0WcmzxPqMqwq9bwdSYEz6JHhCB1IA?=
 =?us-ascii?Q?r2i52N273qqz0ixQm8xT6Y1deIBsDFgYnt1VHd40b9rw+57l84e+04wcsPY0?=
 =?us-ascii?Q?WjjXl/ZNxlI6iSTSHlnr87uEqk0WZVVtL5CMVXQ5KIKCwoffQIqAvBef82oZ?=
 =?us-ascii?Q?4lgaNBO1Rzd+QWtPbGBXcnCMX3Q3n9iVFYqHlO3WcgwQGko7ChIYOZaD0Q6O?=
 =?us-ascii?Q?Xr+gQFcrp0tv/wqIYPqx/xATykkF8lh5AA6jiUeiezSqzpWlRZpaHgBPEgKx?=
 =?us-ascii?Q?r7AxBjiZqpGjkR+kVvARr9Zoer0bLIajbu7JcVflAhVV1KhwRWaj92RsDQHW?=
 =?us-ascii?Q?UZ1pBSzyEKlxluJAeWDA0TjeqseIVdK32PJc3CCkaMUOrICgifN6HQTAIZ8u?=
 =?us-ascii?Q?b4HvzSJ8fmTfZb69M+OfDhOucJR5GrN0WCcQgdE+FS6YfQhPgWCluOcDi1Uv?=
 =?us-ascii?Q?pDgIWYDrodfAnEmy+GWqfGPWZoLcnVBbB3i1YNG+pRl/YStQYbYUBc7WKDB+?=
 =?us-ascii?Q?idZ3LrD2wRVxqljnYYTMw3YzZQuTWIL2iSyk7MP1XQ2QmRPUeeIV3ChAee/u?=
 =?us-ascii?Q?8rHQuioWf5coN86W/bb6rwuu9ECU8RA26CFratpu/kbgYM7hxtb+h31s2R+O?=
 =?us-ascii?Q?BZtSram6BNPDxnCIv2ANZ+j4Qc88sC/ejR2Az0GT3qUhuSHMKcCoyCl46sYD?=
 =?us-ascii?Q?ZM7Ole+RA5DjO2KKsfiGMOPIBP6Kz8LcHXUf/mQ4ZfvoWtPZ++Q+qApRc7dU?=
 =?us-ascii?Q?Xk7tqyeqiU/QunrqdTCsL71Me9Z6TACI0nSwW6gtJzVk+uAgJd59ZG0Mo0SC?=
 =?us-ascii?Q?+w9ZOxDZuU2zhTk8gjChDTzosRYF67iON9C2H34lna7QBulYrlYoeSkjsPye?=
 =?us-ascii?Q?HXicw41Y38nmtmNhATGRZ0C9BgQy17WI6tOU0Rvcpa2ktsFI8pTh/BReiSi5?=
 =?us-ascii?Q?pzrvYuOhDx7I4kt2+5rJM6T/1i0pTteUsL4oupnRqtz+rJqDBaM9bB2PL5bs?=
 =?us-ascii?Q?0ZNDIZYtnUlRq9n8EZ+sXPAcmdY4o/d2oQRY+ZJAgThNZx68x5Azkf7vVpOW?=
 =?us-ascii?Q?u8IQqEBEyKHJchJxv9DAHzRgX9XpEOViYwAjbX92DQEoMlsxyp8RfTCIxJgM?=
 =?us-ascii?Q?vewlT3VRzf4YPQJ73ConXZPH/Wohobgflgt6xRc/QLgAn88X1CzFwAmBsHce?=
 =?us-ascii?Q?RGZ65CsV88uLebW5puyAiwSV2DLd7qIgx3dQXwgsYx5/TMfW9YuiD8hVOmrI?=
 =?us-ascii?Q?6gGLUsDWnqyYOqgtT5Ns+RzclmDo0ztwPFSSACDfvMDGbv6nr+fQzpHJAnhb?=
 =?us-ascii?Q?LgYjacd5of18P3ERzUWWwcPj+26UuJYzGHCghClJT4Cnax2gZio56jq15o6j?=
 =?us-ascii?Q?HxPxnOpJTEuqLB/BUGURpI9RBc7B3UXvWvmCC2afENbEUyKCC9eOzBJMH45V?=
 =?us-ascii?Q?Q3KiWyUoOnbhFdf55WE4/UHRXYU6TNALl9cqvSpjhJyOiDR4g1G1tWHClEWH?=
 =?us-ascii?Q?KGyAFg2tuQdThCJSrLV7BuRGci4BNyCNpQW21y3AZsvfgXVk2klktFVNWnkD?=
 =?us-ascii?Q?zh6gjd/05MXA5XYk3fLyji9x67gxVAM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d7a8bd-fa2f-4f96-3d11-08da4ae21761
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:54.4315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXHLERHFidmM8xdJ4n6qeAoHAnQec4K5ZxoEVvZrbaqlVKS0cI+CXkp4Gdh/0QdglMlkMNTty5rIND9vZvNczg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

