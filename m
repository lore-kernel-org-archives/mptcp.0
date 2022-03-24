Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A441FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648128526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57VG9dAwfZ/adB1vQjKrxyNSQm4WcZxAMpmmh/EPR8o=;
	b=mkXyhrFlvDWO8NYOLN5ZGXaj3Qflc+3ueqZr5WkEOy/N1J1IJWpAF44DPlv/jK+5BuQcyP
	JchU/j11C9jbJgroZlvh8kNo1m9bAqet7Ut4MoVbE5FfVsnYU+z489NHlW0mVcxWz8S66j
	ECucfrwZbvjtkdvjABzMVvo/RVckdts=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-6j-s1QelPD2vik5POoP6Fw-1; Thu, 24 Mar 2022 14:28:45 +0100
X-MC-Unique: 6j-s1QelPD2vik5POoP6Fw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSVPBjPvfCfq7VwHT1c23F/46eX7GqReChiG3Lxn7/s1VwizVOCS1XNQ6nHdcbXmeqFnQyieQx0oT7vRuykRgHfSVn7D4JWEnxt1kSPEWaYRabUUwzGv7NTHY5/qCLJZ8gm1SKzwk9xNmoQAd25Uy/8XDhobHk+ki0chpbAdwQyuTmMxJlyjbUK0zy+CL1GsGfbkxqdBJ8aAOWErEQYxBaMWucJGJhaZH5oXl+On/d1IyiOdw8iDGtiZm2+nzH+8GM/RS24Oiz5bjjqtEK6Jce2S6GGtXe55wXRVE+3n4F40vGyFjdbvIH2O2OfQU/+SFZirR7HL31blemuiUSFcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIb7W6hB1nDHNZ/asE+BLO1zd/Ih0gNjB8lc5WqRtOA=;
 b=dQ31mxJ4XztyrzgCFSyfR42FPaf3tuK27gXG6r4ivvW3s70IS0OxhC4zMQ+F2ucNqll11mHcTYem6J25EWCHPcXra5wLEK5Lwq/0tifAUuF+kZmd5Ny7jDUTxnL8f8ie2Eycy4xRXzsY+/hFDrzXv16roRK0agmdXVHWEmR/ai7AQuwJFRK+jel6xpTiXjyg+VZWxCAizHm+SZ4zloMupcUFFpMdo2FMuUPp97pLoVhZAoIAYZCUDey7OeMwY49X/Nu249Cm4O3LZiOTldkDLXe/mAYyE3qFFdcBaTgW3OC6kIjTOZUXZBIi0m36V8lzXMpYjnQu4drI5FHCOMy8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB2782.eurprd04.prod.outlook.com (2603:10a6:800:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 13:28:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 13:28:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 2/5] Squash to "selftests: bpf: add MPTCP test base"
Date: Thu, 24 Mar 2022 21:28:29 +0800
Message-ID: <3fca1327933734f25222c16e4fb5c473630e91ec.1648128255.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648128255.git.geliang.tang@suse.com>
References: <cover.1648128255.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6629ed6c-c928-41a7-71d5-08da0d9a372d
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2782:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB2782C9B6CDD8D591ACCD76D3F8199@VI1PR0402MB2782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K6e91rxYnyNB17dsuxE8BGrj7fmLo9lt0MPKmNu75ux1Rz2PBYjoxjUSfkNAV5iKTIMPtO+Cn66dbasQFrY11HOqOBU2Rr3JS/J53NweiXjkIxsTJ5cvE7FNTERjKrDBxLaH5OUF/fcs1NXtMMjQZ/lPlaMLqFsQdWpWagFcZb+8Ho4H6s3RdLljUbil6o8LYiFjj48WLaXlNzQdBUvHSKwK+QZTCGExkTTJc864B/7ByiTWJEAzH2b1qk1vgqnzmFkZh5jdsKIC2GV4kMlyLQIdTrFjuo5RdkfEE5AUY7U8wZqShhIxNdgoI2bOLa/7uNeoXUlLD1RTWowtvAFGwj9G/19uFyDfnzxRjsubQ5DijqMp2ToR4BNFbjkLugPPtQFX32WxNJD/Ji9DL/w9ETH4XDB00KTn0Z++usUABZSjlVWE4ZufOyMSe80by6H0oJrumaPxanYtjKhKZ3+fgidr3MGajblg0zaN4eVZkHUWHAhRVA0mKI8k+xJQBvRZ7xm9HqG+sH2RWNfJU4j6VT/USAfn3l3AenBuk9wVUxi/Yks2nc5ilwS+Rn49kdZZSp6lfvJbUZoE6YYLneQ/XVLz0dmwlfsP5er0NVf2tONSPmXX6+rCPBmxO6HcWBo17WU41kRKw6idd7J88NBQ8zmfewCFwBkaovEVEL29ZSOTZqmJgdLOU2NjXifxrZgw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6486002)(508600001)(2906002)(6506007)(44832011)(5660300002)(8936002)(83380400001)(26005)(2616005)(86362001)(186003)(6512007)(38100700002)(316002)(6916009)(107886003)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vmxBG7sbYskV42dkY+yCMCVJBXBFYriqTAJ5IGmorePaTUUSg2QzdAMn8/5i?=
 =?us-ascii?Q?RLQQeh4UFK1Tyo7UdAgRPhDpf0QhKaed7odRuxnFLpFNjhIUNM+NuJm+phy+?=
 =?us-ascii?Q?zNVJdYrsH1iw9a0uGl8W4ENPdJMM8UJHfniAZLWPfmbq0+kIac/WIVh+uiaT?=
 =?us-ascii?Q?QXQI7rTwRKFb1p9T3l0RFpNL83z0SMAg0aBQQSr+6Oup6QVU8gGcCv+GgAKr?=
 =?us-ascii?Q?IbdhDTM9DN25fMZ7jQ87OxYmTYwIuURQF3+EL0zMfwj8xxVdWQ4KdhgWX1e9?=
 =?us-ascii?Q?PDlyIimA6WSI2JlrJlp9DVyAcSDnXt0/NR22JR255FxhJD6pjE7yqqAWmAVm?=
 =?us-ascii?Q?5Ukp0RbgCcDTDaqXnQu9QTt9FgEH9kO10sQZQlhjzCvmzEMNCVhRU8SZXyKp?=
 =?us-ascii?Q?LYs85rMQi+Qw5TyTA5mikgGz/MgjIXrPDZJukzeRDfFkv9Szk8n0gT31miC9?=
 =?us-ascii?Q?xNMrfOtEtMa+7lMAkMWZMgAxEvVJMWoGkYm1k/CfS8qpkPvMhC9QgDJYU9Tz?=
 =?us-ascii?Q?RkJDT7aREUY6hf9J7lpLAW+BnWv3enExO1SMGkDPNz/QHUeiEIXrixB/ahLC?=
 =?us-ascii?Q?B5FU+Wnkx0dCHUUvRxcol3+j2uqKI+VpwdAShzs81bEsEfHFJj4eIpRxatoP?=
 =?us-ascii?Q?HjlFWLn81N8vPtLhbW5YZte1hvzYoGJ4CPf0Mk89Khjb0cSGhCkKYBBuOV9v?=
 =?us-ascii?Q?/aYFHUUKUO44FoQCTgD7UTlwXKVum7eW+y/UzZOeOACXCNPra9pPdrp9U0qj?=
 =?us-ascii?Q?xkk+ztA2BiTwttDDbu/VA8rkkQIfRbThNrSpJhEZya/d5EowpFw62iT0JZOg?=
 =?us-ascii?Q?XG7e84QZlgTFLj2HoqLWGubRINzu5o/U10k4w3pSNSJyU5ELGuTOtFk1wCkQ?=
 =?us-ascii?Q?w6tiI3hlLarFGbI8N61Nm5AdZ+XbYJ7JfSnC+MiVdnAzp/oKLtK0qHfnillt?=
 =?us-ascii?Q?kJNHueSk8M6alVe7vany1VuTg+F03Jz2KKjdBIaswycrDwFF77ILWptpvDLf?=
 =?us-ascii?Q?4ttu1JFA39OVJAe340ieuZyyuP3n3GQgfawxlbQ2oSRipZCYDtrTttgySAdL?=
 =?us-ascii?Q?yTztzaCQLrWIIDP+wwQbbbuiOVtv0qfiqIUF9TikQIkkw6hCIlB+gAfRGs8C?=
 =?us-ascii?Q?iTegGt8LM6OiEjgJmOG7n7ZJU8nvCOQt4zjZtZI3Tq//0fJNwOLq4aAhRfSb?=
 =?us-ascii?Q?8GQw1gZ66C31g4fNf1N5/QNJysuRcIhWBP6xZhOYNSju4dX0cDwQNa8QLaFv?=
 =?us-ascii?Q?F3GjrFX7azpFhZm0JhibDlX6Alc7BJXbRCGjJC5ehK2w8UjU+fu+TxTn/c6E?=
 =?us-ascii?Q?l+ltdC4WeyPqgJ6e4ZUG1ptpS/uxduTUKvVwdXFSdgBDfaXX44n+N+N/RHC3?=
 =?us-ascii?Q?Pa5k0DyAPyWTwJ6bgi51zL51pJVJRI/W9G/CIgtXbb0u39CdMx5wbld2uciS?=
 =?us-ascii?Q?vzlek/dGg6EFRHADqyFz/4Vpw7DYKQODvFTYiOSsbvvPofxQ4htkgjX3i467?=
 =?us-ascii?Q?U7PB7wsC5hnDxHUVnE1t23kC3vQmfNySchRsCPqkzSbqlKA2LNTNoZurx8Hg?=
 =?us-ascii?Q?/rButv1B5BGjzDGbjYmGZb7EfyguxxpilFAMubecRmHTheLux6ePq2oAyPXA?=
 =?us-ascii?Q?i+oBI+BPBr7DCwbuu4T2Yfs/Yo4+yrq8UlHo3h89nFqMlUvhi6SvdCywBtb/?=
 =?us-ascii?Q?4YQtq1gzB3kk5Ub2Ju+dF7ps7D+ANNJpPI6uxoMsyLzy94bbiuzPionnDIFI?=
 =?us-ascii?Q?hG4EVYPqXAQDG4kx1cF4fugRh3kWIss=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629ed6c-c928-41a7-71d5-08da0d9a372d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 13:28:43.0383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5XxUF6zY1mY2/6zU02IkTldb+4p7fqbkqzheaGukmnWDN3UHjSJ7J5uKUexrYCTpbr8auSeZmcxkhlITq2hzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2782

fix libbpf 0.8 build break:

prog_tests/mptcp.c:176:2: error: 'bpf_prog_load_xattr' is deprecated: libbp=
f v0.8+: use bpf_object__open() and bpf_object__load() instead [-Werror=3Dd=
eprecated-declarations]

Some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 60 ++++++++++++-------
 tools/testing/selftests/bpf/progs/mptcp.c     | 16 ++---
 2 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 04aef0f147dc..5ec1cc4c2ef6 100644
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
@@ -44,28 +40,46 @@ static int verify_sk(int map_fd, int client_fd, const c=
har *msg, __u32 is_mptcp)
=20
 static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 {
-	int client_fd, prog_fd, map_fd, err;
+	int client_fd, prog_fd, map_fd;
+	const char *file =3D "./mptcp.o";
+	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_map *map;
+	int err =3D 0;
=20
-	struct bpf_prog_load_attr attr =3D {
-		.prog_type =3D BPF_PROG_TYPE_SOCK_OPS,
-		.file =3D "./mptcp.o",
-		.expected_attach_type =3D BPF_CGROUP_SOCK_OPS,
-	};
+	obj =3D bpf_object__open(file);
+	if (libbpf_get_error(obj))
+		return -1;
=20
-	err =3D bpf_prog_load_xattr(&attr, &obj, &prog_fd);
+	err =3D bpf_object__load(obj);
 	if (err) {
 		log_err("Failed to load BPF object");
-		return -1;
+		err =3D -1;
+		goto close_bpf_object;
 	}
=20
+	prog =3D bpf_object__next_program(obj, NULL);
+	if (!prog) {
+		log_err("Failed to get BPF program");
+		err =3D -1;
+		goto close_bpf_object;
+	}
+
+	prog_fd =3D bpf_program__fd(prog);
+
 	map =3D bpf_object__next_map(obj, NULL);
+	if (!map) {
+		log_err("Failed to get BPF map");
+		err =3D -1;
+		goto close_bpf_object;
+	}
+
 	map_fd =3D bpf_map__fd(map);
=20
 	err =3D bpf_prog_attach(prog_fd, cgroup_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (err) {
 		log_err("Failed to attach BPF program");
+		err =3D -1;
 		goto close_bpf_object;
 	}
=20
@@ -87,7 +101,7 @@ static int run_test(int cgroup_fd, int server_fd, bool i=
s_mptcp)
 	return err;
 }
=20
-void test_mptcp(void)
+void test_base(void)
 {
 	int server_fd, cgroup_fd;
=20
@@ -117,3 +131,9 @@ void test_mptcp(void)
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
tests/bpf/progs/mptcp.c
index be5ee8dac2b3..0d65fb889d03 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
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

