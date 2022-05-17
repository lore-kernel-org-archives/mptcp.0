Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1007F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8W5GocivOU6pF0tgJhKG5DKlXZrAQ7PU1KFlZLK3lI=;
	b=WeThTMi9Scpl55qVDNI1PDV1s+XrelrskQbxl30YDNAGNNYlGnBbFtr/mDyPnO5KQCvmCM
	IEXDgbr8PJcmDDabl7wpoIbyUpN7auBGUwuUXT42rjfVg21OUJZYO6kTb2Uyo1rk2JxUNR
	NyzMxC0OcnXf0XIXKPCG8jA2HLfmRzI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19--i_Rm9xZMuW03XTN0uI6VA-1; Tue, 17 May 2022 09:43:35 +0200
X-MC-Unique: -i_Rm9xZMuW03XTN0uI6VA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7QrBoZmWOmGG7mWQm1Uy5FRela3NtCXVCgTuDNFg5vkiotxOLckcMpaCTqdSi0936Copjf8xI4y3yr716r7hL0yw2riRj8dTNY93LeHoovWrSdj/r5ffvsMGmfn9ZZet6slBMaAOp0eBbSKnZ81lYhzXiGw/am6CpLrdufwU39PDhSKbJPY6WXgKbBbliP3pyxfJfYGRJYE2PQbLv9mPyS7ISy2/9geyy95ELyCzYwHYWMxt9WwP0/B15mcLOpJt++hIqMKCG27y9KQwiSpTXixkg9GKlvAFIDO8IozkaVTD4XEtIkaUz4HYUOwF/XEn615EZ+lEg9zxHbsFAiSig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXHX9YpqLDqfurfURF/MkZaCoeF36yEn7NptiYKjxIE=;
 b=nDawc3H6eXDMFHdrskRffhCFXWvX2lPEKp7smhYisr8gBDi9G7O0MQQ825qwPyQ/Pbw3HDe1u9qaerjhjw2WKC7KJ/t6h+rJXOkObMFagY7LsFPIax4sQeuWD7++N2US8Xs/qMmJRmGUTf5uQvpIugPvol+1mryEBsZgPfoExwAXW+w71dUdUKlfc1jtqFrkhVkf0Tf9+7+/kcEji7y4FJFycS0nhxwXigxOFDPwd2FxJQB3chCVINLcoCLWRcjSbKeyE1ztpkEtw7ZckKp7fJ272HXrGkno50g+mMQNOO3xS66v3x3uRZYJMvRg+9dnhnEYxpVzsMGgOFSUz3HYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2732.eurprd04.prod.outlook.com (2603:10a6:3:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:43:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:43:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: add MPTCP test base"
Date: Tue, 17 May 2022 15:43:20 +0800
Message-ID: <206d96f325dfb199a54f59a7c799bf6515c36cc4.1652773250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f1955c7-144f-4b4b-f87d-08da37d8f239
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2732:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2732DBE20CACCCD4CC5EA13BF8CE9@HE1PR0402MB2732.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hzls7FH4HJS8P3egoB6HeXQKQEInTrT9/BskMnejGhcY3sniYOhF29zQsRByp/FxpJLAt6IVY4LvnqTyixKNXth54m2+3jZ12m4CVmmcFDD3H2g8wd2EbZE+VMM20FndUQt3TyaCilLDa63Z4o0IesePnfAOYWLJ3wgFJ+G2DXeljhlDqRt/5y73+9/b5UnRSvN6xsRXhwJdgRQZ7a6Da/LFM2eP7YAXymsIvcsoimZBODiYEeZT1GtDTJ12bkw1bWMEj2tqbJQ6hDeaz77dlkahIQkbPKsSIQfdXFbezfSwR6MaA98FcykurNHHjX97GbrmrQnMZMG1C9+J07YcC0M+JAd8de9AZ7EJfQ7tqQcQQFJuQ5OfuAeUXQ8VNNQumAKGNWJI1TRXrqEMVLjIXKeruOZmv9XFBlJcD5XsHpkzI/lA3EgoOna57r3XARC5ti5zLkvYVlbzLcG1v2Yk7ckFCnHPHVkC0CvwJZBKQWJ3QnWEHvSlzSGTn7k8IpHfVOgVG5udoq+nDnzxhjN3h6sM1mPOr1t3Ulo4vcxiiWjEvrCshGN0oyRj4urwh2dvzaocM81baQgHvcJ002qEUz2mlOdYXBiSjgHwaKCPruYzPuz7QyodHBjK9DEdYIPuAfWWOGwxyu+dGiewphfTzi8ItW8Ww+K8rEjwIyfkz/WECSFq60Wo0eOgH380XfJpM4CKs/kHFdMCACLJSx5t4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(8676002)(44832011)(6666004)(36756003)(6486002)(6506007)(186003)(26005)(5660300002)(38100700002)(8936002)(508600001)(6916009)(83380400001)(2616005)(86362001)(107886003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/unY0OnO3t011RnrfQG83n4hmiH5gasFvsLLeoX+m+m1yFuRPsM66EWtwMin?=
 =?us-ascii?Q?ezjduRnZ6UHg8CgysQv6xhC9FqSSKXeWgk1YMr0NTxwEp/fSkIMzFIVJdt7k?=
 =?us-ascii?Q?PFhzIH/ZBUfyUVkPAgwKPFVLTaeSIqsU8VkGWBVqxaMxOT3Xm5shG0HlxK7J?=
 =?us-ascii?Q?68XxbiMJjH/r90Hjt4iZpVOcipDPostTW2g0uj9K2MYribcDRTgCuqFvbXeL?=
 =?us-ascii?Q?lDUVH1d0Wo2FiG/OEJMLH7GsSy+aQJLFbIXZ3/MSYTxJqgw010p7Y3dYPxHN?=
 =?us-ascii?Q?urKWiI7mG+6xSgvWC3Hq+FPWIzwEEibUNNckfQeAfKxJn8345KUoel1lrQDG?=
 =?us-ascii?Q?3XtDoMJrtmebUAHI09Ib3Gl5g94VigCGkjfAf+e4oa4Qv6D+LXMkqjsJSNCv?=
 =?us-ascii?Q?J6l3TLGl7Awq9GouOrq1sE1AL3kccjGnUEthuM8h6IfHnHtxdX7g/7jYjXmh?=
 =?us-ascii?Q?r4JJhuCTr7pUUqS2JfPqVwuIrLFjhKSX6ORLEEwycpWehoOKUaXwdyvY1yEV?=
 =?us-ascii?Q?dQ0Snoxwvf/Xbm8r64W6U+9CB9ucJ+j0kWAtgDKxmy8GvJx1wW44Frm1/nlF?=
 =?us-ascii?Q?aKOKJRLDALxrOI9lMrM7ACO5qQI0lAcLkncASkeY3YI46LqBC1Vp1vehgXgH?=
 =?us-ascii?Q?74OJmiFYm+PI+rCmzJMIfPoUKEP6dcZ/rP1paOJSks9VEgr4/SXrH2aSx/CQ?=
 =?us-ascii?Q?swOqrbUMhg22AS5LPwC4G9UyMk6sgCUSsKv0MjSxeIyo68si4VO0kM7mDW6U?=
 =?us-ascii?Q?G1Er/SoovBlPqEkCYx9vxV67XtE6VzdQJkQopL7m+x62TuTO/19PyI/aOh7E?=
 =?us-ascii?Q?4sAWol8TsC2qvPqzSPOEAr0dvcSYFZnqxpAfhXNEaMLdiWb+s0ENjUKQlJd0?=
 =?us-ascii?Q?RwlLLkWtv0KePkjVFa9l61ofjjdJ+JEu3w9HLtQp9Ia6tyzEBE+n2hYZT8p2?=
 =?us-ascii?Q?7NabGyU1eV8ZPUf4deLTRXGHJqkdhCtbk3I5CiHCNHG3nAWPwI0yj72vT7ax?=
 =?us-ascii?Q?ES4LQePbRvSUWeJmvN9BJkXqY5qfyKbhf16JutZ9jSK9y9bf4cmS4RFAQpHx?=
 =?us-ascii?Q?TTFGAMkmXKi9239EiSFohVwBm2Mfpgqnqp2XAaic0x7lF86H/UvbFxY5ky/F?=
 =?us-ascii?Q?UW+t5UeSQC++YhoT+D/dnhG2w2tOdkHtQ0TYwmCstYPd5v7slBvN6vcjps2r?=
 =?us-ascii?Q?eTKJv1O7z4TnTcsHrOUUUpYoBa4jd0rieEUZgwcVAcVQiPRZW+2M7myC8q6D?=
 =?us-ascii?Q?assuhFMzdiU/4ug5jaqhEI1r3LBMF7TvcQ4ptpObqWsdNRrYTcTrVJf4ZDjU?=
 =?us-ascii?Q?gDnGOTlsXDa2BtxWjspqUzEwfUJa3Zn+FNdgrhsh/fUBfO3y8Mw0IoMY+Mxd?=
 =?us-ascii?Q?xl/m7kifyeJEH7VEvYIkPv3fqdDOTzV4keYSXia5gg8ZL16zlAZPQQCdJsU1?=
 =?us-ascii?Q?wHlPGpjIGp13u48QdIBJdB4j1DlSxIdAmd9clWOKLjwbtlBDKqppmDUwuD07?=
 =?us-ascii?Q?+VvJkvQPX8Z1UyC2tf6c+X+DhBhUxTS2xN4Jeullctc3nh9tecOxi1yBs0w9?=
 =?us-ascii?Q?w4PYgkeIj8ter29qhNYt/kzrkCvAxnwJD25hZAbujJv4xASpsxPS2xnhcIzk?=
 =?us-ascii?Q?AqTpdbO6MqB3g0BA2j/G8YU5QWVTUlAIzJ+piSEzuPaSo5N8Sz189vHhj/Ns?=
 =?us-ascii?Q?PcNV5IXF3iNtydR8/6pgvfIj4mTJQDmsc4Zupi1AvH6oGhZx4IILrJrCsitm?=
 =?us-ascii?Q?lpcBg8PKA9inucYgf6/9X95wjlBolZw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1955c7-144f-4b4b-f87d-08da37d8f239
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:43:34.5664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAIdk4Eo0T+iuERTJua+ck527syay9H9wwiTgle+1CEUlgw+EOjxCT0NrJDzC+90vhY0APe72fpo5QEkLOY6Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2732

Drop connect_to_mptcp_fd (Martin)
Use BPF test skeleton (Andrii)
Use ASSERT_EQ (Andrii)

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 19 +++-----
 tools/testing/selftests/bpf/network_helpers.h |  2 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 44 +++++--------------
 3 files changed, 17 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/=
selftests/bpf/network_helpers.c
index c9a2e39e34fc..59cf81ec55af 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -264,7 +264,7 @@ int connect_to_fd_opts(int server_fd, const struct netw=
ork_helper_opts *opts)
 	struct sockaddr_storage addr;
 	struct sockaddr_in *addr_in;
 	socklen_t addrlen, optlen;
-	int fd, type;
+	int fd, type, protocol;
=20
 	if (!opts)
 		opts =3D &default_opts;
@@ -275,6 +275,11 @@ int connect_to_fd_opts(int server_fd, const struct net=
work_helper_opts *opts)
 		return -1;
 	}
=20
+	if (getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen)) {
+		log_err("getsockopt(SOL_PROTOCOL)");
+		return -1;
+	}
+
 	addrlen =3D sizeof(addr);
 	if (getsockname(server_fd, (struct sockaddr *)&addr, &addrlen)) {
 		log_err("Failed to get server addr");
@@ -282,7 +287,7 @@ int connect_to_fd_opts(int server_fd, const struct netw=
ork_helper_opts *opts)
 	}
=20
 	addr_in =3D (struct sockaddr_in *)&addr;
-	fd =3D socket(addr_in->sin_family, type, opts->protocol);
+	fd =3D socket(addr_in->sin_family, type, protocol);
 	if (fd < 0) {
 		log_err("Failed to create client socket");
 		return -1;
@@ -315,16 +320,6 @@ int connect_to_fd(int server_fd, int timeout_ms)
 	return connect_to_fd_opts(server_fd, &opts);
 }
=20
-int connect_to_mptcp_fd(int server_fd, int timeout_ms)
-{
-	struct network_helper_opts opts =3D {
-		.timeout_ms =3D timeout_ms,
-		.protocol =3D IPPROTO_MPTCP,
-	};
-
-	return connect_to_fd_opts(server_fd, &opts);
-}
-
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/=
selftests/bpf/network_helpers.h
index e0feb115b2ae..f882c691b790 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -21,7 +21,6 @@ struct network_helper_opts {
 	const char *cc;
 	int timeout_ms;
 	bool must_fail;
-	int protocol;
 };
=20
 /* ipv4 test vector */
@@ -50,7 +49,6 @@ int *start_reuseport_server(int family, int type, const c=
har *addr_str,
 			    unsigned int nr_listens);
 void free_fds(int *fds, unsigned int nr_close_fds);
 int connect_to_fd(int server_fd, int timeout_ms);
-int connect_to_mptcp_fd(int server_fd, int timeout_ms);
 int connect_to_fd_opts(int server_fd, const struct network_helper_opts *op=
ts);
 int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms);
 int fastopen_connect(int server_fd, const char *data, unsigned int data_le=
n,
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 301f19375811..59113eb982e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "mptcp_sock.skel.h"
=20
 struct mptcp_storage {
 	__u32 invoked;
@@ -23,17 +24,11 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
=20
-	if (val.invoked !=3D 1) {
-		log_err("%s: unexpected invoked count %d !=3D 1",
-			msg, val.invoked);
+	if (!ASSERT_EQ(val.invoked, 1, "unexpected invoked count"))
 		err++;
-	}
=20
-	if (val.is_mptcp !=3D 0) {
-		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 0",
-			msg, val.is_mptcp);
+	if (!ASSERT_EQ(val.is_mptcp, 0, "unexpected is_mptcp"))
 		err++;
-	}
=20
 	return err;
 }
@@ -41,37 +36,19 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_map *map;
+	struct mptcp_sock *sock_skel;
=20
-	obj =3D bpf_object__open("./mptcp_sock.o");
-	if (libbpf_get_error(obj))
+	sock_skel =3D mptcp_sock__open_and_load();
+	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
 		return -EIO;
=20
-	err =3D bpf_object__load(obj);
-	if (!ASSERT_OK(err, "bpf_object__load"))
-		goto out;
-
-	prog =3D bpf_object__find_program_by_name(obj, "_sockops");
-	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name")) {
-		err =3D -EIO;
-		goto out;
-	}
-
-	prog_fd =3D bpf_program__fd(prog);
+	prog_fd =3D bpf_program__fd(sock_skel->progs._sockops);
 	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd")) {
 		err =3D -EIO;
 		goto out;
 	}
=20
-	map =3D bpf_object__find_map_by_name(obj, "socket_storage_map");
-	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name")) {
-		err =3D -EIO;
-		goto out;
-	}
-
-	map_fd =3D bpf_map__fd(map);
+	map_fd =3D bpf_map__fd(sock_skel->maps.socket_storage_map);
 	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd")) {
 		err =3D -EIO;
 		goto out;
@@ -81,8 +58,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 	if (!ASSERT_OK(err, "bpf_prog_attach"))
 		goto out;
=20
-	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
-			       connect_to_fd(server_fd, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
 	if (!ASSERT_GE(client_fd, 0, "connect to fd")) {
 		err =3D -EIO;
 		goto out;
@@ -94,7 +70,7 @@ static int run_test(int cgroup_fd, int server_fd, bool is=
_mptcp)
 	close(client_fd);
=20
 out:
-	bpf_object__close(obj);
+	mptcp_sock__destroy(sock_skel);
 	return err;
 }
=20
--=20
2.34.1

