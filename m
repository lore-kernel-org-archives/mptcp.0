Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851583235
	for <mptcp@lists.linux.dev>; Sat, 26 Mar 2022 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648311883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N+v7msnfEZRValIt5xjeVsE3e7nZL2aiPAZDHcuQdI=;
	b=cD5UZUhMRF5Op4zIXfzBdyiyEIGl0uoKatAGNSkzPqFL6KUf2nqMVHSvjlOReKcKq3XseX
	DCl2AXEjd6ahPBI4X7lrYjWd2sO2oG2ZSGHzZFOfrJbBjWsLr92/2Uq0o0xQAm11/+Zl26
	U1W1d4IVdJ4LabGFCYbYoom6WNbWLSA=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-5-3Avwh0kaPhW_JYZZt7f-Kw-1; Sat, 26 Mar 2022 17:24:42 +0100
X-MC-Unique: 3Avwh0kaPhW_JYZZt7f-Kw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hE+5ov2TI4xli3d4ksYAeoa8BnqKZW2FWXAROg0P3YZphvlG1EraNYHcuzIuzaXTzmosWbvT4Grv8QvAeHu6YouYSxI1e/AGMrlWCxBhN/Ux/UMJQdeYiQQmTfjQRp1euRjpfR80fSjzmUICC0D3J2J9DEg941NVaGL+Y8q9DmHk4YdakHP8NQIHY9doClUIsvJ28bnX/xBMTK9N0iFcC2NINNsIyuBpeqUNHlKacdKlfwJMifnHSj7lcSUh2xyLLJyiG0zzEmhdpBdliTfxYwd4pKrYJZItAiBHpUwzXBgMCQ/DbvtIYINqV9x/jUXltmMddYMgOhfObpQ+0ZX/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0SuNGvUJv57nXFpn4CbA51/t8xpdbuq4cki+JbTtjs=;
 b=l56vFCyXNzkhk2S7YeaMkrU3LGndCaY09RDBDlEHnHRF31EWAZhvTb6sTjCn4OM5oENlr9+WveEvNjnBPGmFyJnO+SOHa1qJo7i1A9/y29FNg15WX5uZS1cdUtkW1kLDlEh/acLLiK52J2tcQugfY0eCTdyMcCT4vn+Dt+nT9kNmoU6J21qp4v1yrxt39CRWiSzJT28tzbfogUWr9sN66Qa/FhJYRhfaKNYb38N0z6SO3A4V4ETnbKTiQcisYkmAft7Bz8AzkDOiO4zrEzJbQlwfqu7YXKI89C+yTQQSK6wHvC9uW0MfAgjqnkxs1QDLd2/2v7sMkT27nKCtiDJqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Sat, 26 Mar
 2022 16:24:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Sat, 26 Mar 2022
 16:24:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 2/6] Squash to "selftests: bpf: add MPTCP test base"
Date: Sun, 27 Mar 2022 00:24:29 +0800
Message-ID: <e6967176c0c8a82903a3f7867b3b1433286d878d.1648311457.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fe1f5a9-45a2-4688-2361-08da0f452150
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067E9FA5291D665EE773D99F81B9@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jid5vSc+7zczvBaca6A/7p/FJnbDPWwq+JhjTNIBaK1QbzOn4+oA6VSeddPa9sFKVR6Xw2ehG1nt+4hFFnf2L+SLqvnu+r4FlE7wSoP1ogY5UaYWryZU7kXAsNJrTBv9njSdIwydv/UA3HZ0HguoWucceOnwmE+C2/uXq8+EfgxadDtrcNG4gwyFjTEDOt8qWzF1muaIcAonc8yiLAOruc8hozRQJe7wfEnhIvT95ZOeaz4k+s5vAJ5noY1m9cESv1VJXYyIGwx4JwRr+QANtE9VKDyXflxNaOt+jdbdA/r/POjhwqPkwZ9duUT16h0pcn+pPUv+H0AHP57KeXf3wXVCpHHCVqLBavffUVROLatc8TyEAt0wd5/WqZP/gsboNyrVxAZWO35oUBnOlhI1z1kEPoEizahaGP761J+eNPD0YzYK8o5Zywg09b/+I1Dr9wWrZvhhXMJ/8MQKWe9VUnduznrVoWBoVvkVSysN4OY7wocjSOpXO9OPN9I7TclQXOwraMAnIVfzNFo/BaVjge/VTpy0BgZ+a6or4SxkIt4lo2j7ZfAMVmdnANx4iU22MRa79SDm0luCHDlrmdq4nXHHli7Q8FRyH8t4Fm25Q1MjfdiWdIX9tKUQEEB+tjveVtxo0avlH11RkYAnEJ1BSKkAyaktkOA8AN0f0wxGqw8wqHfRyLUj4BDFLrIoHK+ZBc+/3I6I//iB+r/eawfngg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(186003)(107886003)(6512007)(4326008)(8676002)(38100700002)(86362001)(26005)(6506007)(66556008)(8936002)(6916009)(44832011)(36756003)(508600001)(6486002)(83380400001)(6666004)(2616005)(2906002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VIGuyNlitSffcBJmdBy4278TLIGULF8cXx0PN3K9lpuZ8P8jo44RTpiJaeqx?=
 =?us-ascii?Q?VgsyO1LRbl3zpbbd5zC+lKWZM0oqEe47WvwP/aWnIp3KOMHfInDEqn6xhs2d?=
 =?us-ascii?Q?E2MqdNUeUZu5FiPenCGpGAhZgDqDivy0HiOggPk+8iYKDvbnhd10Y+Cwcn0u?=
 =?us-ascii?Q?HNDoAqfzxGMmfWgbTMQMR40PP2jb9SjG/Kierk/oVUrWs/GQeNrwpyc50Jj/?=
 =?us-ascii?Q?mzwTKTYYOc4L601VeeThBv0e1BSsis0nWWZo0o/7ql0fJqrlc7cE9Z4fALyF?=
 =?us-ascii?Q?OappBhYevlBgbKpjNRlBS1mzm8NItwb+h1cDPt8a2hHUl3gKi92GtBt5qFD2?=
 =?us-ascii?Q?BJG8GzmFHP8CYt/b/qQtGyWEafdxjWSzbl/ndRsIAuKL+zqCf0sMVmtI3lfp?=
 =?us-ascii?Q?cpVuhBmN2xtFPPOIV/LQDT29GwVxJM+A1oxcmtmscooScEMYbpdbIBzSeM0w?=
 =?us-ascii?Q?3qICX2Fs610D9ET2j0LmkSCp3AwCsmv1xubTn3LZPZhcH/LkbihHyNrSDcWp?=
 =?us-ascii?Q?E1ARHNpQBMe/op7UAc4tj9b7/hjgkWvCLgtlFtcvoEPcfGI6Hk2pG/pOlczw?=
 =?us-ascii?Q?RCxFCMws9OrTiCuvJw6I34M8hLlVw8mwKTcvXhK8hYeuSYFqlX5S6SS+u5jP?=
 =?us-ascii?Q?Odbu26+kRKapXSGys+LFsPi/d83nT8t5R4/8sdYajNHXuSXpeNs7I7v+bfxd?=
 =?us-ascii?Q?jxE/2TkwbsfYl1pTCzrfIG1M0z+wAD/gE6AUWHdu/cLYM4xBEu2aHAUGnYgW?=
 =?us-ascii?Q?mlWCNcXBTOf8zeEnkfRRB+JJbC89zvHZ9LtwhdEyby2ebDDAdGKzsRd4yj95?=
 =?us-ascii?Q?/yR6aCsmveNKoHwBMMPHESBtvZGCcI7E/zSxu5YZAE/OHGqUTvouW3HPfODl?=
 =?us-ascii?Q?RwUI1zD7vq59qSZvXgl1oclzbCfnm5HRUupswbiOCTCWHdsiC8bj2g9lGFhG?=
 =?us-ascii?Q?J7sj0Oqin+4BwcoMZhR7nueQCYsoJoMEyY+4bGZdY/7MIqOjhddhaYexfP95?=
 =?us-ascii?Q?va94X6lehsFrQWGtfIp2tnJXWTlsZh73Mxht1zEmi2oc/ctbA64J69H/cM4J?=
 =?us-ascii?Q?ksCd4w7q8fuI9lyllL73Ssf2d7v98wno3u5mpW/XyDW3FcWY1DwYZKV095lD?=
 =?us-ascii?Q?AAS/BZVffepBHm75/gfzGyOMzxUGmAhoCQC6vuPCogSNLAi4bT2b0yXDFp/4?=
 =?us-ascii?Q?/WFoD15upV29bw4UKU5V8kwWTnyQgq+jlybGZFt5OqX3suj5JSso7LyUExrr?=
 =?us-ascii?Q?rbMeuWyMu3UQxoKvsLRT6icilyStOyhgrpoSZkjNPzMrN+41F3uu4Die/ZCY?=
 =?us-ascii?Q?sswOPVfU/nRD+i59O2lviR2tlKoFtMcE+C7bECja8PCiKXqDLSTMkRbeDEi3?=
 =?us-ascii?Q?eU6UcnD5GVuvRla2/xkfZC+d80sp9nLi4RJO0pSeg9tidixh5UyRg1wtP3FV?=
 =?us-ascii?Q?qwYIVCY7IBfakbIpn/BoVJEXND117M39eT9X41xXdDuNO6HOgn5GfQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe1f5a9-45a2-4688-2361-08da0f452150
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2022 16:24:41.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQWo1oOZ+qJXhM76UWkwin/JSv77AvVDDfKTasEojBCyotTzHzlU70a9kXVSQZ3jtTC5FEqSFS1xKRpKQ6wVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

1 fix libbpf 0.8 build break:

prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbp=
f v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=3Dd=
eprecated-declarations]

2 do some cleanups.

3 rename progs/mptcp.c to progs/mptcp_sock.c

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 77 +++++++++++--------
 .../bpf/progs/{mptcp.c =3D> mptcp_sock.c}       | 16 ++--
 2 files changed, 56 insertions(+), 37 deletions(-)
 rename tools/testing/selftests/bpf/progs/{mptcp.c =3D> mptcp_sock.c} (95%)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..cd548bb2828f 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
@@ -13,12 +15,6 @@ static int verify_sk(int map_fd, int client_fd, const ch=
ar *msg, __u32 is_mptcp)
 	int err =3D 0, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	/* Currently there is no easy way to get back the subflow sk from the MPT=
CP
-	 * sk, thus we cannot access here the sk_storage associated to the subflo=
w
-	 * sk. Also, there is no sk_storage associated with the MPTCP sk since it
-	 * does not trigger sockops events.
-	 * We silently pass this situation at the moment.
-	 */
 	if (is_mptcp =3D=3D 1)
 		return 0;
=20
@@ -28,14 +24,14 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 	}
=20
 	if (val.invoked !=3D 1) {
-		log_err("%s: unexpected invoked count %d !=3D %d",
-			msg, val.invoked, 1);
+		log_err("%s: unexpected invoked count %d !=3D 1",
+			msg, val.invoked);
 		err++;
 	}
=20
-	if (val.is_mptcp !=3D is_mptcp) {
-		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D %d",
-			msg, val.is_mptcp, is_mptcp);
+	if (val.is_mptcp !=3D 0) {
+		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 0",
+			msg, val.is_mptcp);
 		err++;
 	}
=20
@@ -45,49 +41,64 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
 	int client_fd, prog_fd, map_fd, err;
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
=20
-	struct bpf_prog_load_attr attr =3D {
-		.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-		.file =3D "./mptcp.o",
-		.expected_attach_type =3D BPF_CGROUP_SOCK_OPS,
-	};
+	obj =3D bpf_object__open("./mptcp_sock.o");
+	if (libbpf_get_error(obj))
+		return -EIO;
=20
-	err =3D bpf_prog_load_xattr(&attr, &obj, &prog_fd);
-	if (err) {
-		log_err("Failed to load BPF object");
-		return -1;
+	err =3D bpf_object__load(obj);
+	if (CHECK_FAIL(err))
+		goto out;
+
+	prog =3D bpf_object__find_program_by_name(obj, "_sockops");
+	if (CHECK_FAIL(!prog)) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	prog_fd =3D bpf_program__fd(prog);
+	if (CHECK_FAIL(prog_fd < 0)) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	map =3D bpf_object__find_map_by_name(obj, "socket_storage_map");
+	if (CHECK_FAIL(!map)) {
+		err =3D -EIO;
+		goto out;
 	}
=20
-	map =3D bpf_object__next_map(obj, NULL);
 	map_fd =3D bpf_map__fd(map);
+	if (CHECK_FAIL(map_fd < 0)) {
+		err =3D -EIO;
+		goto out;
+	}
=20
 	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
-	if (err) {
-		log_err("Failed to attach BPF program");
-		goto close_bpf_object;
-	}
+	if (CHECK_FAIL(err))
+		goto out;
=20
 	client_fd =3D is_mptcp ? connect_to_mptcp_fd(server_fd, 0) :
 			       connect_to_fd(server_fd, 0);
 	if (client_fd < 0) {
-		err =3D -1;
-		goto close_client_fd;
+		err =3D -EIO;
+		goto out;
 	}
=20
 	err +=3D is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", =
1) :
 			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
=20
-close_client_fd:
 	close(client_fd);
=20
-close_bpf_object:
+out:
 	bpf_object__close(obj);
 	return err;
 }
=20
-void test_mptcp(void)
+void test_base(void)
 {
 	int server_fd, cgroup_fd;
=20
@@ -117,3 +128,9 @@ void test_mptcp(void)
 close_cgroup_fd:
 	close(cgroup_fd);
 }
+
+void test_mptcp(void)
+{
+	if (test__start_subtest("base"))
+		test_base();
+}
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp_sock.c
similarity index 95%
rename from tools/testing/selftests/bpf/progs/mptcp.c
rename to tools/testing/selftests/bpf/progs/mptcp_sock.c
index be5ee8dac2b3..0d65fb889d03 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020, Tessares SA. */
+
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
=20
@@ -25,22 +27,22 @@ int _sockops(struct bpf_sock_ops *ctx)
 	int op =3D (int)ctx->op;
 	struct bpf_sock *sk;
=20
+	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
+		return 1;
+
 	sk =3D ctx->sk;
 	if (!sk)
 		return 1;
=20
+	tcp_sk =3D bpf_tcp_sock(sk);
+	if (!tcp_sk)
+		return 1;
+
 	storage =3D bpf_sk_storage_get(&socket_storage_map, sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
 		return 1;
=20
-	if (op !=3D BPF_SOCK_OPS_TCP_CONNECT_CB)
-		return 1;
-
-	tcp_sk =3D bpf_tcp_sock(sk);
-	if (!tcp_sk)
-		return 1;
-
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
=20
--=20
2.34.1

