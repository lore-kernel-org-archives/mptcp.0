Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE233D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E875lApRqP3Nc3/AkZT1/6mDu5Z2Q+KWrd5hdc+1Ci4=;
	b=NGqSMqed/Pd4F0wgkU9S5YCj0PNbkiTfwTeyNaYxtLX0AD9qzEx65zhcwxq3RkRQ/sms5n
	lhC51dXo+Xdok4rhMPATM3jI1t1O8qgr8N36mtDpm6tndVwIw27vxUSPSObHAzq8y5kuGy
	PNU21PNQqGyaOF2L1HTfLe45sCSdE1s=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-RjxlTdpWMSWc3WUx3YiK6w-1; Sun, 20 Mar 2022 15:10:11 +0100
X-MC-Unique: RjxlTdpWMSWc3WUx3YiK6w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQvO3yown8gGB9GzGm+Eq1F1ckIZQmQOfTwfMggPVOc+PalM8tDe0TwFkPVLQWTaE/8cOEPGBtDyvli12GPqohQiTtK9wLr7YxmSnz/MkrYzyeqVUd8Bn1by+NewysWekfjt1uxvVeRd0ZeREP4GM+CqOrutAfMVSV3l63BOxsoLhZ26YSevie+dtf+c1KcdFD51vlY7IHG/Wxu3A0Y3HzCvB9X+u+rH4/OQkXh8dv+0qtVBL+FxCerd1c+xPIzAOsBlcMNDnx78P3GgqIRDrdUD3culHGrxA94GYJ+FBq2Map3Twt1wqDrMwhshhF65Vqx0MCJWyK6nazU9QVKd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wB7fkOhFXhOBZIrH/S+dFMwu3Q3xu4/lQQu+SVCa7y4=;
 b=EqMlPc27oJAyCUzMf8cEU4vRFAmh6X5eWuzbOABkpobTHQxjFD0gDrsKmYIZFb3Q4IQmVdqb3rALa0j9enaiYQ9dJfdE+zNhiM23tGluboJhnpuz7lMJt0VlkfwHlFbFTgeXjSp0Ia4jr9+yPD060UYtcMsHbubwI7/8Pk91nnNcjkdKBbVBixBKTDtQa93YpVcBSwfWGIA/WDHb27Tt441RzN+8m1JJrv5rejEJNcfJTaxEESKjccZzZeJb4zv7BDytPHJw93ZJRf+SUrDdtbPOyJc9oaFkQ3xdearc+j/oiFzgdXbuPnjUhZE/DXNKiap/WCw980hXZrEpKJ383g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:10:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:10:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 8/8] selftests: bpf: add bpf_first test
Date: Sun, 20 Mar 2022 22:09:12 +0800
Message-ID: <009a3975bc708a82c331e9ad7073342490a8a121.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:203:d0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e56e39cc-cf9f-41b2-fb8d-08da0a7b57f5
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB703503BC6E37F5DBCC1114F6F8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tDsIzso7/rI3FboEFh2pD3nqbwnDRmUMJyTmnesTcMmUNl/a8dno0D0bGqKKQndFQU99CWULV46/0ieuM9jWQo4FkVKAyX58ejDgFwfSt2ObdnI5lHSyhvsHeUgyueiGiGj54Cf+L8YELCigMafWCwlPxkPnvbJazea0bwK8HHWJ0+SLeBMJCP7th+WwOeCFFtM+lKHaR1KBp9ef6XFNo3wxnT6rY7ZAP3cyybmorUvH+ej+/FKcTH6jzhrqvBXsBJ8wvuAq4ZfhT0MkZLMeLUxGLvcJDTnRyFG1Go8Ok2cvPNIyd1a9kRdz7OsgJR+t//8/ws8dGWktPe92VImaJq6ZcSmovRvhQkY0U/T/CuyNtrALAXCIlXRnNdEuOfHf3Ycd4XvZ8FDATRCUa1Id2R1gZJKR3G+JlRCUAmQb6OzhDu24NriCv2rUXbCreEt+ZndftJ6TbDqG3k4Eg/ljGlbGBPLd5nE8jIyP+XM1I+VexsUsCdAJxwl18KkYyX+lQrWGv/uTgXJ+OaLowHl8YT5ACAKnT+9zrVc7z/xd14Lk89VkJP42WHCl2Yss1lL+yKygHqncjck7cPBY6xF5wLJa65qdt+XhPyQsg6dXem336ozPS5xYlSkggHTyZ8BJ1coP53EUi+POzvxT45zLUBBMB5VMza2D07TWzGrgxVz7d9qeBT6RlVPSwk53emlWhXTjAopbK6rDFWkbjXEvbg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KjFlWsnAjufsz3Sb4nLTGXBIwFJ3WR7I0yKxKEPiH4Gasblmj1QiKjM8QhTk?=
 =?us-ascii?Q?yuQQc2S46YGrR56lW6FWXMv1jAts+uMZtV/8oG64lcMhU3mX5MoFEh80rDsr?=
 =?us-ascii?Q?zANn3xQfdvX82yCSbdp7T0V81unYyye2m8ZSFZVec/wNSHX8cCf1EvCJ8xsN?=
 =?us-ascii?Q?expbW+BlH7qVcqWAkiqmaflgklFxG+Dm8+W+HimSQQ8oaRhSPUEdG/+kjSoj?=
 =?us-ascii?Q?8q0LlPJMWxgw1FrYKYqA4c0oqIqLu82XyFgyfpfQXVI9JamDotbJBBAh68hB?=
 =?us-ascii?Q?O0d65yWZqMCHBWE2ZNP3Am2ps4QXUbweMeQkLNXIT2n5yy+R9ibWfX7gX+sD?=
 =?us-ascii?Q?x+tZjfwt9Jp0e6EmaO8jMLPXw4zt9rjN4axLbXZPuL/xSEgBmkSDNLRdd0Rl?=
 =?us-ascii?Q?kWy+s3/9f8ID4wJBxJu9HwrOInlB5kVSrFgntQK3lCjIHSxLVO2gXA4vz+FX?=
 =?us-ascii?Q?HzEnkyM0aMn9o71T1C1K9rtEKNVGTouLE3ewbj6PvvVbpM+BwmmfRXKMr/EI?=
 =?us-ascii?Q?UybWeZASENobRRqoe5afjALQdO73Tt7ntaAZi7//a+RUodDwE2YPJMJXjMuL?=
 =?us-ascii?Q?sJunusm1D8ep0Y1viH4XmCyBmJmaoButI49v03YEj9NRzTv5jwXn4cL+/4UY?=
 =?us-ascii?Q?eyI0fu6slNVCL6HIeUk9xTKP/+o6KbUge546HtC0rAWLZzPuppDwPfGc4Ots?=
 =?us-ascii?Q?ZV0F91UQtTpISIj79EFURk/3KnsTN1ebLyl0nZZzlfZGgBcLrcJnN3sncBIE?=
 =?us-ascii?Q?QSUC55MmgyUy3p277kQur/Nw+DxsJb61KcKuR1qjK7vitvHF0ssebeTWpkux?=
 =?us-ascii?Q?eGwjgNFd608DrcniH9GXGg3Pbtp8w7KvHBVldIF7ZjqJdlKlkVlD/H7pBV1c?=
 =?us-ascii?Q?nRvY63tzvt3A5c1BeoC6v4Kn/+t855u+vlCYzyjW0dnqnklcjbK01RN/1mx7?=
 =?us-ascii?Q?Yctv5vw5whppgM3oxSmAtIXY+tD4T8sfJ1s1SNi68sYlcitTGr+F5iZVQHHw?=
 =?us-ascii?Q?Hslv5bJV3oq3hdd7659j5Seg9MSCc+xYkXrlXOE90WR9HYJd+KV+wXWvXxNH?=
 =?us-ascii?Q?3fyv5yEdkUmFbrNMgIZvLNCk/J5isLmcDIsuCOKjhIpPn8EHnGCa4DZQobqv?=
 =?us-ascii?Q?cs8pY0w2qf4S7T8L3J+7J4lmyfjglCTc206O0+wdrx782Gn7J7oc+wKhYgeY?=
 =?us-ascii?Q?N21VPmiWiwSnAyr+KBJZRVs6F3XLzXz4/onW6E+i+9h6ZuUM7nMqNKB5G6yQ?=
 =?us-ascii?Q?D1bpnbnOjJ/Ou48hRhjqP+5/qHikW3c7osl1o2s4bHREQAIxI/YEQL2tt6SH?=
 =?us-ascii?Q?8MQg9s8bakCq1hHqPGyHryb669eqecAmzZO2pXAEQYqiUJeDJI54nWFEjg2k?=
 =?us-ascii?Q?BgtwqO+yOewA6bdX2Jo6dM9lB1dl8wShyhGZQpIS7R6WvjU1w36gWi2h6Yn1?=
 =?us-ascii?Q?hyhug8QSUlS2P1gTJVFU+SRnZkQjMbGCxHbvIY8qtKfBAjNQhBIDrg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56e39cc-cf9f-41b2-fb8d-08da0a7b57f5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:10:10.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndz8N5l/ajymUxmbNkUNR9Vi77Zl8cLdeq6P8DNTTxi0aMzLjjBfsPK8YHc2UEN8u4QHotNijLs1V8406kdHSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

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

