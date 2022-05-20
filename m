Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9807E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ujtn/ir3BywRu/XHoPKmF0e293RIdjOqxbfk+lBpL3Y=;
	b=QqPLZI4sZrwiw6Q4PcFGaPrX6krxVuqJkmkTuoOd9KSo1nW8anfANq6TJ/DUvAvvGlUXMT
	AiJdNEQJoLzTMeSU35SUs9SH9JRqINHPwK/NPwro7ug+OsxQveA9xnlZSTN+JbyU3I3gpU
	cI/zDuOhIVo9ZdmI8WSVmwiBe3Svn+o=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-RICDJ_u5PMWRTHhVwfpRAg-1; Fri, 20 May 2022 10:06:00 +0200
X-MC-Unique: RICDJ_u5PMWRTHhVwfpRAg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzNEKU7BCqWyCrVyRYeWNv8fj3SRar2lFEFSZyFhTkcPHqijsIbF6ADLg0hDqWYnjUq+KsD9Oc+yYl2u7KF8qDcV2fd9vCGRoM9TI3SHtv9loDdMAvU08xoYiwXjlqdC0zznPcZ+TysTfBO+SV8LhFznwcjlT5GG3EG5yT4cPliQjR32CaQ+bXSnobfAMUSGu+I4upzHY7hQ/EBS2FRtEJK70kyqtTLX8B1X916Fttr+vpTkdGv5ENdpL5qFf5HFs8pKRbwPaeCGTzjNbqVX2UYPo1vwLyEkyKgH5jzbrCX3blvkNeuh/7jkbL069X39Chu3cbm418wdvJA+xMeK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY5mqVlKkpk3VxqBmZbxPRfQ/sWMgY9XAo3CyhjoFeo=;
 b=PONQZLHiG6iEOV7GSeKT9KSoEAdJY/YmeegzylGoG/CPpSPEVVtwqDeyFpz59F2JKEbbE6FreOicW4MQP1CPMrXgLbyl0AJoUcSSjZP0eosvc+FBLE4F2XuKZSYOtA6vGKCrWfS0JMsMZOD+DSZkK+Ej7CJRzHLNehoI6FbfJw97aHoJg1O/4Y9963bDSyxbArvK9kEsLUtShMKDIoUn/MFrEjUcw0KR8BtcgdTNVN3KGh2oFXZDW6BTGqV9yXgW37MjeRP9w9lkDiflx5adO0HqpHgXyXDDP7fu7UsFVibltpPezPfCAJvPyc45wI/7LFDSKzEECEAwcS4BFD1h1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:05:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/10] selftests/bpf: add bpf_rr test
Date: Fri, 20 May 2022 16:04:53 +0800
Message-ID: <643692d09a7a68a384ff33ce6be2646c510f9cd1.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee1f68e-03bb-46fd-08f2-08da3a379326
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2757:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB27579EB02D5222C5097D5B35F8D39@DB6PR0402MB2757.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fp/fGaMbYpt1PejoIIEjLD7KmF1IGMGJvCV7mtbWkKHIVwWR3eOeM8chRlmHZuFUJYgGTti+vXhw8eSk4Kq6WnRKUnByjc/K/y9ueddraBYEC6S1TwtaZswIYOFT2Q2hpiRgCYnv2Vt6p333AjNrroTznHNpHkfle0k8N9S1av2zChcCZguyQrDHkeO3x/jp7Eltvx/I5BVtKTuYXtkmEl3iYH8BC1aI+oakzoBlokh26SvUiizdbI4v91V63Dd89rxIKz94ZGGw/GFqU8/ycHz3y8mYnLN20FZgZWY9sd1DU4ML564Cqp7Zziu+fXQq8IrmAHxUh+1X1J1h1wrNSxu/upQ1K13WEeTR64QcGxRw8ig8l9gz551i8oxQsxcbvs/FTp0XEqdGnMocGj0U/wCo08jmq8yxueUNBgmcTDqlkbBUXpAVv6ELPVgZQn0fmQ5Y9dXADZrGpiomSyAgJuzJ54rx+5JZIyllfZm92tVW3G2ZY/G233XPfbMIXmKKqV9BljP9vKb4joRONhw3otqq/oVhuy0tYcjWzh6t8BxiNsiZl9/jY9gV0mixKrXYtx0QuswO97jqiXW8hxNUkPKlEF3l0KUal7SrLiLxPoOgMxDb/vv9k83pCOb79aWBH7bDKzCgceIgcsjl9DCmh3mdekzsfBVdvO0MIVvkCgRiW5DfK1MyLP/XrQpPKLxy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(508600001)(6666004)(6486002)(316002)(2906002)(6916009)(5660300002)(38100700002)(8676002)(107886003)(4326008)(44832011)(83380400001)(36756003)(66556008)(66476007)(66946007)(2616005)(6506007)(186003)(6512007)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDXLVwXUejPP7zGO8syDan9JKldwdJkwrtWkXUAi+6sauopt/Qp00BVyp/KA?=
 =?us-ascii?Q?b7DIQfEU6ciTvDnj0AXAjJ9xZ/Mz+ClGm+DS8MyXsGfbh6MZ1+4zrm9+cGwj?=
 =?us-ascii?Q?I7Sldu7lzgK5zM9435pD2GShrD3o2PkN1Yp8LpCEaCW7yMoerB2F1yruD8Mo?=
 =?us-ascii?Q?A8I38jFwMIID7lrhA6nMVr2MgpuVkO1dJab2aQT431FVQeSZKdB/G1kM39c8?=
 =?us-ascii?Q?ILvkOu4elaXwlFZ9RzvjD7sMLIEYUoXgN35DaWnwMhPKuXq6N0UzTho+ovev?=
 =?us-ascii?Q?+FIaXDpmKDla2JQE7b0Aw1zlfYhoHBnKUpL+7iVDYVTis+POGBfQanq80OCR?=
 =?us-ascii?Q?RpXfLQ9STE6YbI6a5q3LeY5YQRopRsjzRr6QY+pcOeudK2/I5oF1wGEQJXjd?=
 =?us-ascii?Q?wd96eCgcKf8VI0xePIQQUl5U8Kdu6jvDOu14lWx4iGVj8HRFi8C8RiOXFiSB?=
 =?us-ascii?Q?1mF7jtg7BudFxiTEyGFD4Lksxauf9YJphMqnvZC4hABlBmlE1G5awXtmPmuf?=
 =?us-ascii?Q?k972NI0wesRdy21PzcJw5chpMT14RDZW06S2sJgpkoair5F95oe80LFHEXB5?=
 =?us-ascii?Q?kB9YJwk1A8GjtlH923tRtdtOTsi9OtY00Z0WOiXuOahu5cFJhD8M8dLplaKh?=
 =?us-ascii?Q?/5I+/+AWUvDCJb8YNukW59F2ih8ek2seUCxHWAeOISSPFOoxa80fQINmpXwg?=
 =?us-ascii?Q?39OQsu6Baw7aRjb0ZOdXyTWKK5qf7zt9Tn9uGDEb6GOMKj32luzQoV182RH4?=
 =?us-ascii?Q?8jwwTik+XDq5NbIzrzRKDmLXDZm5+X+DbHyjDzAcf1ZdveYRm0iYKglFblDx?=
 =?us-ascii?Q?O8OGb2EMFtMn8V4rfi3GqQsDFixXYJmpwExJCOxmnPW/Koykx4PxoRa+bs7o?=
 =?us-ascii?Q?sI59FiMEOuPPQQZw7SrJWRD1BmzmdYwu3R+5/B2RQadgAl8xXF19GLIxtKEE?=
 =?us-ascii?Q?Nxgg+VM85KvE7OmihKWgW1n3sHmSDihCUpzx7eu/xRzztBamnGU16Z4r2WGU?=
 =?us-ascii?Q?1u14Ynpy8MjX2kRMZ7Gzsy1XFmLF6hKFEb8USUuF29mL798mUAITRKdZ3pxv?=
 =?us-ascii?Q?KCOF3jMrmjt2hAxgrn2LhrzRqM539KtyHHE0Up7wtyquJB14vxmg2M0U0VM4?=
 =?us-ascii?Q?pIwYF4jYD6VuTUCyrqdLR02hHjgWGpzu8xQzBXnPqvinTu3wnAUG2F2PEzWv?=
 =?us-ascii?Q?0d/rMi3Q53rmTZxtU55zYdPlpAxkXVHhQIb++xUlgWG9IBYxTGeiW1gAp/hc?=
 =?us-ascii?Q?VQ2YNo3JXJqE77J57Oj3jTexI9g4jeip62oEQLGol9RenIiexpSmYCtwj8Sn?=
 =?us-ascii?Q?8RrAhfWvkZhvpGRbS6rSos22s/bVRKRjduktwC+3ksVit+xgdSHGzFd1jJ35?=
 =?us-ascii?Q?4W67UqirOTmq2F5EPUB8f/aJ6KRknAiaw0LYHhaztlUPOamyyvnl6erdXNU3?=
 =?us-ascii?Q?0VtrwZSOXCWLo1INK3gj0TTJN5kBWPSXZWz0ZqNxVPYpA0OaWKPC49VOidEX?=
 =?us-ascii?Q?vbzBsFtKWU58C535u2ljVWhX9pn/1qqyLhqIdMBvsMg3mhQT3DPnqKjS8tsG?=
 =?us-ascii?Q?Dnz+1yy0THNtpk8+rCCrPvWLHHd29dGDgVscP/D5d9/L5K8vcpOxkGloRwIC?=
 =?us-ascii?Q?3OCpHQByy7/iN9apj5WHFvm86unHlKCSBBorL0QpIDE5Hm5s3qerv7de/z7m?=
 =?us-ascii?Q?rv9GHJwTW09dHIrt0QlZlGAQahpqkvW6WnnEh2MCrKO5TGt8fadXBUfR7PuA?=
 =?us-ascii?Q?cDH8UZgU3tkImuUI0lv+f7ir5S13kn4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee1f68e-03bb-46fd-08f2-08da3a379326
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:59.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hq4uRQ5TnY9zKviq40yRtMclegJD057uUgLbbrqJcz4bSXEJerDGIwbZTh0ALWSv50wCzojBzn96Zy6VI5NZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 9d37c509d3ce..afa4de991f1e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -279,10 +280,47 @@ static void test_first(void)
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
+	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
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

