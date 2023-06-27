Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D9CA23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6L21mTKuV+krYLa+ouuQ2Xiv+4a83582rcFgKceOzLdqsRmdO8cgBtXDTv1srMK6VKQ/fzXNeP0eppu6jnpWBKeSGc++islVIHsKa5h3E7x2h+33IQnvBbB0DzhaNepocY3zc3E4m+ntU4JAA5BSkjgBipqpXtYDUc/OKCuccYoWFQkkpv5ubpbjKlW9T6hqvV7yOmtwu37cM4qpZrlQXLDEDywTT8mC7WGLiDV78V9m/J1nU+K6+Ax5OOAUMNWujlnf/V3g+VguRMT1VDxVvxl2iyX6clnRQJJwjKkmQlZKZY6RO6dWguonbJOK8G4kdFaSBapV4B+ZNkuea3h8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSsqZ+ABYs0nPmCwTrtEZpJQiGzgJihD909h/WfD6d4=;
 b=Z6EhSCx/PBS4Uiat7nCM0eEU14l72qEfYzcwssMRPJe1Drm9MuzS5QpVNlFJ1r1cc5ectw++2IyT1uu9PmvsjvmYsBMG0LQPnCJSO2391skm8OTuN9grxP44U5yEHTtfS/IK8+kr++vwfXQ+pUE6PWv/52BZTHw4dsh16gGIot9oArooFpYnLggteYYocY9/w7xkxs21CGTfkoQgta+pffP7q1YrJfE0H8CWBLaEXezd7S4JYmK9ZhDbQbbHxEk9oqXSalXpzRnZTU0c+BxuwIS0pwgPQzPVZ6KfcioLglCAXNM+CWsyBB+R3F9Pj9K5MDrSjzzHvRj5Y4gOiY3POQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSsqZ+ABYs0nPmCwTrtEZpJQiGzgJihD909h/WfD6d4=;
 b=4HLx5v3EcyZwxsYlXSB9hK6qsMzQrfQ24O/qIuv9mS6hAocRVVZyQapuIjvsKpLsZ+ZQ58Ow0/wpZHW45DvL+Y7wvLBdPb2fmd2uSTZunJ/UiM/8dURVyC0Iff2WnHT0GJKhy6MY97YV+3Ehz17ezMNlWu0F42Hf4JhJi1019jc/XH7/9t/3xGRhJ+LjLmRq8DsNjL62H9MVMjhK/Ud74iwbB2DMO1yjBZvWKseugtQo7aYcCc3FspPuxSVK+yShSMsZJdIXeqflztSEJwivSK02JMiQsQAScShIBgor0Pimb5Y4G4tPoeoWQNGedUo14Sjgr4EMfgrj+8OQ/N4E5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/10] selftests/bpf: Add bpf_stale test
Date: Tue, 27 Jun 2023 09:39:28 +0800
Message-Id: <fdec34dec183bc427faebf45f8feb3f88a575478.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: e3fb02f3-947d-4bcd-0503-08db76af832b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1WqSo5YsEYxyAtvZQGyfbm2GWlhqmQYxvIONG/OhohdFuBG8UHH/OO1NyVHjiqxfyrKNw075VeYCU9o042I2Z+4wumVZBJqIBOMpAelLQqE5k+0OJQzNi3+XiA7K8pYZNJmUnsDAD73Y8GvA6csmIPnG5fXI+u0sEwaC4zTqm2rtR7GH1VbL/5NhzemRK6HjGfR7c/+FnvYHjtFm0AB3lPxVNUEbTqIXmKFg/QJkDa/EwbtEViKauMBZusF8NUutzpBmheMGYEMeyhYwXg1WmfGtw8NVAMoq0IJVJhQEtJFy09SgC2RZF8WiYwg53tKtdzfjm3MQ0mqy2cDBLuuYP/5si4eIpccz9TU/gm7uPytp2WM7e/CqKUKGhuSo/fJkXqLUbfse1/I+MsLsSAq1fvS7vxUbLrPEDRDErrvxrMZhVsVDXd5JVZI/Kfl3EORB2fbS7GK9AeNQJp3iaqamM7fizRKVzk8TwXVpy+FYZYF4z7JoUADedg/0t+J1v9zgFY4h0Iz9OBm6hvJOgvrutnS611tVgqa3sQaD+Km5GDm2XmYbBlF5MxYKkJcnjXpp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zqQymiZX951MS3nwHVO31RGfqmvrT0Qcnh2CKpgpJGiCSyX+gikSPV+RNAnD?=
 =?us-ascii?Q?W5BCO3AK2+tj70tvHB69+wu+lp9fthpxKcWLiwM1XvEkkT/bHWQUlgnRSqLw?=
 =?us-ascii?Q?Hker45FKG0tWxRiFNV+XUOlKtnJt18irwrzkIaotZRtPVzLbzgcCbuFK66PL?=
 =?us-ascii?Q?1xVxN0lMJJ3V1vjw1iQFjuf42ZcB9Cb1grMv7qsmLaNV3UZFF7X44pW/9fkv?=
 =?us-ascii?Q?a+03dmfvQgwOhQH58o8m/qZTGwkmBzNN2ccUg/BZb/Q3lqZFrG0BdJfQ/+Fh?=
 =?us-ascii?Q?s5NsXKnZugLUZBmsoBB1wrh5Msy7FpvB/ahckNr4p5YTBrPWX2dNTu5ZOaWH?=
 =?us-ascii?Q?TgO8ApoM8kpBRs5QY3AV4t1Y/qIWefuHZiELUMGrWR0UaJHUd/AWOWqvVhq0?=
 =?us-ascii?Q?FgFB2YnHW3h/a+YhUkF88BcbZBVzA7GTIE6ndBPkQOk/d88Z8JeeW45NfAr6?=
 =?us-ascii?Q?A/zZtrNRbQfCu6okCbERvPOGLKA06afAAoK6KhQ1u8VUdDGEY3D62EjbkVu3?=
 =?us-ascii?Q?XP2PwefA7nOsuqXgfNyAnjoKSKUeEXrMjQECE0aDO+3fWQm3QLF8JweyidTO?=
 =?us-ascii?Q?HO6KFD2vib+c65YOX71nscq+D+KJsd0W4U5Cin5S9ryMWD3R6PMniSqUuPqJ?=
 =?us-ascii?Q?MVue6JJrjreZ6RZskac1Uwe7f4ztPrV1YmLI53ZXdkb8cErxdt2ULn082mSQ?=
 =?us-ascii?Q?WSb2laLIBtdi8BZvEAMPQMkTuOhtGapQZBHRkTZp4P80Eh6v+CPaJX8NbdcE?=
 =?us-ascii?Q?iKxPA/8tUZ6+58gYpC4RA77uzQf+ux4BW8EddZ6Pwjd9uYLwLIjzkwjec5Ib?=
 =?us-ascii?Q?5RSslrEZtMR3ZKKXL23Jvj4OJyf6mApICfS8ROhH1QbujsNk3B5LYcr1rmyV?=
 =?us-ascii?Q?0rP50CRMIlaxDmMxa5RzWfpUUAL07ueBR7uSUG5IsCrqWu/NO/Jbb79BRCVk?=
 =?us-ascii?Q?QCEeuya33DxcwW9hDiJ9KOVS8jbPftG71PPqJUN8ayaoblkDUJNevGrYculi?=
 =?us-ascii?Q?xu6sHZCWSys838tViomrutUl12prwx5URGa3kyIRwO96SBtzo7ogSNWIsXUI?=
 =?us-ascii?Q?Iy+AZlD0UsGOj3/VEMtfmkZr3WIJAISuq8cWLVOIAK0dg++Z9oA7yt9ytXrw?=
 =?us-ascii?Q?mPzWGDdusIJhXKtVxLIPDM51mIGAnSW3PK5EwwGTfOPVIUYhfT21ocHBwzpu?=
 =?us-ascii?Q?XhUcNEV4+wkBQlHPja1uYj218l0XFngHBdVWYHWF0O9FL0ytPUyMni7BU40l?=
 =?us-ascii?Q?7bpmQrZD8OOv6Znp680jjyKRKL7IRWn3h0sL8XEqdb/Ad3KAqfXfaGQkLolZ?=
 =?us-ascii?Q?C26RNoS4bHeZUZTJX8sr06MZr8AkpvPArVqrCeiepRmWVlaQ67UV7+pTO4pR?=
 =?us-ascii?Q?bQ6JppfJ6UE6Ak1umccWDk6b8mITDH2WGNjbJacG1pk+amsP23Zf9A3/mFGj?=
 =?us-ascii?Q?8X8hvuv1OWiz7+myVWz4joeU1JGr6Eu8zi2KVdvIMn1DOGDq0WtrIIdjvS1q?=
 =?us-ascii?Q?oELUJjsD6RhRD4BlfDdMsvE1X9i7eH9BDfNtPO7Wz3f4XwjRcpmuYoDrgchN?=
 =?us-ascii?Q?yp3iRHXVNwVJN2B58LnQzshGxiqxorEtvQ9i0HpQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fb02f3-947d-4bcd-0503-08db76af832b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:39.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FHHjgnJ+l2JPwSBCKF2uqPkFreTbhoph6c0HXqpNMeIYXZWz5XMykfmYcix8ZOevErJNcrHd8tnJ+/DYNXVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on ADDR_1
since ADDR_2 is set as stale.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 4b346eeaf8e2..851ea32dc1d0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,6 +11,7 @@
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
+#include "mptcp_bpf_stale.skel.h"
 
 char NS_TEST[32];
 
@@ -488,6 +489,41 @@ static void test_red(void)
 	mptcp_bpf_red__destroy(red_skel);
 }
 
+static void test_stale(void)
+{
+	struct mptcp_bpf_stale *stale_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	stale_skel = mptcp_bpf_stale__open_and_load();
+	if (!ASSERT_OK_PTR(stale_skel, "bpf_stale__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(stale_skel->maps.stale);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_stale__destroy(stale_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_stale");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_stale"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_stale");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_stale__destroy(stale_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -502,4 +538,6 @@ void test_mptcp(void)
 		test_rr();
 	if (test__start_subtest("red"))
 		test_red();
+	if (test__start_subtest("stale"))
+		test_stale();
 }
-- 
2.35.3

