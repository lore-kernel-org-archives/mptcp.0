Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545DA6AB3
	for <mptcp@lists.linux.dev>; Tue,  6 Dec 2022 13:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHwsoUZ92q3RDV55cMNgX8f0KBIntdIGe1JwyDxv9inNyUJzunfRZCU34NEKQO+ilZ9QtUBRRcj6z6Tnwc+2ULB6wUfjU00dWgjDhE7zhwcNhaKg0kc7hnZugxup1U8nKgEvDoB6uJyhhWnubhEtuWjC634Q2WAuHld+ucw4Zie9bBDAiDss/VSwgkgK3Y1ae8fd5Zv5DHjtF/1+GABSLdJW3rwN96UKparFNByzrzq/cQQqL7xNXF78EaOqKdMidUPjP+VEp0iGxwXR4I6JvcFUcNQw9RhZ12Sq5PJrL6AKzopphuInqbEEZugEorlQI/MlUENqZWyvK+SYmhm/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=WlUeCQvn98QWcgDg+PjMvj5RSpeYp8U883WbkPAmYxOQyf853pFH9Z3wQXiZnvfwZuU7Dh37lF4MTb+8IHx1g3mWrJboK1tpnx3FCM9kM3LQ5ep4z8ztypqRMjHb/6JGYXxcxOmlfUt4pwuvlznMRwlsWrz8GuOteecwLkeADTfpTBP28mx4pT/Mg7BY25ypBUQPOKnbnIb+nlc+KSF0eaFtaORi2l1GbpEcufA5wuQTfxQn9gNpc/96FLOB0HRbZyCWL047xWTm0OsQFma5QoT/Rd7xubjRdvAo63zTskIW0A+Z3XCsk8agJMwsyDpEnliCKK12pag3jlkZIEXdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=CgYWIoqD0XirXy+NppfUehq/2W7d81p+8WLBHW4MY+mlHaFEXi6rlx5262208e18szkpyxGtUY+kop2u7nI7FFTL+DsIA+3FAdy2QSZDthCE+VvjH9UWwtBkW2l2HWbdtvDsSSZdC5mr9U+EFwY2Jf+WDX7MA9l2eDmytZlebU2fn2MZ1hQlcuznLpzOSRa1tcq9yJ1ytQ9vQvFYgzaY8NBDt6tsL6mFP+9hiESa9kUZqyxi8rHEonMkNSOXUn84A5/1qDB7g/5PJR0ydRLzlquN84/XCQj6RkAuJrLUiO5Zq9vsny4Z6kKdeFmwaYd0NmgviOiWINx5D6vPUc6hkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Tue, 6 Dec
 2022 13:24:47 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b847:ffc7:deed:c700%3]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 13:24:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v23 5/5] selftests/bpf: Add bpf_red test
Date: Tue,  6 Dec 2022 21:22:21 +0800
Message-Id: <1937ca954785e8dad06aa2157722c7c5409e0957.1670332660.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670332660.git.geliang.tang@suse.com>
References: <cover.1670332660.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: d41055c7-c482-4730-e112-08dad78d2287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q8zTKcxYL8IeZJvmjSHM+7ltODP6GyJxtYQGhmgUPffX+ejVD8kyy0Wckl7rjnnZUt0Gk574SpIPFOix5nrF8CaLzv/CWu+W5govvkM/hJuJxgTpqgkfaJ7ACXAkxnkfg/d0I4JJg7+enV/wyyIxhmSRMqf8Ojp4Tdreq0Gpn3ZA0uaQPdfQC8gUcCa/ZN5oe+GUalpuXmBCZvLuR7Cb7SZ6TFvxvBC2uHN5Bqw5SHob0WFoIv+kp4ys0IBBf9VUHWC1y5gLImtTccsv+7vxvFBa7C4SBh4ftiRSNiZr9DQDk5eWUsx3xbE7tDg6gZJCetD6erLvSZ4c2DC4iKbeb1eETKoUKyQdz+R16U0km+D2pRD/s3SZcXMEq8qFFadvsZctyl6JwIm2LUgj7+OlikJXb1aDEav4axlZsMjUMDO7I6sBC2Z7qQIfPN1WpUKNZrS2BSZXzQCUzmBL8FrkPmvX4GxvEbf2eFV1Cn8aY7l+6z+9PAUSg0tKF9fHbYfW394aZflcKArRHO3OArXbZpCVjY1ia4hpYk7ES6foAuhVFWA8g3SelSZSZKGfz4vk9PVl+/y2rGEK1BD+9iq4NQqreKS7Pk3kU7nV9+OC7vNGpAZVwETmyZ7gVlNOf7ad
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(6506007)(86362001)(478600001)(6486002)(26005)(36756003)(2616005)(38100700002)(83380400001)(186003)(41300700001)(4326008)(8936002)(5660300002)(8676002)(6666004)(107886003)(6512007)(316002)(66946007)(66556008)(2906002)(6916009)(44832011)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PDW+pmpxLdI2l2Umqpp0zem92ISdiFX3KCgLTI7W9CSOJnWoxawaTRJuzaVg?=
 =?us-ascii?Q?LAmI0iqNv3hexSHA+13puJUvWfQRqU3Al6gRLR48DqkcYvMfeCtvlAxlQX3L?=
 =?us-ascii?Q?MyXwdF9IDBHQ+O/ZJz7ztzWGAFviQP3m4FmIJHDNG8+7Uo0uZcPifxyGlTPX?=
 =?us-ascii?Q?OzTsyEfsBqNGzLGS0C5DpZKhYBQjUSfN3Qp3Z6a9hM/LeelQYXbFunSlX7qH?=
 =?us-ascii?Q?PrntO7ICdlvWrbktD+yk2HlapxbimrBYewF1zvPvhdrPzRWeCQrdoC8IkjpU?=
 =?us-ascii?Q?9EqLeSS0KLHEPECj6CiYdOvyfAJfoEFKiFl3ypE81vdygvmk/JllkSTFVMBI?=
 =?us-ascii?Q?Ez6riPM+J2J6GlOcgqHznvFC347nDmnY4F1yssu3VmMVuE3LTar46TSEbh1n?=
 =?us-ascii?Q?JhBxvQBDvBj7tmHy+/fWbEXZSyUyTeW4bWIKETo2zc7XY9S8Fw6zoMDleMiq?=
 =?us-ascii?Q?lm/c5gJU3w/yDz2sSFx+PuOLem+Uy1S5fS+eEjRjlVkXF06PF13xPNB3k8Vn?=
 =?us-ascii?Q?wf6P9CuA6QUsZl396CYDV8uavDSeRD0tXsKlEPphwZ0F1NkOEQpcHRgTQc4E?=
 =?us-ascii?Q?aqQZB/dPmkYITast2xM2mLlCtDufQcUwSCuYce+RrBzvLKtuca6O3iYngzbI?=
 =?us-ascii?Q?/+XrQmRu5WwVZrV88lLM6/YZlKFI4fF1xa55Se1Hw1LKSadK/JoBAIBhf/t4?=
 =?us-ascii?Q?SmPPNnz+WBTZzH+3RKHb9+SqrI5dDoodAj5KOI6jWr6Pu+SbrORnsPROzv41?=
 =?us-ascii?Q?mtIhCf5qFgk8PNSvJVcwzl8ZGc6H6GVP4J1fqVJIZFDh8wFgf3hdnrsdtgtP?=
 =?us-ascii?Q?qWuhPWyTcM0SIih37E4ZRW69nObyTKvhbslhBSmS+wGzWnbfmpw70NzB/Ssl?=
 =?us-ascii?Q?PerEkmZvv0kbOvWAEAQMdk2eYyz48+bJmwDaWokG/sDvxKAPyjJ9Ct7CuGWG?=
 =?us-ascii?Q?q6WyctH6LMz572Eus93Zu17RhDx5hdQ2wYF/WlSeVnTYt6h6Rnhp2GEVuvXe?=
 =?us-ascii?Q?gkBSURgYFYlrFBJhZ1pcAsIU9IZ4ju28qVy1RrimlkKOwBOpa9zpDT8vFsSk?=
 =?us-ascii?Q?4r08W2lZNPflv/LKsXS8i4ttOPrKneIOFOcRiB94fK72VKrbQsLzqmKiIEEV?=
 =?us-ascii?Q?gqAIAgqgoGZ5QKfJt1lLkx2IO2tvgzpzVLz4ZRIUgYaf9kCYLje8aXGh4EMD?=
 =?us-ascii?Q?e0EKmncgvrq4PcShNtSRAAAMtnMl9KeT8rLPAQLWPvkhCjtsq6VRv5dKKXYR?=
 =?us-ascii?Q?SiGPtSyCJXYp8fM9pf836PMwTB/MxMdhCFJYpsmsWxvTR1fKSC94a7MRaIjG?=
 =?us-ascii?Q?gh8UCabPZydP4v28IvkMYqan6nMmnremQF6VCWA4+SygFl6kTLp8kJQRrDcz?=
 =?us-ascii?Q?DE6U6N0bTaEVHLaVlS2eLisoID0FrDxq+X7bR1VO2d54lBvpuvL1BNEgEKVp?=
 =?us-ascii?Q?heYCkQsrKX1diIR6vc5QigJO7xK2kw9O8AT0YRPfvtG1pFbRuUdkDpiSgKpI?=
 =?us-ascii?Q?i7NoJED85v4RXYMlnVLanIP5sue4etT13t8DAs9VCKUmp2i7q4/vPXbSMh1O?=
 =?us-ascii?Q?xpe7ik6UrTy4UcJCc0CbLhStcEmcuGXQV2qLjTPpOjUQ7yxrAa4FVlH+m4K3?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41055c7-c482-4730-e112-08dad78d2287
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 13:24:04.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wJEvDhWwonT4GYQ+QeFxIR4uhcecCilIG4znR2Jss69U2sJzPVvxow6NXRUr0I+43D4LUr0k2AmN2iMQ5IKCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

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

