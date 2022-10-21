Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013F7B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdZyaBIrLZLnMcGmIITK0dp6yt7PMPwmCXxf1Bye2ffxafIIU3h/Q1zn7WZPOj0+nTB1grKMo95bQ5D/wlf2VCGe+PVcFbRvwu9+9qyPGvuHYJETYHJmI4mdhSe89IHi2W6wng5QUKQlBwlve1Y+zVkBVFRKxvLHPz4oWw4Z8WCiHtBPPvDp8T1juk1MrcupIrkApr70oXUPzwycVoixWrF1xgnAO40SwVFPiF74qXgMTUV1+SwDudtD6aO7ZUi8w3sBvelAZfuxw6KFw85FHIcNx94I1xcofYPYs+PusNuWKoNkygqFbi4a4lXVdcmNkHfLcKFVyEhmJzmq7Epf4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=WGXZ4r4q11CJFKTanUaD7BqmPNS4OZ8bhmucRsRrcBOMOCqqDCwNDLRHEyGJSZT/DmJxU7sItBJK+lwi8saWbwk8smTPE7Ts/SyU0bI3Z3RhRG55wCTq9aJGJH0oEJKKTQ+iCxwFqyx42WaCZubgDjqr47RF9/624Tc01MwZ406SVPWIe80pXauwrG4AqqgtpLEKIauBtWQUpcuxOYAyeO0USTZYiK6qV//Cf9osV+/HfGN7EAL3d1PyTZ7K1YFIt6/3g2Vz8wUO4Mm86XgDATds6cJBU/ppVo8HaehXaOfWyRcodeyMGvNWmWx4gXV8c3DCD2lfY+KFakLFyQXyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=uFwOV2f5sVkS9UV8R1LGJShKjQyK3EM/wcRmIyhs8/AEuR75m8cOkQWDr7HyOOlWOxlUBHElfDs6OXYPLQ2x6ZC9wU3vhTXDkfwnKpcmTv6hKWmIDhzZFceLDRfZOsq97VZBFPOxgMSnmF3hioddMxjaMc8M7xmM+/mCXO4aBXIQiZUBNv7N4a9utg6tQChm2ZeFJ1hjO2nstWc73957X0Ub+XxarWos03UFblPjkCiZwj5FyXKIasmEnuccM4qVoViDxY1AqxpCqI8EJhtCzxDw1L3eFSPcvT9jt4wzDkzWSlJHlnEcVoyTYgszxkm+ko8ovepTNSLoAt1QKqzReg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AS8PR04MB8884.eurprd04.prod.outlook.com (2603:10a6:20b:42f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 11:03:48 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:03:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 19/19] selftests/bpf: Add bpf_red test
Date: Fri, 21 Oct 2022 19:00:11 +0800
Message-Id: <b0a39d02796da8a214fb8b8b9a597eef59e3ebd7.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0115.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AS8PR04MB8884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9c4012-d991-4819-5d80-08dab353edd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2owvyckFkNKZgQ8dQTPYX6+qd3SobYx4wzIq/oMwkhwzEAmsvtXWnNEl/UGe4gllg/8cE+IHpOGiGJs2EcEJYT2BNXEdqyw3vwrM1Hn41qFEKWhTHBZY1OQ4sbaPwVXqBp6nNAIaiXV9wMDaySmz8vPcsddrKLYC6NStlweNtTYZ/PKGTLNZtEfZ0j66BxkxxBrQyYoF73iaoAlofIAmn3cd40TjpikGEwZ49WjgtBuadVV9yuDN+KxeTLTWhzfmdFzcHQuVCoJLrKaL4T4t4YE0RDpTqQGg0GJjSEEgizaxKCqeo2dEnZK2HSS3BlHqaaQW3bT602t+Fc1RBrqxNAuWkh8JPiP2t8heuJdW8xbSFwtzn/81BSUqpOQYmeY851yIyH7N2esOFBuGASewIolPvBUiOi5bhi8eNl6vEQeecmtUFm7ED/CjU+l2gqwEC5uLN/f1spUmeVCB39/GVoqDxEsAl8Txk47b06Qwux4bhYiP1ZjJWsQwfgQnl9eIvW2OOktX4M9/w4E1BN7itmj+9GUBrRqwLt+LF6wGEloibJaElMqQx/dWvmA387cx+6leSEZhqc78ycalCXZ4SCD//L8ee5Y079p8FqXvO/Aal8X/9OzCYFaN0QJMt/JppjJ9EoTCJKHlPwUGeaxMlt242AEB40di37w++Iz+DPiBNUfNXnEUXC8XZCvZVW+o+o2Gx7I8EjXOvG4yd59Bu8okaPUpNx/2/9Dr+1z86imomTs80e8xgYlQoehYs1Yh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199015)(478600001)(41300700001)(66556008)(66476007)(36756003)(66946007)(44832011)(4326008)(8936002)(5660300002)(6486002)(6916009)(316002)(8676002)(83380400001)(26005)(6512007)(38100700002)(86362001)(6506007)(107886003)(6666004)(186003)(2616005)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fiVK3FZJ0+3n2qeZbR1+TUwMlhGlTzy/gPDHNQa3UCB5LLEXhnsw1roWW7T?=
 =?us-ascii?Q?F/yV7OGz6EA0GN4EP2baJ2HczATcm9trRL72lsYtVrDpJqhwi/1OT6ozL0je?=
 =?us-ascii?Q?BdklwPtpDH/5wl0orpboIXXhuijl15QaOF2UQONLpkpoqXDDxcVO4maxcxYu?=
 =?us-ascii?Q?ZK95TKOPZQaA5beLQ6zwiey+6s04uA9rxbW3/asoQyU/FzUrBfXbtZyO73Fy?=
 =?us-ascii?Q?SUN5RRcld+aAbWD6aUb55+2n3Hp2GY79640wsfyn+DGjGKMZ9aFG+DSFrVKz?=
 =?us-ascii?Q?/19mFmghx2sBN09uK488hUWIMyMo3DhZihga5ZPNmGfWt8OK80XaXo4lTASC?=
 =?us-ascii?Q?GPsfs9Pc3RBol1GwlAK4pcYskvJzAWJP1iHhU/oZiPY+7+A+UgwaY/HzEfrP?=
 =?us-ascii?Q?MtX/g6/uccCJ+fcHodrMDbm54dNzx7HSz7o8ts/nQww5IM4xtV/3Vo/JQkGY?=
 =?us-ascii?Q?ZLcmub/bJJbzyUxunIrI4xuKveEkb6EYI6+8pIJ0/s4moUXitioNfL77gpyJ?=
 =?us-ascii?Q?kxnGHXCgfmfPfDAgraaS/g9lpAR2vAaVjSqGyMV5zLfz6YsUkQrnsYotAS5f?=
 =?us-ascii?Q?ky1hh4Nll9Jd1dh7RWTJG3rogIJKcpH4OMSELlX6/mJIevdu0QCV/jvYxt6I?=
 =?us-ascii?Q?dhKPUgkO8mXb0evHwubAtbuTfiahXl8yU5RpmNqlUDX+yZATFt8aJSg9QSIe?=
 =?us-ascii?Q?TRZAoqSPLzr5HtUu04JpbmtZFKuTF5ht6jeUx9QwuTL8X8zz2rtMw98iWEd/?=
 =?us-ascii?Q?gKUy0Wo6T2XcISjqj0suf/QmuMl/z0Ql2eQReHVO0b7T3nYY1tMYR1jLbrUe?=
 =?us-ascii?Q?lB7bZOAc2xhM5uvDeu2q4amSAXZPWExRxIlsfMsMph1MhHO2ulo+KTAY8H+m?=
 =?us-ascii?Q?tbfMh5xb/3MG4RBYdZBRsVgFyWDebGp4k2ePMMI+Qwp3sPw+ifgG15Wn4W2T?=
 =?us-ascii?Q?qgzofixUFuaiawUULjX08DWSc8//VK4unx1z9wpwOUOysviL4M2dYGPj8Yec?=
 =?us-ascii?Q?Fl+iKJIYQPRk1rrklwox0ALU4aej9eK2cPMiZqsHKKiU9M+PkPa5BtFSCD4x?=
 =?us-ascii?Q?Gv24Jou+4L/0AIHYGpPBUFGkj9KV4l15sa+V9jQoVyoA8PtOJ4LQtVUYUN7i?=
 =?us-ascii?Q?oPvEXef5c1UA0xth2uqQPeZNo1IpOnz3xmqg8OPm6EYU/uxK5KS+9bgo3g1k?=
 =?us-ascii?Q?nc6R1JY64+jit3Bq2P9/9bKOh0UkB4BHWG6AtlnlF+kot5eiLg1mer0hCOKD?=
 =?us-ascii?Q?lOOJdYEKQBCCj3Ia5RBx+nKX4t9mJRfdSLihEisJkbbrLVd9gqSt2p8LFb5j?=
 =?us-ascii?Q?N/lw0LQ6np2zNA99eapnJJe58J+rzBZsiYqO5LncSLKltlpn5NSR5ZncmMIk?=
 =?us-ascii?Q?PtUVfpt+8ccohds8twgZPiiZohVJSQDdDNxyyIeDZ9cW4pfkJrzsETKko7J1?=
 =?us-ascii?Q?dTH+G4yMDm1OPOhhcx4W5yr4+16B9090RocPBGTYAGmhYnX3mm6SGfNPYhsH?=
 =?us-ascii?Q?tkulH1Dra876AaQx6Cp9CiLR4t+fsjFoWVNfu7koOQEG2c2S3NDmaZSkqdu7?=
 =?us-ascii?Q?z9v/tZpskEoF0bWspz8AwJf+8Ef4B5daqAVPkGMsk8RJAAb3cmvVpjr8f5vT?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9c4012-d991-4819-5d80-08dab353edd8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:03:48.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xw8H7NtPscO253sQ8MVF7WjcTLi2E+5oE2nZdFjRRy5PenNUMhK/2+SUFU1Z17T4ZCGtWhiaBe9hYWEu1fALCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8884

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

