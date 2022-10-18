Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20076.outbound.protection.outlook.com [40.107.2.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811D84A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDrrznvLoSTj8zJcLYhuJfiBgiyOc595rXHna+psODO6AA9ZNVD4jTGG3pLelkP9Dk6YxKm2EtYC8hBkmPrPoM+MVz2DI2fXbsRfUTyKfhzZksGSnF9TSo1Mqf7AMskhKNh0AAb9zNVx2rSR8T+y1M3VO9R+oDVyTZNW690TR9no7CthvUKLGZI6JMPV3Jeze8M6hd6ZRCq8h/yPJdnp/jury/t2u73KOnukJBFPv/darPr4VIfKl3xS9xCdJ6DGj/CFdoWVAGIQooMPZTmhmaDnfeiVuKFBj6hhNf3ranVHcGenJenguDp5eLEUJ25xAedYf7t9W75YJ1JV/Qg4/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=DwYYEFaCjdnoT+Qa83WWtyKe8OnLh6LzTt0wLSrmVExjdlc6dpfpNpcravwLt8T/M56MHCiX/qfAxE3O7NzoCGmr0nsXKZY5Z32+iBdGqw62jN5dUP858nC/ytLwV0O/deJAVzLOaP7Iu71+qGgyJgI8tU1H7HZ1HyhMwe7prAimOOjc0DvNY+KnQ9mR/fUAf0v1zNxXq+DiDqLlGBlbJYcCdWqcRF8L68Ur/UvEv7I/kPqwqCfPVwGNG9qT3GRheStE9nEiW9QgJ/9IUvVwExD2EARkvIfxzmY0DbEs1XeIw12Mj+pjyw4sYhLgo57RUqN99zmk4POSf/Fw0ALb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=zH/EXftm9ynMXQYcFpQvJODeS2cUvWqAZvCUIgI+Xjn53pB5PoUJS+q08xDbipT7ZB2Jq5UUZ8xpR6C/2nf498KhjJKIzk86K60FQMStql7QLLdnuolFDOeAB3hEaOhRr9S3Vn4PAk/CRByPNVSx1W9OiPnCMZgHvYIDvdhiGpGF+yOwRQuXlAsBgAYFdRZlkRXE8htLb8PwR9ilZM9BNzpCgGLwLB6a3nB8Kh1suNFeZSkHds5a6O6d++QR0aL4aStVl2DlgfKUn70xTx2VgzFJEoeSQmfijp1ZK4c/I49n5V3MxuAixwsD6cCf/FsnjVOGK4F2drm+PTqNEeuvKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 11:44:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:44:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 6/6] selftests/bpf: Add bpf_red test
Date: Tue, 18 Oct 2022 19:43:18 +0800
Message-Id: <20221018114318.23627-7-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018114318.23627-1-geliang.tang@suse.com>
References: <20221018114318.23627-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:4::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a67ec05-4399-49ed-a764-08dab0fe1bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	74Zu+/CKBSH9uGKNc8dyxp00iPWkXoTjgyuovAH9U0n0bUxwNJTWlkgmtkX72MfKecF6J4R2spDH7KziwH+ELaehiMd4E8ihvyP/Xkjgk/W25orGdiaW1vL7yb0RE5VtJ8BDow6gvBKqAQGE9lV9eWZt8wTiwpWPJKROgMRG0L7diTTCweRFCo8g1GnzfHMNX36zjYWiICoZjERZw+oAY+xNxbAvtrTrW5eB+/jBoc2l6HPaKy3O13c7qHlXwhaPO+Fxd5xjiU7XTjMQrktQbs0mSPnKQlB4SIw3vqKy/6ty2eQPOcGzZwg4sYvwOPk6I4UyOfsVuajrn/n+ny3Nvlnc9lm22iGz+lsCPBCZM75XxFwEqOPa/AKWoyLPhFOdjfcz9CFz9X66fj1vuGSgc3hRYPBi8LdvGjxtLkxu8Empm+V+1YAYy6e4tPH5Tqn4ay07oTGkurSDn3eeytfSZurgeWwC0qRvEjwdR4QPERTPDcXWiawzc95ES3AvS9l1j1nKBGV1s5LvQwDxUok2nKIk2SIHYXRhUgis+UpZyktL4lFw8teTiIPwMeTCiw103jQy/Oe45A2T5gYKCAjxXRRmK8wTiUAD38g8vvj9ruOKhAM27pjqvBCWuQd3MhsDoYOvOp7xMeszZYRLt/sL1hI4st/4c0Iyp1zMfxE/9ZZ4MKM01fJ5KATwHs08Mpu3LpjYgtvAk6ohmy6fV+bHfce/6lZOB7LzXeoH8HLuJqNO+d8qsHv2d8aXTbfutxx8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199015)(6916009)(6486002)(83380400001)(2616005)(186003)(1076003)(86362001)(38100700002)(2906002)(5660300002)(44832011)(4326008)(41300700001)(107886003)(8676002)(8936002)(6666004)(6512007)(478600001)(6506007)(26005)(316002)(66476007)(66946007)(66556008)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ADOVsjTnL+F13IzLCun/3dXwMMW09udrYT5TFULvVJzqXe1HV/UWicnC6R1?=
 =?us-ascii?Q?gRqnCrVetyauL/59LRtkQbtFnKWh1MocE6RaPsNQPfbd1UrM1pHBDe1xdtzE?=
 =?us-ascii?Q?EQsLocdSuHymCDeUzr6Fc+pXSquYTufjFE307pP7YHu0TSh77t+gyW1ah2Sv?=
 =?us-ascii?Q?QbtPXRjLC8MtA9hau7221ieQBkxYO8xR6q07s9RgMMrdOnd9xuEAY0zdw4rE?=
 =?us-ascii?Q?pAIwi/0UDWV0xOSwJEpyglbdiihI62rHA+7YMeWFyVpW38gy1MaLN0R0kP4A?=
 =?us-ascii?Q?5Z+bpZdzrOZfsy4yAsPMqqyb2fyveSH8PG4lmk6xHKL6CWhmhUPNhYu/U84/?=
 =?us-ascii?Q?s2jjI9Xmd5a7dvpYC7VYz/rP9saBiB+aPO6l0UWur48JLcvjMx75vRqAaiNd?=
 =?us-ascii?Q?+fCJ0uPtonWQiTR8x2sbBKFzM8fq/MBAkQ1JYiUrZXc/OYpu/qI/5sgCNE55?=
 =?us-ascii?Q?r9FJiK1Bur6a5QGmX7j/2o4E//IDj87aGpiObdVIrncsNNvIDjjRo0B0eXFA?=
 =?us-ascii?Q?oRm8ZxTIGa0z2LGMdjey9WX8lqhTtCJ96Gr2bFYIWLan9kEVERMz/4GwG6gP?=
 =?us-ascii?Q?jWS0gim2ZraAC6vJDx8WKhe0oFlTB5vTciQDvmM9Rmx7gP3QcfR7rUsib4W7?=
 =?us-ascii?Q?DzkBvIIKblKyrUutGuOCMNKApj6Bv6y2sqkb/pm1aGPseV6wXd6VdWtr7mQm?=
 =?us-ascii?Q?GxHa+t1ndnNlS/wbgof7x4Ih5jyAZE6N6AEfLMkMlwl+xCmdLA4QBEcHmCDH?=
 =?us-ascii?Q?DN655jCGvQJRmRQb9fifivpcAUswukIT0pAropCqBsBpeAM4W2UTYI6PZStw?=
 =?us-ascii?Q?4MOiMFPXcYP/8/yUk5OQwUevOmazp6nmxwY4+WXhCCJrunAngD/TGj/+OWe6?=
 =?us-ascii?Q?5peWWoB/ohFgxoU9cJIbLbxCJBZO1byH7SdziAxEeHLDgr6+2AYdKno9o0Ol?=
 =?us-ascii?Q?4/72hpgP+w4v5exy9Knbf2Us8Nm4lnXT4EYAY4YZ7Mjrb+FF03PRQjUn6Jvw?=
 =?us-ascii?Q?MTTRzRyFJasa2YRKcNxeqmqEw/t4hpQaIn1Kxe8/OG6S3qf49jaFOA6VkGng?=
 =?us-ascii?Q?KzhocJRmgDTRXwm2zMpLRPMKPba76rRqLu3zfP8RNwqZqFe4qAk/BcGU+1gG?=
 =?us-ascii?Q?CkNenoPxeoKMHkmz+F6F7d0ZvXwbLraO2qFrr6ACK2lUDFajVSJqLllGe6Ua?=
 =?us-ascii?Q?d+CQDP++2kZfmwlcfYTGoIJmG2ivMcW5ys9s9HaNzHeer+zBPk/qsPF6vCul?=
 =?us-ascii?Q?BjsomNrLa3wbEx+Zlh1ImCGMIJheLUMxMIMb7nBbv45Mp0HPGItFv7gBVfAv?=
 =?us-ascii?Q?2SSNg3DsyzVADVQVnFJHy6mMM/0lFE9HKycjJmdyM0ngVVnR7HOtLRYNTSeP?=
 =?us-ascii?Q?p+0768WBW6NL7CfCZSk0AfcNOEJgZdAvumgL5qPhNJc5l2t4gzMopEIZnLR2?=
 =?us-ascii?Q?DONKaVmu6uYOLaPzW7aHcSS7/KtT5VPoi2pLqRjaXoWTWrh+9QmMhnXBDGz1?=
 =?us-ascii?Q?142YYyKjWT+XNxU0Jbr77ms5/+G2VznZZD89IcRDOlR+3k8lO5z+N1tg3Rq+?=
 =?us-ascii?Q?xLKbmOzyzrTr7SWuJeIp/kcD1Fy1GRiON7Nkn7JzoOVK+GIQzAFVVJMpbUsK?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a67ec05-4399-49ed-a764-08dab0fe1bed
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:44:26.7150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdCHLP2A4N0L+qfg4AWPrrAUB84bHkEeG+6kGa+Z36zI5y6xWxoPJVjXXGeQp8JX9/0SbgLc5XB1xs6fgndggQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919

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

