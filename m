Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84215A5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 07:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649145221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdwYXfc1w2T/XdFkru56tEfsMTvmiglzhYb1TDKHgeQ=;
	b=W31NJhBiz/b3cW9LaaehqKQfsWfuMI4nI5EUA2MIy8L4ELBJ4yJ1gtVjRagsEGQjXc2gO5
	PRHaiWUKHlve91uDnBHBq4sieTJExhDL7JD+AEHk//ERi+zhlwfCWtI8NmGpgl4X3+ez9T
	XI6TE4ipDk9QIiAEaye6D9wmj/tKajQ=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-cKqN6pnFP7-gvU6hADnX5A-1; Tue, 05 Apr 2022 09:53:40 +0200
X-MC-Unique: cKqN6pnFP7-gvU6hADnX5A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrA8MLfjAmmGqWt4nOqsETfeM2iGi0kvUKB9UgjQJ2SdgEqByxRWJGPGJeBh6u+bYa+j5eEV/QN/mhKEqF3x2Ns4yBzc28HkY2VZMjc2BbWi440RzQHY21Enk2Ffv/PI1azk6RLGES01+Dup6/lfNWwWauKPwBWKe+LrK1uJJgtM2NhFGtQYJY8yIydaxiZ2tnzu4MU2WIq1Yp45sbeKjURhaGIOXS/XUAy3EqxDCG+qfAVgXMP8lwuo0YOab1lEhs+tfhix24DkX5Zc7W/4y9pb9meAk4jKINpjf5OPB2YXhoKdklbhBZ/UCMSdOI9Susi2DLTiJrhWL0BkObUQBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdSivCaJQmaNvMDw06m6MCQ6cX2YWB0Zhex6qTtlzfM=;
 b=F9ixL+ZG7XESH5AGJ5GpkXBD4Tf0UNmbdcvEzQ28XnjpJOnXuituPDFP6XvAEnK/mtE0Ai9Nhuu9ab0e8lqpAqAj3zo5AbMsne1JZWZQSJ/tTMOsizIgdr+18n7LZFfVZTs1aogU/dcJwowzKDxydKeHJBJ96n58piKBoCcfLn+TDf8TQLx8U4ifYUfY7upEbeDzoZbQmUgUhLpbDQhgek11qL4HiF4WMHP4kYjIclL8tzwDC37nggGHVBH0QHjGMjaCZFaMtEowPfeQrYGVXuNyp7i+cvuXR9GFSQ4rhMmHNQlG3Wt+MMmrsgJWqfDQFFwJq6XmSssX3RA4caIjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4950.eurprd04.prod.outlook.com (2603:10a6:20b:2::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 07:53:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 07:53:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] selftests: bpf: add bpf_rr test
Date: Tue,  5 Apr 2022 15:53:21 +0800
Message-ID: <68f53df75601b2b3aea71fe12e69e3e065612af2.1649144853.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649144853.git.geliang.tang@suse.com>
References: <cover.1649144853.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bc90311-ef19-4579-83c8-08da16d96556
X-MS-TrafficTypeDiagnostic: AM6PR04MB4950:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB49508F4AED6FEDC3DCAAA6DBF8E49@AM6PR04MB4950.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kb4FaKUFY4oO6hUw8dvuzi8qet5NBmZCaueOz3v/J1JgrZhQc+fvx/yMMw1Rom859MrvlBUdsCxpTWXLVNu4dA0tmAFfbijEDwwvoMXD21XuEkpbRU04kEJ8fhYg+3vyKUgYvHv/r8hmhr/RCpQtJpnWOuEyE0jPLuGSnhI5LVMqvZuIiLYqD+IczRiwb7MXuTJ1bZRuK+srQcKD+Mclg7og+y5DaCsreZrsvY+rrZdoZV+C/Pbifx0aXSfjJkvwiv8zEfTt6hwnM/k90Bpojk7ZlV9Zsz/Db4uLkj80MamdLw29SVvL+dn7fshg2octE1y0H6M5yUejLBnclBAHTT+mOvhJ/V4dph+f3f77Qrc/Hzn03gYrlJUm8GcvlmeTaalmjBDWrSQ7dXBONuksGuv6TGgWB1ol3CZkHRwLBL8Q7k4TjdhqFJE8fLLbhnSUzL+DhKeuCYUHEJaU/8q8COUNOdaAZxkTTWRWDPIRGkZU8VUtbNWDsOkEHx204QK49uFec/ubD0Dp5lSsy8I7ne5XAPNdjMQxDm8wufN7gNfyE9AWutIHEPbMxq3L+Vm87j/dvax3dLZvjOUCPORBxOZv1DahRF+qlqHJhbRApiOLZeQRYHatBeIUQJjoQGm33RnFAr1GscM3oq21Zem3Zcpb6pO/oAqd7dLAC68lkQthbrNCztOss35A/unK80mP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(107886003)(6506007)(2616005)(4326008)(66476007)(8936002)(86362001)(66946007)(66556008)(8676002)(2906002)(5660300002)(186003)(6916009)(26005)(6666004)(6486002)(44832011)(83380400001)(508600001)(316002)(38100700002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eaHLnDdI+cTsnbOyaqm9bw0URMn0HKATO+jnIk1hUNPmvbsMVnok5bUh71Af?=
 =?us-ascii?Q?jzKdY8FUvVBp86QflEK+OCm2roo/y0AV/EzFA5gyVI4rxPwR9bzLRdOx2KOy?=
 =?us-ascii?Q?Tyan/QTARFUT/bhjZ5CvVzUllODyUhIqMs4jiht7t/wenvVDvG1IW0U733Jy?=
 =?us-ascii?Q?+3MfydIbbcow0cxjLiS1/LzpZd1irbpk+YceXd1PFdFgDvjtURYWUv/vC67G?=
 =?us-ascii?Q?5MOPLvLhulFpoC12BXkAfItX2jI5udbHDSXHyx1bZVOoqYvBNkjDuS8GCE7e?=
 =?us-ascii?Q?k5UzDDMLu5VIu8AXzI+i+ZKJR+ipSygxskc5Fyf20w9KTygBW9gLksHopWQO?=
 =?us-ascii?Q?57q0N68rjULyW/V3WkvvmbNlQx9mIsCeeVGZjLTr9NDE60QAGz9HPH+JOyfo?=
 =?us-ascii?Q?hqD/7Zlu8Rzzdp793ekMOmtqRERxHnHGeWJrX7IENK9LMHcho+pFRVq7g3PU?=
 =?us-ascii?Q?sfOAnGk35hMtb8BFm1V2mOBhDHvwW5SspLZYCHgp8Bx9SBhXOA/DHG8ZujAr?=
 =?us-ascii?Q?xDJCIk7hUdSNkHdH2UOxZthGBUdxXADAvsRMjvhLMZGAQQA2ixZes8Hf0/GC?=
 =?us-ascii?Q?51EfoXJ0SUhkHE0jwRMcBn6hPfGMvwh1RfnmuiTK2uIRQhkMPfta8NnTtrhZ?=
 =?us-ascii?Q?GVGBHBKIc/JtYHK9sZmcbNLHUT9rSX2POrB0JlrxkMH+AAw3qP30atAii73R?=
 =?us-ascii?Q?V0V20efLKmucyt95SOB6brnBGQ6YV1mPTG4q9F6OeMUE++eEA9gGDxLyQNtg?=
 =?us-ascii?Q?QG95bMI/1H+v/9zGqbpFcj+RRaxyp3vgPTDrPgESt7LLTy5dzEPN4VnOesOp?=
 =?us-ascii?Q?kpAbg2DJhc2hRmXnEvd3VOKFPz7OBrjVW+7n52EUvYO5y6Xs9qzP/myt+sI4?=
 =?us-ascii?Q?fn+87TI3beQJoCz2yHeTfhM2BIBGN60i4dB4hrFDnpiUqmJd5CQDeA5UPdtv?=
 =?us-ascii?Q?tRkm24GY6gO4zxeGbpTW1CJx7HS9ENVI7ZVQJDaPKJ9E6qbb342MfyXItdcg?=
 =?us-ascii?Q?gj+1HeHfKVYKxroS3kZA2vJgtopHcm/RjK4kQiXKZzY4Cd/U5YdkRRw+T1rO?=
 =?us-ascii?Q?njjcL9LZBe0QXkn1/SYt4w1SuvogXijVow1nJBrzbGGTZOU5vUdrR2hakXp3?=
 =?us-ascii?Q?az7qunw5zvxqpEQNkNxDjKMP+jYHUbUbuNTOUSNRsdE4Sy8nNQ0ECIStNCmA?=
 =?us-ascii?Q?9XOTFcRHZ0MV6e2yLYiGQVLHa51TpXH9V0voXm7K5/LtQ5fe28k4l/VFClXr?=
 =?us-ascii?Q?6V4uE1GF8Z1JeoLgavQhNUOSsnxSfQfRoogzU20YrzONiXU/ZTB3+gkeMeql?=
 =?us-ascii?Q?5q2djiHaUDiIQFnoRIUbVtmqAArrwtHjOsUs6T8x85m7tMtKaOM083oipyD0?=
 =?us-ascii?Q?0dHWpZGCojvD/qV0rL3acAgBIxb83+ceHZ+KxuaD2Lb0cfo9A7I8/NtXE5zz?=
 =?us-ascii?Q?S49pPr+Xdd9JS+A+3LUPaf+DoGfS1Qlhf0qdf2aroV6og2W0pER20p4oapjr?=
 =?us-ascii?Q?IRYAaWud06qj/JJM5bLK1cqx13Wp3fzFOp9ChaUSN4FKCVjNuMIc5Y0Xsg6N?=
 =?us-ascii?Q?LXkNS8vd4MhTaY5SVuDwHSxiu8kb2cNwYMwoZwPN5XUxA4Hj+ppg+3ur7zii?=
 =?us-ascii?Q?h+peCRPtYad9YWZxD12zMyp7sI6xkuZuXUf/V9YsFdhc3G6qGVYYIVNEIQ6g?=
 =?us-ascii?Q?er9fZmUA7Dna+XU0WMsRBkUd3UObmx5wPG8bERtxGCKCf7vvhCNzYXkycGjb?=
 =?us-ascii?Q?wiPJ6eO/QF3iGcfxDRm3ntAlUH9z0rI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc90311-ef19-4579-83c8-08da16d96556
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 07:53:39.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUqlBT28nt97r/uR8IHie7sbSEK6RwS548WNReuUAMHYYAE7pQNJ0hmINT9Jqk8dj5dRL/10gq2z0W6qDboHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4950

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 467769e229f5..12287f086238 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #define min(a, b) ((a) < (b) ? (a) : (b))
=20
@@ -363,10 +364,40 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (CHECK(!rr_skel, "bpf_rr__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

