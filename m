Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C35615AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKXiBix1nrMVVuNHiRjqmG4LLhxztPa9ak36EJbSdvk=;
	b=dqiiOLHL0i6QL7NnwDvzsS0f32mPAuodu0Fn0xdy/2I4CRvDt/9Vp8KL1i9MNYgZLHTA6B
	R/Wv/JJCKSHIxIW4UjNnRA4iJduSXi1ntTfQsR+TwgikyA7euCzXKhtsu/ipKPJs9XVJw7
	DhklergEns+1jAw4brH5jBCp3duvvE0=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-fsgbwkAEO0K2KY2HKJv6dQ-1; Fri, 18 Mar 2022 03:59:19 +0100
X-MC-Unique: fsgbwkAEO0K2KY2HKJv6dQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5K+uj3f6vwXlzd3loTJNGree+wF6o2ej22NpVyv3mqH5bRvG7dbDgkp2sn+3A/WHS+LHb3x9D01nxj3m529CRoztCz+9Ito/+aR4K0VXtadcsuj4TcgWYQjbYLL4Soz8qxSaWAhuv7hEskubba9CtxulZ/TE5eXxw2QVTzVmqaVE3OCnu4dV1WZX7MDgJC6BfAuc+8n/4e9GsuARH2pQ/q2tFbpv/dZwZ4qNCmi0bza3mS6iBnXK7CYImZg4mmVjIIX17g/8B5JKq0iYc0AiqCgi3E0FsSdxYvRFzHEcBW/NV5c1a2Y83fRT9RbPjY9N+7CBFGB6rk387/Y7J9viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUKoondKw6BCZiC4PRISP37TrGA5gO43q4DMIok3z2k=;
 b=bUB8Dq/Rtup2KbSUkrTGKemszt5CdOxxD3mSFwmYM9T4mnKYoqC+uIr1IL9zOeiEcmiZSeBG84L9MVSGGGGFfXpu362LeJH8JFasng8lqy1tdsey5EWP16Y48NAJkTffDf84y2jsm2oCWRNHyA1DcHdQUOfyjq3sriD2DHLcPff2PLS1XhVWydLN4kfY7VSkluBFGKxJgXHGBLMpLoD4riKInmlxVEEi0Hq8zhEOQDX0qU2DrvHO0rfHkqiXYaPPmStUGlZJr57vyZEEgkA/YqpyuEUcoTNqPcXHCF4CiFDpaM1E9DWy9mTZHoJeLnNrIo9/XdN2NJcSAJww/GxGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:59:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:59:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 8/8] selftests: bpf: add bpf_first test
Date: Fri, 18 Mar 2022 10:58:10 +0800
Message-ID: <c42b1c51caa4a27d5d99825df04921472f9bf7f0.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: add986f2-8a48-4351-281f-08da088b4b0c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5652A2D7704CE438BFE0A684F8139@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tAHsYLqVswEVoqFqeihibwbSKK+FY8G/zGLeQqWAxMs210vb8LzYgffwzXfd2S9dTgQjuEBAWJTXZrQykdNgGdbt9IUTYLyPhrT+A7wnYxjJmtyjrSWVBMReENZNtYvySVSpXVBh4o9KIy6HZZ8/NQGqNyBzVx3DUk4nOOGRfXyeFK/74tuy/oySLYufN8GGc5cc5E/AY+bf3UeneUcVQc4dTo2ieapj/5nGR1kyB4GOZFCvSjQ+WD2WWsqV5x7Q7QpNca6my6bbQTT//kfy4jV1uXf0mwIOgqlIzzAc4/FjsfGPERxkAGFX5NZaFYeBLvJKJEyEPFOaG0eMJqSe8m1kGRZG5g1S9mW4gnOBrpdZc8dbPxI6f4SAhfA/x7gyNo+e+J39RAFmkm5EkpeTj89RWyCjjiWhpVy+5GKjcVNJppkK5aQ8oCD9hli6j3CGkjbIYskS4LPw7wn1cEu/rrky+fS/HCZ5wLlVhCvuo1Qu05At4sYJ45FE/dzgXZQWLmaINWQrlFkmohvrEUAob8KJuTZ+u6xEXehbkJapurPvg64MJMkUVN2sHy099n9TlHJxdxcVfEjo5nWQDzkCDCZ7iy3Kwnb6ixeS4q4y2tJ7Tbt9KSMd/pVjGhnobPfk8KW+EOJWyfQXlXcDnq6Cq1LFTzFZqKLOcjUqv33O2w/xWqmARjazUvfGR8Bu++fzPheT2ROmsVlZBqK2vroEeQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(86362001)(66946007)(316002)(8676002)(6916009)(6486002)(508600001)(6666004)(6506007)(44832011)(83380400001)(2616005)(26005)(186003)(107886003)(6512007)(5660300002)(36756003)(8936002)(4326008)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4HqGPb/xsK1MBe/hDZ43BlzNfR+m4N2ykNAUnwMcmuemReBBJQj1C9eCALG?=
 =?us-ascii?Q?1X27bs8fE+vBxDBkD4A5FsJ+qGnUJJ0tYPDsnk+eAkeCJAbBSs+5yOll6T2c?=
 =?us-ascii?Q?sgV56hIOBU+y6rcbw2uohW4z90zgAklcWFeiHS0d77gFyf0aIUU/NWwR6dQ/?=
 =?us-ascii?Q?HSd0wlWRpcoL2DGwROaP7gEJrHb9uquA+EUdzRRG56yi2SHbYpcI+XOiitHe?=
 =?us-ascii?Q?BumENpWSeMpQPvRcqsnqqPb1hBEV/WoBCa+TJTHGzCsX1aBCKkMQg4giunRl?=
 =?us-ascii?Q?GrHWBELD+I4toR+V4YP4gGhHYp/0eVHEDJc8/ZEUjHCX+XS173RgCbNoKjyA?=
 =?us-ascii?Q?HK2FENnDZv8sRU6cA8gwlNCZb6bnatOLPiHiLot6MaXym7qeUPcgMfV52u63?=
 =?us-ascii?Q?8mgGhJvOuUa/Jyfl8jS00F3shLBLsRRunlxZwjDU03B4hZ4VYvRRNNBDuKdk?=
 =?us-ascii?Q?jDJtgqxskQkaE4uaUckIj447KBs8v5g9ifLK1By0Qtd7tZV62bn/+96rXMon?=
 =?us-ascii?Q?ZRKT8FMZj/V/bqlHAU8JY0Z/8V9wjeOsltGfhoeVY/0jkpfStIC5VQ0EvyD4?=
 =?us-ascii?Q?35gmBf3rywJ5Xe8LWVPtU+dZf5KGC/xWKZjHtaxiAkyfXNh57Jf5np0NbUyn?=
 =?us-ascii?Q?IpCLl/qb71BXzkyNjlTgTEhs4O8WYIOQK0Eb9UCWVWF/oiSB3/7dRKQzi0pZ?=
 =?us-ascii?Q?/zuUuCMRcSVdQdjtjJyTILNz1MoXX+dUZaHKiDKMKaUP4h5owdPOuAZJ6i9c?=
 =?us-ascii?Q?ZmLnskChz4mj4Aip3a815It6bz7pk5qF+Ixxb62ciMb7dGDS597p4OJ07oqO?=
 =?us-ascii?Q?Yuj551vdJEagePSNjgXYGYvKVPJ1BZycLJXTkwLt13yIKFAA2AoPbMA/ObAi?=
 =?us-ascii?Q?xQ5H1OACxae7gsCUwwiXf+OHK0n8ZfWNCb2hOcTshAcAlWk76EqomL7ixw6s?=
 =?us-ascii?Q?B25jtnuArTztk+cWdYpHZ7Wn/fwkIQxCCjE6yK+mhyPMGFJOEJf4MyVcGSgp?=
 =?us-ascii?Q?1y5VjBsPBGmuuVbKtiNUpjhz9XF8eQESkWFG/JCEuNx7UWGaibD1CY00BL27?=
 =?us-ascii?Q?xsFQbAdGEIZ6u4dDTYUZBz5Y5oD+Z5cqQbJR9ghDGs4Q2+Dubp//BIKq8a0y?=
 =?us-ascii?Q?yoTCh77BTXHC/Vzv8WuoU96Q7kTR57WBvXfCtMde8Yo5omLPiRlqIUeBKGvw?=
 =?us-ascii?Q?jPfnTrSQkO3h4xHMjOuAM0CyqAYg0OBnj1zKch2wqoR0Yuwek/KvGugJ10W/?=
 =?us-ascii?Q?vtN/VWQEmVlAoA+z3p65Zo6Y3jQxgAdwULVEzc7GcsMxVGlfo+Vty7OUuTJE?=
 =?us-ascii?Q?Bop56RNey5XPtbATEAdrHg4WynDinlx0g9Edm9IVOnej1YCOojbJvLSQ5FNs?=
 =?us-ascii?Q?XAEXxKaCUP+dMYWV8XbioPTy/JrO3q8DJzS2BFL0uijkydOOoTIf3lQo1TSQ?=
 =?us-ascii?Q?JrRf0DrHvG5JMN6fqHj1O/E77FsxncYWgP5K6kCzo06P5UUCNcrsnA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add986f2-8a48-4351-281f-08da088b4b0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:59:18.0785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6XrJEhwzexQCCEyfkAQsgiAIRq/KyL7ZIXfkAegw0JH8hKopAjKFoTDncpi80xu0IEAfhN1Y4gFBtrQH0vExw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch added the MPTCP sched testcases. Use sysctl to set
net.mptcp.scheduler in the tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 42 +++++++++++++++++--
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_tcp_ca.c
index 8f7a1cef7d87..979b6e90b372 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
@@ -9,6 +9,7 @@
 #include "bpf_cubic.skel.h"
 #include "bpf_tcp_nogpl.skel.h"
 #include "bpf_dctcp_release.skel.h"
+#include "bpf_first.skel.h"
=20
 #define min(a, b) ((a) < (b) ? (a) : (b))
=20
@@ -16,6 +17,10 @@
 #define ENOTSUPP 524
 #endif
=20
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 static const unsigned int total_bytes =3D 10 * 1024 * 1024;
 static int expected_stg =3D 0xeB9F;
 static int stop, duration;
@@ -85,21 +90,26 @@ static void do_test(const char *tcp_ca, const struct bp=
f_map *sk_stg_map)
 	socklen_t addrlen =3D sizeof(sa6);
 	void *thread_ret;
 	char batch[1500];
+	int proto =3D 0;
 	int err;
=20
 	WRITE_ONCE(stop, 0);
=20
-	lfd =3D socket(AF_INET6, SOCK_STREAM, 0);
+	if (!strcmp(tcp_ca, "bpf_first"))
+		proto =3D IPPROTO_MPTCP;
+
+	lfd =3D socket(AF_INET6, SOCK_STREAM, proto);
 	if (CHECK(lfd =3D=3D -1, "socket", "errno:%d\n", errno))
 		return;
-	fd =3D socket(AF_INET6, SOCK_STREAM, 0);
+	fd =3D socket(AF_INET6, SOCK_STREAM, proto);
 	if (CHECK(fd =3D=3D -1, "socket", "errno:%d\n", errno)) {
 		close(lfd);
 		return;
 	}
=20
-	if (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
-	    settimeo(lfd, 0) || settimeo(fd, 0))
+	if (!proto &&
+	    (settcpca(lfd, tcp_ca) || settcpca(fd, tcp_ca) ||
+	     settimeo(lfd, 0) || settimeo(fd, 0)))
 		goto done;
=20
 	/* bind, listen and start server thread to accept */
@@ -324,6 +334,28 @@ static void test_rel_setsockopt(void)
 	bpf_dctcp_release__destroy(rel_skel);
 }
=20
+static void test_first(void)
+{
+	struct bpf_first *first_skel;
+	struct bpf_link *link;
+
+	first_skel =3D bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	do_test("bpf_first", NULL);
+
+	bpf_link__destroy(link);
+	bpf_first__destroy(first_skel);
+}
+
 void test_bpf_tcp_ca(void)
 {
 	if (test__start_subtest("dctcp"))
@@ -336,4 +368,6 @@ void test_bpf_tcp_ca(void)
 		test_dctcp_fallback();
 	if (test__start_subtest("rel_setsockopt"))
 		test_rel_setsockopt();
+	if (test__start_subtest("first"))
+		test_first();
 }
--=20
2.34.1

