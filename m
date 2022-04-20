Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2777A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 05:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9PjuXmxx//rp3Sg1bxMtKi7svQtMfnWGsRK9tVAIhg=;
	b=bXHHPP3iQiEOfhoEznh+mqQeuRTi+ZQm9iaAHvj8ZO1orY2xMtKkkQq25KgwNUziTpddXn
	/SntJ09OP52N0/DUsQNu0RG+OhfuyDoUb1RcV/MAIosrC0GIn5513Zv6lAjgh6J79u1ovy
	4Pr2m81PA+FFupFrz9XqypIGkhejn9s=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16--A9yUNsHMm-TA8CQKTDowQ-1; Wed, 20 Apr 2022 07:03:00 +0200
X-MC-Unique: -A9yUNsHMm-TA8CQKTDowQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv5WkmIihgrrSwdhW+ZHZFOyIT6Ihj+6owftC4FUWfHAGrZj77lhd6K85uB8zU+/BIj223NJreh6XAe4MELcRufVkSd4xSgXsg2x/tY+YRo4n+zAfXw75l08HnvGdasSMZ5NUSJu9X/3SjSFjM+n+oACpvBAi/2ZBLmAJt03B9/XductDR24yAR9FzAuxIuqiPBCeZ54dYQeOKYzuFgwm7Qa4HXqJYphk8Agl0a7IAGCtkjD0OquQKTr3hsokB/U+R5fyCrfl8mDdnP+SPSbnyqr4164054FhFQ5kKMa2abATwSSs/UMN6FjF9pSEiflXufajUXGvL9AV3ORtvMbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDnccN4Ej6cG02KY5kELgZn3ENNVMtxOEg3GeS2yTrk=;
 b=b7TO7H5OSZpPnXcMdcwH41Q2N3AX1LiSwT8ybiq25XojH8zETPKTph/6NUHkpv0SMH0KNl6EzQY9YJ7fGO5llNMtt3Nuls5NM9DH5eVq1b5zd/YJ60uwpbhtn/PpkrfMC/N4+VwQSRwNx1c7eS/90/agnwtbZCRwoenQTN6lmzpYG6sZgAlVqnk+u9LiTLYuiyIUTAUvQId1CwvuP2DHDe+x8i6E5ShJQxlwD+KHKbv97y/UJzT6+3vNtJsaVCsIbVG6Lt/U7nNeYXeC6+8nhULoX2/aWjj4/hxE+lplIFXZdVgU5dJB26YBQBU9BViCjfUlz9xE8x57qY7NTjzEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4303.eurprd04.prod.outlook.com (2603:10a6:803:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 05:02:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 05:02:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/3] selftests: bpf: add bpf_rr test
Date: Wed, 20 Apr 2022 13:02:55 +0800
Message-ID: <37b2f66cb0ee8ed053d0e189b52ef996445d0a66.1650430881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430881.git.geliang.tang@suse.com>
References: <cover.1650430881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98ea6f52-759c-442d-e5e3-08da228b0a01
X-MS-TrafficTypeDiagnostic: VI1PR04MB4303:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4303532796AC190903FC2D9EF8F59@VI1PR04MB4303.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9n6epHIRRBZ5ZyGASIxyXrrEKNNmm+XrSKlfPE2AiIaHzjLpjFx3nmt1HlwkxFurvhc0VHJ1hmCc/gQJhB/+I0UC79WMJytQXpzCodmrB5lce8eWETndIN1xG8TebGzRed+AO+1KAfLoAiALTC/GoSxGwwsnXmMJz47MCR4uALJpRLH1sRmyh5zl7k5zleaa3b8BRfERz6WVhwZ6uBNzrrctG5vNsKyiWjLJqNj7d5Y2HgYH6E1U1u0YuB8IkbqoPnZ5Pvd3kRdIh3KRz52fqylKhFfMVmytje1KILfZirMinm+YvMW1cix2ltF4LGWd6ffMMpr7t98wdN+HBKuqwwwDnr2aHLEiHYS7ck2VJZOUlUeVsOox2gK3AT6Tscn6gUYOXNbVx61ijZAsyquRV2HMyiZeuBTcl8xzY3m8JBZL1J1M/dwQlanZn/VVpgo7Zct4uMoyOAJvCpuBAY1tAEy6KLAVe+s+CvN9OZdw5ilfEAbZbvcM+gf+/hRHZgX5h9BJoXxDPirvHCBSz0XJwxnmQ9K7lWZQrmF9xGUL6Syu5kbejgezw1PFmsrXv4iR37GhBQo6hIQPupiUF8FISmhpVSgSQtWeSoiFfbIP/jOV6oeMd68wPgD+fjso57noB8mufpLHidUfDzeTDwuRiUDLGeU6X/QS3b1HRIJSaFzVVnZBMJ4/2glj3chUZIBc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(44832011)(5660300002)(26005)(8676002)(6512007)(4326008)(6506007)(66946007)(6666004)(8936002)(66476007)(66556008)(186003)(2616005)(498600001)(36756003)(107886003)(83380400001)(38100700002)(2906002)(6916009)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0iXe1ng0+qfetlPn+AiMlY9t3RjKmSQR+Uwhfp2I6cz31fnxtIMkPbMftDN?=
 =?us-ascii?Q?jon1FErHAi+/sFEdJUGwwKIx406ltvuY0fs+GP5tJHfEPWA12pGShhbYjchd?=
 =?us-ascii?Q?/KwYabdt2+szE4cKMdvSsNEQO9cdqSNnuJc5UF6n7sTO56pd60jUI/8m7PgO?=
 =?us-ascii?Q?f3ECbS2fJG7QgSzOrNYYJgKDaibPGUG/Wh3VyVD2lXD4etZzJGXvAVS0hy4j?=
 =?us-ascii?Q?Q3M2hGyq2yGOfHFpjlpILfn0GcCPO+yzJKqtQ3yipvISoaBROrXwn9pjyB9X?=
 =?us-ascii?Q?Yx3S5Owz8+yyxyDRVeMJ4a0qqOL1vH2/Ui+uXm7q4WCOn7cGVKQypX0cJ2Pq?=
 =?us-ascii?Q?gAulX0YpdCeR2Lubxy6BceU6haHtl3hugrxdADLMwzglJp4g3QLXPutpNnT+?=
 =?us-ascii?Q?Qt3Z9iQpyxsZZQAXNMbvqaWyNfEt72PEENAtbh5F5UrIOibYac7h8+2MHZB9?=
 =?us-ascii?Q?nV0TWfg8bRvKu6ko+XBq03GplRd3gH4mHwkH5kn8qFwo+7tb5u+HvdsbXt3p?=
 =?us-ascii?Q?UAm7fosGddyZErlUEc68UzLQAUJ43rr/iblip5T4/1/xyLLuV3qEYFdyXhhu?=
 =?us-ascii?Q?ujRYqtaG0EqDC2B/Ztxy2RrSwXAdI8XivwurZkoraAjtq4TZIVEb+3Cyvq8f?=
 =?us-ascii?Q?/U4+0ohtJWMUDoW2RznV8jOK1a021CSuHZpziUKltbd66hm06jGTbiL9YYbz?=
 =?us-ascii?Q?1weAYpmNr/tlV31ejxkzj0fUWm1r5NyvQffnr+PNqmgSJGokoFDECIldyokF?=
 =?us-ascii?Q?AI4BH4UyJ39iaK8G0d+nB/wZQiFsPq8ige6aPClLNWReUt1ylx3VpuBDW1df?=
 =?us-ascii?Q?4cSlTWBYjublrto0cdxw78v57Aj1jKArAU3vOJOdhwkQDfQDDEpDgHkg2FKZ?=
 =?us-ascii?Q?t0M/K0yTbT+4NSGfGtsQEkL6ubV/655qv28scX961Ol4MweQMGhDML+pNBas?=
 =?us-ascii?Q?CTqxFlJX9f/irNxAkhfgbmOI9x0aaN7gXMu7XnUBNCvI4lJzSwxT/UcfSWQu?=
 =?us-ascii?Q?9qIBTwC1FWTuxIvr8OkQpAWxY8gHtjxen98upR7z+vLOb7mXsBQMo6K7MCkm?=
 =?us-ascii?Q?0h1EYMiCYDNub5iO8rOEYwv2Y1HMs3V3to3gDXzmzGrL+tHIWzp1upEwTec2?=
 =?us-ascii?Q?0Vf3BrgTQ1eT7PVRLisCbIJUrnMPhj+8AX9JuCLCJAbtNqF5HAu3IWI+CVEk?=
 =?us-ascii?Q?MovEsegWYEbY62RtB2XTrGvF2TkHWrVnHfckssHGzywd+TCte7LHMp6LWRmX?=
 =?us-ascii?Q?gRw+BA3vODlkjmDMxYrQewmh+GaMWWZn5zSXyC/0o7OzT9qVD+SDXpfxpY6b?=
 =?us-ascii?Q?kkDmtmJskK0yvv9Jaq8MI0NZvy3rCqduLEdtkpW0RfvcOcDJ74bx2cwmp5Mo?=
 =?us-ascii?Q?eckr4R5aZ0XBmqwE8S/RvQh+U03GRFLTKPDobEs797bw0WDPFjtuIxpI7UKq?=
 =?us-ascii?Q?CzAFkbmowutYdkRlTL45CJV43L9tMqD7G+zgRRoXZsFugx+5lWzTeMCkUi/1?=
 =?us-ascii?Q?Qbmhli0Ca5FIc2PzMQwMcdhfxRF1p4DyEIub+SnN9EENbfnm+g/5V9E3J8DD?=
 =?us-ascii?Q?2PS56YKuqCdDfEtRp6LPtyaBL0f1j5DLOTFMcgwixAg268rWjjUSarfuRygY?=
 =?us-ascii?Q?AFJhjau2c+ke3gzpoYHIWYegtN/iXMsqlmRS+C+4b4ihT4fBRnWUxhcto5w/?=
 =?us-ascii?Q?NW0FRgG8n4nvGbjPgWZy5IlOY+vwFNYRukNUX7sl3d1wyVjncKH4yvHTWHXS?=
 =?us-ascii?Q?qccWBcinJLMoxewXiHLNzSXDne5AL5Y=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ea6f52-759c-442d-e5e3-08da228b0a01
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:02:59.3635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yhjuAq13yN+zSMEQH5+EA0HK3XgEsu/x861WBKvkEjgitWHJsp3R8q9ruYP8eycjXocFPF5DQmox5yUvg8cKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4303

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 377ebc0fbcbe..7052c520c0f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -362,10 +363,46 @@ static void test_first(void)
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
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
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

