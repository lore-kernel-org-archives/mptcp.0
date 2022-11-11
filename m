Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CB6D22
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 13:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzMaKR6BhVQTYf+TsTPz0rfx7awI6NG5++hPvLqTISq0uTahz/BjApTwtgGB6uJzaDTrWgMaws/6bvKDYqfCSMAaxOEEve7oqCFBsu1i9x953frfMBrYtGC6ZXKn7JYdmVL2moe2zcUugSSq7E+JngEoTL3J4tC6A12Bb82bfIAbqmBZJiEMZAq8WnIl4s5qUgkdessi7Kemm5UaqSdQ01TU4GNU+3JBk+mUaoDRYlwcWKiXSiwF4qhw4oQwHToeR6sDA+LoFSs99JoJvoK/13UBGS+gzwuyEPP0IOLeAsmzJ1XX4mWv4AowkPrYYhVHsQUfsBSfYFC5y2L75Szi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=dFzw/kKTLCMoYJLkoV0tMP1lOUxpBTMlSaAaQVkUhgQDwT90z3/sCAAqoqfrttOaPSNt5fxkxo2HnTaLq8s7Xe6iz61prFQ8PIDaWtlqxd1CQmHTYZkmvHL2Xh/p4aJhP77tHjsSu5czvnYIMgJQwLOfW24DCpcfPbyE3OK4ldxuX/LouDxDeGxhKIfqXKJ3cLwjPrHMAYIC63jFNp3HfLnv/t1P7o8oven5NCHAAqElNG9JcupDuMVTdX0bIqsXCdaGpLDbdVM14rtLuRZp2JsHzTul85enERuWO15uTnjHlvyPDNSE1H1fzIzeQADIYgT8GeradqcJix2UvUZbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=5ggeUYHC/WdNRkL2Ds1iNfbzUFJ3FkH8yN6jplUkAp5rkcZWbKWXalZ9x5cIkLg+j7ANv6MNPzfQeOd6jql2H0L1X0CTv8goCFZZRF09ZnPLTVzuY72eTdMuq0qyI+a8/8NIMveKIvKEpzflZ/+KcD6hlDTR3vi7L3yh5G4meF62Qt/7pnaX8iK+19VrNSrEphl92tajNbYTj0W2vP/heCDwgVhLrptvUMyVvMI6EOzwKGXDsYQw6F6R1IoNU9hRTO5JPmdz+H5yYbTlj9d6HRmVp/W5MrZ0SqvkH06vX4bnhuADkYH282LdLrsCorCbXGCV1YsW7SutGza/zMkCOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 13:33:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 13:33:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 6/6] selftests/bpf: Add bpf_red test
Date: Fri, 11 Nov 2022 21:32:49 +0800
Message-Id: <efef4c472c5ec1ea6c8e1c1f7d1288df41445afe.1668173360.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668173360.git.geliang.tang@suse.com>
References: <cover.1668173360.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 45929ba9-e299-430c-f217-08dac3e94d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYUAJRgIsE2puPgm+EwcIf6C/FYG9awc4Atml1Xyn9v9uC/+8noevyCZitMgB9K7RpTtulfigfS99eRG/kNEeP+Uj6Qk/JLCZedUKWKSpkeOkuhyX3AWDdAa+o90WnlGvXbeTq5vQ2Dvu/xjLCKldQKhu0kEDK32LxG4BA2VIfn7q/rWNne71fbgzXTtPL9//6SI0j48H/VL6SfX2eAbUcZ/yznX4kQPhVocHoxaUIFMuWxC7nePG6bduJLBh3+0pxE2yUALUf/cdYXZb6WgOTcc5RcnQu3T/wCoTTIUxpqq+sBw0Yawb69YJGCIdU2Fz5ZxA5yfKh1aa+6KsbpX7YgXnVGpQZtPIcg7bCi/wZ679JtuAmBqx8Cji+K2qqCMYRdnqFOH/14zPk6IfdDW5m9lpOaC29ZSJtxHuhk7ATPonS94qoX+n3bbclIRqS34obrJLlLgn3yyVc3U4/Td5xX2meB1QY4D0j6a9aOelN8JHNt6ntRyByptP+27/PO97QaPLtc6clqRMmJXv4SKSym/FCG/Sird3Xmd8QOCRo4z53SC29oFBVuhkG3Z9wMLe2hGekVQ9Q1ylVxWnpYi6Zg9wR1DqRJDMxs/CdgXIdlBR92sRCPUSGW5nIhqWWMKLH6EoyKafk1C8+vTQ2WfMdcCd6RGwNvi1/jcdDP4WyQgF0IhhtsjWixt3lEkaN/QDSirGW+fnLyQ2iiEttlB9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(38100700002)(5660300002)(8676002)(66556008)(6666004)(4326008)(41300700001)(107886003)(316002)(86362001)(478600001)(6916009)(66476007)(6486002)(8936002)(66946007)(186003)(2906002)(44832011)(6506007)(83380400001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JvxEmwpisFs+pryI2UrnCS4feRqMfnmPH4F1cUR8EOJmy8FO65e/yimmJTtL?=
 =?us-ascii?Q?huw/SwPZD0ZimbPJUjUYUqF+f9sCjgC2O7yEXLFMl/sc8XAqm429gSe2SuKH?=
 =?us-ascii?Q?hDYTFWBptsrx7REG0lpcIYdzOYpQ8JBMBxm+Ef0thGXbnHpwx/9cEW1/xgqT?=
 =?us-ascii?Q?XmQe5F8eR9MU4Fm1aSv9nHEINYSNZAoYUva/m8FJfNjJccAoFKdSQhZG9W2l?=
 =?us-ascii?Q?Mgut0o2aeVJokVp29Md3Nw6XKPgVcJWyHBqVr5xthWCSOASKlcrQ+o2t4pAe?=
 =?us-ascii?Q?vnuYhkjRjZfn9Zg9kklUB7Tg5SYrOSPA1oW6MRWZVjvDTXp/hvURPNGkuxtt?=
 =?us-ascii?Q?/37eJ/lrg+tYs/rf6B+vXcPNdqoeAz3nwQ68/wW0yJ/RT1NclLxsR5CzvRRD?=
 =?us-ascii?Q?SIoYuQfX0dcIMXkZjYXs/1g2fBHkrwi5cfBHfMXj6d6ActQlNVXs7yWwlaEP?=
 =?us-ascii?Q?2gzLasmKVA8etKUfpAAGGh3A4Aw9elJ2HPJiVOvRRMrh6egeiwS/i3z/5pvM?=
 =?us-ascii?Q?bThA6U0kfEA5rJtmHKj2Z0+2R7pO18ZKHnOKa20bYzCqiSXO0rr5yh2YJ85I?=
 =?us-ascii?Q?z8zV683kZwj5IpdkJOZFJ6xaVvKXF+epEgGe1RFkuv+kAvQgKHgbt5RZkZCu?=
 =?us-ascii?Q?F0zhzl0J6xlYtZLKjYJrDauqibQIWXPGUGhwwjcrDdj6XL38dTN/daZJXbBv?=
 =?us-ascii?Q?dmAF7PZCAHQG4yQPKgclch0FExLjf412eVuyFhPvuu4tPGq1N/h/T7ZtMkLW?=
 =?us-ascii?Q?hBtUngZfRW2/Oy4A4iPHm7NMqXRnFg2SocLM+5rPR70l8qh1kZzVVRvxo41C?=
 =?us-ascii?Q?zNbppooHf8Zv8tJqzxAGZdPnpeQnPE7fxJH5/bFFVNfy7MT0qYLAcKSCkdxu?=
 =?us-ascii?Q?KeAQqEDyn2CdikNAO/TM1mLOThM0LNei36vNNeMJDEz0zekUY8W3rMZOKg2w?=
 =?us-ascii?Q?Oq5j0jNXT4qYN2x9T0P4xcmA5snhRko62PpFD7YeWWNAH9MkSNsu8RvrkIdr?=
 =?us-ascii?Q?OY8qqw5V/bSk2iN2U3dTFicyJtllLEvbs83vAZiusibkgNsL6XW9/x34gDkq?=
 =?us-ascii?Q?G2DsYMrjtYsrBevVskqaRjoAGSGDsErY5B9u+0w8aVogcZTP20Pz5B44wWiZ?=
 =?us-ascii?Q?Wjtf/f/995n8S7N6uU3/TzzIku37hK/ccBfqzHYI6Ed99p887AVDLcfqCjhr?=
 =?us-ascii?Q?kH9qm/AqNzeeJLodkZLw1oRUdhs5A1ZISnjRsZMYLKIieOPOl+m0NFV9WRVY?=
 =?us-ascii?Q?5qrddt5hjvVh8frhd41RRSO74NbfK8w8jAPhGb2Npv5QEzdzJ5JvyrumxOYK?=
 =?us-ascii?Q?ekjYVhGGXV5lK7czblm5PIYHQG8IVp3YDkWiAE6zovLWKwKbit9mky3ZLz6F?=
 =?us-ascii?Q?ifPCyqGhzRk8+RU2o2L+OmZt195TvLtDkc3Cfixhz3Rnh6ihF4OVXb3/+Vst?=
 =?us-ascii?Q?Z+Qbyrz0SvXYxjM+9Ql5asEU7fu75mrmOmuK7bB/dun9g62nESH+atanp6sz?=
 =?us-ascii?Q?AlHZ43xLGTWRJw+MSKZuEU1TFema81WmEoh+sQ9DO4lnCCKk+ooxhPkMDPTf?=
 =?us-ascii?Q?qc/VWe5ctCqwg+wn8JRugnlEhTysbTsmZeWAJdBlOtTI8FEdb2WDk7e1+VHH?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45929ba9-e299-430c-f217-08dac3e94d64
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 13:33:22.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4Nx4V0gAdW9n0O9B6rt2S0cYxnnYR5ZKmrxJmFUZfLhfjmcFZMDvuxSbO4nuf40JA/ZAqQ0vJguWOMFnQOjmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

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

