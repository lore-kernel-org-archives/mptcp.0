Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2073.outbound.protection.outlook.com [40.107.13.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7717CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWyMT2fJbwr6l9ukpRshb0YaaSZirrUf4hpOUhRKfTsdREEqM1KB7eL/l6HCkMvd/GVsYfNJ0xUJSBYoyNP/7bhTNFlgJt2d8Y9MNCOFLlHckDqEBewPklKnLGQI2vZsetcafS9KxfXlslvpMGe1VYNF1ESIYzCGm68k57a0/BspeV9mwG9JvrSqJkuDlkOvmMwdHAZ63xQt4DNBUV2KmKTUGMEdFeB5pRIgY4Wig2VkjWeZ13u8BjoZg4yMEuX2d2lddDUfnGLfjeAo58kjegtiB9GKcE1h/Hrpc29HEB18S3KWGPQe0JrHQ7BlyymSR9FkpCREsAjrdVVxmMkvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGKd1kVdg4aE5fn0bPrPl6vP4iE+ZEF7I5FpCxMAsvQ=;
 b=P9UoiYL/LEhO2EGN1aUW54iwiOAnlL1R/2DNgE1/Ju2Qekhnjd4A0iq94ZKJteg2KNEla6RLvRyPLySDaTrLGKnHutQPkrwAnl60OXGFgU9lUrRNEra6bMTWscMq+g2Uw1lK1hdK6kfOyHgtv/4Irfo3m33vZAwMvElgDPp47ORkRSsGFkMTkElZd8RqbbgGB+u4LzKq+uVM5dYuoz2pOsmZnYI1/iJxjGjvMn8C33Hc9CmowAK7EFXkRAjYnPJnKk2NVPA+cCQEpTtHFRflx896NoSTvyY3q6NyKB7aLzdoUeuStybuvKAh1d3ZZCeSQNaki/CHzHH3o32P+6XFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGKd1kVdg4aE5fn0bPrPl6vP4iE+ZEF7I5FpCxMAsvQ=;
 b=jqlJtZbwAQXuZ603Xf3gGA9jmJHYDmE+ajT6mZ5wj00R2aHxs3nDCbh3P/EgGBmKGKCWyGmBq6ZqSKCpsbH5oAqzW/UuIMSt1YPdM5p+nv+T7Ti8OobEW+oSPChHvyigkrmFDAwBpGgWZJ1qnp2VgbPA+D9XGDs2uKUzwjWOEB0xl27vY6hMB9pmeXIN1yynkNSKO2lAV8RzWYbXfrd0bzb92X5/63OBLknF5EKzP/FGyNnPGqahf4eNgEkfHVlnsdT6DWaBNHJLole8LzeegsIf/Ou3Biu/1MEwt1xD9kFRTYmEstQXJ6eiT5sOZESKTghPiDdbYRNFdTc7KxTFLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:38:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:38:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 13/13] selftests/bpf: Add bpf_burst test
Date: Tue, 18 Jul 2023 11:36:50 +0800
Message-Id: <bbc41ae5d06bfeb5de45b94f73319d22d41dd7fb.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7b7c5b-2731-4560-5f5c-08db87407be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wZSd4m+U0vfcr0XVwEVHL+F296jkQFBcshvJ0HkSvX6CLSKTx7Lkqr0SRn8qzUejVruW8ZnV3yWmdS4vYt/CTJXvIQBLRvUOChyiq6TZ2QHCFlY7L7WLLUy8vb7amNJBCTm2Q3CvfHjrNc98fa6GR+FTxtjj8O5y2/EDMJO0WAnuMYmIG8Jpig47hMnNXQVCI+puK9OE9RBapAHUtSESFRcBhEB09ql80d/S0yULbOUto8mlcmTNDnrW4nZJTiw3yq49IZC0uFaMjIp1tEeMap0IuOiqVbf/3nsV33zJKQewZRwdbAl7de2mGRtz9+USdyYJKGcfJ8HjZpGetmEUfhB5HC9aao8UF2K0C1eog7mVDe9A4ZRoOUWQx33Id8BEZY10+L9rZOTqMJ7VPWTFUqPer3iXm0ER78pd63PTenhR7Ws4wtI32mjmHUeKtCVv4gU2K2ixLN2U8tnq3OwRiBupIXdioFQZrHRcp0C4UBIx80OmtK+2xr7OwiNa3buokC0b/c4WdUZMvnXllW/AwSanGxiDhDzpDf3bFUM6ESqBAAzp5rCnJ9aFVpek99XWiTPrdcn6MGJIUY2j6WIxnZWyk1Gow9QDKxq7o44gjLc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?adKM80YRBznf7MUD46D14cDwHVD2eSI41kywji7r90ErdKERm4qI8v+gQkHE?=
 =?us-ascii?Q?y49nTfU7f+l/h1LUREo/oxEM1P20KQbBTyfXYa0hrKQNxlHRovx0wLQvnAl8?=
 =?us-ascii?Q?bhipco1Brq4cZTbwZR2PxG4zWzdMtXXYIqhhT8viiLMyY86nPtLGdnC6hmi6?=
 =?us-ascii?Q?g2V022HyfaOhqVMIN/3zgIG2ZUr1OCWcJrDbCLuh+7fBmp1argi6U/LgzrTf?=
 =?us-ascii?Q?lfwLrNXT4r0Fzasm+6NPJyrlcEO3PN4IbLL2FfpDNEIDpK2TNaMYavtDYDD9?=
 =?us-ascii?Q?v1f0RWRIIeAD+qHvf7yrAw8YdUdVcELKVETcGzBhciTwYl7C1H/gkAh6tXIE?=
 =?us-ascii?Q?tolc/ucGd2ahakUHoYr7YoApbTd80vvnRqjwCnPvQWPcS55SRMVP1CfusHUM?=
 =?us-ascii?Q?X+JVTQCMnwQCnJfkpf4OU935JKQ3ssXnx1d6DDq5rrxbOPmoY4RRWvWsQp3B?=
 =?us-ascii?Q?IhGuHXtNRRbvArYq0LJfKtKRqxZ1GaM+eGMc2L5s0t+sDF+wOcPc9GE76YcG?=
 =?us-ascii?Q?q3rdIW6x1dZKadaayLXeR/4tqJr5b0Ab3E/Ftz4t+M4F4vWUGAywijF+8U27?=
 =?us-ascii?Q?4FixlFKkfe3LCdpJqQvp8a3QoXhmw/y6giw85evYF5vFUPi5RW3qLuYnijNM?=
 =?us-ascii?Q?Ov55JJIjvSl8KKSjIMUei4Mvwa+5oe6/UskKrxrKhY8uC8KKdDISmBlLHd4r?=
 =?us-ascii?Q?6/8ZSjo7/3+Cn1NSyqYgPmANJ+mLLnW8i244ccJRv4USPDRaeyobkS1+uJ6n?=
 =?us-ascii?Q?+kvtKxd+BmfhTTkApxPA0p0nHTht4v9O5YM86LxuNwyF7xBklCQgBwXjn7mu?=
 =?us-ascii?Q?4WZ84X618SIUpOwK2RN6ifM5aiNdaMp0k49W4VmEl6DumURaxo6fjFa1Kbh8?=
 =?us-ascii?Q?kVnFYEhcsZC5rmecBVV/iQVM9T9m8uTX3JIcvKLwQT01AAo9GcmTJFN4Pxzi?=
 =?us-ascii?Q?TtKu3NDX9DKYteFbDpDmtJF/2viyVQOsJ0qC35tfLbLRM0Jf9HAs+csmOJ9o?=
 =?us-ascii?Q?yDnSS4Y7lvPHanrFuoLoGk/rKMNEVEz4UGT+6oKDA6vQ5vzExBaRemPaQdY0?=
 =?us-ascii?Q?b1nugQWBgRcp12+TN52JrIb3RS8NZXHtG8FFX6zb0q6JpaUOphpi6ZgQq9wV?=
 =?us-ascii?Q?4oOeQXdfk/MubqVhj6MyT9cjDre57i4yRldAANcHIHORHSz4cj72E3dneEJZ?=
 =?us-ascii?Q?+CvnsqYvg2SKsiELdXjaFpQU3s9dzQlTobGQeqGM8Pe3mLzOn+fF7M90m2Mr?=
 =?us-ascii?Q?3pWsi8MlkN5WTKK7gkZ12g1f9BVd1RCsm5awU1snSl10GtdByznSR29ultQ0?=
 =?us-ascii?Q?tkTiFaE0ljqXxmeSXxReOSISAltOX0Iga1CVcKPkSY/ffgwHTd1k1ZypPXcL?=
 =?us-ascii?Q?fLyXy7aHIcAQaJTqwnPpSER1C/rZ5acT7/VaIm30Lv6FD7/SXumA/zY0OwvX?=
 =?us-ascii?Q?e6EeL3q6YvpvzSVhsGXaLJ1rkp9hAQObUjY/R8KdppvVua5zgdSOXX6/X+un?=
 =?us-ascii?Q?Q4oadCTwNp/e2KoQg2TykW7cHoc+MD8NouYGxse+bAXeWrkJFcWAl0WeArH5?=
 =?us-ascii?Q?mBwYN3XxEk3iZojZaIn4iDaewSoAOiTfGqxrXQmm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b7c5b-2731-4560-5f5c-08db87407be9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:38:43.0727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtQspL0mOF8XiGuMfEljvyHDfxKDrAujTwhr510dF2WlLOEkLYVUx+PYOkqGZIC/9aRkEs//8XufGinG/+kjPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent
on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index c6aa34f3a0d7..1be15973880e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,6 +12,7 @@
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
 #include "mptcp_bpf_stale.skel.h"
+#include "mptcp_bpf_burst.skel.h"
 
 char NS_TEST[32];
 
@@ -525,6 +526,41 @@ static void test_stale(void)
 	mptcp_bpf_stale__destroy(stale_skel);
 }
 
+static void test_burst(void)
+{
+	struct mptcp_bpf_burst *burst_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	burst_skel = mptcp_bpf_burst__open_and_load();
+	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_burst__destroy(burst_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_burst");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_burst");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_burst__destroy(burst_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -541,4 +577,6 @@ void test_mptcp(void)
 		test_red();
 	if (test__start_subtest("stale"))
 		test_stale();
+	if (test__start_subtest("burst"))
+		test_burst();
 }
-- 
2.35.3

