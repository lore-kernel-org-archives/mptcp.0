Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F6F33EC
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkbWRXk6v/7tJ3+aijsR+6az6OXVhWYlogzxbwDmGKqx3HacKlYC+2RRP66ZGi9aoADQwg8ZvyXaGligpTu7gjmrjV6ipUOB4p1hILTFnAzIufs3NwRnFVZb3ZokNw1W98/m0CagIXxD/YMyPCJtMSihBph91HgR0WUruLwxkhLYnYalwtlpWMdY7oLPNWbYFC2XWDQ+hRZiFPNiPtCbM+ww9LTMtAc/wW3SPpIwJwxFDOmz3dykubzKNAm9SLmfhnGphX6VVsepJOMTLREuoSLuVy1LvTEoclyTKobmNbfpwHLooMkqW1wbXIIUcW4dIMnVLahH6Icstc+3NIqkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=h/BJ2XfduN1XmLMzs9kosqL/N+faAywh2w5IgJZgmJVVRBBU2cJtc3RohzBvWwE2CRW3/KII0NNJeEQJH43YwVwhVp52QiTrycN/YnRIkGBhcEwxj3wosoExeRgiqPm2qLzD+LW1SFWrkA5ij2XVO6+P03u8ZVggnGoyOhO7rEdIZhiOT1GUXsp6pWzgwm0a4dfXt1Xv+dmdhhJiNKUNL+/n0zDC8ZkntXhkkqGnUZP0uJacGftWmusaHl7857qyOFLLUGguSCdrsyxVEDjiQAMaF6dlRi/oaRutZrMyyiWxXLhiXJOhQrQ89Iy3+NiqhUACI4ee+ezVsATAa2C9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=P8B1MDLlfwm7C90fCBUi3UvU3iWaZdOVuhT3Fix8fgo6oabkEABQEwct+TffvRNqMN9Sb8TAbkyGVYzx7NhUtv9yfQ//W90knLBi3w1GbFk+z9StvVjVf25gTPEBZ1eXGSkcPDYB5Qw3j5rrsZliN0AhNo2MZnzgbKagjX87dyQgYRedXlwmtOkce/D5lYPqF38i0jrJJxjA4aqHCJYnlwRT9r0qXGjxOB3BwOW7mvgQyNQKAIADLQYnWecQCnq1Gndy7dcOQzrtgUuJSEav1FJGfp0HhSUGSJfyZCndHmb3ueIVNmIVlUflUGwWoaABS/DPqVtsElh5kKwF8eNL3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 15:26:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Tue, 27 Sep 2022
 15:26:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 5/5] selftests/bpf: Add bpf_red test
Date: Tue, 27 Sep 2022 23:27:04 +0800
Message-Id: <9c104d9eebb5c7f2f6b5e0e0079cd0efb90c788c.1664291273.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1664291273.git.geliang.tang@suse.com>
References: <cover.1664291273.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1c9dcb-2599-4564-bb79-08daa09cb65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dT1DFLfRt/GjcRlSZPG6W/CPjgzP1HiLfipGRQ0OMYLFGQgOHmi6OMxFG7bfCoYtYweNbyG4OnVlj/aQS1A0/gSdJxqpx7Y9ILogp/ikgTtTZE8iEe0a1VzgGB61UxGCxEA1dowuZHjjn2yuqXR70dtQ+slUtmSy4NoLLKL2gxDPZX7a2PJEmWAIY+ZlPftnTMFYFMH++VbLpKjAJKo0/YluSrOHbsrjobG1VzGNuO5dzcVgVpg3YQHFr5i0ss79/effLUo1SPIeFjSJFPg9s2uTZZPXSBoWV0ZVFrZXTVeDtpxW6H5FeLeeQ9Th6MR4a2f7yqHE87imna8nJUxbGSL3NpDwCs+uQyi5rJhuC6BMtozNKWe3Ao4dX/LHyiZDpTnkC2G+QruOg0LPkNVV26ceCKuBQZ8IdaL6TdivsZQtEXWyUBma7PeKdYoVjFra78PYEmBhUjfbW4yW97hPtNw0Rpll7cXgALwQCqDUquXwtBNH/honkB+FpvzLkIBDcS2/i5qZy/I3EFwtye1m8TnWAPyitX3aMASzlyZwcEao7p+/5iS16FVkammR8iEHJFEgO4xtqhjen6AVeGBMFbbAvOv+teXzJxgdMDIeXp4Tz+S5xtIZ/Ryzq2pY/wpojuVF76a3vIDb+IztdYZuqfpJ0GKFnM3jGASRGL3+EsuXky7TicUFoDzweJRM3FcNI49vffEI7dDKaH6KsIoMQIpCxTKhL3pfl//02Jz7gD7sVX4bg7r/JG3hTtpN8znF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(6916009)(478600001)(6486002)(8936002)(2906002)(5660300002)(6666004)(36756003)(316002)(38100700002)(2616005)(41300700001)(86362001)(107886003)(186003)(8676002)(66556008)(4326008)(66946007)(26005)(6506007)(6512007)(66476007)(44832011)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2oUOVkTpdw3+jTT2WdFLOb/Z4W6Xz+tN4Wvg5F19ZjVkP9KHs2TN8L+B/x+?=
 =?us-ascii?Q?+TejN4mdssvgVInPw+VQNg9CiD0wn7PPsXnzgeBO8BFRQO9HMoO+Vnqim9tb?=
 =?us-ascii?Q?wMsjTlb+4Wje2j6I5yGQxaD8DbyhG9tLH7A1ED4SYPex4rtlE7rINre+ovRu?=
 =?us-ascii?Q?v5PE5MgD/wXC5Emp0f/W/j3UoOqUPjrNDoRT/CaGj0luEq92Gc0TaQPy95d4?=
 =?us-ascii?Q?lVV357ZoaqYVVcVkynbkKGKkijhprrLXdU9buviRmJWZyK/N+Yn83g7WMqnA?=
 =?us-ascii?Q?eqVTgIzfPZ5t+UNe45xylnCPVlgaKrZ+dJzievJjM/11UseK6qWBfvwFTTV3?=
 =?us-ascii?Q?iVQsSutZLq0P1hy/VxaKpa5Iufd0gOB5YVBep7HqCNRFLPxsE/N7wTarr1Wv?=
 =?us-ascii?Q?NwmqWYC8b7NrGrCUqJ73V+NRyEnjTajmvY5M99C8SxFE5zibajuIo/STboSc?=
 =?us-ascii?Q?d1/f6hWLkaK15NLqiENOxClB/ro8UN6uVi+3ofggeO4H/+YcpYycRpVAKE5J?=
 =?us-ascii?Q?Y5EKrWvGyCPqjcEHV00CwTUObkvltVMhjsYWyQYbcadQqA4Gg6QBo/0un7QL?=
 =?us-ascii?Q?mwoE3zCOBHd87SvP+EmVpP1tVm6p5qfzVqsaGOYUo1RA6Dc5Jj4STZ/6+LEz?=
 =?us-ascii?Q?iC1OGcbow9++zXueaU87GBUplE6legXtmFzVyl4DdgS2yUo9oKh9VcAlz6+z?=
 =?us-ascii?Q?9mPEo1qZmcQUaI+7urHcrZtpBMw44OqQG0Dn+Ir7A57alMJpdkam+8WLH2Jw?=
 =?us-ascii?Q?D8EoOHwpXtG11eFMr3LLoQMOjlE7AVXn7bkRG34NLU8ui19USMnNHysDpfbj?=
 =?us-ascii?Q?jTo6+mjhsz1WcyukC70htXLBEJ50vG7txo9a8ONvhblkli+Z3lbuviJQqfa8?=
 =?us-ascii?Q?cBVrarkVopMYiPq2dTlwOY56g24kCXsbX3oBetOiVSju2m/0CHVKUeMxMi6k?=
 =?us-ascii?Q?uSaVz964Igb6hdwEyUKTxbxXAAnXrwuNpJjsTS1fPNdGMwSCtqWNmviXGdYS?=
 =?us-ascii?Q?rYtAFRAqYwpF4WW/mJPEuDBdzaQ7DsTVXFgAEXDPc9H9U3Tmww6Vk18C9PPD?=
 =?us-ascii?Q?8XgeM6AiM7npBtHJbYqpuS6KNLpdPvCk9MPHJiZ3r6aWOJzCJgCsv9m3bVzC?=
 =?us-ascii?Q?Psuz5FrVzenYwgCnM+cZKt/OAkh9o+eLpzxiCpHFJyTml6ZW58JcJKoq6fiY?=
 =?us-ascii?Q?mRUI91kgRTWgTfjlyWVDaidh7L+JQSRkqIdpYT8FvcrXzXYJv/SyeKf/CRS+?=
 =?us-ascii?Q?gOasVVMA0xEJoCGr1LCpBqwYsaEt46mgwwFhY607oeSAWl2asWWrlrVUhScm?=
 =?us-ascii?Q?XPoww2sFP70p3H0+w8Tj6UW1Z7fPAyY3L63yy1CaQONW3htOm3hFxE2+SAHc?=
 =?us-ascii?Q?6OXYQfCDsTdgrWF4VmDnUJ+tzJ4wK6lD+rH9Hzbd8kfPrDt3gCGUPiKOA1+1?=
 =?us-ascii?Q?IB5omZRlcRw/cfwOQKSm0ZbGgpxMdi23wM8uL1Cng3Evd+uroH/3da8uB+CO?=
 =?us-ascii?Q?4Fi0kI1vB5eI9VeM4QTNoivYY8W6m1nwH1aahp796+XWEfFYo+fLtMiaNTaG?=
 =?us-ascii?Q?NXSLKZxaST8A59k7sZnwOIK0Nuzp4OibL2fS2vgH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c9dcb-2599-4564-bb79-08daa09cb65d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:26:56.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8oS0J63T7ujUINe77/OxIuviXfJqxmaREWcF2LmsP9slz+cM0lIU/Eo9qUnSNum4TaFY5u4k34KOoCbCKKxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092

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

