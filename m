Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EC1876
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 10:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQCLHFEZHt1YHnLZnAZ7Tm1aqx54VWfnjlyrwgX/ARqv5xzNGqOW2J2CO9cfz7TSzFGgMoxs/dqQnWvlhIdiyt/LG4P4YrjzkwjOA1LQjr6WsZBhkURLSwLHIYWg/41tjsOWhd0fdinP2dn4FVijrL1kYQ1RPfEPM7xuEqiDFlvbT6JWnPnxBnR5ALQirgnmGQVXqQgDabkmeiwkMXGFt1JGFgu99HFI7QeTresfPlLdUu5P9zFHssteedHcwt25yBTZSW1VehUDcAkDSC+lHb1F12HUXCBl3B/50BKfBm7M1G0IbN7xc1Z0AIhBlLI5/tfqmfmhVLbak4VpKhuAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=oexnkeZcguQGRK1C2/lyYSqoJNuHfUCCqvRcc0ym5RK0ItsE/ESwyCfPEEnMYmpgK2aCGGz847tedRVGFtB9ZsqhWsTU6tQKbvVyatB9DYIORKLT1EZOdvy/t13z5OLtsHn97QbJP+M828fV5JieKJzg2fmXTywB5HlIOBrm/nLieXu/7ztNvYG7BZelouBTALiI5PPdY47mu5f1rpMbgDgQBFN+dt8kDFvGOYlVdFofG0Q+02mnSbMtumzd6CWER8bxstYTPs85X5aQq6Zyppq1CIQSjkjUIFyGkfAGRHfC5Oz1J9tt/NH4kCbOuVFTEinMCmWsF5cN13l6pZANUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=Rg8lbAWfMctjHKlsqbKg4nk0APyG9hso0YG9SVYcydpA4Njm1j/DHKQc7Qzr5VFTZFUf8WkLy9ONcp2QQBQQ9dd2SnL07ubufHp/+D03pILtV0PB1uABDJZHLD7fIPgRUdCb4KMIgvwDRqBXTyYC/+cRxMBsXJteplHAiAc2GiqlIJUjum3WXxRD5mgTuy9A/XINspFHg1yKUIhjCg9BMJcfHEH+oJACEAIZ6BX82x3ogKnoGl/EpDOoBICCvPL9EnEeQb83RvlL/CHHUY1KTd14h3PIrakjgD5q1IZBmQFyPreuHW/mMtdSE+ESG1qdMR/7aSsXYQLPqLmTi0Zccg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7659.eurprd04.prod.outlook.com (2603:10a6:10:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 10:51:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 10:51:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 6/6] selftests/bpf: Add bpf_red test
Date: Thu, 23 Jun 2022 18:50:28 +0800
Message-Id: <e721cb6af6bec51ce7aa90d5f45d432c85222d93.1655979747.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655979747.git.geliang.tang@suse.com>
References: <cover.1655979747.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff6efbdf-2f93-4af0-4cb4-08da550642aa
X-MS-TrafficTypeDiagnostic: DBBPR04MB7659:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB7659273804D8E607EA096A0AF8B59@DBBPR04MB7659.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TOYlkQKvmUpS24UXJn6Td5aIHfd0Zo3Y6CcDhVJ0U6BCGtNy2vT9VbQ0pNtjrqpcEjojVlXBtOT8Z0ua3WypGG+tkIFvyyvDSnySr1tJPAEnqqvdEzhixGUS5tZ6rgaLnt7228qtyMY52or5NLPFYgwz3+ZowNZ/rJ8y0L12LYjIpa09wvYDAa2fz13tPhSvLebNKSPccWDG4nJxcbPieltxWTRwrpNE7QXunWYVtKQ7PadSyVCU6n/nvCT+rbKLL+ZNufFExJd09XgTMLK5JqjtyNHs+csrdMGfKNhb5FRtN1XC4MZrdajWKRokXanGY1zdlE7Ta/PyBpSvJ07xCNH6wfoxBO86pzs/5P9Dedyt9ofhBMoKZZBSmFTARSWcCcj0FpFow5lH8bZQIWYkpAFhy1+zN+xp6LKN5f+oHvvotGjBsiAcRVhFAYOhcZOZmz0Ig7j5kEzbGwhgmmPk5fUKLKTVLNUSQGrd4D9VLcrPiO9lHoNXRgeUbhh35g/YxwaWY+qaEDymHEJWQpTygv64VhIPMOEJir9fkjfTkR/cxFJJVHvZGSQS50JF0zZW1Vb4kK/tgwCXnEms8wt77gO0mMDfD+EtFql4oeyZAdbaAid9K+ThvPr0bD4547F7f76CVVoRn8WkWI0fO6ygMrgQJ9dEF3TulliRdAwJ88umm5MO70p0kL8k5hv7v9pyQRYUDgByEgr3HAqLQYEu4ghnY5Uf3swZhCpzTP/wWlzLwHcERnjautZaaW0Vc4k1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(376002)(366004)(136003)(8936002)(186003)(6486002)(6666004)(66946007)(478600001)(36756003)(66476007)(4326008)(8676002)(41300700001)(6916009)(66556008)(6512007)(2906002)(316002)(26005)(2616005)(38100700002)(5660300002)(44832011)(86362001)(107886003)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EHhv/Kh7Z20eFJVOI/k474Kib48mxtH4k7haCeeDjmu0GDpgCHejS9YBfXrW?=
 =?us-ascii?Q?rEHclheqWzadxm80O/tyHRvO6VrHbGYyc9eg8BJh+tEj/y/tFuZ784IvfY+f?=
 =?us-ascii?Q?5SEC5dOuD3X0Y8JMpMW0C2pHX5pdyDrIsvTAFSoh+p2sR+EeiXelMTc1Sz9P?=
 =?us-ascii?Q?ZEzd1gN3SLxEEuZ5a4B2WKf1L7KzvQ/tXMM3E9peUJ0esr+PHr3YOcnaHbKC?=
 =?us-ascii?Q?qV2/sNoL/yIBpiH8pu9hOAK7sailmJ/T934T8JWmXyytjCk4Ppmk9l4jaNsZ?=
 =?us-ascii?Q?Hf9sgTfDQMwLXf1t3IF43qllBTo6fjfqnXgIbbw/5zYgNnvoWVRGq98Sp9BW?=
 =?us-ascii?Q?8f/HD34vTWwkn2QSM/FPls7WCTlQmQN8Ztkgqzg7d54ukNpiX4py4Fhw2fKB?=
 =?us-ascii?Q?P91B74oviroKy85zC2Xm30Ip+FF0mMV1Aapvic6+agWBSab4p3UnQ/TSuJET?=
 =?us-ascii?Q?bQBjStStAZyyfzGgXusVHpRv4E/TIq3o4g4r8JC17X9Kni5ImvDiTuONTuBC?=
 =?us-ascii?Q?Dfix41/SimHRcgPzfIeaO67QBg5uMvR1CMGsE/cnDHJxxNTRRs7QfGm0M2Vw?=
 =?us-ascii?Q?FAa8J6kGL4QbMjlmEmw7NLnAmdzrdFgN7cisx8HVWVD+LUfM9AiK0ZLYL86i?=
 =?us-ascii?Q?kKt87K0LLxig9SIj60KeUHuD9Ugfqe1nhO53stw4yAzTWO47/1i5sUs1cVUZ?=
 =?us-ascii?Q?M4sbPAR3E8SshORisHCT5Nw3ekiULd+Xc5/HnplooAWpysHNfohtXZqO1kzR?=
 =?us-ascii?Q?Tz94idOntB/UvlmnWsYmI25k5wckuCJbqjYokWKtOsDiiLMJ1aU9XetPbzBc?=
 =?us-ascii?Q?vaY3hky9SuWZ497LfBl+wNaDQ8wJlZKtl40FSWUVbkO/Ok7Pk6IHePk4zGj4?=
 =?us-ascii?Q?JTgVouyd8MdoJP0p71fjVobLi3Y9QuL1WVMjk0fVcfmA1P5moGEk6p+8MJw0?=
 =?us-ascii?Q?omX/LyoVM/LfJLg9VhbAoeby50qwKK78MKsqWs6egHT12VKqDa2q7EnizA4c?=
 =?us-ascii?Q?Dg9VTHNhSOJWlu3A2+sjdat91xus0FY1TIS6kuH/AvYhLhQeZBspLkiPDUZG?=
 =?us-ascii?Q?cYuz/UzPwDbsnvjgsZsoIMWHUj6hgA8bDgop9JaVKEQ4bYeB3vHjnvf2giMk?=
 =?us-ascii?Q?KpLg1DVyjL1VNjHHPMH+o28eFud9+nnVj7Sk6Oa3nPVSx1PPZ/tw3dKRmh1X?=
 =?us-ascii?Q?HFXgHOclSIVSMa1t/x4BZ/v2qIY9wU6tl1gTrxQ8Ky6gbkkieiwR5uwCX/rl?=
 =?us-ascii?Q?me2lz1C5CfaR4Wx8Ls18NTvCiqttgqLDmLoOdKm47TNpTzDSFSUV3XmqBuYL?=
 =?us-ascii?Q?x9rVcHBQD+CkibQ3D2/TJbkyTH/k575MIredNfkG0bKZZoqAQ6ClTJlh4Zfp?=
 =?us-ascii?Q?gUV0PdWpFaVqyMCFa9snhtlVb/NwWbPRuy1o5Rg98mug+V7s2fePi5toDSK7?=
 =?us-ascii?Q?txoCYaxOA5BmqLFn3sfAqCBNR1yy7wIBqin44nzbGMYXDAhjIm84xtHn0SjL?=
 =?us-ascii?Q?WnJxFtdZ60rdg/adWJGi8qH10CNy01MjgiSyLaI9N5jBH2YRYbXTIy5sExi3?=
 =?us-ascii?Q?I03aRwaRGr+XAjay7VwgKPsbvivRybGFqlWcbUUXPYIBlOsm681VwYjoZtB9?=
 =?us-ascii?Q?G+2CLkHFMtZoFKceohMNiPRos95ER6YLHRggSOi9rn2FoSl4fav8DBeSGz0D?=
 =?us-ascii?Q?x0cDLljpcum42EMIrBUAwsBHFIddGvwy32QBPaAeTXUH4G06Q6xK2a30vf68?=
 =?us-ascii?Q?ALi2z8LW3Hpn+HFGjtDZ+P8UyP6Mr/Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6efbdf-2f93-4af0-4cb4-08da550642aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 10:51:00.6092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bdqcq65hrKWd3g+j8LQ7eEsfvqKEplqmj0cls8FwGnAyx5N3nvqUScLl+EBv4iGRBAyn/nQF8K/1t39frkyE2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7659

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

