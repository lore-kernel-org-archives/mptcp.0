Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723FE7E3
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 09:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8yqdDnX46PT8W+2RTZ3iRY4yLNJiOQhkIc6rPQCZtKSIgQ+TumFtIdruzjhV88Gy50BPzn0bzwQveMJn13m0Ta9D7kbHx/FTMyKEgw/E5x34c2XUUVsfmxlNpHK4nL3HzwuSNaW+yqXTxAWWTBHZ6tHFt2JFeohkXtKbZzRvn3GrUhkOP/rsxKshEuB2dyY5E+kaOS9ouzveaQtUNQPgcGYqLfYol866LWEe8pdcqVXqlwAvjJ9Y8fDacjcVMIgCrngnsQYVc8r+sxGmuHgEh9tF5dRV2Lp67BEsHr7xFwUs3jzO5GcfrT+T5XSm27QWDSR8l0uYfXk4j5CJYG64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=O+jQA9OV5gg1Oe1HWBSYuGA3v+YnFWmvn2AI4PYZ6qzn3lzHbjv7bgOeSVy0WSjZNFY/OF1x9SS6gBI/uJ+9fev5paRaeUFHf5wBRg/JZUlhzUThm5eB+DqPjqemrRYQoAUEIlgtdyamG8ojNLAE3mYWUYwATvNaKt+LZj2J8JCjLttj53VOWoMyoNI6H/E6QbdMMNSPTbIwCDY1HnyNBx7A7kDIFc8UAmDqoo4igMfiPvmmW7Wsa20IHuMAVU5G5jK9bXuGL+4njAoiZOzsIAlannTaZUeuxKNOpHK4WqJ0MJtrLFjt57lB3fKokGa3Y/BmZ2L+t9vDaBhpvO0Qow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=dQUCdCVflUZvYYTgaXYkEyUMvTQtmsAkT904B18jefJnYDYJKByGy6Eylc8n7uqpOdKbdw+akgyNTqP5CLg24frbnVKJo1qFb5rfTtmEGPVWH+fae167syizuecJkcXp5L9yUvOlbnCoISN8ERmuQ4J21Hc6hiJYucK5w8n82nQw2547TMpLH0odaSejiyTxcNztzNj6WUodgRnh+uI8mvvcIwqlOUb7RAc71BHitI5gj0+39cIxEvPHNOyJfn/vIUZazRnsS9ES3GHKhczdLRY3160pvjmpeCnhfM8dokn1kRI5R+sbWx7Fs/4dPpE9YD0Et0hIZQOJGSnNnLB27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7542.eurprd04.prod.outlook.com (2603:10a6:20b:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 09:11:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 09:11:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 5/5] selftests/bpf: Add bpf_red test
Date: Fri,  9 Sep 2022 17:11:36 +0800
Message-Id: <03a6d8d7833e6b258ab4702291f01c8f2dd309cc.1662714028.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efd5c35-a73d-44b2-e223-08da92435414
X-MS-TrafficTypeDiagnostic: AS8PR04MB7542:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rgIhkCads3zk1XYQ6JBG4fu9CAdqYYTGBcZEGYhmqedeFKFFe82fWpAxu/RdyApbZQ/ec9ADDrA//xumdaVxgNzszQU/LNk3pFa+ZxknNLqdstOYO2jY4OwumI01nfOjmsrWMMZYRUncu6tE2qCoxHIt+QS5OAhUgLHHnNcT2e4TCmnRW0j1lwELhJ3XL+Vd8cRfqMqLauO9pDcehoRLheJZYJkXb5X4NnZ5vhZAhOH29p4kLJAOwEVUuDlL1f3fDXeL66f8mhGaK4K1voE+aNGsqGJAkCq1z5M/+SRAHQpMNI7wg3hxRzjw/+iUKNaez/bTnkg4v4elSikikM/6w2Ih+A/ReIGjstpB26UK/WQ3RyaunFFbPXN9XdY4B6VjncrJOUY53I7B8SJuyjsfgtuDy9cYjXjgbZ0QovjmsIeXwjU0bBk6dH40UovSiAJpRafBm3VaRIk3ODJbVmMCOJLqugkvrBdHBTKIbtEUQwbQUSbIXWsgkQsiDrOGEZd+mjJPidBvtWXnykxMbA5Fq3iLvE198xQheihBrIjYKlZZntzgvp807+Cv5xCk2FfbnXmJG5FPweA75qXvLXDVuwPu6I0WmEjTNLtlr8S84HOt+g4BegAkCYVfsDx8TcrX2nC5ojIBQqVphLaIcYylLh1sjzdrt4neBxz5OSXNL56Jgtk1EID8RzSh4k+EkwXypc1tXZf8U+aRHb9FY6CBZDU5kFL1cF0ug9q8K1PU++svI29AE1zuV55uJMiXplpU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(38100700002)(4326008)(66946007)(8676002)(66476007)(66556008)(36756003)(478600001)(6512007)(26005)(83380400001)(2616005)(6506007)(107886003)(6486002)(6666004)(316002)(8936002)(6916009)(41300700001)(186003)(44832011)(5660300002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+dAM6ah4+reAUtfevGLN2R65C/9doiFv0MHEvch9KkxLFPE9kDDiiIT1ZMWi?=
 =?us-ascii?Q?KNCbJviSuksdfayVpoXKvjNYu+AOtbTap4LseaIMQoKXvnPUwn1aI+l1Xl7n?=
 =?us-ascii?Q?AFbREsqtG81QOcxAjE1W0pFiA0Fx40NDxAaVxeIpJQRgzdYiZWrD3TEOuHh3?=
 =?us-ascii?Q?4GdDhMA8OSGSsbTksSLZDF4kAF74N+bORhh0nC3/E0cpwGM4QQ2SEEjJw5/C?=
 =?us-ascii?Q?N9HJG/sHzPNvM1KMZkXF1pvbtnl50VZK+v98zjK/ckWsMdKMR48RArEcll6c?=
 =?us-ascii?Q?EjQ8q70Vb73oryVRWpiKX9aRbOWqN6w0ynSbWNAceXbI/uGQ4eCIhy5gRnP8?=
 =?us-ascii?Q?6gHyJB9i5LfMMWOz+Kz34YEsj4W8AOoU2aA0vCbw5R690mUJaJ1nYLvb61AV?=
 =?us-ascii?Q?pwHE8r8MXiHF1iEsz0RiaqWRwxmh/JMWCHQ11SmRvLhUBR7epU1FPHi7hgIG?=
 =?us-ascii?Q?DkdMzAhdDtxwQzE6snc1blMIwFNiSLxhHuorU4fWArmWyaKYDa/PkcGRF1FG?=
 =?us-ascii?Q?s2r1xm/IMcXyZ6nchZniqkQo4VdfDwCBY026K4k+2Re8I3MaY/K9NLrUCMiG?=
 =?us-ascii?Q?7F/eb2ZFDscFbawA7n9nzakWeG6ifYdlDgamIL88/3VOkWL8JpXPIO86yg6B?=
 =?us-ascii?Q?0k7U7/8mDhZkG+21zAvyC7s51BaOZ7hXWwEvEkdgylahA/e06menqLLmnusi?=
 =?us-ascii?Q?X1laUYYWRMMZWj/XocSwRGP9I2SnJhuvwuVqOM2aelVcdNnm8Uqs1NssaCGA?=
 =?us-ascii?Q?DLewzyUxSoDsbI/X3CAIdJHNZd5HEwLg/7OuvVzroe9j/NeOEKYRFzCa6W0I?=
 =?us-ascii?Q?8i4Q4/fmwhe64BKCkiNYt0uXWripINGHqpHbh2+KervMi4C52L4WrnZMNvmK?=
 =?us-ascii?Q?YngPTG1HYtyuKdoj2O4JlKfT89yx0iAGJY0loBKxSIGbb8N3aUvTk2Wyx8Gz?=
 =?us-ascii?Q?ruHzXjL7bKdfkA6uTh0HrJmIzACKxizLMHJ3jY46G8pJKKNn5bJG+47BXcT0?=
 =?us-ascii?Q?LNVI8sb87lWNEnAWyW/9iRu5rcbnTKRYOxnG///gnJ2zyKniAGG+HlQGbigt?=
 =?us-ascii?Q?ogzykIbYwHVqJXakboOQP71NW1NEHGwMBRgVKSsOV0fsK7ar1lMnaN7nqALB?=
 =?us-ascii?Q?zvnPElD8hrvHvjaEQFsySGHI3CXsTF5rJvtwXX/xz3fOuBkVwAfRw6cfmc1G?=
 =?us-ascii?Q?0MdKvGsQrATJiEjXg4n+atnzXsegDkkilPjn4e2IKzjXc7kjvRTY4ui098aI?=
 =?us-ascii?Q?xX5T34RNsYWc8lKJwKaZ2GJYLYJZyMMyyHHbQJxviG6ckLhqnEOArbA6mxns?=
 =?us-ascii?Q?9oQQLZ6du83OPBoIdc6Cv1ipqdQcNEGF+QSN3EODv52/2lsohNA7fh8ayPa+?=
 =?us-ascii?Q?oxOohmTWmSSQ17OEQzTjdTYkJ55NFiQ3rX4ZMZX//UzwBP5QnKR1a3592Zh8?=
 =?us-ascii?Q?KYMvlMftNvr9LIrPIgMVTS0ph6dlmqrXu5iPAyXSlYwauVcRqKQgztN+C8Xp?=
 =?us-ascii?Q?IZV1yAJw/hBcw5ckwXHkIG8HJs6OsSFw7itFbqWlBmAIaF82eVa+90oCrttq?=
 =?us-ascii?Q?hoooMmKJCvOrnPJfbg5nAs22LPVRa5QkxtWPNjvU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efd5c35-a73d-44b2-e223-08da92435414
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 09:11:49.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNyE36qhCvoG4V6ZPwrP441WoI7FpRFOeSmo2UeairV8C+PgavR2Q+3EIGVC3bBKDOFTYZBWQbgscgy/jyoDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7542

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

