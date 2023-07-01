Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADEF3D67
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 12:57:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTMIuB3Qh89eKG2wDKcDaPwP+sbPbqODI9E9dA9zV5ow5c4Hz4CjcNZwITcmItRguMnW8mvULpy25yGFEF74utMmfwxWynU8rYobhb2ZLmZ3LfszogrVsxgf9xWdONgd1KZ5hF53Dl1vpBcVo4Xnd3ouUibQ76Ra3mB7OuTq0s7Pgm1PwvghZPcsUvZUoJkXAj+9Lke/q7IXbYpGmrrWYbnpkQakjQf5iGUDJmyzOEymDxeImZlsNduO24K75ey0vjiulG7cNx2nFxwt+hFDV4nfltTGCuwS2E1hBmzLmUfk3s6iRZTmBs/5AA2IVtfELUi2wWr+83AKZkQhHl72Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K03zPrbKsteGPyD9MPaCNvWRRibZ6cS2jInZuWCy2k4=;
 b=BG0lQDPPUmyVFUqhdYyXzGnfIayuHHIvMf0OTtiqCu5IlmSyIr4cE189wCgwB8pw4QW9jDJR4Ic1n0mfBgFjBBlVl3MYmbHalr7+p8xgfmQsyOrOqysdK1CiwIL1iOZ9nwo/ZWNJyJe2lLQzDvJZtLb8frWNvGkj8peQ8hE3lssPBvLCMF/Fz/+dmKy1edI0ZPazm6Q5TBEjP+nccdo3KsAlJv4y4v0zfqlTpvPj07DyZXMEoTk78jhj8OanvptTn3dDtmDwq/HKbkBT7xv2xyqafM+W9jSOhfkoVQwY2esLeyTBBWA486E/LiBSYwLcnzD8VA/kzYs8rcXttqmWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K03zPrbKsteGPyD9MPaCNvWRRibZ6cS2jInZuWCy2k4=;
 b=h4b59VLEry6JhYM0q9Khl5seE/eILaYmKRAwHeVngBAFJe9lOF1EJyL88xVnHthhI8mcNovIBYIIQnuFOXZVQdq94+W3PmUSb6M+9K5IV1+b2EenYobszSRI4bkuv0M57m89uLDag2+urkSjqbXOWYPzfn6q9Y832XcQJ+wnEWmvfqXIBrGzqFM6GqgtEJ3pHp35mYbYLeMxLeZgWXcvKnpdI+RyW7xm1oeBpUdqXFTLur2NbeMG0TBP4Wz/M0ZhNARmpx9OgIbJOPwjiiDBo+SkVfvWC1r177SJfxNi55mqa2BdesO6/AaF79pWy3wtgnlTjaNsBYr4k8PstfdVaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 12:57:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 12:57:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] selftests/bpf: Add mptcpify selftest
Date: Sat,  1 Jul 2023 20:57:00 +0800
Message-Id: <56db1c21d35a76ebc9cc6017da64b30add33304e.1688215769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688215769.git.geliang.tang@suse.com>
References: <cover.1688215769.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0015.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 526eb61c-03f3-4a05-67b0-08db7a32c972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oGv8xMj2K7MGoNJcP/2Tz5vp7I99TaEGTwjSKm52PVKS1gF8P1YYgQoZ8nIrglLQtupX2l0uM7Pv5mmZqBLLmBMOs55lkXxatgX2MblCRYo6TMcLJb5ZQ77BsfugZleV7oJm8OVz5LkHHe5Ty6KUxqpM4m3Pnk9v49hb4Av9Uq0OPaudPlVcaemRbW/Lo3TlOd24oXZ6SHKSBjZ6p5hROUcGbAC761CKFfyBQnoJMiH+OCv0G0VknQxs3kXuABzux8JkVhn6GdVYgcMWSMsdBihgP31FMJTkfhka2u03/ZgWbaWQRXb5xnhS6pzuq9Bf68hVq9EGhUQ84LsYR3PsMuYEsrW2+DXR7mf4xXL6VrN81NHze7YLpcpSFP0DvYKWY2n6zif0OkOARgK6idaKQ1lRPDHlslFjckg0P9iRQSXEHfOWzTrJp6PNvCgSOUqibJWHNFmUKrH+oMC5d9KpKQh0+Zj22Tgo9ct5kP7b0JIgOE6R4BXR3lQOvkwkjsEK3IZQiGn3mkTMKrr1ACSddl/oh389ieIJLw1qtvBTNLEqSum2e4q6HhjCehLluJ4A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(107886003)(36756003)(478600001)(6916009)(4326008)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(38100700002)(44832011)(186003)(2616005)(6506007)(26005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfNIFQvZUMp5aHHFTNyY8OO6GSv6/1X6dn2wIRehVOvHp/RkIkNDSEQ12p/g?=
 =?us-ascii?Q?6yt8TRvHaoKVRTnUvqaC0qCOJWbItN9taTEAsf+s5g8InEQabHAU/wNb75kk?=
 =?us-ascii?Q?nClOYilCrBIQfKsLIhpZVxYHUNb68+LhVOmswU++RSjRjnIbFDTFIeCsHtfh?=
 =?us-ascii?Q?7pxl/k2zS0/VfJJNq69LsVGXrCBbhrSVML+a+28ig9xc9YABL+TOZ5mmRMEU?=
 =?us-ascii?Q?rAq67TR9OE4Aiow+8WNE6o/ahiujguDP6W9NWvjuvHPVQfs7VI7WUMSKLKvb?=
 =?us-ascii?Q?rjDZ0dZ74MYHu8aAw6Wq8LzsCUDVrgG1t1t4vHxjFaxbosiZ9EIKYYa5KAFD?=
 =?us-ascii?Q?5LT6GoTljwJvAb66OBwm9R5D/6SGfcdM3u2uj7voG3XxvoUOz3wG2KkNmWUG?=
 =?us-ascii?Q?5BcG6um0pS2axNSa48VLaFOYzYhw6z5Dq6M123XLImZ+DKSEhTqKbBNwy7PG?=
 =?us-ascii?Q?LbgoffvPvpkUkItevJ5A+j3lRlOFPtKwgsDJq0JP2J3Y6OjkfF6Km0LggTA3?=
 =?us-ascii?Q?MpaKPBAaoRwhWUsCpJz8UuLg6uFAThmT6/1aN8n7/razdz7ITfvYxRAGXXB8?=
 =?us-ascii?Q?jsORb6xVjtcL4lW0uNrVgwM6xM24L8PQTvdwz/dnr4B1+RviFLtzTOx9FRaq?=
 =?us-ascii?Q?w2j6X9t7e5EVmxhE7WjpWPOoD2YpduVx1K26QBjWhHFAbPJBpDMJag+tcS3E?=
 =?us-ascii?Q?3fKNCaXlxqrvT27wLFRu/PHM+ra97wSKnF/jZ8jhVsLg3JTQb3/a2aILPi5A?=
 =?us-ascii?Q?zsv9UIxIwqSSASoWDL3usf0Eu1jTt5BbSmrXfxGyojMt9MKbYGKQrKP4+m7r?=
 =?us-ascii?Q?mMYAuNJLDEMWKvW5ag8xqMqjKuEIDoGNRnSXICPvT1ilFZLtImciUncsCt79?=
 =?us-ascii?Q?7Rc5cBi/dFvRnwJ/UnZT6iZDEwbU16Q53xE+WU7mDcTAgYhiHDS8k6AjvOzl?=
 =?us-ascii?Q?9t+zhpzUe9bpZJCuxzKcA0WML/MykZERvoIaJC1RPKhN/SoKKM+K0Pw1R8Ah?=
 =?us-ascii?Q?hMU58xW6JA8PMIfhqSBgvdhbkyY7URiir37DStneDoz/AMI1+mX7pFsl+fo1?=
 =?us-ascii?Q?3tv25mgfNUNyrQVyJCE+gR5wqbbn4Gs6IhLwAh/xylzqqlQVG5PcDq+FjZq3?=
 =?us-ascii?Q?xxMFcvpHIFVdJ0lSSwvANkXa6qpINX6jCgichnoyYVfLL0Z/NphUsNQo5Zew?=
 =?us-ascii?Q?1RGYWVGNoj1JcOhnFjQuDCWw604uSjiw6hmupy366JNsdAu3ySlVZJH82Irx?=
 =?us-ascii?Q?nlwL/joOHDUos+6aPcnAfRcaBpZm1qQs7wXJxy+9wfb5E84vd8L/jB5PBRWY?=
 =?us-ascii?Q?R2ya2aa71vP3zPt8KsOI475xiZMgBhw3ptSne3kWDor5Ztf6I73PbcdCU0VY?=
 =?us-ascii?Q?tIcCtMdvKj1b6raClKS/OnXbtclZOr1G1BZCdtVDOgUI3AGvRufcd41CiQVb?=
 =?us-ascii?Q?C45NHqNm3xFbT1Y7ALsFfVx3cokuX6tZj0UUU1ks/LBX0dVZa3xtqICa3GpQ?=
 =?us-ascii?Q?/eXhKKbA4OXnX6/RNkUb5djIGquj9+1iT6OzrhZDA5fJ/77c6ISMk5rpvxOT?=
 =?us-ascii?Q?NxsT7LjTpWVw+ZqeQv7gswpGDKMjtS+ijCdJhUXe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526eb61c-03f3-4a05-67b0-08db7a32c972
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 12:57:55.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT5nrg7M0xN/lQMYc/lZxLv+wqmo7AzYw8VV26+Z/1VGA4iSUDJ8DzODyy81SnJ9WUMQwz8av+WY34eBw9JDBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

This patch extends the MPTCP test base, add a selftest test_mptcpify()
for the mptcpify case.

Open and load the mptcpify test prog to mptcpify the TCP sockets
dynamically, then use start_server() and connect_to_fd() to create a
TCP socket, but actually what's created is an MPTCP socket, which can
be verified through the stored local BSS variable.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index e430bebebcf0..5f498bf5a677 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcpify.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
@@ -13,6 +14,9 @@
 
 char NS_TEST[32];
 
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
 #endif
@@ -200,6 +204,87 @@ static void test_base(void)
 	close(cgroup_fd);
 }
 
+static void send_byte(int fd)
+{
+	char b = 0x55;
+
+	ASSERT_EQ(write(fd, &b, sizeof(b)), 1, "send single byte");
+}
+
+static int verify_mptcpify(int protocol)
+{
+	char cmd[128];
+	int err = 0;
+
+	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "unexpected protocol"))
+		err++;
+
+	snprintf(cmd, sizeof(cmd),
+		 "ip netns exec %s ss -tOni | grep -q tcp-ulp-mptcp",
+		 NS_TEST);
+	ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!");
+
+	return err;
+}
+
+static int run_mptcpify(int cgroup_fd)
+{
+	int server_fd, client_fd, err = 0;
+	struct mptcpify *mptcpify_skel;
+
+	mptcpify_skel = mptcpify__open_and_load();
+	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
+		return -EIO;
+
+	mptcpify_skel->links.sock =
+		bpf_program__attach_cgroup(mptcpify_skel->progs.sock, cgroup_fd);
+	if (!ASSERT_OK_PTR(mptcpify_skel->links.sock, "cg_attach_sock"))
+		goto out;
+
+	/* without MPTCP */
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
+	if (!ASSERT_GE(server_fd, 0, "start_server")) {
+		err = -EIO;
+		goto out;
+	}
+
+	client_fd = connect_to_fd(server_fd, 0);
+	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
+		err = -EIO;
+		goto close_server;
+	}
+
+	send_byte(client_fd);
+	err += verify_mptcpify(mptcpify_skel->bss->protocol);
+
+	close(client_fd);
+close_server:
+	close(server_fd);
+out:
+	mptcpify__destroy(mptcpify_skel);
+	return err;
+}
+
+static void test_mptcpify(void)
+{
+	struct nstoken *nstoken = NULL;
+	int cgroup_fd;
+
+	cgroup_fd = test__join_cgroup("/mptcpify");
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
+		return;
+
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+
+fail:
+	cleanup_netns(nstoken);
+	close(cgroup_fd);
+}
+
 static const unsigned int total_bytes = 10 * 1024 * 1024;
 static int stop, duration;
 
@@ -459,6 +544,8 @@ void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("mptcpify"))
+		test_mptcpify();
 	if (test__start_subtest("first"))
 		test_first();
 	if (test__start_subtest("bkup"))
-- 
2.35.3

