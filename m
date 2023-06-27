Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720EDA23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0W21COtKlb1JZ2E/im+4cSDgRlGoSzMR4dS/xWNqbbXQWDYVEiWfjfkmhrDNLOTvsVZq/GL22/8mC1s5Rk73fEdFBFT/IvZFULmvqeUPAHLHQ7ahHZwjAdjMw+wnfCuqPd13dOkZsU7DtHNfHaI7ess8kLUi6gFQERYDp8Ll4uTFmDjimKw9EVGvVGw3VyvifhlTWfw+0WIXcKOAJlXcrVTmRyxRWXfotGmkRc0tvAC2UEU74cX/YmJieFin6bG1/V6Qfs983q5azsC1UEaGvSi2sDwB03NCi7EFeSAE4scq8krPpnPxomItFiMJenGk7EYVdn2ybHzSxs11IcTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6X/iPydP+WBXRTuZEM8ABlhZ/odWRKqPcuOTyPdie0=;
 b=XDRsyZ1mX+CTo6lRoZfD5O5uOrUoXZTmIjZEJdL7JpjFnf0OXreLSn02r7kwVECO8NBpmt/YEyZ09w8ry0e2ANKhGNSJyLS5q0o8W6x09yfG/mJ+9/PUnmU9qtgj3wT/57CqTxnEzYbkLiA4BJnVHC7nfzumEn8FfGRn5B7Ow6go/6RD2ULWBOebwU6VA0vbRH6WJcWV04ZCQlFuC5sgZr6zx0hWMtrvQ8G/MTjBl3ywYoOk8dSOk+WFhie129WNUN3YH+jpWfyYf/2OjYk1b+I1+BkRNksHwU0zdO+g0sVgXUakekZELPGfyDG1GIWiZNLaWRC8pSpvR+nlDKY/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6X/iPydP+WBXRTuZEM8ABlhZ/odWRKqPcuOTyPdie0=;
 b=Mrr4cQto+rCqaFxy2USsUphcKjxO4QER/IbrTxwzBuh8OTM6ZMTlTqtgOd4r0ifITBwL3K+T0Z/Xc+Y9FjKy/izUHjInphDEA98TQQHWlEL/1ZMHAwsd6Isn/g/1EXIQUgpIi6hk8Qcp6O/ycOGbQExS1ThzZXBgfJVCYWp9BY4Fn0//7nY40Ta26I86QsVm5g7JcsfJZFIeyLxtnQU+NjrGiOHSvhuMZfbHDWsAuHT5kTN5S736T6+DfD47E8cLBrhd+ucWcU3nPD8Vv9Ho8bNyC8PZvw8jDeJWFiZAx4+fSNAgxkTU4DE5w3BqIu+m80D/5LYDVKBCMV54UAt4Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:40:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:40:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/10] selftests/bpf: Add bpf_first test
Date: Tue, 27 Jun 2023 09:39:23 +0800
Message-Id: <f18a115eeac9199d5c1dc111f9ffd6adcd3eb99d.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687829823.git.geliang.tang@suse.com>
References: <cover.1687829823.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d1527d-be35-42ff-0489-08db76af6c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z4hs9Wa2Wn9sPYEodeiKBqQYTBGef7gxje7Pt7lc4WNhvW6NXcBZm0DcjorKafK3t8yQCzQ7fOsLIUzQRpZToGVIQSPeAkfbC1dQACxZmqwYxjxnEJt1HUkX3cMrj0R6dBt9WxmQmjdTZ0HtVv4xJ8xDDrKBd8ixLnrgUZ25P3Qt6vsXnwhht1rrU3H93ZbKsdbG+iaXQ6Vsntw2PI/BJXo+usJAq8dowDTwGcQK9zqa7cMDDD2ukrAmZHsBeqMFS8lzxLUsJqCdx00pTX2e2KigYoxTRODRXbxrDUQuyyVpkeYsS8aneCmKvkOw1/DF5MDNNQBFPj+ShyISyf8rnRvNtuzXbCkh5/9K6IY79UwoSPdNwIGjAlfV581LSbTN7TAKm+jqXYXYXFNvA8N08lhF8JrbHCqLHI5ru+r+ZT4Pp3d68Vav6Um5oLIOY42GzAD1HhZXDqm6wqI3NV+x8phTFA2sfcMv97clQuxrtosO9hfgWFDTJ+RUK6Bs/gm8Y3fjn9MbY/PR5/kl/NyRPGGM52147rt+cHkrSNKZaFt9NhCBfkJvziqNN7x4wMHM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ntfl6JGe6YHCRCy5X6692qSNTdTPvGoCIt39/Gx2tlAj1yctokywuZ8slIvR?=
 =?us-ascii?Q?PHeuN0UvYQqxheUnU0/zH27qlGGK/TY9f9i4m/I8nALztxr2MbHeL3Lar4Xr?=
 =?us-ascii?Q?C/u8GCND4c2Esi0dalqMrfPw0oCaYp1tpvf+N8WkgS4qkRD/ie6MT+yLOTUF?=
 =?us-ascii?Q?dYlxSIZHyI5pSIhCxqTktc+6nep4vZyBqGDoWEcoJnMVMqh389jjZjE91ZIb?=
 =?us-ascii?Q?UkguQWOyWZDf4yTZQBYJou8OWlhcNuRBgHvsbENLw2FhI/NzDoXoJRi4kmMk?=
 =?us-ascii?Q?lozy9qTRAaA7dOSjFNLoRiA8o1hGZ56oS2S6pFH3Sp/7J21TZzZbA6K0RQV2?=
 =?us-ascii?Q?TWxt9ZDs5Oic/N9D5yqi91BTrGIEsWf0jLbCB7VuyOvXpQC1Y5YrJZ0tP5kO?=
 =?us-ascii?Q?0Yczh1U+M/VPYUAtvflnTr26ZsAy4MchCK6GRPJa9mN3qr20UazeVfsSf9We?=
 =?us-ascii?Q?HBi5wcapTiApa8ZNcQE/tign0rCfpCWvmCzq2RaTSSSL9wQAMEucHofVT+xG?=
 =?us-ascii?Q?OtH1Tc60stTMOtGLPB0pxm4vducPBupzoP25h7kGJQJHnHZdonZhtIBOnBc+?=
 =?us-ascii?Q?8aNaV34W03XfdwVFIVl/gRdsm0nahxsIr05p44muxCXTd8xG8hgRH98MnleR?=
 =?us-ascii?Q?2j0nebM8Xzgy3vX7xw95HyUPCNglkaU7YO5JkGMUByD59+G285uK14OfoPiw?=
 =?us-ascii?Q?yI9yA/QHv5x1+sEul4uGUkl7DEzkIFoShUwkvmSIXxBO7UMXPjWjAfl+qcxt?=
 =?us-ascii?Q?/0e5Q6zXjxG56kppCXdO7GoAgAlefgLQSfpYsWv7+3gZGS5MqRG85Evuzm0e?=
 =?us-ascii?Q?rV0sDEc7+FVAmCNB6kIm+VHpbbzr9aPVHQWxZdRdxLFDp9XxM52p8tCvSOsm?=
 =?us-ascii?Q?jDiCDqsJ1qf6/sJjSOtUcvcrpOYHgqFJpssg/FHWPITX9QfZJijgxamAG8r8?=
 =?us-ascii?Q?Iyh+5ta6E65IzkONb2PDo31DUuatAZKW16BJU666ZlhQky4gVirqn/IvfqRA?=
 =?us-ascii?Q?HT5rbFj+WqqjYmQ+g5YEAz6ACjEmfOvDKRERCDfjaTuH2vkNZFyYmUkuX7g6?=
 =?us-ascii?Q?8Losj0QdNU4eH8NME3UqPV6LbgHhxklsSSMgfJAIl5mFGrEzLnKC9F64dz24?=
 =?us-ascii?Q?+yp5haVAWECoJfGNSykKDXBkyvI6apKPpeF68G2190XIxpvHxZVo32B/Agvk?=
 =?us-ascii?Q?NEMcB5Wfw9HuQ3pzI+UpsALmkE0o3YmgZQMwEpPAVujvWDMmZihRZ1IfVb6/?=
 =?us-ascii?Q?tOY0VISohN0xMdajxj/TkTe1dCLkOJKVOGsF5OzK+VEJ+t2gHS8W+PceafDv?=
 =?us-ascii?Q?HPDtHBQ/KAvEa7gH6cY6aWjYlAOT6WLOlYPJ3ytWc+XPlTzimFoUizWRwjeg?=
 =?us-ascii?Q?q6291ZWmuDqXWqo34HTVFfjDQ6CQDtxCPdBBw3QZ1xLxxJSVIxDrVyjmNfqH?=
 =?us-ascii?Q?wDdW5qi7/wv4p0Hx53DnnsybQdsfYHRlx9Ig9hRVlz9naoPud/5u2Wo3yNoD?=
 =?us-ascii?Q?RDUxCrVGfnUU4G/X6BOI6iHXnohBKCrNArd9aLEjQAGbj7tyfgESMPcN7yIx?=
 =?us-ascii?Q?uWn2eNUm1b8t/udLjc2Dh5Lj6M/M1ON3WOMg+CvQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d1527d-be35-42ff-0489-08db76af6c02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:40:00.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x64N91hRCVcPm2u49Ue034tIIPRiRxml4GpkQet+WOcRcvVnTjm0UqPj1lfC9suXdKMszJqhmaX0xQENollj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

This patch adds the bpf_first scheduler test: test_first(). Use sysctl to
set net.mptcp.scheduler to use this sched. Add two veth net devices to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
of 'ss' output after it to make sure the data has been only sent on the
first subflow ADDR_1.

Note: This commit should be merged behind the commit "selftests/bpf: Add
bpf_first scheduler":

 selftests/bpf: add two mptcp netns helpers
 selftests/bpf: Add bpf scheduler test
 selftests/bpf: Add bpf_first scheduler
 selftests/bpf: Add bpf_first test

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 39d95c6a18e3..21b7ac6d72fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
+#include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
 #include "mptcp_bpf_red.skel.h"
@@ -347,6 +348,41 @@ static void test_default(void)
 	cleanup_netns(nstoken);
 }
 
+static void test_first(void)
+{
+	struct mptcp_bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct nstoken *nstoken;
+	struct bpf_link *link;
+
+	first_skel = mptcp_bpf_first__open_and_load();
+	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_first__destroy(first_skel);
+		return;
+	}
+
+	nstoken = sched_init("subflow", "bpf_first");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
+		goto fail;
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd, "bpf_first");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
+
+	close(client_fd);
+	close(server_fd);
+fail:
+	cleanup_netns(nstoken);
+	bpf_link__destroy(link);
+	mptcp_bpf_first__destroy(first_skel);
+}
+
 static void test_bkup(void)
 {
 	struct mptcp_bpf_bkup *bkup_skel;
@@ -458,6 +494,8 @@ void test_mptcp(void)
 		test_base();
 	if (test__start_subtest("default"))
 		test_default();
+	if (test__start_subtest("first"))
+		test_first();
 	if (test__start_subtest("bkup"))
 		test_bkup();
 	if (test__start_subtest("rr"))
-- 
2.35.3

