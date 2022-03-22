Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA3A31
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647942828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E875lApRqP3Nc3/AkZT1/6mDu5Z2Q+KWrd5hdc+1Ci4=;
	b=aYJR8MGcIkTWZ2WqDFh5geHj9t7m6BdrCysT3DHh0LknNlrI0hqYzZ2buvr+G1eGZa6mSU
	t9Eusz6CY5Dp0iVmEnCM4hdfxTv9534TwlChe9FcYuR7IihpLi932RG6gl0Ot+gtZOpq8r
	QWi8QtnZZQ/dHzva+SkdNuccSnL/rD8=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2059.outbound.protection.outlook.com [104.47.9.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-8OhqCwKTP8iy9TNRkeOwNg-1; Tue, 22 Mar 2022 10:53:47 +0100
X-MC-Unique: 8OhqCwKTP8iy9TNRkeOwNg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTLcs/o08RemQZEon3GDdS0nNtkWGOOcVkJYELzTicLe4REDjBNtZ4LA2wfdPWABNWCr6X9jSP99JliByWCKg9TRlV/BKoZDCbc+h+iL4yDL33W6YyFjw0n4W8Kr4uagTNLvl2v3IPUZ36pwpYsxskbdGHj4F98iMdPexHsN4HUSIlHwBxEk7Gz78M0yaERVimSkBAD1KxkQEnBVJDn/sl/JmNGEig5ebJvMCxVaOi9RLmnRpeEr9k3EFlrYwx69F9sqd7/nLw46Hh1aEx793q+ufjbO/rg8e0jE/4xM8KVmWMEirHPPy56pkacS6iRiUgsQ/TodQaPIaKHXjxrOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB7fkOhFXhOBZIrH/S+dFMwu3Q3xu4/lQQu+SVCa7y4=;
 b=SH0KyIwzE9qS5uBQQWgzerDJLBGcdpzTmbrIYLDKwNBl2iWmJsBw6wNwdFwNoef401OhpEuW2laUtr6yt1BqghUmGZajKFfzUICDbi+MjzzvyOQNEXbvQdwYUGkxjiwNIRRXbHyF19242Qw/q39kch0cgu21lo3cp0jiQOaiyl/uG8hQV1az3rOA4zYEyIa2yWpjNM4AhAoIkGSUBhFxNtmJzDyLgdw2tQO0Ju1m9ih2z7ZrrOeEZrs+F2/CNGGL8GkjL7NnGw2zjHwe3i/naGkmvcjgYbtE775MmpXYf25fg8xs5Wixa97mJBEoUFVT3f5ktK/qbbWddUfd2/wNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2282.eurprd04.prod.outlook.com (2603:10a6:3:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 09:53:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 09:53:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 8/8] selftests: bpf: add bpf_first test
Date: Tue, 22 Mar 2022 17:52:43 +0800
Message-ID: <11db7ce5a24b7f38ea835e5d286f7531b3a95929.1647942374.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e63e5f23-d67b-4a40-9e7f-08da0be9db96
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2282:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2282046D9752531E89374D2CF8179@HE1PR0401MB2282.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7AUFiR3Cv+YjuLPvUrrs4XfD+0KUAl1zW1QDhWxv+vx99uu9czq+BVTmmf9Lj4JhaL4y9/r076ZzZXFsShL4gB17iEYvq2OIp5dbaM3EadxpDBTB3N1+kIVNkt/4ur433rgOBP2UxE/abobCF+lzJfNnbonXN6Pnw0QamIxCAOLDzYmqdVEkHzvmE6GCaWkxbKNF+KIBOPZcETUCno7mPhjXi/eS+yaV8VCfjwzWI2bCKod+fAidWyBLzTqfhJLVUE3hXA+i0agFOrnB+7w1MqpujiG5755P0h655xnyg6A/eJvIMjOjH0seNQkUTXc65mDTR5qD5kCWR6p3yOhUBlhJxG3GX1I4YNhRql6pcko6n6TdRLzuPbRhNVtaYffj0v84tUiziHjI8YbKz5Xnm2vMLZAVaf6vmbPvCPrETEPKBg5Fbw7PlL6Hta9/xWHNcYHZiPhW3cyfskcuitdclzN10C6qhhGcgGoAg+ZuxQSB7rSpRCqOf9k7F+U5ySJDnVz68wVy/Xr27srs4yWpHGETBdiJx8i+pGwmHB4ax5OVUEzX+xkgvwIl39MEcntW05muse9NsFLWndaApVzhjxD1vZSC3BQ8Z8qzdtLIlzYkVclbbpqJaLEytYP6PdUphyOckgHs/FVyIhL79gsS/OBeo95FExxiTc6XRFV1L1GXNSAd9R9oGVcbQguEiWvINAx2wqIgjW1VJjnyWgaPgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(8936002)(316002)(6916009)(4326008)(8676002)(66946007)(66476007)(66556008)(2616005)(38100700002)(86362001)(6506007)(5660300002)(6512007)(186003)(26005)(107886003)(2906002)(36756003)(44832011)(6486002)(508600001)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vo1PzYjHoa7Qfu5JaW4nF/lniXMLBSp+axlXcvDEl8tFbZ2FEGnNfPZ3xi4T?=
 =?us-ascii?Q?yKnlxhU8Fnu17XgwlzeDhuQNDLKvleR5UFxD75fgkNqnYtevUudysCf8TsDF?=
 =?us-ascii?Q?sPS3vvwxcVzaEhvpSJBMcS8wxwvUT5SDn2CgafPLHsCO0x2XpOpbRj9E6hAK?=
 =?us-ascii?Q?+HHie6jH1to3F8AePT0aTckIzhu4rKEdMmQVN8MH4EZk3rKgC39RX/40jpDI?=
 =?us-ascii?Q?FWC/qzj1QYGIlapp78zXIeuGegjDVzeM2LIAwgFtSkUpY7F6/nHBvSi0Z3gf?=
 =?us-ascii?Q?fUg/0/ZwLIDV6ys0KaVrm/EWLyLJex8czVqfUqBANe59mC24p3RAbStT7NfR?=
 =?us-ascii?Q?MWOq4QHsagAGenQ7ZJ/QtgE86I7TTlZLan61EIhaEAGhplvOyHa64n2ZeZ5w?=
 =?us-ascii?Q?iYKKDtceBfVYqTcfHmExvbKKDezECZQG6wGoy9S4uUTuOm4W6wFQ2SrKvGZ3?=
 =?us-ascii?Q?SeLNz4wT8s1ix6zXJOWgp3LxP7L9L849fTrY2x1wrGG/mOog39IZ4eAcyQP1?=
 =?us-ascii?Q?/jRkjGLgzvaUD+yIID+dW2acWb01PdXiQgbeEEaXn3JMwa35iD4I3ZZ1ptKN?=
 =?us-ascii?Q?gDGqmHuD5IMhte4covFnUESNoiWGeD7wDOFmSKLWY++TTDzGcE9nhBz0KSKq?=
 =?us-ascii?Q?tlBeSPJgzaFWUUD6fxko7oHI9rO5J3uLQotHaBXXSVtisrtj/uZ2KukIypRX?=
 =?us-ascii?Q?hGkh4cUswerTSupJDJ9nM82tlRGAPchFtn7PE5CEyYN/rOWDVNpvbI3CizV+?=
 =?us-ascii?Q?v9M+sCqLem2GDdCEzf9H7npD6A/lN7chwsEI3vmIfZJQ/R/hamfIlfvttAzh?=
 =?us-ascii?Q?JXLL3yMDky3GY/KpOJhsjG+ylN7GYDjeIRGEnSWMzJQiBizrrGPIA/fGp8Hj?=
 =?us-ascii?Q?3+FVvJeUcCRBUiVc5xVCogu9fxkgr6ReIlpvBejYJdz3XeOvd3vo3mHcTrMZ?=
 =?us-ascii?Q?gPUAanQAUe/DiHyX0rxaZ9+ucEWzrHT8RXBhOF+AvknOczl2WaYfsOQABTgM?=
 =?us-ascii?Q?iJD+AHqqVIwci0WQ5KGUTsgSrwAifMsq9uf0M8fjd7vBCwR1ARP71a3iIUsg?=
 =?us-ascii?Q?NpKBPxcgFhSQRbMBj/AQ60EW7RCLAiwlO0vgK2yi5un/PKhk0sqREqtaQGuU?=
 =?us-ascii?Q?V53Jdeap+IJ1FBrC/og4sGTaYPUtsttpBy5598Wq0Vfmf9i6nhe3cdmzkYII?=
 =?us-ascii?Q?Pj6lc4BW3zy5nIp97KecnWqxyxchuuH81ucQ7Xkqwv0A4Y71O7MIEysq4If+?=
 =?us-ascii?Q?I9d8hAjWPaM2zlm2qlGxPznqQB5inqlzRCHYNB9mKZ9aHfV8mNzPM4M2VLr1?=
 =?us-ascii?Q?Ihmg1x1FKK35JDztDcFg8qg29IcPFNKYLbJlGdE8piRgUxfno7gW4flVhtwT?=
 =?us-ascii?Q?XN+2pwZIFNPYlcWbK9B1mXsGzGqdlOtRxUHdbj1zGMeFBI93jkDHOlwhQCgq?=
 =?us-ascii?Q?JMNRxEq6CKl/OnH/Uxbzjeh7D8chbI/VPAfJy0XzGQLOURYswe7urg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e5f23-d67b-4a40-9e7f-08da0be9db96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 09:53:46.8369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odgmN0IOt/abFudB9EQLQh7GxIJFVRMN/vl143THtSvBS/Pd62HjYpGIfNuRIojuZgrimmRVwIxc6Fd7CeCtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2282

This patch expended the BPF TCP congestion control tests to support
MPTCP. Add the bpf_first MPTCP sched test in it. Use sysctl to set
net.mptcp.scheduler to use this sched.

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

