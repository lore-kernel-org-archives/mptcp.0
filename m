Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88688323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:46:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6CpUz+oEt2yG1SNVL6tPhOg7zSmijMpkKobmwUttW1aynth7q6iYpNUonFZlawBdVmzGWleK3FJ193lv8XFS3ESQZ38FuI25wHI7lvVLdOenig/7n2i5H/4uhCI7GG6aDt+lEgl6CstBCktvS84JrqMqttlboMQUk61SeY+8WX9aEXXaU+SMyMR2FfIcfC+np69Jw62CC7u3W2cEEYfS5zGCV9C1f///oq6f5EdhoiL25N7m9FZeLJD2KZClnqP6yn++F9Wy4vcdGwJO8A5AFMRTzwM5s0cGq0D7pQhRNPpv/zOxDtr8JENyxOxUKNIirXIro3+Xm96O5/jdlaVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=cpcePR9NO/jBKkwZ2ZWvSXWG+Y26/uBtUV1YxBsejcBEPPJjRFId6elJ8dTgRuvwb1rtxdOURxHt5TDX2xnzHNZrqRps6VNwMxmY4ZFFuBGnUs4Uk/CZFHArrwuO1T1989NJwjolF6QynpFXqCpjSAujofCB2xhS2e1wNedSXLs+xagJz99ReXxPyNuGr8TYztVht8fSAzb6x0cTNNoBfVLVOB5gcCUdqV9d6T1IW1wWRDBcsleZinLax+Hi89nvjmbUIBu8yU2eYij4SeB1KXlcHX0FUFP0EwpiUvhQbe0B3oJbMbU7UdEcz5mioDgTpoGXxg2Xo6QA3ogIUWrgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=m/A0fYb9UIswnNpNtEyJcvQhWEOlPd1bJORxGJ+DwEd696Yp+BaHAp4GLlgh8FcER2MIw7lurX4AM28jLP2K0VV6sj0b68noxSx8gxHgK1/MfwFTcWESSy7wsX/IFXuCZJzaS/a77lMYimqgqnSguWIPSUWY58/ZO9fblkj6+3yNpGEQk2dOmjE5aU1tdxXO60MONClMNArkNb4l9+CDf+eYPPV5W6fdZFDm+BEiM5mUXxgb/BqSBjrzoGYnJBrCasOShDCIzwI+OVsUvcUyN6/qIxgOOg2eaHyo3tkz2mpARNwreRwgXHY3vCsCZNTyMjQoCatqtJw1EntT8X8Ewg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:46:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:46:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 15/15] selftests/bpf: Add bpf_red test
Date: Tue,  8 Nov 2022 14:45:14 +0800
Message-Id: <bdcd868980996e3b9ca84b361ab5f561cbc2d0af.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a58b27-c7f3-48b0-8306-08dac154fb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VM2hf5a1/gaMpAZFoKrOBy94z46QMf9U3UuACsTOl3Qyu1qSIhJKA68xkYovXR+pe1iWSaBJiE8a5aQusB5n08ni11QRBB1EIjBwEIF/qOutCSGLo5AUw1nPceeuq5JVpHQPU/Ov6c9q00m0Er2Z9SxfKIlRnJrAabw58pp+nXZ3F7dCB8J2WoD7ISX5FI7cMPEOC5A6mk5jpUkRu51UHWsnJIL9pkIgeaTwrDadqYxlqa1aEq+lTnuaEgTSn8aJ/HjFQ8NAydhVk4hXNE8huVSMggbSByCevYVvGkVKMDLs2yM/2HkX90M0plcQY+fSI5xfLGdx0vCsMWUlL9IQy3/YOj7PHFgUItk4uu9jKDa/MpCf2Lh9q28vSM5dcke7WV7/ea4EdAcqXyMk/cIL+n+HK6y4u+/YgGRisWBBTWgbGbq1mwXVGx5gdyHTWBrjzaKB6FHzOPG0Yg7Fg0+8PKD3s2ExBQe7/N83kHiG0UMlTLM5gwaZ+RnvlXA/iqVR+Rc6ZPnrccGwaBGjqGR3jhMlumtjovG6W2k7pinJ6TVO4kAecLf/9Eb5ZhB1eGcymSJEjffFVhnMmYIvWg27ZHkj7CiMGAt6Eol31Z9AlU0dCKQIYL8Vk8JQEKd+GTT/SGIAiZCtQjmVnbg4O2wYpu/wFNoHTl0mjHAZZmJuX2nJjnBS1DrMrrga9QrCNcCke9HzuYj+7x2uIvUavT7Chl1zsqI92GsIcmC/uZqLwFUYakw6qZZBsPRIgGo7AcuI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(83380400001)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ndHqwcBhu6TNG2jyDyFE0/DZeF9Q3YZ39wHlZ0a4oFtF6FupKs51HNtCxfQv?=
 =?us-ascii?Q?BJKiwSPl2KFozhVsn5Ot9g1LbmFyLhLrh8PzwTaaXGqlK3Rz3gxkYOWGqCbq?=
 =?us-ascii?Q?rvFcqywl6hQOfZGu37fijKyeOhEa1p/pr1Bp4nqr5tqDmyAXNE48TZedyok0?=
 =?us-ascii?Q?l9iMbTKXSS7t46rbo0MgGHIYeztg9mKAQ7UhLQPVO+hiOdmYOI5Fc/WlCcLq?=
 =?us-ascii?Q?RdNSOnVGVpBvFBGNU2ZeMNxdTKCIq9F6J4pbQy7RNMCv28NN8xeaR8ngRJjA?=
 =?us-ascii?Q?MBNCxXV7Z3A/xjaHD7jRFxZqz/CA0+KiBx+izKZgE5wpVolZDEn/HkoqKuso?=
 =?us-ascii?Q?pgFJFSiRhC/9ZtjVmnFhWT15zVJPPo1hIDzEAqvNJeX/kt4JxntEWaev+ZCO?=
 =?us-ascii?Q?PNkJFEnK9nlaaL5DSWdadaFc2IGHL3heUKkUWlAw6TFzemXP7+6ECSMUtqMf?=
 =?us-ascii?Q?3b3DZC9m8qotI19aJ93dJySOfc/tT9ASz5rPQhRYBuHdl5Re/LDPYcbQtkMc?=
 =?us-ascii?Q?jqCgsYaCV9+CVLnm70Epp6CzlvGscqDfBxSrUChojnBZlIPMh2LWicjT9JSz?=
 =?us-ascii?Q?b6ll0yHsJKwUxJ8qTxRP5OuHsYvpYvN/SiFKf8BJturakv/C5HDWu5VuLgZj?=
 =?us-ascii?Q?4LEuP9NjJjKXLmkshXZxXNKymE4sitLRMCVXH18g/HHxNQRa7Yfie27nQs8f?=
 =?us-ascii?Q?XZJDhqzR5qozx6TE5IwH4EIYCkDMwZGy/ZWBQaPSm4m23iMRtEneMTXCIEdo?=
 =?us-ascii?Q?a66ibbVcKFQcJB9Sy6LlKb23me59cHq8bylK4xLE6Ueo5iUbrufFnW3zsb7A?=
 =?us-ascii?Q?09fuaWIHkZuV48MI0EZYUpEbwWPJQbDzAehUSmL2s4DYBfromCGPRzwSSjoy?=
 =?us-ascii?Q?E/3IIMtXvgoT3FALhJoDSW4J1zTOyeyk0+6FYFuKlqvhruPyz+eBnHQBXRcc?=
 =?us-ascii?Q?4Q2qlZb3yvMPH2/n+lUAZBRt60iPpK4cEPdKQUVN809kciQRYq0yIPT8QXp8?=
 =?us-ascii?Q?tGJ+a7V1zuo9hzNtx1xXRGjZWAxIoJbB3EO4WssNALIdJsglEFNVzaWzieuA?=
 =?us-ascii?Q?B+tGzp9yFs6RvNfugQalDfOpPBLFc8X2AOFus62OQ57GvN8X743UuO56Qoec?=
 =?us-ascii?Q?Yqg1tlGD3QWbEZBHwA0/pYAPtvISXM+6zOwPC8KJmEewvlkOp5q3swLBdfVW?=
 =?us-ascii?Q?UmBIcvVnzyTfk3JfeWCvGOPHcQw6tlRscC8iBmVmCBKkxGFsdZ7XLK3F86Kh?=
 =?us-ascii?Q?sv/J4O0bow0ZqP1jiaDh+KtQ+Ah7ToZSKrYm8mOzhyRqBWRykumwYGhpPkOm?=
 =?us-ascii?Q?B6NY5mIkvACkJGvQhH+WgVvcR0sNo3Fj5V/c+CbqFd8wZVjW+1dWT/DVtrLg?=
 =?us-ascii?Q?e1kydD2KCTy8CTdHEzeIzTYCsEJu708bMmkp9aegR/bg5560R9oH7cwYk3nq?=
 =?us-ascii?Q?0uO8hp7wc5xPToEB+nOGdffzSUhR13HTBKtFMBD5VNgsnnPt4cigR2vXOxF2?=
 =?us-ascii?Q?zWLUcxL0DBOosxKn9erYk96EZLYsCRJenmPS2hEmEs08alM+7bdU+toHf9GD?=
 =?us-ascii?Q?fnGzUDl8Fi4tnwE193FS3GtVKxCl9UWAOBy2kdp3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a58b27-c7f3-48b0-8306-08dac154fb33
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:46:36.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B9aDFrqFmrPhVILIjqB6ML5J+6CoLJSzahzgWWy+8B4nQB8k/QOoLT75qMUg4IT5tbcMP9XCFjJoxwUF7NvTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

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

